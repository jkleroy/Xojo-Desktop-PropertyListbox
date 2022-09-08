#tag Module
Protected Module PropertyListModule
	#tag Method, Flags = &h21
		Private Function MathsCalc(OperatorArray() as String, NumArray() as String) As Double
		  //Calculate the result
		  
		  Dim i, RemoveArray(-1) as Integer
		  Dim Value, result as Double
		  
		  //Scientific
		  If OperatorArray.IndexOf("e") > -1 then
		    For i = 1 to OperatorArray.Ubound
		      If OperatorArray(i) = "e" then
		        NumArray(i) = Cstr(CDbl(NumArray(i-1)) * 10 ^ CDbl(NumArray(i)))
		        RemoveArray.Append i-1
		      End If
		    Next
		  End If
		  
		  For i = RemoveArray.Ubound DownTo 0
		    NumArray.remove RemoveArray(i)
		    OperatorArray.remove RemoveArray(i) + 1
		  Next
		  ReDim RemoveArray(-1)
		  
		  //Powers
		  If OperatorArray.IndexOf("^") > -1 then
		    For i = 1 to (OperatorArray.UBound)
		      If OperatorArray(i) = "^" then
		        NumArray(i) = Cstr(CDbl(NumArray(i-1)) ^ CDbl(NumArray(i)))
		        RemoveArray.append i-1
		      End If
		    Next
		  End If
		  
		  For i = (RemoveArray.UBound) DownTo 0
		    NumArray.remove RemoveArray(i)
		    OperatorArray.remove RemoveArray(i) + 1
		  Next
		  ReDim RemoveArray(-1)
		  
		  //Multiplication and division
		  For i = 1 to (OperatorArray.UBound)
		    If OperatorArray(i) = "*" then
		      NumArray(i) = Cstr(CDbl(NumArray(i-1)) *  CDbl(NumArray(i)))
		      RemoveArray.append i-1
		    ElseIf OperatorArray(i) = "/" then
		      NumArray(i) = Cstr(CDbl(NumArray(i-1)) /  CDbl(NumArray(i)))
		      RemoveArray.append i-1
		    End If
		  Next
		  
		  For i = (RemoveArray.UBound) DownTo 0
		    NumArray.remove RemoveArray(i)
		    OperatorArray.remove RemoveArray(i) + 1
		  Next
		  
		  //Addition and subtraction
		  For i = 1 to (OperatorArray.UBound)
		    Value = CDbl(NumArray(i))
		    If OperatorArray(i) = "+" then
		      result = result + Value
		    ElseIf OperatorArray(i) = "-" then
		      result = result - Value
		    End If
		  Next
		  
		  return result
		  
		  Exception Err
		    MathsError = True
		    'HandleException("Calc Method",Err)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MathsEvaluate(Value As String, OldString As String) As String
		  //Evaluate the string expression.
		  Dim i as Integer
		  Dim result as Double
		  Dim tempText, StringToEval as String
		  
		  MathsError = false
		  
		  //remove the last item if it is an operator
		  StringToEval = Trim(Value)
		  
		  //replace other bracket types
		  'StringToEval = ReplaceAll(StringToEval, "[", "(")
		  'StringToEval = ReplaceAll(StringToEval, "]", ")") 
		  'StringToEval = ReplaceAll(StringToEval, "{", "(") 
		  'StringToEval = ReplaceAll(StringToEval, "}", ")") 
		  
		  For i = Len(StringToEval) DownTo 1
		    tempText = Right(StringToEval,1)
		    If tempText = "+" or tempText = "-" or tempText = "*" or tempText = "/" or tempText = "^" then
		      StringToEval = Left(StringToEval,Len(StringToEval) - 1)
		    Else
		      Exit
		    End If
		  Next
		  
		  //remove the brackets
		  'If CountFields(StringToEval, "(") <> CountFields(StringToEval, ")") then
		  'HadError = true
		  'EvaluationError kErrorUnevenBrackets
		  'Else
		  'StringToEval = EvalBrackets(StringToEval)
		  result = MathsParse(StringToEval)
		  'End If
		  
		  
		  If MathsError = false then
		    If left(Value, 1) = "+" then
		      return "+" + CStr(result)
		    else
		      Return CStr(result)
		    End If
		  Else
		    return OldString
		  End If
		  
		  'Exception Err
		  'HandleException("Evaluate Method",Err)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MathsParse(StringtoParse as String) As Double
		  //Parse the string into 2 arrays, Operators and Numbers
		  
		  Dim OperatorArray(0), NumArray(0), tempText, Number, prevtempText as String
		  Dim i as Integer
		  
		  OperatorArray.append "+"
		  
		  Number = Mid(StringToParse,1,1) //to catch initial negative numbers
		  If InStr("0123456789+-.,", Number) = 0 then
		    MathsError = True
		    Return 0
		  End If
		  
		  For i = 2 to Len(StringToParse)
		    tempText = Mid(StringToParse,i,1)
		    //check if the current item is a negative number
		    If (prevTempText = "+" or prevTempText = "-" or prevTempText = "*" or prevTempText = "/" or prevTempText = "^" or prevtempText = "e") then
		      If tempText = "-" then
		        Number = tempText
		        tempText = ""
		      ElseIf tempText = "+" or tempText = "*" or tempText = "/" or tempText = "^" then
		        MathsError = true
		        ReDim OperatorArray(0)
		        ReDim NumArray(0)
		        Exit
		      End If
		    End If
		    If tempText = "+" or tempText = "-" or tempText = "*" or tempText = "/" or tempText = "^" or tempText = "e" then
		      NumArray.append Number
		      OperatorArray.append tempText
		      Number = ""
		      prevtempText = tempText
		      tempText = ""
		      
		    Elseif tempText = "," or tempText = "." then
		      prevtempText = tempText
		    Elseif tempText <> "" and IsNumeric(tempText) = False then
		      MathsError = True
		      Exit
		    else
		      prevtempText = tempText
		    End If
		    Number = Number + tempText
		  Next
		  If Number <> "" then
		    NumArray.append Number
		  End If
		  
		  return MathsCalc(OperatorArray, NumArray)
		  
		  'Exception Err
		  'HandleException("Parse Method",Err)
		End Function
	#tag EndMethod


	#tag Note, Name = Description
		This Module contains the MathsEvaluate function that is used to evaluate maths expressions in the PropertyListBox.
		If you need to add more features in the MathsEvaluate feel free to do it.
		
		If UseBBCode constant is True, then the Headers and Names will be parsed using BBCode.
	#tag EndNote


	#tag Property, Flags = &h1
		#tag Note
			
			If an error occurs when evaluating the maths' expression, MathsError will be True.
		#tag EndNote
		Protected MathsError As Boolean
	#tag EndProperty


	#tag Constant, Name = EnableDatePicker, Type = Boolean, Dynamic = False, Default = \"True", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kversion, Type = Double, Dynamic = False, Default = \"1.8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UseBBCode, Type = Boolean, Dynamic = False, Default = \"False", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
