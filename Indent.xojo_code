#tag Module
Protected Module Indent
	#tag Method, Flags = &h21
		Private Function CheckFor1Tag(theline as string) As boolean
		  if CountFields(theline, ">") - 1 <> 1 then
		    return false
		  end if
		  
		  if CountFields(theline, "<") - 1 <> 1 then
		    return false
		  end if
		  
		  If theline.InStr("<?")>0 and theline.InStr("?>")>0 then
		    Return False
		  End If
		  
		  If theline.InStr("<!--")>0 and theline.InStr("-->")>0 then
		    Return False
		  End If
		  
		  return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CheckForStartTag(theline as string) As boolean
		  if InStr(theline, "</") > 0 then
		    return false
		  elseif InStr(theline, "/>")>0 then
		    return false
		  elseif InStr(theline, "<!--")>0 then
		    Return False
		  else
		    return true
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DeIndent(byref textindent as string)
		  
		  for i as integer = 0 to UBound(lines)
		    lines(i) = trim(lines(i))
		  next
		  
		  textindent = Join(lines, EndOfLine)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FixIndention(textindent as string) As string
		  LoadLines(textindent)
		  DeIndent(textindent)
		  LoadLines(textindent)
		  Indent
		  SaveLines(textindent)
		  
		  Return textindent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Indent()
		  
		  
		  for i as integer = 0 to UBound(lines)
		    
		    if CheckFor1Tag(lines(i)) then
		      // We need to start or end an indention
		      if CheckForStartTag(lines(i)) then
		        // We need to indent every line up until the end tag.
		        IndentUpToEnd(i + 1, lines(i))
		      end if
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IndentText(thetext as string) As string
		  return indentation + thetext
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub IndentUpToEnd(startatline as integer, orignaltag as string)
		  dim keytag as string
		  dim i as Integer
		  
		  // First, we need to extract the name of the first tag.
		  // Up to a space
		  // or a >
		  
		  if InStr(trim(orignaltag), " ") > 0 then
		    // Go to the first space
		    keytag = mid(NthField(trim(orignaltag), " ", 1), 2)
		  else
		    // Go to > or cut out last two
		    keytag = left(mid(trim(orignaltag), 2), len(trim(orignaltag)) - 2)
		  end if
		  
		  
		  // </keytag> is where we stop
		  
		  i = startatline
		  while i<>UBound(lines) + 1
		    if instr(lines(i), "</" + keytag + ">") > 0 then
		      // stop here
		      i = UBound(lines) + 1
		    else
		      // indent this line
		      lines(i) = IndentText(lines(i))
		      i = i + 1
		    end if
		  wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LoadLines(byref textindent as string)
		  
		  lines = ReplaceLineEndings(textindent, EndOfLine).Split(EndOfLine)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SaveLines(byref textindent as string)
		  
		  textindent=join(lines, EndOfLine)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		indentation As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected lines(-1) As string
	#tag EndProperty


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
		#tag ViewProperty
			Name="indentation"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
