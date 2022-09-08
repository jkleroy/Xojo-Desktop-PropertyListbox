#tag Window
Begin Window EditStyle
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Edit Style Window"
   Visible         =   True
   Width           =   341
   Begin PropertyListBox PropertyListBox1
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      AutoCompleteMode=   False
      BBCode          =   False
      Bold            =   False
      ButtonColor     =   0
      ButtonEdit      =   0
      ButtonPopupArrow=   0
      ButtonPopupArrowUp=   0
      ColonString     =   ":"
      ColorGutter     =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      CustomGridLinesColor=   &c00000000
      CustomGridLinesHorizontal=   0
      CustomGridLinesVertical=   0
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      DefaultType     =   0
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   0
      GridLinesVerticalStyle=   0
      HasBorder       =   True
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   366
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      LastEditCell    =   ""
      LastValue       =   ""
      Left            =   20
      LineCount       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MacOSStyle      =   False
      PropertyString  =   "Property"
      RBColorDisplay  =   False
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   0
      Star            =   0
      SyntaxComment   =   ""
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   14
      Transparent     =   True
      TransparentString=   ""
      Underline       =   False
      ValueString     =   ""
      Visible         =   True
      Width           =   301
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Function FormatColor(c As color) As String
		  If c = &c0 then
		    
		    Return "&c000000"
		  End If
		  
		  Dim R, G, B As String
		  
		  
		  R = Hex(c.Red)
		  G = Hex(c.Green)
		  B = Hex(c.Blue)
		  
		  If len(R) = 1 then
		    R = "0" + R
		  End If
		  If len(G) = 1 then
		    G = "0" + G
		  End If
		  If len(B) = 1 then
		    B = "0" + B
		  End If
		  
		  
		  Return "&c" + R + G +B
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Untitled()
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = Definition, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<PropertyListBox version\x3D\"1.1\">\r<name>PropertyListbox Example</name>\r<contents>\r<header visible\x3D\"True\" expanded\x3D\"True\">\r<name>Header Style</name>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>BackColor</name>\r<value>#DBDFFF</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>Bold</name>\r<value>True</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>Italic</name>\r<value>False</value>\r</param>\r<param type\x3D\"5\" visible\x3D\"True\">\r<name>TextAlign</name>\r<value>0 - Left</value>\r<valuelist>0 - Left|1 - Center|2 - Right</valuelist>\r</param>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>TextColor</name>\r<value>&amp;c000000</value>\r</param>\r<param type\x3D\"6\" visible\x3D\"True\" fontfromcell\x3D\"True\">\r<name>TextFont</name>\r<value>System</value>\r<valuelist>fonts</valuelist>\r</param>\r<param type\x3D\"3\" visible\x3D\"True\">\r<name>TextSize</name>\r<value>0</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>Underline</name>\r</param>\r</header>\r<header visible\x3D\"True\" expanded\x3D\"True\">\r<name>Name Style</name>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>BackColor</name>\r<value>&amp;cFFFFFF</value>\r</param>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>BackColorEven</name>\r<value>&amp;cF3F3F3</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>Bold</name>\r</param>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>HighlightColor</name>\r<value>&amp;c3399FF</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>Italic</name>\r<value>False</value>\r</param>\r<param type\x3D\"5\" visible\x3D\"True\">\r<name>TextAlign</name>\r<value>2 - Right</value>\r<valuelist>0 - Left|1 - Center|2 - Right</valuelist>\r</param>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>TextColor</name>\r<value>&amp;c000000</value>\r</param>\r<param type\x3D\"6\" visible\x3D\"True\" fontfromcell\x3D\"True\">\r<name>TextFont</name>\r<value>System</value>\r<valuelist>fonts</valuelist>\r</param>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>TextHighlightColor</name>\r<value>&amp;cFFFFFF</value>\r</param>\r<param type\x3D\"3\" visible\x3D\"True\">\r<name>TextSize</name>\r<value>0</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>Underline</name>\r</param>\r</header>\r<header visible\x3D\"True\" expanded\x3D\"True\">\r<name>Value Style</name>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>BackColor</name>\r<value>&amp;cFFFFFF</value>\r</param>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>BackColorEven</name>\r<value>&amp;cF3F3F3</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>Bold</name>\r<value>False</value>\r</param>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>HighlightColor</name>\r<value>&amp;c3399FF</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>Italic</name>\r<value>#DBDFFF</value>\r</param>\r<param type\x3D\"5\" visible\x3D\"True\">\r<name>TextAlign</name>\r<value>0 - Left</value>\r<valuelist>0 - Left|1 - Center|2 - Right</valuelist>\r</param>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>TextColor</name>\r<value>&amp;c000000</value>\r</param>\r<param type\x3D\"6\" visible\x3D\"True\" fontfromcell\x3D\"True\">\r<name>TextFont</name>\r<value>System</value>\r<valuelist>fonts</valuelist>\r</param>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>TextHighlightColor</name>\r<value>&amp;cFFFFFF</value>\r</param>\r<param type\x3D\"3\" visible\x3D\"True\">\r<name>TextSize</name>\r<value>0</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>Underline</name>\r</param>\r</header>\r<header visible\x3D\"True\" expanded\x3D\"True\">\r<name>Default Value Style</name>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>BackColor</name>\r<value>&amp;cFFFFFF</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>Bold</name>\r<value>False</value>\r</param>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>HighlightColor</name>\r<value>&amp;c3399FF</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>Italic</name>\r<value>#DBDFFF</value>\r</param>\r<param type\x3D\"5\" visible\x3D\"True\">\r<name>TextAlign</name>\r<value>0 - Left</value>\r<valuelist>0 - Left|1 - Center|2 - Right</valuelist>\r</param>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>TextColor</name>\r<value>&amp;c000000</value>\r</param>\r<param type\x3D\"6\" visible\x3D\"True\" fontfromcell\x3D\"True\">\r<name>TextFont</name>\r<value>System</value>\r<valuelist>fonts</valuelist>\r</param>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>TextHighlightColor</name>\r<value>&amp;cFFFFFF</value>\r</param>\r<param type\x3D\"3\" visible\x3D\"True\">\r<name>TextSize</name>\r<value>0</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>Underline</name>\r</param>\r</header>\r</contents>\r</PropertyListBox>", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events PropertyListBox1
	#tag Event
		Sub CellValueChanged(row As integer, column As integer, PropertyName As String, Value As String)
		  #Pragma Unused row
		  #Pragma Unused column
		  
		  
		  If PropertyName.NthField(".", 1).Right(5) = "style" then
		    Dim s As PropertyListStyle
		    
		    If PropertyName.InStr("header")>0 then
		      s = me.headerStyle
		      CreatorWindow.BuildBox.headerStyle = s
		    elseif PropertyName.InStr("name")>0 then
		      s = me.nameStyle
		      CreatorWindow.BuildBox.nameStyle = s
		    elseif PropertyName.InStr("default value")>0 then
		      s = me.defaultvalueStyle
		      CreatorWindow.BuildBox.defaultvalueStyle = s
		    elseif PropertyName.InStr("value")>0 then
		      s = me.valueStyle
		      CreatorWindow.BuildBox.valueStyle = s
		      
		    else
		      Return
		    End If
		    
		    
		    Dim c As Color
		    Dim Colour As variant = Value.Replace("#", "&c")
		    c = RGB(Colour.ColorValue.Red, Colour.ColorValue.Green, Colour.ColorValue.Blue)
		    
		    Select Case PropertyName.NthField(".", 2)
		    Case "BackColor"
		      'Dim c As variant = Value.Replace("#", "&c")
		      s.BackColor = c
		    Case "Bold"
		      s.Bold = (Value = "True")
		    Case "HighlightColor"
		      'Dim c As variant = Value.Replace("#", "&c")
		      s.HighlightColor = c
		    Case "Italic"
		      s.Italic = (Value = "True")
		    Case "TextAlign"
		      s.TextAlign = val(value)
		    Case "TextColor"
		      'Dim c As variant = Value.Replace("#", "&c")
		      s.TextColor = c
		    Case "TextFont"
		      s.TextFont = Value
		    Case "TextHighlightColor"
		      'Dim c As variant = Value.Replace("#", "&c")
		      s.TextHighlightColor = c
		    Case "TextSize"
		      s.TextSize = val(value)
		    Case "Underline"
		      s.Underline = (Value = "True")
		      
		    End Select
		    
		    me.InvalidateCell(-1, -1)
		    CreatorWindow.BuildBox.Refresh
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  me.RBColorDisplay = True
		  Call me.LoadFromXML(Definition)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ContentsChanged(ContentsName As String, Comment As String)
		  #Pragma Unused ContentsName
		  #Pragma Unused Comment
		  
		  Dim p As PropertyListLine
		  Dim s As PropertyListStyle
		  s = CreatorWindow.Buildbox.headerStyle
		  me.headerStyle = s
		  
		  Dim myAtt() As Introspection.PropertyInfo= Introspection.GetType(s).GetProperties
		  
		  For i as Integer = 0 to myAtt.Ubound
		    p = me.GetLine("Header style." + str(myAtt(i).Name))
		    
		    
		    If p <> Nil then
		      
		      If myAtt(i).PropertyType.Name = "Color" then
		        Dim v As Variant = myAtt(i).Value(s)
		        p.Value = FormatColor(v.ColorValue)
		      Else
		        Dim a As String = myAtt(i).Value(s)
		        p.Value = a
		      End If
		    End If
		  Next
		  
		  s = CreatorWindow.Buildbox.nameStyle
		  me.nameStyle = s
		  myAtt() = Introspection.GetType(s).GetProperties
		  
		  For i as Integer = 0 to myAtt.Ubound
		    p = me.GetLine("Name style." + str(myAtt(i).Name))
		    
		    
		    If p <> Nil then
		      Dim a As String = myAtt(i).Value(s)
		      p.Value = a
		    End If
		  Next
		  
		  s = CreatorWindow.Buildbox.valueStyle
		  me.valueStyle = s
		  myAtt() = Introspection.GetType(s).GetProperties
		  
		  For i as Integer = 0 to myAtt.Ubound
		    p = me.GetLine("Value style." + str(myAtt(i).Name))
		    
		    
		    If p <> Nil then
		      Dim a As String = myAtt(i).Value(s)
		      p.Value = a
		    End If
		  Next
		  
		  s = CreatorWindow.Buildbox.defaultvalueStyle
		  me.defaultvalueStyle = s
		  myAtt() = Introspection.GetType(s).GetProperties
		  
		  For i as Integer = 0 to myAtt.Ubound
		    p = me.GetLine("Default Value style." + str(myAtt(i).Name))
		    
		    
		    If p <> Nil then
		      Dim a As String = myAtt(i).Value(s)
		      p.Value = a
		    End If
		  Next
		  
		  me.Reload
		End Sub
	#tag EndEvent
	#tag Event
		Function LoadingValueList(ValueName As String) As String()
		  ValueName = ValueName
		  
		  If ValueName = "fonts" then
		    Dim a() As String
		    For i as integer = 0 to FontCount - 1
		      If left(font(i), 1) <> "@" then
		        a.Append font(i)
		      End If
		    Next
		    a.Sort
		    Return a()
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Position"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Appearance"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
