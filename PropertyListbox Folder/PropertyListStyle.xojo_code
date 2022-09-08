#tag Class
Protected Class PropertyListStyle
	#tag Method, Flags = &h0
		Sub appendToXMLNode(parent as xmlNode)
		  //#Ignore in Language reference
		  //appends this style to the parent xml node
		  //this is done to export the lines as an XML file
		  
		  dim xdoc as XmlDocument
		  dim param, node as XmlNode
		  
		  xdoc = parent.OwnerDocument
		  Dim colorStr As String
		  
		  
		  param = parent.AppendChild(xdoc.CreateElement(Name))
		  param.SetAttribute("UpdateStyle", "False")
		  
		  //name
		  node = param.AppendChild(xdoc.CreateElement("backColor"))
		  colorStr = FormatColor(BackColor)
		  node.AppendChild(xdoc.CreateTextNode(colorStr))
		  
		  node = param.AppendChild(xdoc.CreateElement("BackColorEven"))
		  colorStr = FormatColor(BackColorEven)
		  node.AppendChild(xdoc.CreateTextNode(colorStr))
		  
		  node = param.AppendChild(xdoc.CreateElement("bold"))
		  node.AppendChild(xdoc.CreateTextNode(str(Bold)))
		  
		  
		  node = param.AppendChild(xdoc.CreateElement("highlightcolor"))
		  colorStr = FormatColor(HighlightColor)
		  node.AppendChild(xdoc.CreateTextNode(colorStr))
		  
		  node = param.AppendChild(xdoc.CreateElement("italic"))
		  node.AppendChild(xdoc.CreateTextNode(str(Italic)))
		  
		  node = param.AppendChild(xdoc.CreateElement("textalign"))
		  node.AppendChild(xdoc.CreateTextNode(str(TextAlign)))
		  
		  node = param.AppendChild(xdoc.CreateElement("textcolor"))
		  colorStr = FormatColor(TextColor)
		  node.AppendChild(xdoc.CreateTextNode(colorStr))
		  
		  
		  node = param.AppendChild(xdoc.CreateElement("textfont"))
		  node.AppendChild(xdoc.CreateTextNode(TextFont))
		  
		  
		  node = param.AppendChild(xdoc.CreateElement("texthighlightcolor"))
		  colorStr = FormatColor(TextHighlightColor)
		  node.AppendChild(xdoc.CreateTextNode(colorStr))
		  
		  node = param.AppendChild(xdoc.CreateElement("textsize"))
		  node.AppendChild(xdoc.CreateTextNode(str(TextSize)))
		  
		  node = param.AppendChild(xdoc.CreateElement("underline"))
		  node.AppendChild(xdoc.CreateTextNode(str(Underline)))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ColorFromHex(value As String, default As Color) As Color
		  
		  
		  If value.Length < 6 Then Return Default
		  
		  Try
		    
		    If value.Left(1) = "#" Then
		      value = value.Replace("#", "")
		    End If
		    
		    Dim r As Integer = Integer.FromHex(value.Middle(0, 2))
		    Dim g As Integer = Integer.FromHex(value.Middle(2, 2))
		    Dim b As Integer = Integer.FromHex(value.Middle(4, 2))
		    
		    
		    Dim c As Color
		    Dim a As Integer
		    if value.Length = 8 then
		      a = Integer.FromHex(value.Middle(6, 2))
		      c = Color.RGB(r, g, b, a)
		    Else
		      c = color.RGB(r, g, b)
		    end if
		    
		    
		    
		    
		    Return c
		    
		    
		  Catch
		    
		    Return Default
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(js As JSONItem, Name As String)
		  //More advanced constructor.
		  
		  
		  
		  
		  self.BackColor = ColorFromHex(js.Lookup("backColor", ""), &cFFFFFF)
		  self.BackColorEven = ColorFromHex(js.Lookup("backColorEven", ""), BackColor)
		  self.Bold = js.Lookup("bold", False).BooleanValue
		  self.HighlightColor = ColorFromHex(js.Lookup("highlightColor", ""), Color.HighlightColor())
		  self.Italic = js.Lookup("italic", false).BooleanValue
		  self.Name = Name
		  self.TextAlign = js.Lookup("textAlign", 0)
		  self.TextColor = ColorFromHex(js.Lookup("textColor", ""), Color.TextColor())
		  TextFont = js.Lookup("textFont", "System").StringValue
		  TextHighlightColor = ColorFromHex(js.Lookup("textHighlightColor", ""), &cFFFFFF)
		  TextSize = js.Lookup("textSize", 0)
		  Underline = js.Lookup("underline", False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String, BackColor As Color, Bold As Boolean, TextAlign As Integer = 0)
		  //More advanced constructor.
		  
		  self.BackColor = BackColor
		  self.BackColorEven = BackColor
		  self.Bold = Bold
		  self.HighlightColor = Color.HighlightColor()
		  Italic = False
		  self.Name = Name
		  self.TextAlign = TextAlign
		  self.TextColor = Color.TextColor()
		  TextFont = "System"
		  TextHighlightColor = &cFFFFFF
		  TextSize = 0
		  Underline = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String, TextAlign As Integer = 0)
		  //Simple constructor.
		  Constructor(Name, &cFFFFFF, False, TextAlign)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FormatColor(c As color) As String
		  If c = &c0 then
		    
		    Return "#000000"
		  End If
		  
		  Dim R, G, B, A As String
		  
		  
		  R = Hex(c.Red)
		  G = Hex(c.Green)
		  B = Hex(c.Blue)
		  
		  A = Hex(c.Alpha)
		  
		  
		  If r.Length = 1 then
		    R = "0" + R
		  End If
		  If g.Length = 1 then
		    G = "0" + G
		  End If
		  If b.Length = 1 then
		    B = "0" + B
		  End If
		  
		  
		  Return "#" + R + G + B + if(A="00", "", A)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toJSON() As JSONItem
		  //#Ignore in Language reference
		  //exports this style to JSON format
		  //this is done to export the lines as an JSONItem
		  
		  
		  dim param, node as JSONItem
		  
		  
		  param = new JSONItem
		  node = new JSONItem
		  node.Value("updateStyle") = False
		  node.Value("backColor") = FormatColor(BackColor)
		  
		  node.Value("backColorEven") = FormatColor(BackColorEven)
		  
		  node.Value("bold") = Bold
		  
		  node.Value("highlightColor") = FormatColor(HighlightColor)
		  
		  node.Value("italic") = Italic
		  
		  node.Value("textAlign") = TextAlign
		  
		  node.Value("textColor") = FormatColor(TextColor)
		  
		  node.Value("textFont") = TextFont
		  
		  node.Value("textHighlightColor") = FormatColor(TextHighlightColor)
		  
		  node.Value("textSize") = TextSize
		  
		  node.Value("underline") = Underline
		  
		  param.Value(Name) = node
		  
		  Return param
		End Function
	#tag EndMethod


	#tag Note, Name = Description
		Class used to define the display styles used in the PropertyListBox.
		Three styles are used in the PropertyListBox: headerStyle, nameStyle and valueStyle
		
	#tag EndNote

	#tag Note, Name = See Also
		
		PropertyListButton, PropertyListLine class; PropertyListBox control.
		
	#tag EndNote


	#tag Property, Flags = &h0
		#tag Note
			Defines the background color of the line.
			
		#tag EndNote
		BackColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Defines the background color of the line for Even Lines
			
			
		#tag EndNote
		BackColorEven As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Defines if the item's font is bold.
		#tag EndNote
		Bold As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Defines the color used when the line is the currently selected line in the PropertyListBox.
		#tag EndNote
		HighlightColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Defines if the item's font is italic.
		#tag EndNote
		Italic As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The name of the style.
		#tag EndNote
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Defines the item's text alignment.
			
			
			Use the Listbox.AlignX constants:
			
			Listbox.AlignDefault
			
			Listbox.AlignLeft
			
			Listbox.AlignCenter
			
			Listbox.AlignRight
		#tag EndNote
		TextAlign As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Defines the TextColor of the item.
		#tag EndNote
		TextColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Defines the font of the item.
		#tag EndNote
		TextFont As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Defines the TextColor when the item is the currently selected line in the PropertyListBox.
		#tag EndNote
		TextHighlightColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Defines the text size of the item.
		#tag EndNote
		TextSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Defines if the item's font is underline.
		#tag EndNote
		Underline As Boolean
	#tag EndProperty


	#tag Constant, Name = kversion, Type = String, Dynamic = False, Default = \"1.8", Scope = Public
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
			InitialValue="2147483648"
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
			Name="TextHighlightColor"
			Visible=false
			Group="Behavior"
			InitialValue="&h000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackColor"
			Visible=false
			Group="Behavior"
			InitialValue="&h000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&h000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextSize"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextFont"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HighlightColor"
			Visible=false
			Group="Behavior"
			InitialValue="&h000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextAlign"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackColorEven"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
