#tag Class
Protected Class PropertyListLine
	#tag Method, Flags = &h0
		Function appendToXMLNode(parent as xmlNode, SaveValues As Boolean = True) As XMLNode
		  //#Ignore in language reference
		  //appends this line to the parent xml node
		  //this is done to export the lines as an XML file
		  
		  dim xdoc as XmlDocument
		  dim param, node as XmlNode
		  
		  xdoc = parent.OwnerDocument
		  
		  If isHeader then
		    param = parent.AppendChild(xdoc.CreateElement("header"))
		    param.SetAttribute("visible", str(Visible))
		    param.SetAttribute("expanded", str(expanded))
		    If hasButton then
		      param.SetAttribute("button", str(ButtonId))
		    End If
		    'param.AppendChild(xdoc.CreateTextNode(Name))
		    node = param.AppendChild(xdoc.CreateElement("name"))
		    node.AppendChild(xdoc.CreateTextNode(Name))
		    
		    node = param.AppendChild(xdoc.CreateElement("caption"))
		    node.AppendChild(xdoc.CreateTextNode(Caption))
		  Else
		    param = parent.AppendChild(xdoc.CreateElement("param"))
		    param.SetAttribute("type", str(Type))
		    param.SetAttribute("visible", str(Visible))
		    
		    If mask<>"" then
		      param.SetAttribute("mask", mask)
		    End If
		    
		    If LimitText>0 then
		      param.SetAttribute("limittext", str(LimitText))
		    End If
		    
		    If Required then
		      param.SetAttribute("required", str(Required))
		    End If
		    
		    If AutoComplete then
		      param.SetAttribute("autocomplete", str(AutoComplete))
		    End If
		    
		    If transparent then
		      param.SetAttribute("transparent", str(transparent))
		    End If
		    
		    If FontFromCell then
		      param.SetAttribute("fontfromcell", str(FontFromCell))
		    End If
		    
		    If Numeric then
		      param.SetAttribute("numeric", str(Numeric))
		    End If
		    
		    If Format <> "" then
		      param.SetAttribute("format", Format)
		    End If
		    
		    If defaultvalue <> "" then
		      param.SetAttribute("defaultvalue", defaultvalue)
		    End If
		    
		    If ColorNegativeNum then
		      param.SetAttribute("colornegativenum", str(ColorNegativeNum))
		    End If
		    
		    If Folder then 
		      param.SetAttribute("folder", str(folder))
		    End If
		    
		    //name
		    node = param.AppendChild(xdoc.CreateElement("name"))
		    node.AppendChild(xdoc.CreateTextNode(Name)) 
		    
		    node = param.AppendChild(xdoc.CreateElement("caption"))
		    node.AppendChild(xdoc.CreateTextNode(Caption))
		    
		    If value <> "" and SaveValues then
		      node = param.AppendChild(xdoc.CreateElement("value"))
		      If type = PropertyListBox.TypeMultiline then
		        node.AppendChild(xdoc.CreateTextNode(Value.ReplaceAll(EndOfLine, "\n")))
		      else
		        node.AppendChild(xdoc.CreateTextNode(Value))
		      End If
		    End If
		    
		    If defaultvalue <> "" then
		      node = param.AppendChild(xdoc.CreateElement("defaultvalue"))
		      If type = PropertyListBox.TypeMultiline then
		        node.AppendChild(xdoc.CreateTextNode(Value.ReplaceAll(EndOfLine, "\n")))
		      else
		        node.AppendChild(xdoc.CreateTextNode(Value))
		      End If
		    End If
		    
		    If SpecialList<>"" then
		      node = param.AppendChild(xdoc.CreateElement("valuelist"))
		      If dynamicList then
		        node.SetAttribute("dynamic", "True")
		      End If
		      node.AppendChild(xdoc.CreateTextNode(SpecialList))
		    Elseif UBound(ValueList)>-1 then
		      node = param.AppendChild(xdoc.CreateElement("valuelist"))
		      node.AppendChild(xdoc.CreateTextNode(join(ValueList(), "|")))
		    End If
		  End If
		  
		  If HelpTag<>"" then
		    node = param.AppendChild(xdoc.CreateElement("helptag"))
		    node.AppendChild(xdoc.CreateTextNode(HelpTag))
		  End If
		  
		  If Comment <> "" then
		    node = param.AppendChild(xdoc.CreateElement("comment"))
		    node.AppendChild(xdoc.CreateTextNode(Comment))
		  End If
		  
		  Return param
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String, Caption As String, Visible As Boolean, hasButton As Boolean = False, ButtonID As Integer = 0)
		  //Creates a PropertyListLine that is displayed as a Header.
		  //If the Caption is an empty String, the name is saved in the caption.
		  
		  self.Name = Name
		  If Caption = "" then
		    self.Caption = Name
		  else
		    self.Caption = Caption
		  End If
		  self.isHeader = True
		  self.Visible = Visible
		  self.hasButton = hasButton
		  self.ButtonID = ButtonID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String, Caption As String, Visible As Boolean, Type As Integer)
		  //Constructor for regular Lines.
		  //If the Caption is an empty String, the name is saved in the caption.
		  
		  self.Name = Name
		  If Caption = "" then
		    self.Caption = Name
		  else
		    self.Caption = Caption
		  End If
		  self.Visible = Visible
		  self.Type = Type
		  'self.LimitText = LimitText
		  'self.mask = mask
		  'self.Value = Value
		  'For i as Integer = 0 to UBound(ValueList)
		  'self.ValueList.Append ValueList(i)
		  'Next
		  'self.SpecialList = SpecialList
		  'self.dynamicList = dynamicList
		  'self.HelpTag = HelpTag
		  'self.Required = Required
		  'self.AutoComplete = AutoComplete
		  'self.transparent = transparent
		  'self.FontFromCell = FontFromCell
		  'self.Numeric = Numeric
		  'self.ColorNegative = ColorNegative
		  'self.Folder = Folder
		  'self.Comment = Comment
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParentName() As String
		  //Returns the name of the Parent line with a dot at the end. If there is no Parent, it returns an empty string.
		  
		  If Parent <> Nil then Return Parent.Name + "."
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toJSON(SaveValues As Boolean = True) As JSONItem
		  //#Ignore in language reference
		  //exports this line in Json format
		  //this is done to export the lines as an JSONItem
		  
		  
		  Dim node As JSONItem
		  
		  node = new JSONItem
		  
		  If isHeader then
		    node.Value("header") = true
		    node.Value("visible") = Visible
		    node.Value("expanded") = expanded
		    
		    If hasButton then
		      node.Value("button") = ButtonID
		    End If
		    
		    node.Value("name") = Name
		    
		    node.Value("caption") = Caption
		    
		  Else
		    
		    node.Value("name") = Name
		    node.Value("caption") = Caption
		    
		    If value <> "" and SaveValues then
		      node.Value("value") = Value
		    End If
		    
		    
		    node.Value("type") = Type
		    node.Value("visible") = Visible
		    
		    If mask <> "" then
		      node.Value("mask") = mask
		    End If
		    
		    If LimitText>0 then
		      node.Value("limitText") = LimitText
		    End If
		    
		    If Required then
		      node.Value("required") = Required
		    End If
		    
		    
		    
		    If AutoComplete then
		      node.Value("autoComplete") = AutoComplete
		    End If
		    
		    If transparent then
		      node.Value("transparent") = Transparent
		    End If
		    
		    If FontFromCell then
		      node.Value("fontFromCell") = FontFromCell
		    End If
		    
		    If Numeric then
		      node.Value("numeric") = Numeric
		    End If
		    
		    If Format <> "" then
		      node.Value("format") = Format
		    End If
		    
		    If defaultvalue <> "" then
		      node.Value("defaultvalue") = defaultvalue
		    End If
		    
		    If ColorNegativeNum then
		      node.Value("colorNegativeNum") = ColorNegativeNum
		    End If
		    
		    If Folder then 
		      node.Value("folder") = Folder
		    End If
		    
		    
		    
		    If SpecialList<>"" then
		      node.Value("valuelist") = SpecialList
		      
		      If dynamicList then
		        node.Value("dynamicList") = dynamicList
		      End If
		      
		    Elseif UBound(ValueList)>-1 then
		      
		      Dim item As new JSONItem
		      For i as Integer = 0 to UBound(ValueList)
		        item.Append ValueList(i)
		      Next
		      
		      node.Value("valueList") = item
		      
		    End If
		  End If
		  
		  If HelpTag<>"" then
		    node.Value("helpTag") = HelpTag
		  End If
		  
		  If Comment <> "" then
		    node.Value("comment") = Comment
		  End If
		  
		  Return node
		  
		End Function
	#tag EndMethod


	#tag Note, Name = ClassConstants
		<h3>CellType</h3>
		
		The following class constants can be used to specify the values of the CellType and ColumnType properties.
		
		<table>
		Class Constant->Description
		Default constants from the ListBox control:
		TypeDefault->Default, the same as the column type.
		TypeNormal->Normal, read only.
		TypeCheckBox->A check box is added to the cell.
		TypeEditable->The cell is inline editable.
		TypeMultiline->The cell is inline editable and can have several lines.
		TypeList->When clicking the cell, a PopupMenu appears with the list of values the cell can take.
		TypeEditableList->The cell is inline editable and a PopupMenu can appear like TypeList.
		TypeColor->The cell contains a color. Either type the color (RGB format) or click the button to show the SelectColor dialog.
		TypeFolderItem->When clicking the cell, the GetOpenFolderItem or SelectFolder dialog is displayed.
		TypeRadioButton->A check box is added to the cell. Only one TypeRadioButton line for each header can be checked at a time.
		TypeRating->A five-star rating cell.
		TypePicture->Selects a FolderItem and opens it as a picture.
		TypeNumericUpdown->Displays a numeric value with up/down arrows.
		</table>
		
		More line types can be added on demand.
		
	#tag EndNote

	#tag Note, Name = Description
		Class used to contain each row of the PropertyListBox.
		This enables hiding rows, and providing alot more options for each row.
		
	#tag EndNote

	#tag Note, Name = See Also
		
		PropertyListBox, PropertyListLine, PropertyListStyle classes.
		PropertyListModule module.
	#tag EndNote


	#tag Property, Flags = &h0
		#tag Note
			Only used for TypeEditableList lines.
			If true, when editing the value, an Autocomplete window will appear with the list of selectable items.
			The keyboard key used to trigger Autocomplete is defined in the PropertyListBox ShouldTriggerAutocomplete Event.
		#tag EndNote
		AutoComplete As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Only for Header lines.
			The ID of the PropertyListButton that should be displayed for this line.
		#tag EndNote
		ButtonID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Caption of the Property.
		#tag EndNote
		Caption As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			If True and the value of the line is negative (smaller than 0), the value will be displayed in red.
		#tag EndNote
		ColorNegativeNum As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Comment for the line.
		#tag EndNote
		Comment As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Used internally by the PropertyListBox.
		#tag EndNote
		Condensed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The default value of the line.
			If defaultvalue isn't an empty string, the defaultvalueStyle is used to paint the text when the Line's value is different from the defaultvalue.
		#tag EndNote
		defaultvalue As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Only for TypeList and TypeEditableList lines.
			If True, each time the list should be displayed, it is refreshed in the PropertyListBox LoadingValueList Event.
		#tag EndNote
		dynamicList As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Only for Header lines.
			If True, all children lines for the Header will be displayed.
		#tag EndNote
		expanded As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Only used for TypeFolderItem lines.
			If True, when selecting the value for the line, the SelectFolder function is called.
		#tag EndNote
		Folder As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			If True, the value is displayed using the font name from the value.
		#tag EndNote
		FontFromCell As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Only used for Numeric Lines
		#tag EndNote
		Format As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Only used for Header lines.
			If True, the PropertyListButton which's ID matches ButtonID will be displayed.
		#tag EndNote
		hasButton As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			#newinversion 1.7.0
			If True, the Name/label of the property is displayed using the SpecialColor property.
		#tag EndNote
		HasSpecialColor As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The HelpTag displayed when the MouseCursor is over the line.
		#tag EndNote
		HelpTag As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Defines wether a line is a Header or not.
		#tag EndNote
		isHeader As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Only used for TypeEditable and TypeEditableList lines.
			The maximum number of characters allowed in the TextArea.
			The value of zero does not limit text. LimitText works for normal text entry, copy and paste.
			<b>Will not work if RBVersion is newer than 2009r4.</b>
		#tag EndNote
		LimitText As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Only used for TypeEditable and TypeEditableList lines.
			An Entry Filter to be used during data entry.
			See TextEdit.Mask, TextField.Mask or EditField.Mask for more information.
		#tag EndNote
		Mask As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The name of the line.
			This property isn't displayed but is used to reference the line.
		#tag EndNote
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Only used for TypeEditable, TypeEditableList and TypeNormal lines.
			If True, when the Cell looses the focus, the value is processed to evaluate math expressions.
		#tag EndNote
		Numeric As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			If True, the line has a parent header.
		#tag EndNote
		Parent As PropertyListLine
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			If the line is required, the property caption will be displayed in red untill the value contains at least one character.
		#tag EndNote
		Required As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			#newinversion 1.7.0
			The Name/label of the property is displayed using the SpecialColor property if HasSpecialColor is True.
		#tag EndNote
		SpecialColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			.
			If dynamicList is True, this is the passed list name in the PropertyListBox.LoadingValueList Event.
			Only used for TypeList and TypeEditableList
		#tag EndNote
		SpecialList As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			0
			The Tag of the Property Line.
			
		#tag EndNote
		Tag As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Only used for TypeColor lines.
			If true, the line has no color and the PropertyListBox.TransparentString is displayed as the value.
		#tag EndNote
		Transparent As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The Type of the line.
			See the Notes section for more information on the different values this property can take.
			Not significant for Header lines.
		#tag EndNote
		Type As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The value of the line.
		#tag EndNote
		Value As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Only for TypeList and TypeEditableList.
			If dynamicList is False, these values will be displayed in the PopupMenu.
		#tag EndNote
		ValueList() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Determines whether the PropertyListLine is visible.
		#tag EndNote
		Visible As Boolean
	#tag EndProperty


	#tag Constant, Name = kversion, Type = String, Dynamic = False, Default = \"1.8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeCheckBox, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeColor, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeDefault, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeEditable, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeEditableList, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeFolderItem, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeList, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeMultiline, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeNormal, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeNumericUpDown, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypePicture, Type = Double, Dynamic = False, Default = \"11", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeRadioButton, Type = Double, Dynamic = False, Default = \"9", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeRating, Type = Double, Dynamic = False, Default = \"10", Scope = Public
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
			Name="isHeader"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="mask"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SpecialList"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="dynamicList"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Required"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="hasButton"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonId"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoComplete"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="transparent"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontFromCell"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LimitText"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="expanded"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Numeric"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Caption"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Folder"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Comment"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorNegativeNum"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Condensed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Format"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultvalue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasSpecialColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SpecialColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
