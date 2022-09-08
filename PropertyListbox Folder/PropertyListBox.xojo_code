#tag Class
Protected Class PropertyListBox
Inherits ListBox
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Dim TrueRow As Integer = TrueRow(row)
		  If Lines(TrueRow).Parent <> Nil then
		    CellAction(row, Column, Lines(TrueRow).Parent.Name + "." + Lines(TrueRow).Name, Lines(TrueRow).Value)
		  Else
		    CellAction(row, Column, Lines(TrueRow).Name, Lines(TrueRow).Value)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  
		  Dim u As Integer = UBound(Lines)
		  
		  If nameStyle is Nil or headerStyle is Nil or valueStyle is Nil then
		    Return False
		  End If
		  
		  Dim TrueRow As Integer = -1
		  If u<0 or row > u or row>ListCount-1 then 
		    //nothing
		  else
		    TrueRow = TrueRow(row)
		  End If
		  
		  If RowHeight = 0 then
		    mRowHeight = g.Height
		  End If
		  
		  //Possible fix
		  If TrueRow>u then
		    Return False
		  End If
		  
		  //Color the row background
		  If TrueRow > -1 and Lines(TrueRow).isHeader then //Header
		    g.DrawingColor = headerStyle.BackColor
		    g.FillRect(0,0, g.Width, g.Height)
		    
		  Elseif Column = 0 then
		    If row = ListIndex then //Row is highlighted
		      If hasFocus then
		        g.DrawingColor = nameStyle.HighlightColor
		      Else
		        g.DrawingColor = &cD4D0C8
		      End If
		    Else
		      If row mod 2 = 0 then
		        g.DrawingColor = nameStyle.BackColorEven
		      else
		        g.DrawingColor = nameStyle.BackColor
		      End If
		    End If
		    
		    g.FillRect(0,0, g.Width, g.Height)
		    
		    
		  Elseif Column = 1 then 
		    If row = ListIndex then //Row is highlighted
		      If hasFocus then
		        g.DrawingColor = valueStyle.HighlightColor
		      Else
		        g.DrawingColor = &cD4D0C8
		      End If
		    Else
		      If TrueRow > -1 and Lines(TrueRow).defaultvalue <> "" and Lines(TrueRow).Value <> Lines(TrueRow).defaultvalue then
		        g.DrawingColor = defaultvalueStyle.BackColor
		      else
		        If row mod 2 = 0 then
		          g.DrawingColor = valueStyle.BackColorEven
		        else
		          g.DrawingColor = valueStyle.BackColor
		        End If
		      End If
		    End If
		    
		    g.FillRect(0,0, g.Width, g.Height)
		    
		  Else
		    //We do not handle Columns > 1
		    Return False
		    
		  End If
		  
		  //GridLines
		  If CustomGridLinesHorizontal>1 then
		    g.DrawingColor = CustomGridLinesColor
		    If CustomGridLinesHorizontal = 2 then
		      DrawDottedLine(g, 0, g.Height-1, g.Width-1, g.Height-1)
		    else
		      g.DrawLine(0, g.Height-1, g.Width-1, g.Height-1)
		    End If
		  End If
		  If CustomGridLinesVertical>1 then
		    g.DrawingColor = CustomGridLinesColor
		    If CustomGridLinesVertical = 2 then
		      DrawDottedLine(g, g.Width-1, 0, g.Width-1, g.Height-1)
		    else
		      g.DrawLine(g.Width-1, 0, g.Width-1, g.Height-1)
		    End If
		  End If
		  
		  //Gutter
		  If Column = 0 and me.Hierarchical and ColorGutter then
		    g.DrawingColor = headerStyle.BackColor
		    g.FillRect(0, 0, 19, g.Height)
		  End If
		  
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Function CellClick(row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  
		  Dim TrueRow as Integer = TrueRow(row)
		  If CellClick(row, column, x, y, Lines(TrueRow).ParentName + Lines(TrueRow).Name) then
		    Return True
		  End If
		  
		  If IsContextualClick then Return False
		  
		  Return handleCellClick(row, column, x, y)
		End Function
	#tag EndEvent

	#tag Event
		Function CellKeyDown(row as Integer, column as Integer, key as String) As Boolean
		  If CellType(row, Column) = TypeEditableList then
		    If SuggestionWnd <> Nil then
		      
		      If key = chr(30) then
		        SuggestionWnd.optionList.ListIndex = SuggestionWnd.optionList.ListIndex - 1
		        Return True
		      Elseif key = chr(31) then
		        SuggestionWnd.optionList.ListIndex = SuggestionWnd.optionList.ListIndex + 1
		        Return True
		      Elseif ShouldTriggerAutocomplete(key, SuggestionWnd.optionList.ListCount>0) then
		        Dim begin As String = ActiveCell.Text
		        begin = begin.NthField(" ", begin.CountFields(" "))
		        ActiveCell.SelStart = ActiveCell.SelStart - begin.len
		        ActiveCell.SelLength = begin.len
		        ActiveCell.SelText = SuggestionWnd.optionList.Text
		        ActiveCell.SelStart = ActiveCell.Text.len
		        
		        'ActiveCell.Text = ActiveCell.Text + SuggestionWnd.optionList.Text.Replace(begin, "")
		        'ActiveCell.SelStart = ActiveCell.Text.Len
		        Return True
		      Elseif key = chr(9) then
		        Return handleCellClick(row + 1, column, 0, 0)
		      End if
		    End If
		    
		  Elseif key = chr(9) then
		    If Keyboard.ShiftKey then
		      Return handleCellClick(row - 1, column, 0, 0)
		    else
		      Return handleCellClick(row + 1, column, 0, 0)
		    End If
		  End If
		  
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Sub CellLostFocus(row as Integer, column as Integer)
		  Dim TrueRow As Integer = TrueRow(row)
		  
		  If Lines(TrueRow).AutoComplete then
		    If SuggestionWnd <> Nil then
		      SuggestionWnd.Close
		      
		    End If
		  End If
		  
		  
		  Dim theText as String = Cell(row, Column)
		  
		  If CellType(row, Column) = TypeColor then
		    theText = handleCellColor(row, column, theText)
		    Cell(row, Column) = theText
		  End If
		  
		  If Lines(TrueRow).Numeric then
		    theText = PropertyListModule.MathsEvaluate(theText, Lines(TrueRow).Value)
		    Cell(row,Column) = theText
		    Lines(TrueRow).Value = theText
		  End If
		  
		  
		  If column = 0 then
		    Lines(TrueRow).Name = theText
		    Lines(TrueRow).Caption = theText
		  Elseif column = 1 then
		    Lines(TrueRow).Value = theText
		  End If
		  
		  If Lines(TrueRow).Parent <> Nil then
		    CellValueChanged(row, column, Lines(TrueRow).Parent.Name + "." + Lines(TrueRow).Name, theText)
		  Else
		    CellValueChanged(row, column, Lines(TrueRow).Name, theText)
		  End If
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub CellTextChange(row as Integer, column as Integer)
		  
		  If Lines(TrueRow(row)).AutoComplete then
		    If SuggestionWnd <> Nil then
		      Dim theLine As PropertyListLine = Lines(TrueRow(Row))
		      Dim tmpList() As String
		      If theLine.dynamicList then
		        tmpList = LoadingValueList(theLine.SpecialList)
		      Else
		        tmpList = theLine.ValueList
		      End If
		      //A corriger pour trouver bonne méthode
		      #if RBVersion > 2008.03
		        If tmpList = nil then Return
		      #endif
		      Dim u As Integer = UBound(tmpList)
		      If u =-1 then Return
		      
		      Dim begin As String = Cell(row, column)
		      //A corriger pour autoriser d'autres séparateurs
		      'If begin.NthField(" ", begin.CountFields(" ")-1) = "get" then
		      'begin = "get " + begin.NthField(" ", begin.CountFields(" "))
		      'else
		      begin = begin.NthField(" ", begin.CountFields(" "))
		      'End If
		      Dim lentext As Integer = len(begin)
		      Dim options() As String
		      For i as Integer = 0 to u
		        If tmpList(i).left(lentext) = begin then
		          options.Append tmpList(i)
		        End If
		      Next
		      
		      SuggestionWnd.loadSuggestions(Options(), True)
		      
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  #pragma Unused x
		  #pragma Unused y
		  
		  Dim TrueRow As Integer = TrueRow(row)
		  Dim text As String = Cell(row, Column)
		  
		  Dim ButtonWidth As Integer
		  
		  
		  //Header
		  If TrueRow > -1 and Lines(TrueRow).isHeader then
		    
		    #if PropertyListModule.UseBBCode
		      If BBCode then
		        handleBBCodeDrawing(text, headerStyle, g)
		        Return True
		      End If
		    #endif
		    
		    g.DrawingColor = headerStyle.TextColor
		    g.Bold = headerStyle.Bold
		    g.Italic = headerStyle.Italic
		    g.Underline = headerStyle.Underline
		    If headerStyle.TextSize = 0 then
		      g.TextSize = me.TextSize
		    else
		      g.TextSize = headerStyle.TextSize
		    End If
		    g.TextFont = headerStyle.TextFont
		    
		    If Lines(TrueRow).hasButton and column = 1 then
		      Dim btn As Integer = Lines(TrueRow).ButtonId
		      For i as Integer = 0 to UBound(CustomButtons)
		        If CustomButtons(i).id = btn then
		          Dim txtX As Integer = g.Width - CustomButtons(i).Pic.Width-2
		          Dim txtY As Integer = (RowHeight - CustomButtons(i).Pic.Height)/2
		          g.DrawPicture CustomButtons(i).Pic, txtX, txtY
		          
		          #if TargetMacOS
		            g.DrawingColor = &c4E4E4E
		            g.TextSize = 12
		            g.DrawString(CustomButtons(i).Caption, txtX + 2, txtY + 11)
		          #endif
		          Exit for i
		        End If
		      Next
		    End If
		    Dim a As Integer = RowHeight
		    a = g.TextHeight
		    g.DrawString text, 0, (RowHeight - g.TextHeight)\2 + g.TextAscent, g.Width, True
		    
		    If g.StringWidth(text) > g.Width then
		      Lines(TrueRow).Condensed = True
		    else
		      Lines(TrueRow).Condensed = False
		    End If
		    
		    Return True
		    
		  End If
		  
		  Dim currentStyle As PropertyListStyle
		  If Column = 0 then
		    currentStyle = nameStyle
		  Elseif Column = 1 then
		    If Lines(TrueRow).defaultvalue <> "" and Lines(TrueRow).Value <> Lines(TrueRow).defaultvalue then
		      currentStyle = defaultvalueStyle
		    else
		      currentStyle = valueStyle
		    End If
		  Else
		    //Column > 1
		    Return False
		  End If
		  
		  
		  
		  if row<=Listcount-1 then ' and Column>0 then
		    If CellType(row, Column) <> TypeColor then
		      If ListIndex = row and hasFocus then
		        g.DrawingColor = currentStyle.TextHighlightColor
		      Else
		        g.DrawingColor = currentStyle.TextColor
		      End If
		    End If
		    g.Bold = currentStyle.Bold
		    g.Italic = currentStyle.Italic
		    g.Underline = currentStyle.Underline
		    If currentStyle.TextSize = 0 then
		      g.TextSize = me.TextSize
		    else
		      g.TextSize = currentStyle.TextSize
		    End If
		    g.TextFont = currentStyle.TextFont
		    
		    If Column = 0 and TrueRow >-1 and Lines(TrueRow).Required and Cell(row, 1) = "" then
		      //Required Text Color
		      //a corriger
		      g.DrawingColor = &cFF3333
		    End if
		    
		    If Column = 0 then
		      If text <> "" then
		        
		        If Lines(TrueRow).HasSpecialColor then
		          g.DrawingColor = Lines(TrueRow).SpecialColor
		        End If
		        
		        #if PropertyListModule.UseBBCode
		          If BBCode then
		            handleBBCodeDrawing(text, nameStyle, g)
		            Return True
		          End If
		        #endif
		        
		        
		        If g.StringWidth(text) > g.Width - 6 then
		          Lines(TrueRow).Condensed = True
		        else
		          Lines(TrueRow).Condensed = False
		        End If
		        
		        If currentStyle.TextAlign = 0 then
		          g.DrawString text, 0, (RowHeight - g.TextHeight)\2 + g.TextAscent, g.Width - 6, True
		        elseif currentStyle.TextAlign = 1 then
		          g.DrawString text, max(0, (g.Width - g.StringWidth(text))\2), (RowHeight - g.TextHeight)\2 + g.TextAscent, g.Width - 6, True
		        Elseif currentStyle.TextAlign = 2 then
		          g.DrawString text, g.Width - g.StringWidth(text) - min(5, g.width - g.StringWidth(text)), (RowHeight - g.TextHeight)\2 + g.TextAscent, g.Width - 6, True
		        Else
		          Return False
		        End If
		        
		        Return True
		      End If
		    End If
		    
		    //font from cell
		    If column = 1 and Lines(TrueRow).FontFromCell then
		      g.TextFont = cell(row, 1)
		    End If
		    If TrueRow >-1 and Lines(TrueRow).Numeric and Lines(TrueRow).ColorNegativeNum and Val(Lines(TrueRow).Value) < 0 then
		      g.DrawingColor = &cFF3333
		    End If
		    
		    Select Case CellType(row, Column)
		    Case TypeMultiline, TypeFolderItem //Type multiline, folderitem
		      ButtonWidth = ButtonEdit.Width
		      
		      g.DrawPicture ButtonEdit, g.Width - ButtonWidth-2, (RowHeight - ButtonEdit.Height)/2
		      
		    Case TypeNormal, TypeEditable
		      If Lines(TrueRow).Numeric and Lines(TrueRow).Format <> "" then
		        Text = Format(val(text), Lines(TrueRow).Format)
		      End If
		      
		    Case TypeList, TypeEditableList //Type List, EditableList
		      ButtonWidth = ButtonPopupArrow.Width
		      
		      g.DrawPicture ButtonPopupArrow, g.Width - ButtonWidth-2, (RowHeight - ButtonPopupArrow.Height)/2
		      
		      If Lines(TrueRow).Numeric and Lines(TrueRow).Format <> "" then
		        Text = Format(val(text), Lines(TrueRow).Format)
		      End If
		      
		    Case TypeColor //Type Color
		      ButtonWidth = ButtonColor.Width
		      g.DrawingColor = GetColor(CellTag(row, 1), 1)
		      if text<>"" then
		        If row = listindex then
		          g.FillRect 1, 2, g.Width-3, RowHeight-3
		        Else
		          g.FillRect 0, 0, g.Width, RowHeight
		        End If
		      end if
		      
		      g.DrawPicture ButtonColor, g.Width - ButtonWidth-2, (RowHeight - ButtonColor.Height)/2
		      g.DrawingColor = GetColor(CellTag(row, 1), 0)
		      
		    Case TypeRating
		      
		      If HasRankCell <> True then
		        HasRankCell = True
		      End If
		      
		      Dim value As Integer
		      Dim StarWidth As Integer = Star.Width
		      Dim StarHeight As Integer = Star.Height
		      #if TargetMacOS
		        StarWidth = StarWidth/2
		        StarHeight = StarHeight/2
		      #endif
		      
		      If row = RankMouseOver(0) and column = RankMouseOver(1) and RankMouseOver(2)>-1 then
		        value = RankMouseOver(2)
		      else
		        value = val(Cell(row, Column))
		      End If
		      #if TargetMacOS
		        For i as integer = 1 to value
		          g.DrawPicture Star, (i-1)*StarWidth + 2 , (RowHeight - StarHeight)\2, StarWidth, StarHeight, 0, 0, Star.Width, Star.Height
		        Next
		      #else
		        For i as integer = 1 to value
		          g.DrawPicture Star, (i-1)*StarWidth + 2 , (RowHeight - StarHeight)\2
		        Next
		      #endif
		      g.DrawingColor = &cADADAD
		      For i as Integer = value to 4
		        g.FillRect (StarWidth*i) + StarWidth\2 + 2, (RowHeight - StarHeight)\2 + 6, 2, 2
		      Next
		      Return True
		      
		    Case TypePicture
		      ButtonWidth = ButtonEdit.Width
		      
		      If me.CellTag(row, column) isa Picture then
		        Dim p As Picture = me.CellTag(row, column)
		        Dim w1, h1, w2, h2 As Integer
		        
		        w1 = p.Width
		        h1 = p.Height
		        w2 = g.Width - ButtonWidth - 4 //maximum width is 140 pixels
		        h2 = RowHeight //maximum height is 140 pixels
		        
		        Dim Ratio As Single = Min(w2 / w1, h2 / h1)
		        Ratio = Min(Ratio, 1.0)
		        
		        g.DrawPicture(p, 0,0, w2, h2, 0,0, w2/Ratio, h2/Ratio)
		      End If
		      
		      g.DrawPicture ButtonEdit, g.Width - ButtonWidth-2, (RowHeight - ButtonEdit.Height)/2
		      Return True
		      
		    Case TypeNumericUpDown
		      ButtonWidth = ButtonPopupArrow.Width
		      
		      g.DrawPicture ButtonPopupArrow, g.Width - ButtonWidth-2, RowHeight - ButtonPopupArrow.Height-1
		      g.DrawPicture ButtonPopupArrowUp, g.Width - ButtonWidth-2, 1
		      
		    Case TypeDatePicker
		      
		      
		      DrawArrows(g)
		      DrawButtonCalendar(g)
		      
		      'g.DrawString text, max(22
		      
		      
		    End Select
		    If text<>"" then
		      
		      If currentStyle.TextAlign = 0 then
		        g.DrawString text, 0, (RowHeight - g.TextHeight)\2 + g.TextAscent, g.Width - 6 - ButtonWidth, True
		      elseif currentStyle.TextAlign = 1 then
		        g.DrawString text, max(0, (RowHeight - g.StringWidth(text))\2), (RowHeight - g.TextHeight)\2 + g.TextAscent, g.Width - 6 - ButtonWidth, True
		      Elseif currentStyle.TextAlign = 2 then
		        g.DrawString text, g.Width - g.StringWidth(text) - min(5, g.width - g.StringWidth(text)) - 13, (RowHeight - g.TextHeight)\2 + g.TextAscent, g.Width - 6 - ButtonWidth, True
		      Else
		        Return False
		      End If
		      
		    End If
		    Return True
		  End If
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Sub CollapseRow(row As Integer)
		  Dim TrueRow As Integer = TrueRow(row)
		  If Lines(TrueRow).expanded then
		    Lines(TrueRow).expanded = false
		    'LoadRows
		    'NoRefresh = True
		    RemoveRows(TrueRow, row)
		    'NoRefresh = False
		    
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub DoubleClick()
		  If Hierarchical then
		    Dim TrueRow As Integer = TrueRow(me.ListIndex)
		    If Lines(TrueRow).isHeader then
		      Dim value As Boolean = Not Me.expanded( Me.listindex)
		      Me.expanded( Me.listindex)= value
		      Lines(TrueRow(me.ListIndex)).expanded = value
		    else
		      DoubleClick
		    End If
		  else
		    DoubleClick
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ExpandRow(row As Integer)
		  Dim TrueRow As Integer = TrueRow(row)
		  If not Lines(TrueRow).expanded then
		    Lines(TrueRow).expanded = true
		    InsertRows(TrueRow)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub GotFocus()
		  hasFocus = True
		End Sub
	#tag EndEvent

	#tag Event
		Function HeaderPressed(column as Integer) As Boolean
		  #pragma Unused Column
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Function KeyDown(Key As String) As Boolean
		  If Key = chr(10) or key=chr(13) or key=chr(13)+chr(10) or key=chr(32) then
		    Return handleCellClick(ListIndex, 1, 0, 0, Key)
		  elseif Key = chr(30) then
		    ListIndex = NextEditableRow(ListIndex, False)
		    Return True
		  elseif Key = chr(31) then
		    ListIndex = NextEditableRow(ListIndex)
		    Return True
		  elseif asc(key) > 32 and asc(key) < 127 then
		    Return FindNextFromKey(Key)
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub LostFocus()
		  hasFocus = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  Dim row As Integer = RowFromXY(X, Y)
		  
		  If row = - 1 then 
		    If isIBeam then
		      me.MouseCursor = System.Cursors.StandardPointer
		    Elseif RankMouseOver(0) > -1 then
		      RankMouseOver(2) = -1
		      InvalidateCell(RankMouseOver(0), RankMouseOver(1))
		      
		      RankMouseOver(0) = -1
		      RankMouseOver(1) = -1
		      RankMouseOver(2) = -1
		      
		    End If
		    ChangeHelpTag(DefaultHelpTag)
		    Return
		  End If
		  
		  Dim col As Integer = ColumnFromXY(X, Y)
		  Dim changeToIBeam As Boolean
		  
		  
		  If HasRankCell and RankMouseOver(0)>-1 and (RankMouseOver(0)<>row or RankMouseOver(1)<>Col) and RankMouseOver(1)>-1 then
		    //A corriger: flickering
		    InvalidateCell(RankMouseOver(0), RankMouseOver(1))
		  End If
		  
		  Select Case CellType(Row, Col)
		  Case TypeEditable
		    changeToIBeam = True
		    
		    
		  Case TypeMultiline
		    If X<me.Column(1).WidthActual + me.Column(0).WidthActual - ButtonEdit.Width - 3 then
		      changeToIBeam = True
		    End If
		  Case TypeEditableList
		    If X<me.Column(1).WidthActual + me.Column(0).WidthActual - ButtonPopupArrow.Width - 3 then
		      changeToIBeam = True
		    End If
		  Case TypeColor
		    If X<me.Column(1).WidthActual + me.Column(0).WidthActual - ButtonColor.Width - 3 then
		      changeToIBeam = True
		    End If
		  Case TypeRating
		    
		    If col>-1 and col<ColumnCount then
		      Dim cellLeft, cellTop As Integer
		      getCellXY(row, col, cellLeft, cellTop)
		      
		      Dim cellX As Integer = X - cellLeft + self.Left + self.Window.Left
		      Dim StarWidth As Integer
		      #if TargetMacOS
		        StarWidth = Star.Width/2
		      #else
		        StarWidth = Star.Width
		      #endif
		      
		      If cellX<StarWidth\2+2 then
		        RankMouseOver(2) = 0
		      else
		        RankMouseOver(2) = min((cellX-StarWidth) \ (StarWidth) + 1, 5)
		      End If
		      RankMouseOver(0) = row
		      RankMouseOver(1) = col
		      
		      InvalidateCell(row, col)
		      
		    ElseIf RankMouseOver(0)>-1 then
		      RankMouseOver(0) = -1
		      RankMouseOver(1) = -1
		      RankMouseOver(2) = -1
		    End If
		    
		  End Select
		  
		  RankMouseOver(0) = Row
		  RankMouseOver(1) = Col
		  
		  If changeToIBeam and not isIBeam then
		    me.MouseCursor = System.Cursors.IBeam
		  Elseif not changeToIBeam and isIBeam then
		    me.MouseCursor = System.Cursors.StandardPointer
		  End If
		  isIBeam = changeToIBeam
		  If Col = 0 then
		    Dim TrueRow As Integer = TrueRow(row)
		    If TrueRow>-1 and Lines(TrueRow).Condensed then
		      #If RBVersion >= 2009.2 then
		        me.CellHelpTag(row, col) = Lines(TrueRow(row)).Name
		      #else
		        ChangeHelpTag(Lines(TrueRow(row)).Name)
		      #endif
		    else
		      #If RBVersion >= 2009.2 then
		        me.CellHelpTag(row, col) = ""
		      #endif
		      ChangeHelpTag(Lines(TrueRow(row)).HelpTag)
		    End If
		  else
		    #If RBVersion >= 2009.2 then
		      me.CellHelpTag(row, col) = ""
		    #endif
		    ChangeHelpTag(Lines(TrueRow(row)).HelpTag)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseWheel(X As Integer, Y As Integer, deltaX as Integer, deltaY as Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  #pragma Unused deltaX
		  
		  If Keyboard.AsyncControlKey then
		    me.TextSize = min(24, max(8, me.TextSize + deltaY / Abs(deltaY)))
		    'me.DefaultRowHeight
		    Return True
		  End If
		  
		  If SuggestionWnd <> Nil then
		    SuggestionWnd.optionList.ListIndex = SuggestionWnd.optionList.ListIndex + Abs(deltaY) / deltaY
		    Return True
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  #if TargetMacOS then
		    MacOSStyle = True
		  #endif
		  
		  AutoUpdate()
		  
		  me.ColumnCount = 2
		  me.ColumnWidths="50% 50%"
		  me.ValueString = "Value"
		  me.PropertyString = "Property"
		  If HasHeader then
		    me.InitialValue = "Property" + chr(9) + "Value"
		  End If
		  TransparentString = "transparent"
		  me.ColumnAlignment(0) = me.AlignRight
		  
		  'me.CustomGridLinesColor  = &cDBDFFF
		  'me.CustomGridLinesVertical = 2
		  'me.CustomGridLinesHorizontal = 2
		  
		  
		  LoadButtons()
		  SelectionType = -1
		  
		  headerStyle = new PropertyListStyle("header", &cDBDFFF, True)
		  nameStyle = new PropertyListStyle("name", 2)
		  valueStyle = new PropertyListStyle("value")
		  defaultvalueStyle = new PropertyListStyle("defaultvalue")
		  
		  DefaultHelpTag = HelpTag
		  
		  Open()
		  
		  //Delete this
		  
		  If not Registered then
		    DemoMessage()
		  End If
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function SortColumn(column As Integer) As Boolean
		  #pragma Unused Column
		  
		  Return True
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AutoUpdate()
		  #if DebugBuild and False
		    If not System.Network.IsConnected then
		      Return
		    End If
		    
		    Dim f As FolderItem = SpecialFolder.ApplicationData.Child(kProductKey)
		    If f Is Nil or not f.exists then f.CreateAsFolder
		    f = f.Child("config.ini")
		    
		    Dim txt As String
		    Dim lastcheck As new date
		    Dim d As new date
		    lastcheck.Month = d.Month-2
		    If f <> Nil and f.Exists then
		      Dim ti As TextInputStream
		      ti = ti.Open(f)
		      
		      While txt.left(4) <> "last" and not ti.EOF
		        txt = ti.ReadLine
		      Wend
		      
		      If txt.Left(4) = "last" then
		        lastcheck.SQLDateTime = txt.NthField("=", 2)
		        
		        If lastcheck.TotalSeconds + 172800.0 > d.TotalSeconds then
		          Return
		        End If
		      End If
		    End If
		    
		    If OldRegistered then
		      Dim n As Integer
		      n = MsgBox("You are currently using an old registration System for the " + kProductKey + EndOfLine + EndOfLine + _
		      "Would you like to contact Jeremie Leroy to update your registration key ?", 36)
		      If n = 6 then
		        ShowURL("http://www.jeremieleroy.com/products.php#" + kProductKey)
		      End If
		    End If
		    
		    Dim update As New HTTPSocket
		    Dim result As String = update.Get("http://live.jeremieleroy.com/autoupdate.php?item=" + me.kProductKey + "&version=" + str(me.kVersion), 5)
		    
		    Dim updateAvailable As Boolean = True
		    
		    
		    If left(Result, len(kProductKey)) <> kProductKey then
		      updateAvailable = False
		    End If
		    
		    If NthField(result, ":", 2) = "" or NthField(result, ":", 2) = "no update" then
		      updateAvailable = False
		    End If
		    
		    If updateAvailable Then
		      Dim n As new MessageDialog
		      Dim b As MessageDialogButton
		      n.ActionButton.Caption = "Update"
		      n.CancelButton.Visible = True
		      n.CancelButton.Caption = "Later"
		      
		      n.Title = "New version available"
		      n.Message = "New version of the " + kProductKey + " is available." + EndOfLine + _
		      NthField(result, ":", 2) + EndOfLine + _
		      EndOfLine + _
		      "Would you like to download the update now ?" + EndOfLine + EndOfLine + _
		      "(This message will only appear in DebugBuild)"
		      
		      b=n.ShowModal //display the dialog
		      Select Case b //determine which button was pressed.
		      Case n.ActionButton
		        ShowURL("http://www.jeremieleroy.com/products.php#" + kProductKey)
		      Case n.CancelButton
		        //user pressed Cancel
		      End select
		    End If
		    
		    Dim ts As TextOutputStream
		    If f <> Nil Then
		      ts = TextOutputStream.Create(f)
		      ts.Write "[Settings]" + EndOfLine
		      ts.Write "lastcheck=" + d.SQLDateTime
		      ts.Close
		    End If
		    
		    
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CellValue(PropertyName As String, MathsEval As Boolean = False) As Variant
		  //Returns the value as a variant of the requested property.
		  //The PropertyName is considered as an object.
		  //If you want to get the value of a Property but several Properties share the same name under different headers then refer to the Property as:
		  //HeaderName.PropertyName
		  
		  
		  #pragma BackgroundTasks false
		  #pragma BoundsChecking false
		  #pragma NilObjectChecking false
		  #pragma StackOverflowChecking false
		  
		  Dim theLine As PropertyListLine
		  Dim v As Variant
		  
		  If PropertyName.InStr(".")>0 then
		    Dim headerName As String = PropertyName.NthField(".", 1)
		    Dim paramName As String = PropertyName.NthField(".", 2)
		    
		    Dim foundHeader As Boolean
		    For i as Integer = 0 to UBound(Lines)
		      theLine = Lines(i)
		      If foundHeader and theLine.isHeader then
		        #if DebugBuild then
		          Break
		        #endif
		        Return ""
		      End If
		      If theLine.isHeader = True and theLine.Name = headerName then
		        foundHeader = True
		        Continue for i
		      End If
		      If foundHeader and theLine.Name = paramName then
		        
		        If theLine.Type = TypeCheckBox or theLine.Type = TypeRadioButton then
		          v = theline.Value
		          'v = CellCheck(TrueRow(i, False), 1)
		          
		          'Elseif theLine.Type = TypeColor then
		          //A corriger: mettre backcolor et textcolor dans PropertyListLine au lieu du tag
		        else
		          v = theLine.Value
		          'v = Cell(TrueRow(i, False), 1)
		        End If
		        Return v
		      End if
		    Next
		  End If
		  
		  For i as Integer = 0 to UBound(Lines)
		    theLine = Lines(i)
		    
		    If theLine.Name = PropertyName then
		      If theLine.Type = TypeCheckBox or theLine.Type = TypeRadioButton then
		        v = theline.Value
		        'v = CellCheck(TrueRow(i, False), 1)
		      Elseif MathsEval and theLine.Numeric and (theLine.Type = TypeNormal or theLine.Type = TypeEditable or theLine.Type = TypeEditableList) then
		        v = PropertyListModule.MathsEvaluate(theLine.Value, theLine.Value)
		      else
		        v = theLine.Value
		        'v = Cell(TrueRow(i, False), 1)
		      End If
		      Return v
		    End if
		  Next
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CellValue(PropertyName As String, RaiseCellValueChanged As Boolean = False, Assigns Value As String)
		  //Assigns the Value to the Property found by its name.
		  //The PropertyName is considered as an object.
		  //If you want to assign a value to a parameter but several Properties share the same name under different headers then refer to the Property as:
		  //HeaderName.PropertyName
		  //
		  //If the Property wasn't found then it will search through each Property and assign the value
		  //even if it is a header.
		  //RaiseCellValueChanged is optional. If True, the CellValueChanged event will fire after assigning the Value.
		  
		  #pragma BackgroundTasks false
		  #pragma BoundsChecking false
		  #pragma NilObjectChecking false
		  #pragma StackOverflowChecking false
		  
		  Dim theLine As PropertyListLine
		  Dim ii As Integer
		  If PropertyName.InStr(".")>0 And PropertyName.Instr("..") = 0 then
		    Dim headerName As String = PropertyName.NthField(".", 1)
		    Dim paramName As String = PropertyName.NthField(".", 2)
		    
		    Dim foundHeader As Boolean
		    For i as Integer = 0 to UBound(Lines)
		      theLine = Lines(i)
		      If foundHeader and theLine.isHeader then 
		        #if DebugLines then
		          Break
		        #endif
		        Return
		      End If
		      If theLine.isHeader = True and theLine.Name = headerName then
		        foundHeader = True
		        Continue for i
		      End If
		      If foundHeader and theLine.Name = paramName then
		        
		        ii = i
		        i = TrueRow(i, False)
		        If i>-1 then
		          If theLine.Type = TypeCheckBox or theLine.Type = TypeRadioButton then
		            CellCheck(i, 1) = Str2BoolWeak(Value)
		          Else
		            If theLine.Type = TypeColor then
		              value = handleCellColor(i, 1, value)
		            End If
		            Cell(i, 1)=Value
		          End If
		        End If
		        
		        Lines(ii).Value = Value
		        
		        If RaiseCellValueChanged then
		          If Lines(ii).Parent <> Nil then
		            CellValueChanged(i, 1, Lines(ii).Parent.Name + "." + Lines(ii).Name, Value)
		          else
		            CellValueChanged(i, 1, Lines(ii).Name, Value)
		          End If
		        End If
		        Return
		      End if
		    Next
		  End If
		  
		  For i as Integer = 0 to UBound(Lines)
		    theLine = Lines(i)
		    
		    
		    If theLine.Visible and theLine.Name = PropertyName then
		      
		      ii = i
		      i = TrueRow(i, False)
		      If i>-1 then
		        If theLine.Type = TypeCheckBox or theLine.Type = TypeRadioButton then
		          CellCheck(i, 1) = Str2Bool(Value)
		        Else
		          If theLine.Type = TypeColor then
		            value = handleCellColor(i, 1, value)
		          End If
		          Cell(i, 1)=Value
		        End If
		      End If
		      
		      Lines(ii).Value = Value
		      
		      If RaiseCellValueChanged then
		        CellValueChanged(i, 1, Lines(ii).ParentName + Lines(ii).Name, Value)
		      End If
		      Return
		    End If
		    
		    
		  Next
		  
		  #if DebugLines then
		    Break
		  #endif
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ChangeHelpTag(newHelpTag As String)
		  If HelpTag <> newHelpTag then
		    HelpTag = newHelpTag
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeSize(Increment As Integer)
		  //#newinversion 1.6.0
		  //Enables increasing or decreasing the size of the Text in the Listbox.
		  
		  
		  Dim p As Picture = New Picture(1, 1, 32)
		  Dim g As Graphics = p.Graphics
		  g.TextSize=0
		  
		  Dim DefaultW As Double = g.StringWidth("AbCdEfGhi")
		  Dim DefaultSize As Integer = 12
		  For i as Integer = 1 to 30
		    g.TextSize = i
		    
		    If Defaultw = g.StringWidth("AbCdEfGhi") then
		      DefaultSize = i
		      exit for i
		    End If
		  Next
		  
		  If headerStyle.TextSize = 0 then
		    headerStyle.TextSize = DefaultSize
		  End If
		  If nameStyle.TextSize = 0 then
		    nameStyle.TextSize = DefaultSize
		  End If
		  If valueStyle.TextSize = 0 then
		    valueStyle.TextSize = DefaultSize
		  End If
		  If defaultvalueStyle.TextSize = 0 then
		    defaultvalueStyle.TextSize = DefaultSize
		  End If
		  
		  headerStyle.TextSize = headerStyle.TextSize + Increment
		  nameStyle.TextSize = nameStyle.TextSize + Increment
		  valueStyle.TextSize = valueStyle.TextSize + Increment
		  defaultvalueStyle.TextSize = defaultvalueStyle.TextSize + Increment
		  
		  g.TextSize = max(headerStyle.TextSize, nameStyle.TextSize, valueStyle.TextSize, defaultvalueStyle.TextSize)
		  DefaultRowHeight = -1 'g.TextHeight
		  TextSize = g.TextSize
		  
		  me.InvalidateCell(-1, -1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CreateButton(Caption As String, id As Integer)
		  Dim btn As Picture = New Picture(1, 1, 32)
		  Dim g As Graphics = btn.Graphics
		  g.TextSize = 12
		  Dim txtWidth As Double = g.StringWidth(Caption)
		  
		  //Drawing Button
		  If MacOSStyle then
		    btn = New Picture(txtWidth + 6, 14, 32)
		    g = btn.Graphics
		    g.TextSize = 12
		    
		    gradient(g, 0, g.Height, &cFEFEFE, &cA9A9A9)
		    g.DrawingColor = &c4E4E4E
		    g.DrawRect(0, 0, g.Width, g.Height)
		    
		    'g.DrawString caption, 3, 11
		    
		  Else
		    
		    btn = New Picture(txtWidth + 6, 14, 32)
		    g = btn.Graphics
		    
		    
		    g.DrawingColor = FrameColor
		    g.DrawRect 0, 0, g.Width, g.Height
		    
		    g.DrawingColor = LightBevelColor
		    g.DrawLine 1, 1, g.Width-3, 1
		    g.DrawLine 1, 2, 1, g.Height-2
		    
		    g.DrawingColor = DarkBevelColor
		    g.DrawLine 2, g.Height-2, g.Width-2, g.Height-2
		    g.DrawLine g.Width-2, 1, g.Width-2, g.Height-2
		    
		    g.DrawingColor = FillColor
		    g.FillRect 2, 2, g.Width - 4, g.Height - 4
		    
		    g.TextSize = 12
		    g.DrawingColor = TextColor()
		    g.DrawString caption, 3, 11
		  End If
		  
		  CustomButtons.Append new PropertyListButton(btn, Caption, id)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DemoMessage()
		  #if not DebugBuild then
		    Dim d As new MessageDialog
		    Dim b As MessageDialogButton
		    
		    d.Title = "Demo Software in use"
		    d.Icon = MessageDialog.GraphicNote
		    d.ActionButton.Caption="Yes"
		    d.CancelButton.Visible = True
		    d.CancelButton.Caption = "No"
		    
		    d.Message = "This application was built with a Demo version of PropertyListbox by Jérémie Leroy." + EndOfLine + _
		    "If you wish to disable this message, then please encourage the developer of this application to purchase the PropertyListbox." + EndOfLine + _
		    EndOfLine + _
		    "Would you like to visit Jérémie Leroy's website ?"
		    b=d.ShowModal
		    If b=d.ActionButton then
		      ShowURL("http://www.jeremieleroy.com")
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DrawArrows(g As Graphics)
		  Dim i As Integer
		  Dim y As Integer
		  y = g.Height \2
		  
		  If Enabled = False or (Parent<> Nil and Parent.Enabled = False) then
		    g.DrawingColor = DisabledTextColor
		  else
		    g.DrawingColor = &c0
		  End If
		  
		  'Dim Normalcolor As Color = g.ForeColor
		  
		  Dim xRight, xLeft As Integer
		  xLeft = 0
		  xRight = g.Width-1
		  
		  //--1 button
		  'If MouseOver = 1 then
		  'g.DrawingColor = DisabledTextColor
		  'else
		  'g.DrawingColor = Normalcolor
		  'End If
		  For i = 3 to 6
		    g.DrawLine(xLeft+i, y-i+2, xLeft+i, y+i-2)
		  Next
		  g.Pixel(xleft+2, y) = g.ForeColor
		  xLeft = 4
		  For i = 3 to 6
		    g.DrawLine(xLeft+i, y-i+2, xLeft+i, y+i-2)
		  Next
		  
		  //++1 button
		  'If MouseOver = 4 then
		  'g.DrawingColor = DisabledTextColor
		  'else
		  'g.DrawingColor = Normalcolor
		  'End If
		  For i = 3 to 6
		    g.DrawLine(xRight-i, y-i+2, xRight-i, y+i-2)
		  Next
		  g.Pixel(xright-2, y) = g.ForeColor
		  xRight = g.Width-5
		  For i = 3 to 6
		    g.DrawLine(xRight-i, y-i+2, xRight-i, y+i-2)
		  Next
		  
		  
		  xLeft = 12
		  xRight = g.Width-13
		  
		  //-1 button
		  'If MouseOver = 2 then
		  'g.DrawingColor = DisabledTextColor
		  'else
		  'g.DrawingColor = Normalcolor
		  'End If
		  For i = 3 to 6
		    g.DrawLine(xLeft+i, y-i+2, xLeft+i, y+i-2)
		    
		  Next
		  g.Pixel(xleft+2, y) = g.ForeColor
		  
		  //-1 button
		  'If MouseOver = 3 then
		  'g.DrawingColor = DisabledTextColor
		  'else
		  'g.DrawingColor = Normalcolor
		  'End If
		  For i = 3 to 6
		    g.DrawLine(xRight-i, y-i+2, xRight-i, y+i-2)
		  Next
		  g.Pixel(xright-2, y) = g.ForeColor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DrawButtonCalendar(g As Graphics)
		  If ButtonCalendar is Nil then Return
		  
		  
		  
		  ButtonCalendarLeft = g.Width-24-ButtonCalendar.Width
		  
		  g.DrawPicture(ButtonCalendar, ButtonCalendarLeft, (g.Height-ButtonCalendar.Height)\2)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawDottedLine(g As Graphics, X1 As Integer, Y1 As Integer, X2 As Integer, Y2 As Integer)
		  
		  Dim w As Integer = X2 - X1
		  Dim h As Integer = Y2 - Y1
		  Dim i As Integer
		  If h = 0 then
		    If w > 450 then
		      Dim u As Integer
		      Dim p As Picture = New Picture(w, 1, 32)
		      Dim gp As Graphics = p.Graphics
		      gp.DrawingColor = g.ForeColor
		      gp.DrawLine(0, 0, w, 0)
		      gp = p.Mask.Graphics
		      gp.Pixel(1, 0) = &cFFFFFF
		      gp.Pixel(3, 0) = &cFFFFFF
		      
		      i=1
		      u=0
		      while(i<w)
		        i=i*2
		        u=u+1
		      wend
		      w = 4
		      For i = 0 to u
		        gp.DrawPicture(p.mask, w, 0, w, 1, 0, 0, w, 1)
		        w = w*2
		      Next
		      g.DrawPicture(p, X1, Y1)
		    else
		      For i = 0 to w step 2
		        g.Pixel(X1+i, Y1) = g.ForeColor
		      Next
		    End If
		  else
		    If h > 450 then
		      Dim u As Integer
		      Dim p As Picture = New Picture(1, h, 32)
		      Dim gp As Graphics = p.Graphics
		      gp.DrawingColor = g.ForeColor
		      gp.DrawLine(0, 0, 0, h)
		      gp = p.Mask.Graphics
		      gp.Pixel(0, 1) = &cFFFFFF
		      gp.Pixel(0, 3) = &cFFFFFF
		      
		      i=1
		      u=0
		      while(i<h)
		        i=i*2
		        u=u+1
		      wend
		      h = 4
		      For i = 0 to u
		        gp.DrawPicture(p.mask, 0, h, 1, h, 0, 0, 1, h)
		        h = h*2
		      Next
		      g.DrawPicture(p, X1, Y1)
		    else
		      For i = 0 to h step 2
		        g.Pixel(X1, Y1+i) = g.ForeColor
		      Next
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindNextFromKey(Key As String) As Boolean
		  For i as Integer = ListIndex + 1 to me.ListCount - 1
		    
		    If Left(Cell(i, 0), 1) = Key and not Lines(TrueRow(i)).isHeader then
		      me.ListIndex = i
		      Return True
		    End If
		  Next
		  
		  For i as Integer = 0 to me.ListIndex
		    If Left(Cell(i, 0), 1) = Key and not Lines(TrueRow(i)).isHeader then
		      me.ListIndex = i
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

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

	#tag Method, Flags = &h21
		Private Sub getCellXY(row as Integer, column as Integer, byref locx as integer, byref locy as integer)
		  //find the window where this control is...
		  //since the control can be deeeeeeep whithin container controls...
		  locx=me.Left
		  locy=me.top
		  
		  dim container as Window
		  Container=me.Window
		  
		  while true
		    locx=locx+Container.Left
		    locy=locy+Container.top
		    
		    if container isa ContainerControl then
		      Container=ContainerControl(Container).Window
		      
		    elseif Container isa Window then
		      
		      // Account for toolbar
		      // Thanks to Roger Meier
		      #if RBVersion >= 2007 and TargetWin32 then
		        for i as integer = 0 to container.ControlCount-1
		          if container.Control(i) isa Toolbar then
		            locy = locy + Toolbar(container.Control(i)).Height
		          end if
		        next
		      #endif
		      
		      Exit
		    end if
		  Wend
		  
		  For i as Integer = 0 to Column - 1
		    locx = locx + me.Column(i).WidthActual
		  Next
		  For i as Integer = 0 to row - 1
		    locy = locy + me.rowHeight
		  Next
		  
		  If me.HasHeading then
		    #if RBVersion > 2009
		      locy = locy + me.HeaderHeight
		    #else
		      locy = locy + 20
		    #endif
		  End If
		  If me.ScrollPosition <> 0 then
		    locy = locy - RowHeight * ScrollPosition
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetColor(Tag As Variant, Index As Integer) As Color
		  Dim c As Variant
		  
		  Dim a As String = Tag
		  
		  c = NthField(a, "," , Index+1)
		  
		  Return c.ColorValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLine(index As Integer) As PropertyListLine
		  //Each row of the Listbox is stored as a PropertyListLine. In order to get or edit some properties for a given line, you can get that line by passing its index value.
		  
		  If index > UBound(Lines) or index = -1 then Return Nil
		  
		  Return Lines(index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLine(PropertyName As String) As PropertyListLine
		  //Each row of the Listbox is stored as a PropertyListLine. In order to get or edit some properties for a given line, you can get that line by passing its property name.
		  //If you want to get a line but several Properties share the same name under different headers then refer to the Property as:
		  //HeaderName.PropertyName
		  
		  Dim theLine As PropertyListLine
		  
		  If PropertyName.InStr(".")>0 then
		    Dim headerName As String = PropertyName.NthField(".", 1)
		    Dim paramName As String = PropertyName.NthField(".", 2)
		    
		    Dim foundHeader As Boolean
		    For i as Integer = 0 to UBound(Lines)
		      theLine = Lines(i)
		      If foundHeader and theLine.isHeader then
		        #if DebugLines then
		          Break
		        #endif
		        Return Nil
		      End If
		      If theLine.isHeader = True and theLine.Name = headerName then
		        foundHeader = True
		        Continue for i
		      End If
		      If foundHeader and theLine.Name = paramName then
		        
		        Return theLine
		      End if
		    Next
		  End If
		  
		  For i as Integer = 0 to UBound(Lines)
		    theLine = Lines(i)
		    
		    If theLine.Name = PropertyName then
		      Return theLine
		    End if
		  Next
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetType(TypeString As String, FromDataBase As Boolean = False) As Integer
		  If FromDataBase then
		    Select Case TypeString
		    Case "2", "3", "6", "7", "11", "13", "19"
		      Return TypeNumericUpDown
		    Case "4", "5", "8", "9"
		      Return TypeEditable
		    Case "12"
		      Return TypeCheckBox
		    Case "15", "18"
		      Return TypeMultiline
		      
		    Case "8"
		      Return TypeDatePicker
		      
		    else
		      LastError.Append "Unknown FieldType:" + TypeString
		      #if DebugLines then
		        Break
		      #endif
		      
		    End Select
		    Return TypeDefault
		    
		  else
		    
		    Select Case TypeString
		    Case "0", "Default"
		      Return TypeDefault
		    Case "1", "Normal"
		      Return TypeNormal
		    Case "2", "CheckBox"
		      Return TypeCheckBox
		    Case "3", "Editable"
		      Return TypeEditable
		    Case "4", "Multiline"
		      Return TypeMultiline
		    Case "5", "List"
		      Return TypeList
		    Case "6", "EditableList"
		      Return TypeEditableList
		    Case "7", "Color"
		      Return TypeColor
		    Case "8", "FolderItem"
		      Return TypeFolderItem
		    Case "9", "RadioButton"
		      Return TypeRadioButton
		    Case "10", "Rating", "Ranking"
		      Return TypeRating
		    Case "11", "Picture", "Icon"
		      Return TypePicture
		    Case "12", "NumericUpDown"
		      Return TypeNumericUpDown
		    Case "13", "DatePicker"
		      Return TypeDatePicker
		    End Select
		    Return DefaultType
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub gradient(g as graphics, start as integer, length as integer, startColor as color, endColor as color)
		  //modified gradient code, original code: Seth Willits
		  #pragma DisableBackgroundTasks
		  #pragma DisableBoundsChecking
		  
		  dim i as integer, ratio, endratio as Single
		  
		  // Draw the gradient
		  for i = start to start + length
		    
		    // Determine the current line's color
		    ratio = ((length-(i-start))/length)
		    
		    
		    endratio = ((i-start)/length)
		    g.DrawingColor = RGB(EndColor.Red * endratio + StartColor.Red * ratio, EndColor.Green * endratio + StartColor.Green * ratio, EndColor.Blue * endratio + StartColor.Blue * ratio)
		    
		    // Draw the step
		    g.DrawLine 0, i, g.Width, i
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleBBCodeDrawing(text As String, CurrentStyle As PropertyListStyle, g As Graphics)
		  #if PropertyListModule.UseBBCode
		    
		    #if not DebugBuild
		      #pragma DisableBackgroundTasks
		      #pragma DisableBoundsChecking
		      #pragma DisableAutoWaitCursor
		    #endif
		    
		    //Parsing BBCode
		    Dim TextStorage As BBCodeManager
		    
		    TextStorage = new BBCodeManager
		    
		    TextStorage.bold = CurrentStyle.Bold
		    TextStorage.italic = CurrentStyle.Italic
		    TextStorage.strike = False
		    TextStorage.underline = CurrentStyle.Underline
		    TextStorage.TextAlign.Append CurrentStyle.TextAlign
		    TextStorage.textfont.Append CurrentStyle.TextFont
		    TextStorage.TextSize.Append CurrentStyle.TextSize
		    TextStorage.setText(Text, CurrentStyle.TextColor)
		    
		    //Drawing
		    
		    
		    #if DebugBuild
		      Dim ms As Double
		      ms = Microseconds
		    #endif
		    
		    
		    
		    'Dim Buffer As Picture = New Picture(Width, Height, 32)
		    'Dim g As Graphics = Buffer.Graphics
		    
		    dim u as Integer = UBound(TextStorage.Words)
		    
		    Dim x As Double = 0 , y As Integer
		    Dim LineWidth As Double
		    dim word as BBCodeStorage
		    Dim newline As Boolean
		    'Dim currentLine As Integer
		    Dim trueWidth As Integer
		    Dim lastAlign As Integer = -1
		    
		    
		    trueWidth = g.Width
		    
		    
		    g.DrawingColor = TextStorage.textColor(0)
		    If not Enabled then
		      g.DrawingColor = DisabledTextColor
		    End If
		    
		    //paint every word
		    for i as Integer = 0 to u
		      newline = False
		      Word = TextStorage.words(i)
		      
		      if word.TYPE = word.TYPE_SPACE then
		        text = " "
		        
		      ElseIf Word.TYPE = word.TYPE_TAB then
		        text = TextStorage.TABCHAR
		        
		      elseif Word.TYPE = word.TYPE_EOL then
		        text = ""'
		        //Add
		        Return
		        newline = True
		        
		      else
		        text = Word.text
		        
		      end if
		      
		      g.Bold = Word.bold
		      g.Underline = Word.underline
		      g.Italic = word.italic
		      g.TextFont = word.textfont
		      g.TextSize = word.TextSize
		      
		      If lastAlign>-1 and word.TextAlign <> lastAlign then
		        //Add
		        Return
		        newline = True
		      Else
		        lastAlign = word.TextAlign
		      End If
		      
		      
		      'If (LineWidth + Word.width >=trueWidth or newline) and multiline and word.type = word.TYPE_WORD then
		      'newline = False
		      'lastAlign = -1
		      'currentLine = currentLine + 1
		      'If currentLine > uu then Exit
		      'x=LineX(currentLine)
		      'y = y + LineY(currentLine)
		      'LineWidth = 0
		      'End If
		      
		      //Add
		      y = (g.Height - g.TextHeight)\2 + g.TextAscent
		      
		      //draw txt
		      if (word.Type = word.TYPE_WORD or g.Underline or word.strike or word.Url or word.hasHightlightColor) and y <= g.Height + g.TextHeight  then 'and x + word.width >= 0 and y >= 0
		        
		        
		        If word.hasHightlightColor then
		          g.DrawingColor = word.highlightColor
		          g.FillRect(x, y-g.TextAscent, g.StringWidth(text), g.TextHeight)
		        End If
		        
		        
		        If Enabled then
		          g.DrawingColor = word.textColor
		        Else
		          g.DrawingColor = DisabledTextColor
		        End If
		        
		        If Word.Url then
		          //a corriger pour URL sur plusieurs lignes
		          'If UBound(UrlPositions)>-1 and UrlPositions(UBound(UrlPositions)).UrlText = word.UrlDest then
		          'UrlPositions(UBound(UrlPositions)).Width = UrlPositions(UBound(UrlPositions)).Width + word.width
		          'Else
		          'UrlPositions.Append new UrlSelection(x, y-g.TextAscent, x + word.width, y-g.TextAscent+g.TextHeight, word.UrlDest)
		          'End If
		          'If not StyledURL then
		          'g.Underline = True
		          'g.DrawingColor = &c0000FF
		          'If not Enabled then
		          'g.DrawingColor = DisabledTextColor
		          'End If
		          'If UrlOver = UBound(UrlPositions) then
		          'g.Underline = False
		          'End If
		          'End If
		        end if
		        
		        //Drawing the word
		        g.DrawString(text, x, y, trueWidth - LineWidth, True)
		        
		        If word.strike then
		          Dim yy As Double = y-g.TextHeight + g.TextAscent-1
		          g.DrawLine(x, yy, x+word.width, yy)
		        End If
		      end if
		      
		      x = x + g.StringWidth(text)
		      LineWidth = LineWidth + word.width
		      'If newline or LineWidth >=trueWidth then
		      'If not multiline then
		      '#if DebugBuild
		      'redrawTime = Microseconds - redrawTime
		      '#endif
		      'Exit
		      'End If
		      'currentLine = currentLine + 1
		      'If currentLine > uu then Exit
		      'lastAlign = -1
		      'x=LineX(currentLine)
		      'y = y + LineY(currentLine)
		      'LineWidth = 0
		      'End If
		      
		      If y>Height then Exit
		    next
		    
		    
		    
		    'DrawBorder(g)
		    'DrawForeGround(g)
		    
		    'gr.DrawPicture Buffer, 0, 0
		    
		    #if DebugBuild
		      ms = (Microseconds - ms) / 1000
		      ms = ms
		    #endif
		    'Refreshed(redrawTime)
		    
		    
		  #else
		    #Pragma Unused text
		    #Pragma Unused CurrentStyle
		    #Pragma Unused g
		    
		  #endif
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function handleCellClick(row As Integer, column As Integer, x As Integer, y As Integer, key As string = "") As Boolean
		  #pragma Unused y
		  
		  //Key is a space caracter. If there is a checkbox then change its state
		  If key<>"" and row = -1 or column=-1  or row > Listcount - 1 then Return False
		  If key=chr(32) then
		    If CellType(row, Column) <> TypeCheckBox then
		      Return False
		    End If
		  Elseif Column>1 then
		    Return False
		  End If
		  
		  
		  Dim theLine As PropertyListLine = Lines(TrueRow(row))
		  Dim theText As String = theLine.Value
		  
		  
		  If theLine.isHeader then 
		    
		    If column = 1 and theLine.hasButton = True then
		      //Finding Button
		      Dim btn As Picture
		      Dim index As Integer
		      For i as Integer = 0 to Ubound(CustomButtons)
		        If CustomButtons(i).id = theLine.ButtonId then
		          btn = CustomButtons(i).Pic
		          index = i
		          Exit for i
		        End If
		      Next
		      If btn <> Nil then
		        If X>=me.Column(1).WidthActual - btn.Width - 5 then
		          ButtonPressed(theLine.Name, CustomButtons(index).Caption)
		        End If
		      End If
		      Return True
		    Elseif Hierarchical then
		      Return False
		    End If
		    
		  End If
		  
		  ListIndex = row
		  Dim HeaderName As String
		  If theLine.Parent <> Nil then
		    HeaderName = theLine.Parent.Name + "."
		  End If
		  
		  AutoCompleteMode = False
		  
		  If Column = 1 then
		    ActiveCell.Mask = theLine.mask
		    #if RBVersion < 2009.05
		      ActiveCell.LimitText = theLine.LimitText
		    #endif
		  End If
		  
		  
		  
		  Select Case CellType(row, Column)
		    
		    //---------
		    // CheckBox
		    //---------
		  Case TypeCheckBox
		    
		    If theLine.Type = TypeRadioButton then //RadioButton
		      If not CellCheck(row, 1) then
		        If theLine.Parent <> Nil then
		          Dim foundHeader As Boolean
		          For i as Integer = 0 to UBound(Lines)
		            If Lines(i).isHeader then
		              If foundHeader then
		                exit
		              elseif Lines(i) = theLine.Parent then
		                foundHeader = true
		                continue
		              End If
		            elseif foundHeader and Lines(i).Parent = theLine.Parent and Lines(i).Type = 9 then
		              Lines(i).Value = "False"
		              CellCheck(TrueRow(i, False), 1) = False
		            End If
		          Next
		          CellCheck(row, 1) = True
		          theLine.Value = "True"
		          CellValueChanged(row, column, HeaderName + theLine.Name, "True")
		        End If
		        Return True
		      End If
		      
		    End If
		    
		    CellCheck(row, Column) = not CellCheck(row, Column)
		    theText = str(CellCheck(row, Column))
		    theLine.Value = theText
		    CellValueChanged(row, column, HeaderName + theLine.Name, theText)
		    Return True
		    
		    //----------
		    // TextField
		    //----------
		  Case TypeEditable
		    If CellCustomEdit(row, column, CellType(row, column), theLine.ParentName + theLine.Name, theText) then
		      Cell(row, 1) = theText
		      theLine.value=theText
		    else
		      LastEditCell = str(row) + "," + str(column)
		      EditCell(row,Column)
		      ActiveCell.BackColor = valueStyle.BackColor
		      ActiveCell.Mask = theLine.mask
		      ActiveCell.SelectAll
		    End If
		    
		    //---------
		    // TextArea
		    //---------
		  Case TypeMultiline
		    //If cell has multiple lines or clicked button
		    If Cell(row, column).InStr(chr(10))>0 or Cell(row, column).InStr(chr(13))>0 or X>=me.Column(1).WidthActual - ButtonEdit.Width - 5 then
		      Dim w As new PropertyListWindow(self, row, theLine.mask, theLine.LimitText)
		      w.ShowModal
		      If w.UseValue then
		        theText = w.EditField1.Text
		        Cell(row, 1) = theText
		        theLine.value=theText
		        CellValueChanged(row, column, HeaderName + theLine.Name, theText)
		      End If
		      w.Close
		      Return True
		    End If
		    LastEditCell = str(row) + "," + str(column)
		    EditCell(row,Column)
		    ActiveCell.SelectAll
		    
		    //---------
		    // List
		    //---------
		  Case TypeList
		    LastValue = HeaderName + theLine.Name + "=" + Cell(row,Column)
		    theText = handleListPopup(row, Column)
		    Cell(row, Column) = theText
		    theLine.Value = theText
		    CellValueChanged(row, column, HeaderName + theLine.Name, theText)
		    
		    
		    //---------------
		    // TextField List
		    //---------------
		  Case TypeEditableList
		    
		    
		    //If ContextualClick or user pressed PopupArrow
		    If IsContextualClick or X>=me.Column(1).WidthActual - ButtonPopupArrow.Width - 5 then
		      LastValue = HeaderName + theLine.Name + "=" + Cell(row,Column)
		      theText = handleListPopup(row, Column)
		      If theText <> "" and theText <> Cell(row, column) then
		        Cell(row, Column) = theText
		        theLine.Value = theText
		        CellValueChanged(row, column, HeaderName + theLine.Name, theText)
		      End If
		    ElseIf CellCustomEdit(row, column, CellType(row, column), theLine.ParentName + theLine.Name, theText) then
		      Cell(row, 1) = theText
		      theLine.value=theText
		    Else
		      
		      If theLine.AutoComplete then
		        AutoCompleteMode = True
		        Call handleListPopup(row, Column)
		      End If
		      
		      self.Window.SetFocus
		      self.SetFocus
		      LastEditCell = str(row) + "," + str(column)
		      EditCell(row,Column)
		      ActiveCell.SelectAll
		      
		    End If
		    
		    //----------
		    // ColorPick
		    //----------
		  Case TypeColor
		    //If user pressed color Button
		    If X>=me.Column(1).WidthActual - ButtonEdit.Width - 5 then
		      Dim c As Color
		      Dim b As Boolean
		      
		      c=GetColor(CellTag(row, 1), 1)
		      If not CellColorClick(c) then
		        b=SelectColor(c,"Select a Color")
		      else
		        b=True
		      End If
		      
		      If b then //if the user selected a color
		        theText = handleCellColor(row, 1, Str(c))
		        
		        Cell(row, Column) = theText
		        theLine.Value = theText
		      End if
		      CellValueChanged(row, column, HeaderName + theLine.Name, theText)
		      Return True
		    End If
		    If Cell(row,column) = TransparentString then
		      Cell(row, column) = ""
		    End If
		    EditCell(row,Column)
		    ActiveCell.SelectAll
		    
		    //-----------
		    // FolderItem
		    //-----------
		  Case TypeFolderItem
		    Dim f as FolderItem
		    If theLine.Folder then
		      Dim dlg as new SelectFolderDialog
		      
		      If theLine.Value <> "" then
		        dlg.InitialDirectory = GetFolderItem(theLine.Value)
		      End If
		      
		      f=dlg.ShowModal()
		    else
		      Dim dlg as new OpenDialog
		      
		      If theLine.Value <> "" then
		        f = GetFolderItem(theLine.Value)
		        If f <> Nil then
		          dlg.InitialDirectory = f.Parent
		        else
		          dlg.InitialDirectory = SpecialFolder.Documents
		        End If
		      else
		        dlg.InitialDirectory = SpecialFolder.Documents
		      End If
		      Dim filter as new FileType
		      If theLine.mask<>"" then
		        filter.name = "Files"
		        filter.Extensions = theLine.mask
		      End If
		      dlg.Filter=Filter
		      
		      f=dlg.ShowModal()
		    End If
		    
		    If f<> nil then
		      theText = f.NativePath
		      
		      Cell(row,Column) = theText
		      theLine.Value = theText
		      CellValueChanged(row, column, HeaderName + theLine.Name, theText)
		    End If
		    
		    //---------
		    // CheckBox
		    //---------
		  Case TypeRating
		    Dim RankMouseOver As Integer
		    Dim StarWidth As Integer
		    #if TargetMacOS
		      StarWidth = Star.Width/2
		    #else
		      StarWidth = Star.Width
		    #endif
		    If X<StarWidth\2+2 then
		      RankMouseOver = 0
		    else
		      RankMouseOver = min((X+2-StarWidth) \ (StarWidth) + 1, 5)
		    End If
		    theText = str(RankMouseOver)
		    Cell(row, column) = theText
		    theLine.Value = theText
		    CellValueChanged(row, column, HeaderName + theLine.Name, theText)
		    
		    
		    //---------
		    // Picture
		    //---------
		  Case TypePicture
		    Dim f as FolderItem
		    Dim dlg as new OpenDialog
		    
		    If theLine.Value <> "" then
		      f = GetFolderItem(theLine.Value)
		      If f <> Nil then
		        dlg.InitialDirectory = f.Parent
		      else
		        dlg.InitialDirectory = SpecialFolder.Pictures
		      End If
		    else
		      'dlg.InitialDirectory = SpecialFolder.Pictures
		    End If
		    Dim filter as new FileType
		    If theLine.mask<>"" then
		      filter.name = "Pictures"
		      filter.Extensions = theLine.mask
		    else
		      filter.name = "Pictures"
		      filter.Extensions = "bmp;jpg;jpeg;png;pict;gif"
		    End If
		    dlg.Filter=Filter
		    
		    f=dlg.ShowModal()
		    
		    If f<> nil then
		      theText = f.NativePath
		      
		      Cell(row,Column) = theText
		      theLine.Value = theText
		      CellTag(row,Column) = f.OpenAsPicture
		      CellValueChanged(row, column, HeaderName + theLine.Name, theText)
		      
		    End If
		    
		    //-------------
		    // UpDownArrows
		    //-------------
		  Case TypeNumericUpDown //Numeric Up/Down
		    
		    If X>=me.Column(1).WidthActual - ButtonPopupArrow.Width - 2 then
		      //Clicked on an arrow
		      
		      'Dim ClickTime As Integer = ticks
		      
		      If Y > me.RowHeight/2 then
		        theText = str(val(theText)-1)
		      else
		        theText = str(val(theText)+1)
		      End If
		      Cell(row, 1) = theText
		      theLine.value=theText
		      CellValueChanged(row, column, HeaderName + theLine.Name, theText)
		      
		      
		    else
		      
		      If CellCustomEdit(row, column, CellType(row, column), theLine.ParentName + theLine.Name, theText) then
		        Cell(row, 1) = theText
		        theLine.value=theText
		      else
		        LastEditCell = str(row) + "," + str(column)
		        EditCell(row,Column)
		        ActiveCell.Mask = theLine.mask
		        ActiveCell.SelectAll
		      End If
		    End If
		    
		    //-----------
		    // DatePicker
		    //-----------
		  Case TypeDatePicker
		    LastValue = HeaderName + theLine.Name + "=" + Cell(row,Column)
		    theText = handleDatePicker(row, Column)
		    Cell(row, Column) = theText
		    theLine.Value = theText
		    CellValueChanged(row, column, HeaderName + theLine.Name, theText)
		    
		  End Select
		  
		  
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function handleCellColor(row As Integer, column As Integer, theText As String) As String
		  #pragma Unused Column
		  
		  Dim c As Variant
		  Dim transparent, inColorSet As Boolean
		  
		  Dim TrueRow As Integer = TrueRow(row)
		  transparent =  Lines(TrueRow).transparent and (Trim(theText) = "" or Trim(theText) = TransparentString)
		  'transparent = Trim(theText) = TransparentString
		  If transparent then
		    c = TransparentString
		  Elseif theText.left(2)="&c" then
		    c = theText
		  ElseIf theText.left(2)="&h" then
		    c = theText
		  Elseif theText.left(1)="#" then
		    c = "&h" + theText.mid(2)
		  elseif ColorSet <> Nil and ColorSet.HasKey(theText) then
		    inColorSet = True
		    c = "&h" + ColorSet.Value(theText).StringValue.Mid(2)
		  Else
		    c = "&h" + theText
		  End if
		  
		  If c.StringValue = "&c" or c.StringValue = "&h" then c = &h0
		  If transparent then
		    theText = c
		  elseIf RBColorDisplay then
		    theText = FormatColor(c.ColorValue) 'Replace(str(c.ColorValue), "&h", "&c")
		  elseif not inColorSet then
		    theText = "#" + FormatColor(c.ColorValue).Mid(3) 'str(c.ColorValue).Mid(3)
		  End If
		  
		  If transparent then
		    me.CellTag(row, 1) = "&c0,&cFFFFFF"
		  else
		    If (c.ColorValue.Red + c.ColorValue.Green + c.ColorValue.Blue) \ 3 < 128 then
		      'If  (c.ColorValue.red*0.2989)+(c.ColorValue.green*0.5870)+(c.ColorValue.blue*.114) < 128 then
		      me.CellTag(row, 1) = "&cFFFFFF,"
		    Else
		      me.CellTag(row, 1) = "&c0,"
		    End If
		    me.CellTag(row, 1) = me.CellTag(row, 1) + FormatColor(c.ColorValue)
		    
		  End If
		  
		  Return theText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function handleDatePicker(row As Integer, column As Integer) As String
		  Dim theText As String = Cell(row, column)
		  Dim theLine As PropertyListLine
		  
		  theLine = Lines(TrueRow(Row))
		  
		  #if PropertyListModule.EnableDatePicker
		    
		    
		    //find XY pos of cell
		    dim x,y as Integer
		    getCellXY(row, column, x, y)
		    If SuggestionWnd <> Nil then
		      SuggestionWnd.Close
		    End If
		    Dim s As new PropertyListSuggestion
		    SuggestionWndReference = new WeakRef(s)
		    SuggestionWnd.ShowDatePicker(x, y, me.RowHeight, self, theText, TrueRow(Row), True, 0)
		    'If AutoCompleteMode then
		    'Return ""
		    'else
		    Return SuggestionWnd.option
		    'End If
		    
		    
		    '#endif
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function handleListPopup(row As Integer, column As Integer) As String
		  Dim theText As String = Cell(row, column)
		  Dim theLine As PropertyListLine = Lines(TrueRow(Row))
		  Dim tmpList() As String
		  If theLine.dynamicList then 
		    tmpList = LoadingValueList(theLine.SpecialList)
		  Else
		    tmpList = theLine.ValueList
		  End If
		  //A corriger pour trouver bonne méthode
		  #if RBVersion > 2008.03
		    If tmpList = nil then Return theText
		  #endif
		  Dim u As Integer = UBound(tmpList)
		  
		  If not theLine.AutoComplete then
		    dim base as new MenuItem
		    dim bt as MenuItem
		    
		    If u = -1 and theline.Type = TypeList then
		      'bt = new MenuItem("Manual Edit")
		      'base.Append(bt)
		      //Getting the items from the Event
		      LoadEmptyList(base)
		      
		    Elseif u>-1 then
		      For i as integer = 0 to u
		        bt = new MenuItem(tmpList(i))
		        If bt.Text = Cell(row,Column) then bt.Checked=True
		        base.Append(bt)
		      Next
		    Else
		      Return theText
		    End If
		    
		    bt = base.popup
		    
		    If bt <> Nil then
		      If bt.Tag = "Manual Edit" then
		        EditCell(row, column)
		        ActiveCell.SelectAll
		        Return ""
		      Else
		        Return bt.Text
		      End If
		    Else
		      Return theText
		    End If
		    '#else
		  else
		    If u>-1 then
		      
		      Dim begin As String = theText.NthField(" ", CountFields(theText, " "))
		      Dim lentext As Integer = len(begin)
		      Dim options() As String
		      For i as Integer = 0 to u
		        If tmpList(i).left(lentext) = begin then
		          options.Append tmpList(i)
		        End If
		      Next
		      
		      
		      //find XY pos of cell
		      dim x,y as Integer
		      getCellXY(row, column, x, y)
		      If SuggestionWnd <> Nil then
		        SuggestionWnd.Close
		      End If
		      
		      //Is this a downfeature ???
		      If UBound(options) = -1 then Return theText
		      
		      Dim s As new PropertyListSuggestion
		      SuggestionWndReference = new WeakRef(s)
		      SuggestionWnd.Show(x, y, me.RowHeight, self, options(), TrueRow(Row), True, 0, AutoCompleteMode)
		      If AutoCompleteMode then
		        Return ""
		      else
		        Return SuggestionWnd.option
		      End If
		    End If
		    Return theText
		  End If
		  '#endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InsertRows(HeaderIndex As Integer)
		  Dim newLine, HeaderLine As PropertyListLine
		  
		  For i as Integer = HeaderIndex to UBound(Lines)
		    newLine = Lines(i)
		    
		    If i = HeaderIndex and not newLine.isHeader then
		      Return
		    End If
		    
		    If newLine.isHeader then
		      If i > HeaderIndex then
		        Return
		      End If
		      
		      HeaderLine = newLine
		      If newLine.Visible then
		        Continue
		      Else
		        //This should never happen
		        Break
		        
		        Continue
		      End If
		    Else
		      If newLine.Parent <> HeaderLine then
		        Return
		      End If
		      
		      If newLine.Visible then
		        me.AddRow newLine.Caption + ColonString
		        me.CellTag(ListCount - 1, 0) = str(i)
		      Else
		        Continue
		      End If
		    End If
		    
		    
		    If newLine.Type = TypeRadioButton then
		      me.CellType(LastIndex, 1) = TypeCheckBox
		    Else
		      me.CellType(LastIndex, 1) = newLine.Type
		    End If
		    me.CellAlignment(LastIndex, 0) = me.AlignRight
		    If newline.type = TypeCheckBox or newline.type = TypeRadioButton then
		      CellCheck(LastIndex,1) = Str2BoolWeak(newLine.Value)
		    Else
		      cell(LastIndex, 1) = newLine.Value
		      
		      if newLine.Type = TypeColor then
		        Call handleCellColor(LastIndex, 1, newLine.Value)
		      end if
		    End If
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LoadButtons(Force As Boolean = False)
		  'dim t As Double = Microseconds
		  Dim tmpTextColor As Color = TextColor()
		  Dim g As Graphics
		  
		  If ButtonEdit is Nil or Force then
		    
		    ButtonCalendar = StringToPicture(kCalIcon)
		    
		    //Drawing ButtonEdit
		    If MacOSStyle then
		      
		      ButtonEdit = New Picture(11, 11, 32)
		      g= ButtonEdit.Graphics
		      g.DrawingColor = &cBABABA
		      g.FillRect(0,0, g.Width, g.Height)
		      ButtonEdit.Mask.graphics.DrawPicture RoundShade(ButtonEdit.Mask, 5, 5, 4.7, 1.3), 0,0
		      
		      ButtonColor = New Picture(11,11, 32)
		      ButtonColor.Graphics.DrawPicture(ButtonEdit, 0,0)
		      ButtonColor.Mask.Graphics.DrawPicture ButtonEdit.Mask, 0, 0
		      
		      g.Pixel(3, 6) = &cFFFFFF
		      g.Pixel(5, 6) = &cFFFFFF
		      g.Pixel(7, 6) = &cFFFFFF
		      
		      g = ButtonColor.Graphics
		      g.DrawingColor = &cDC5E5E
		      g.FillRect(2, 6, 3, 3)
		      g.Pixel(3, 7) = &cFF0000
		      g.DrawingColor = &c5EDC5E
		      g.FillRect(4, 4, 3, 3)
		      g.Pixel(5, 5) = &c00FF00
		      g.DrawingColor = &c5E5EDC
		      g.FillRect(6, 2, 3, 3)
		      g.Pixel(7, 3) = &c0000FF
		      
		    else
		      ButtonEdit = New Picture(14,14, 32)
		      g = ButtonEdit.Graphics
		      g.DrawingColor = FrameColor
		      g.DrawRect 0, 0, g.Width, g.Height
		      
		      g.DrawingColor = LightBevelColor
		      g.DrawLine 1, 1, g.Width-3, 1
		      g.DrawLine 1, 2, 1, g.Height-2
		      
		      g.DrawingColor = DarkBevelColor
		      g.DrawLine 2, g.Height-2, g.Width-2, g.Height-2
		      g.DrawLine g.Width-2, 1, g.Width-2, g.Height-2
		      
		      g.DrawingColor = FillColor
		      g.FillRect 2, 2, g.Width - 4, g.Height - 4
		      
		      ButtonColor = New Picture(14,14, 32)
		      ButtonColor.Graphics.DrawPicture(ButtonEdit, 0,0)
		      
		      g.TextSize = 0
		      g.DrawingColor = tmpTextColor
		      g.DrawString "...", 2, 11
		      
		      g = ButtonColor.Graphics
		      g.DrawingColor = &cFF0000
		      g.FillRect(3, 9, 2, 2)
		      g.DrawingColor = &c00FF00
		      g.FillRect(6, 6, 2, 2)
		      g.DrawingColor = &c0000FF
		      g.FillRect(9, 3, 2,2)
		    end if
		  End If
		  'If ButtonColor is Nil or Force then
		  'ButtonColor = ButtonEdit
		  'End If
		  
		  //Drawing ButtonPopupArrow
		  If ButtonPopupArrow is Nil or Force then
		    ButtonPopupArrow = New Picture(14, 7, 32)
		    g = ButtonPopupArrow.Graphics
		    Dim gg as Graphics = ButtonPopupArrow.Mask.Graphics
		    gg.DrawingColor = &cFFFFFF
		    gg.FillRect(0, 0, g.Width, g.Height)
		    gg.DrawingColor = &c0
		    
		    g.DrawingColor = tmpTextColor
		    g.FillRect(0, 0, g.Width, g.Height)
		    For i as Integer = 0 to 4
		      'g.DrawLine i-2, i, 16-i, i
		      gg.DrawLine i+2, i, 12-i, i
		    Next
		    gg.Pixel(7, 5) = gg.ForeColor
		    For i as Integer = 1 to 6
		      'g.Pixel(i-3, i)=tmpTextColor
		      'g.Pixel(17-i, i) = tmpTextColor
		      gg.Pixel(i+1, i)=&cEFEFEF
		      gg.Pixel(13-i, i) = &cE1E1E1
		    Next
		  End If
		  //Drawing ButtonPopupArrowUp
		  If ButtonPopupArrowUp is Nil or Force then
		    ButtonPopupArrowUp = New Picture(14, 7, 32)
		    g = ButtonPopupArrowUp.Graphics
		    Dim gg as Graphics = ButtonPopupArrowUp.Mask.Graphics
		    gg.DrawingColor = &cFFFFFF
		    gg.FillRect(0, 0, g.Width, g.Height)
		    gg.DrawingColor = &c0
		    
		    g.DrawingColor = tmpTextColor
		    g.FillRect(0, 0, g.Width, g.Height)
		    For i as Integer = 0 to 4
		      'g.DrawLine i-2, i, 16-i, i
		      gg.DrawLine i+2, 6-i, 12-i, 6-i
		    Next
		    gg.Pixel(7, 1) = gg.ForeColor
		    For i as Integer = 1 to 6
		      'g.Pixel(i-3, i)=tmpTextColor
		      'g.Pixel(17-i, i) = tmpTextColor
		      gg.Pixel(13-i, 6-i) = &cE1E1E1
		      gg.Pixel(i+1, 6-i)=&cEFEFEF
		      
		    Next
		  End If
		  
		  If Star is Nil or Force then
		    
		    If TargetMacOS then
		      Star = StringToPicture(kRetinaStar)
		    Else
		      
		      Star = New Picture(11,11,32)
		      
		      g = star.Graphics
		      //change the color of the star here:
		      g.DrawingColor = &c000000
		      g.FillRect 0, 0, g.Width, g.Height
		      
		      
		      Dim s As RGBSurface = Star.Mask.RGBSurface
		      s.FloodFill(0, 0, &cFFFFFF)
		      s.Pixel(5, 0) = &cA5A5A5
		      s.Pixel(4, 1) = &cF0F0F0
		      s.Pixel(6, 1) = &cF0F0F0
		      
		      s.Pixel(4, 2) = &c4E4E4E
		      s.Pixel(6, 2) = &c4E4E4E
		      
		      s.Pixel(4, 3) = &c1B1B1B
		      s.Pixel(6, 3) = &c1B1B1B
		      
		      For i as Integer = 0 to 4
		        s.Pixel(i, 4) = &c0
		      Next
		      For i as Integer = 7 to 10
		        s.Pixel(i, 4) = &c0
		      Next
		      
		      s.Pixel(0, 5) = &cE6E6E6
		      s.Pixel(10, 5) = &cE6E6E6
		      s.Pixel(1, 5) = &c1B1B1B
		      s.Pixel(9, 5) = &c1B1B1B
		      
		      s.Pixel(2, 6) = &cB4B4B4
		      s.Pixel(8, 6) = &cB4B4B4
		      
		      s.Pixel(2, 7) = &cEFEFEF
		      s.Pixel(8, 7) = &cEFEFEF
		      
		      s.Pixel(2, 8) = &cC4C4C4
		      s.Pixel(8, 8) = &cC4C4C4
		      s.Pixel(5,8) = &c808080
		      
		      s.Pixel(2, 9) = &c1B1B1B
		      s.Pixel(4,9) = &cBBBBBB
		      s.Pixel(6,9) = &cBBBBBB
		      s.Pixel(8, 9) = &c1B1B1B
		      
		      s.Pixel(2,10) = &c1B1B1B
		      s.Pixel(3,10) = &cE6E6E6
		      s.Pixel(7,10) = &cE6E6E6
		      s.Pixel(8,10) = &c1B1B1B
		      
		      s.FloodFill(5,5, &c0)
		    End If
		  End If
		  
		  't = Microseconds - t
		  'MsgBox(str(t/1000))
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LoadColorSet(root As XMLnode)
		  Dim i As Integer
		  Dim node As XmlNode
		  
		  ColorSet = New Dictionary
		  
		  For i = 0 to root.ChildCount-1
		    node = root.Child(i)
		    
		    If node.ChildCount > 0 then
		      If node.GetAttribute("value").left(1) <> "#" and node.GetAttribute("value").len <> 7 then
		        LastError.Append "Error in ColorSet for " + node.FirstChild.Value
		      End If
		      ColorSet.Value(node.FirstChild.Value) = node.GetAttribute("value")
		    End If
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LoadColorSetJSON(js As JSONItem)
		  Dim i As Integer
		  Dim node As JSONItem
		  
		  ColorSet = New Dictionary
		  
		  For i = 0 to js.Count-1
		    node = js.Child(i)
		    Break
		    'If node.ChildCount > 0 then
		    'If node.GetAttribute("value").left(1) <> "#" and node.GetAttribute("value").len <> 7 then
		    'LastError.Append "Error in ColorSet for " + node.FirstChild.Value
		    'End If
		    'ColorSet.Value(node.FirstChild.Value) = node.GetAttribute("value")
		    'End If
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI) or  (TargetIOS)
		Function LoadFromJSON(js As jsonItem, keepValues As Boolean = False, AutoSetDefaultValues As Boolean = False) As Boolean
		  //This method is used to load a XML-definition to "populate" the Listbox.
		  //An example of XML definition is available in the Notes sections of the PropertyListBox.
		  //
		  //Optional parameter '''keepValues'''. Default is False.
		  //If the Listbox already contained a data set, and the new data set is quite similar, you can try to keep the previous values with the '''keepValues''' property.
		  
		  
		  mRowHeight = 0
		  
		  If js is Nil or js.Names.Ubound = -1 then
		    me.DeleteAllRows
		    Redim Lines(-1)
		    System.debuglog("Empty JSON loaded in PropertyListbox")
		    LastError.Append "Empty JSON"
		    Return True
		  End If
		  
		  
		  Dim node, contents as JSONItem
		  Dim i, j as Integer
		  
		  Dim contentsChanged, hasButton As Boolean
		  
		  
		  
		  //load a xml data definition.
		  try
		    
		    
		    SyntaxName = ""
		    SyntaxComment = ""
		    
		    
		    //si le XML ne contient que Style, ça ne devrait pas supprimer les boutons
		    If js.HasName("contents") then
		      ReDim CustomButtons(-1)
		    End If
		    
		    //version
		    If js.HasName("version") then
		      DataVersion = js.Value("version").SingleValue
		    else
		      DataVersion = val(kversion)
		    End If
		    If DataVersion > val(kversion) then
		      System.debugLog("Version of JSON is greater than PropertyListBox version")
		      LastError.Append "Version of JSON is greater than PropertyListBox version"
		    End If
		    
		    For each name As string in js.Names
		      
		      Select case name
		        
		      Case "buttons"
		        node = js.Value(name)
		        For i = 0 to node.Count-1
		          contents = node.Child(i)
		          CreateButton contents.Lookup("text", ""), contents.Lookup("id", ticks)
		        Next
		        
		      Case "comment"
		        SyntaxComment = js.Value(name)
		        
		      case "name"
		        //syntax name
		        SyntaxName = js.Value(name)
		        
		      case "Style"
		        //Send the node to Style Method
		        ParseStyleJSON(js.Value(name))
		        
		      case "ColorSet"
		        //Send the node to ColorSet Method
		        LoadColorSetJSON( js.Value(name) )
		        
		      case "contents"
		        contentsChanged = True
		        //TODO
		        'If keepValues = False then
		        'keepValues = Str2BoolWeak(node.GetAttribute("keepValues"))
		        'End If
		        ReDim Lines(-1)
		        
		        node = js.Value(name)
		        
		        for j = 0 to node.Count - 1
		          contents = node.Child(j)
		          hasButton = False
		          
		          If contents.HasName("header") and contents.Value("header").BooleanValue then
		            LoadFromJSONHeader(contents, AutoSetDefaultValues)
		            
		          Else
		            LoadFromJSONParam(contents, AutoSetDefaultValues)
		            
		          End If
		        next
		      end select
		    Next
		    If contentsChanged then
		      LoadRows(keepValues)
		      ContentsChanged(SyntaxName, SyntaxComment)
		    else
		      LoadRows(True)
		    End If
		    Return true
		  Catch
		    System.Log(System.LogLevelError, "Error in JSON")
		    LastError.Append "Error in JSON"
		    Return False
		  end try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LoadFromJSONHeader(js as JSONItem, AutoSetDefaultValues As Boolean)
		  Dim node As JSONItem
		  
		  Dim LineName, LineCaption As String
		  Dim isVisible, hasButton As Boolean
		  Dim Button As Integer
		  
		  
		  
		  isVisible = js.Lookup("visible", True).BooleanValue
		  If js.HasName("button") then
		    hasButton = True
		    Button = js.Lookup("button", 0)
		  End If
		  
		  Dim HeaderLine As New PropertyListLine("", "", isVisible, hasButton, Button)
		  Lines.Append(HeaderLine)
		  
		  HeaderLine.expanded = js.Lookup("expanded", true)
		  
		  For each name As String in js.Names
		    
		    If name = "Name" then
		      LineName = js.Value(name)
		      
		    Elseif name = "Caption" then
		      LineCaption = js.Value(name)
		      
		    Elseif Name = "items" then
		      node = js.Value("items")
		      For i as Integer = 0 to node.Count-1
		        LoadFromJSONParam(node.Child(i), HeaderLine, AutoSetDefaultValues)
		      Next
		    End If
		  Next
		  
		  HeaderLine.Name = LineName
		  If LineCaption = "" then
		    HeaderLine.Caption = LineName
		  else
		    HeaderLine.Caption = LineCaption
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LoadFromJSONParam(js As JSONItem, ParentLine As PropertyListLine = Nil, AutoSetDefaultValues As Boolean)
		  
		  Dim param As JSONItem
		  Dim Button, LineLimitText, LineType As Integer
		  Dim isVisible, Required, AutoComplete, transparent, FontfromCell, hasButton, dynamicList, Numeric, ColorNegative, Folder As Boolean
		  Dim LineName, LineCaption, LineMask, LineValue, LineHelpTag, Comment, SpecialList, LineValueList(), Format, DefaultValue As String
		  Dim i As Integer
		  
		  LineType = GetType(js.Lookup("type", 0))
		  isVisible = js.Lookup("visible", true)
		  LineLimitText = js.lookup("limittext", 0)
		  LineMask = js.lookup("mask", "")
		  Required = js.lookup("required", False)
		  AutoComplete = js.lookup("autocomplete", False)
		  transparent = js.Lookup("transparent", False)
		  FontFromCell = js.Lookup("fontfromcell", False)
		  Numeric = js.Lookup("numeric", False)
		  ColorNegative = js.Lookup("colornegativenum", False)
		  Folder = js.Lookup("folder", False)
		  Format = js.Lookup("format", "")
		  DefaultValue = js.Lookup("defaultvalue", "")
		  If defaultvalue = "" then
		    defaultvalue = js.Lookup("default", "")
		  End If
		  
		  If LineType = TypeNumericUpDown then
		    Numeric = True
		  End If
		  
		  If js.HasName("button") then
		    hasButton = True
		    Button = js.Lookup("button", 0)
		  End If
		  For each name As string in js.Names
		    
		    Select Case name
		    Case "name"
		      LineName = js.Value(name)
		    Case "caption"
		      LineCaption = js.Value(name)
		    Case "value"
		      LineValue = js.Value(name)
		      If AutoSetDefaultValues and defaultvalue = "" then
		        defaultvalue = LineValue
		      End If
		    Case "valueList"
		      dynamicList = js.Lookup("dynamic", False)
		      If js.Value(name) isa JSONItem then
		        param = js.Value(name)
		        If param.IsArray and param.Count>0 then
		          Dim items() As String
		          For i = 0 to param.Count-1
		            items.Append param.Value(i)
		          Next
		          SpecialList = Join(items, "|")
		        End If
		      Else
		        SpecialList = js.Value(name)
		      End If
		      If not dynamicList then
		        Dim tmpLineValues() as String = LoadingValueList(SpecialList)
		        
		        If tmpLineValues <> Nil and UBound(tmpLineValues)>-1 then
		          For m as Integer = 0 to UBound(tmpLineValues)
		            LineValueList.Append tmpLineValues(m)
		          Next
		        Else
		          LineValueList = SpecialList.Split("|")
		          SpecialList = ""
		        End If
		      End If
		      
		      
		    Case "HelpTag"
		      LineHelpTag = js.Value(name)
		    Case "Comment"
		      Comment = js.Value(name)
		    End Select
		  Next
		  
		  Dim ln As new PropertyListLine(LineName, LineCaption, isVisible, LineType)
		  ln.LimitText = LineLimitText
		  ln.Mask = LineMask
		  ln.Value = LineValue
		  ln.ValueList = LineValueList
		  ln.SpecialList = SpecialList
		  ln.dynamicList = dynamicList
		  ln.HelpTag = LineHelpTag
		  ln.Required = Required
		  ln.AutoComplete = AutoComplete
		  ln.Transparent = transparent
		  ln.FontFromCell = FontfromCell
		  ln.Numeric = Numeric
		  ln.ColorNegativeNum = ColorNegative
		  ln.Format = Format
		  ln.Folder = Folder
		  ln.defaultvalue = DefaultValue
		  
		  'If Lines(UBound(Lines)).isHeader then
		  'Lines(UBound(Lines)).Child.append ln
		  'Else
		  If ParentLine <> Nil then
		    ln.Parent = ParentLine
		  End If
		  Lines.Append ln
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoadFromRecordSet(RS As RecordSet, IDField As Integer = 1, DisplayID As Boolean = False, DefaultType As Integer = 0) As Boolean
		  //#newinversion 1.6.0
		  //This method is used to load a RecordSet to "populate" the Listbox.
		  //An example of XML definition is available in the Notes sections of the PropertyListBox.
		  //
		  //Optional parameter '''keepValues'''. Default is False.
		  //If the Listbox already contained a data set, and the new data set is quite similar, you can try to keep the previous values with the '''keepValues''' property.
		  
		  
		  mRowHeight = 0
		  
		  If RS is Nil then
		    me.DeleteAllRows
		    Redim Lines(-1)
		    LastError.Append "Nil RecordSet"
		    Return True
		  End If
		  
		  
		  SyntaxComment = ""
		  
		  Dim ln As PropertyListLine
		  Dim LineType As Integer
		  
		  Dim LineNAme, LineCaption, LineValue As String
		  
		  ReDim Lines(-1)
		  
		  //load a RS data definition.
		  
		  For i as Integer = 1 to RS.FieldCount
		    
		    
		    LineName = RS.IdxField(i).Name
		    LineCaption = RS.IdxField(i).Name
		    LineValue = RS.IdxField(i).StringValue
		    LineType = GetType(str(rs.ColumnType(i-1)), True)
		    
		    If i = IDField then
		      SyntaxComment = LineValue
		      If DisplayID = False then
		        Continue for i
		      End If
		    End If
		    
		    If DefaultType > 0 and LineType=TypeEditable then
		      LineType = DefaultType
		    End If
		    
		    If LineName = "ID" then
		      LineType = TypeDefault
		    End If
		    
		    ln = new PropertyListLine(LineName, LineCaption, True, LineType)
		    ln.Value = LineValue
		    If DefaultType = TypeEditableList or DefaultType = TypeList then
		      ln.dynamicList = True
		      ln.SpecialList = LineName
		      ln.AutoComplete = (DefaultType = TypeEditableList)
		    End If
		    
		    
		    Lines.Append ln
		    
		    
		    
		  Next
		  
		  LoadRows()
		  ContentsChanged(SyntaxName, SyntaxComment)
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoadFromXML(Str As String, keepValues As Boolean = False, AutoSetDefaultValues As Boolean = False) As Boolean
		  //This method is used to load a XML-definition to "populate" the Listbox.
		  //An example of XML definition is available in the Notes sections of the PropertyListBox.
		  //
		  //Optional parameter '''keepValues'''. Default is False.
		  //If the Listbox already contained a data set, and the new data set is quite similar, you can try to keep the previous values with the '''keepValues''' property.
		  
		  
		  mRowHeight = 0
		  
		  If Str = "" then
		    me.DeleteAllRows
		    Redim Lines(-1)
		    System.debuglog("Empty XML loaded in PropertyListbox")
		    LastError.Append "Empty XML"
		    Return True
		  End If
		  
		  Dim xml as XmlDocument
		  Dim root, node, contents as XMLNode
		  Dim i, j as Integer
		  
		  Dim contentsChanged, hasButton As Boolean
		  
		  Dim version As Single
		  
		  //load a xml data definition.
		  try
		    xml=new XmlDocument
		    xml.LoadXml(Str)
		    
		    root=xml.Child(0)
		    //doc check
		    if root.Name<>"PropertyListBox" then
		      System.debugLog("Not a valid PropertyListBox definition")
		      LastError.Append "Not a valid PropertyListBox definition"
		      Return False
		    end if
		    
		    SyntaxName = ""
		    SyntaxComment = ""
		    
		    
		    //si le XML ne contient que Style, ça ne devrait pas supprimer les boutons
		    If Str.InStr("contents")>0 then
		      ReDim CustomButtons(-1)
		    End If
		    
		    version = val(root.GetAttribute("version"))
		    If version = 0 then
		      DataVersion = val(kversion)
		    else
		      DataVersion = version
		    End If
		    If version > val(kversion) then
		      System.debugLog("Version of XML is greater than PropertyListBox version")
		      LastError.Append "Version of XML is greater than PropertyListBox version"
		    End If
		    
		    
		    for i=0 to root.ChildCount-1
		      node=root.Child(i)
		      
		      select case node.Name
		      Case "button"
		        CreateButton(node.GetAttribute("text"), val(node.GetAttribute("id")))
		      Case "comment"
		        If node.ChildCount>0 then
		          SyntaxComment = node.FirstChild.Value
		        End If
		        
		      case "name"
		        //syntax name
		        If node.ChildCount>0 then
		          SyntaxName=node.FirstChild.Value
		        End If
		        
		      case "Style"
		        //Send the node to Style Method
		        ParseStyle(root.child(i))
		        
		      case "ColorSet"
		        //Send the node to ColorSet Method
		        LoadColorSet(root.Child(i))
		        
		      case "contents"
		        contentsChanged = True
		        If keepValues = False then
		          keepValues = Str2BoolWeak(node.GetAttribute("keepValues"))
		        End If
		        ReDim Lines(-1)
		        for j = 0 to node.ChildCount - 1
		          contents = node.Child(j)
		          hasButton = False
		          
		          Select case contents.Name
		          Case "header"
		            
		            LoadFromXMLHeader(contents, AutoSetDefaultValues)
		            
		          Case "param"
		            
		            LoadFromXMLParam(contents, AutoSetDefaultValues)
		            
		          End Select
		        next
		      end select
		    Next
		    If contentsChanged then
		      LoadRows(keepValues)
		      ContentsChanged(SyntaxName, SyntaxComment)
		    else
		      LoadRows(True)
		    End If
		    Return true
		  Catch
		    System.Log(System.LogLevelError, "Error in XML")
		    LastError.Append "Error in XML"
		    Return False
		  end try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LoadFromXMLHeader(root As XMLNode, AutoSetDefaultValues As Boolean)
		  Dim node As XmlNode
		  Dim LineName, LineCaption As String
		  Dim isVisible, hasButton As Boolean
		  Dim Button As Integer
		  
		  
		  
		  isVisible = Str2Bool(root.GetAttribute("visible"))
		  If root.GetAttribute("button") <> "" then
		    hasButton = True
		    Button = val(root.GetAttribute("button"))
		  End If
		  
		  Dim HeaderLine As New PropertyListLine("", "", isVisible, hasButton, Button)
		  Lines.Append(HeaderLine)
		  
		  HeaderLine.expanded = Str2Bool(root.GetAttribute("expanded"))
		  
		  For i as Integer = 0 to root.ChildCount-1
		    node = root.Child(i)
		    
		    If node.name = "Name" then
		      
		      LineName = node.FirstChild.Value
		      
		    Elseif node.name = "Caption" then
		      LineCaption = node.FirstChild.Value
		    Elseif node.Name = "Param" then
		      LoadFromXMLParam(node, HeaderLine, AutoSetDefaultValues)
		    End If
		  Next
		  
		  HeaderLine.Name = LineName
		  If LineCaption = "" then
		    HeaderLine.Caption = LineName
		  else
		    HeaderLine.Caption = LineCaption
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LoadFromXMLParam(node As XMLnode, ParentLine As PropertyListLine = Nil, AutoSetDefaultValues As Boolean)
		  Dim param As XmlNode
		  Dim Button, LineLimitText, LineType As Integer
		  Dim isVisible, Required, AutoComplete, transparent, FontfromCell, hasButton, dynamicList, Numeric, ColorNegative, Folder As Boolean
		  Dim LineName, LineCaption, LineMask, LineValue, LineHelpTag, Comment, SpecialList, LineValueList(), Format, DefaultValue As String
		  Dim i As Integer
		  
		  LineType = GetType(node.GetAttribute("type"))
		  isVisible = Str2Bool(node.GetAttribute("visible"))
		  LineLimitText = val(node.GetAttribute("limittext"))
		  LineMask = node.GetAttribute("mask")
		  Required = Str2BoolWeak(node.GetAttribute("required"))
		  AutoComplete = Str2BoolWeak(node.GetAttribute("autocomplete"))
		  transparent = Str2BoolWeak(node.GetAttribute("transparent"))
		  FontFromCell = Str2BoolWeak(node.GetAttribute("fontfromcell"))
		  Numeric = Str2BoolWeak(node.GetAttribute("numeric"))
		  ColorNegative = Str2BoolWeak(node.GetAttribute("colornegativenum"))
		  Folder = Str2BoolWeak(node.GetAttribute("folder"))
		  Format = node.GetAttribute("format")
		  DefaultValue = node.GetAttribute("defaultvalue")
		  If defaultvalue = "" then
		    defaultvalue = node.GetAttribute("default")
		  End If
		  
		  If LineType = TypeNumericUpDown then
		    Numeric = True
		  End If
		  
		  If node.GetAttribute("button") <> "" then
		    hasButton = True
		    Button = val(node.GetAttribute("button"))
		  End If
		  For i = 0 to node.ChildCount-1
		    param = node.Child(i)
		    Select Case param.Name
		    Case "name"
		      If param.ChildCount>0 then _
		      LineName = param.FirstChild.Value
		    Case "caption"
		      LineCaption = param.FirstChild.Value
		    Case "value"
		      If param.ChildCount>0 then
		        If LineType = TypeMultiline then
		          LineValue = param.FirstChild.Value.ReplaceAll("\n", EndOfLine)
		        else
		          LineValue = param.FirstChild.Value
		        End If
		      End If
		      If AutoSetDefaultValues and defaultvalue = "" then
		        defaultvalue = LineValue
		      End If
		    Case "valueList"
		      dynamicList = Str2BoolWeak(param.GetAttribute("dynamic"))
		      If param.ChildCount>0 then
		        SpecialList = param.FirstChild.Value
		        If not dynamicList then
		          Dim tmpLineValues() as String = LoadingValueList(SpecialList)
		          //A corriger pour trouver bonne méthode
		          #if RBVersion > 2008.03
		            If tmpLineValues <> Nil and UBound(tmpLineValues)>-1 then
		          #else
		            If UBound(tmpLineValues)>-1 then
		          #endif
		          For m as Integer = 0 to UBound(tmpLineValues)
		            LineValueList.Append tmpLineValues(m)
		          Next
		        Else
		          LineValueList = SpecialList.Split("|")
		          SpecialList = ""
		        End If
		      End If
		      End If
		    Case "HelpTag"
		      If param.ChildCount>0 then _
		      LineHelpTag = param.FirstChild.Value
		    Case "Comment"
		      If param.ChildCount>0 then _
		      Comment = param.FirstChild.Value
		    End Select
		  Next
		  
		  Dim ln As new PropertyListLine(LineName, LineCaption, isVisible, LineType)
		  ln.LimitText = LineLimitText
		  ln.Mask = LineMask
		  ln.Value = LineValue
		  ln.ValueList = LineValueList
		  ln.SpecialList = SpecialList
		  ln.dynamicList = dynamicList
		  ln.HelpTag = LineHelpTag
		  ln.Required = Required
		  ln.AutoComplete = AutoComplete
		  ln.Transparent = transparent
		  ln.FontFromCell = FontfromCell
		  ln.Numeric = Numeric
		  ln.ColorNegativeNum = ColorNegative
		  ln.Format = Format
		  ln.Folder = Folder
		  ln.defaultvalue = DefaultValue
		  
		  'If Lines(UBound(Lines)).isHeader then
		  'Lines(UBound(Lines)).Child.append ln
		  'Else
		  If ParentLine <> Nil then
		    ln.Parent = ParentLine
		  End If
		  Lines.Append ln
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LoadRows(keepValues As Boolean = False)
		  Dim newLine As PropertyListLine
		  Dim valueList() As String
		  Dim ValueDict As new Dictionary
		  Dim U As Integer = UBound(Lines)
		  
		  Dim HeaderLine As PropertyListLine
		  
		  If keepValues then
		    For i as Integer = 0 to ListCount-1
		      ValueDict.value(Cell(i,0)) = Cell(i,1)
		    Next
		  End If
		  me.DeleteAllRows()
		  me.HasRankCell = False
		  
		  For i as Integer = 0 to U
		    newLine = Lines(i)
		    
		    If newLine.isHeader then
		      
		      HeaderLine = newLine
		      If newLine.Visible then
		        'me.AddRow newLine.Caption
		        If Hierarchical and i < U and Lines(i+1).Parent = newLine then
		          me.AddFolder newLine.Caption
		          me.CellTag(ListCount - 1, 0) = str(i)
		          If newLine.expanded then
		            me.Expanded(ListCount - 1) = True
		          End If
		        else
		          me.AddRow newLine.Caption
		          me.CellTag(ListCount - 1, 0) = str(i)
		        End If
		        
		      Else
		        Continue
		      End If
		    Else
		      If HeaderLine <> Nil and newLine.Parent = HeaderLine and (Hierarchical and not HeaderLine.expanded or not HeaderLine.visible) then
		        Continue
		      End If
		      
		      If newLine.Visible then
		        me.AddRow newLine.Caption + ColonString
		        me.CellTag(ListCount - 1, 0) = str(i)
		      Else
		        Continue
		      End If
		      
		    End If
		    
		    If newLine.isHeader then
		      me.CellType(ListCount-1, 1) = TypeNormal
		      me.CellAlignment(ListCount-1, 0) = me.AlignLeft
		      'me.CellBold(ListCount-1, 0) = True
		    Else
		      If newLine.Type = TypeRadioButton then
		        me.CellType(ListCount-1, 1) = TypeCheckBox
		      Else
		        me.CellType(ListCount-1, 1) = newLine.Type
		      End If
		      me.CellAlignment(ListCount-1, 0) = me.AlignRight
		      If newline.type = TypeCheckBox or newline.type = TypeRadioButton then
		        CellCheck(ListCount-1,1) = Str2BoolWeak(newLine.Value)
		      Else
		        cell(ListCount-1, 1) = newLine.Value
		        
		        
		        if newLine.Type = TypeColor then
		          Call handleCellColor(ListCount-1, 1, newLine.Value)
		        end if
		      End If
		      
		    End If
		    
		  Next
		  
		  If keepValues then
		    For i as Integer = 0 to min(ListCount-1, UBound(valueList))
		      If ValueDict.HasKey(Cell(i,0)) then
		        Cell(i,1) = ValueDict.Value(cell(i,0))
		        If CellType(i, 1) = TypeColor then
		          call handleCellColor(ListCount-1, 1, newLine.Value)
		        End If
		      End If
		      
		    Next
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewRow(Name As String, Caption As String = "", isChild As Boolean = False)
		  //Because the Listbox uses its own storage system, to add a new row to the Listbox, use this method instead of Addrow.
		  //Caption and isChild are optional parameters.
		  //If Caption is an empty String, the Name is used as Caption.
		  //The “isChild” parameter is to set the new row as a child to the last Header. This is only effective if the Listbox is Hierarchical.
		  
		  If Caption = "" then
		    Caption = Name
		  End If
		  Dim l As new PropertyListLine(Name, Caption, True, 1)
		  
		  If isChild then
		    Dim u As Integer = UBound(Lines)
		    If U > -1 then
		      If Lines(u).Parent <> Nil then
		        l.Parent = Lines(u).Parent
		      ElseIf Lines(u).isHeader then
		        l.Parent = Lines(u)
		      End If
		    End If
		  End If
		  
		  Lines.Append l
		  AddRow(Caption)
		  me.CellTag(ListCount - 1, 0) = UBound(Lines)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NextEditableRow(row As Integer, DirectionDown As Boolean = True) As Integer
		  Dim i As Integer
		  Dim ReturnValue As Integer = row
		  If DirectionDown then
		    ReturnValue = ReturnValue + 1
		    For i = TrueRow(row) + 1 to UBound(Lines)
		      If Lines(i).isHeader then
		        ReturnValue = ReturnValue + 1
		      elseif not Lines(i).Visible then
		        Continue
		      elseIf Hierarchical and Lines(i).Parent <> Nil and (not Lines(i).Parent.Expanded or not Lines(i).Parent.Visible) then
		        Continue
		      elseif Lines(i).Parent <> Nil and not Lines(i).Parent.Visible then
		        Continue
		      else
		        exit
		      End If
		      
		    Next
		  Else
		    ReturnValue = ReturnValue - 1
		    For i = TrueRow(row) - 1 Downto 0
		      If Lines(i).isHeader then
		        ReturnValue = ReturnValue - 1
		      elseif not Lines(i).Visible then
		        Continue
		      elseIf Hierarchical and Lines(i).Parent <> Nil and (not Lines(i).Parent.Expanded or not Lines(i).Parent.Visible) then
		        Continue
		      elseif Lines(i).Parent <> Nil and not Lines(i).Parent.Visible then
		        Continue
		      else
		        exit
		      End If
		      
		    Next
		  End If
		  Return ReturnValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ParseStyle(StyleNode As XMLNode)
		  Dim i, j As Integer
		  Dim node, contents As XmlNode
		  Dim UpDateStyle As Boolean = Str2Bool(StyleNode.GetAttribute("updatestyle"))
		  Dim currentStyle As PropertyListStyle
		  Dim isParameter As Boolean
		  Dim HasBackColorEven As Boolean
		  
		  For i=0 to StyleNode.ChildCount-1
		    isParameter = False
		    node=stylenode.Child(i)
		    Updatestyle = Str2BoolWeak(node.GetAttribute("updatestyle"))
		    select case node.Name
		    Case "header"
		      If not UpDateStyle then
		        headerStyle = new PropertyListStyle(node.Name)
		      End If
		      currentStyle = headerStyle
		    Case "name"
		      If not UpDateStyle then
		        nameStyle = new PropertyListStyle(node.Name)
		      End If
		      currentStyle = nameStyle
		    Case "value"
		      If not UpDateStyle then
		        valueStyle = new PropertyListStyle(node.Name)
		      End If
		      currentStyle = valueStyle
		      
		    Case "defaultvalue"
		      If not UpDateStyle then
		        defaultvalueStyle = new PropertyListStyle(node.Name)
		      End If
		      currentStyle = defaultvalueStyle
		      
		    else
		      
		      If node.ChildCount>0 then
		        Select Case node.name
		          
		          //subclass properties
		        Case "ColonString"
		          isParameter = True
		          ColonString = node.FirstChild.Value
		        Case "MacOSStyle"
		          isParameter = True
		          MacOSStyle = Str2Bool(node.FirstChild.Value)
		        Case "PropertyString"
		          isParameter = True
		          PropertyString = node.FirstChild.Value
		        Case "ValueString"
		          isParameter = True
		          ValueString = node.FirstChild.Value
		          
		        Case "TransparentString"
		          isParameter = True
		          TransparentString = node.FirstChild.Value
		          
		          //Super properties
		        Case "Border"
		          isParameter = True
		          #If RBVersion >= 2008.03
		            Border = Str2Bool(node.FirstChild.Value)
		          #endif
		        Case "ColorGutter"
		          isParameter = True
		          ColorGutter = Str2Bool(node.FirstChild.Value)
		        Case "ColumnWidths"
		          isParameter = True
		          ColumnWidths = node.FirstChild.Value
		        Case "CustomGridLinesHorizontal"
		          isParameter = True
		          CustomGridLinesHorizontal = val(node.FirstChild.Value)
		        Case "CustomGridLinesVertical"
		          isParameter = True
		          CustomGridLinesVertical = val(node.FirstChild.Value)
		        Case "CustomGridLinesColor"
		          isParameter = True
		          CustomGridLinesColor = Str2Color(node.FirstChild.Value)
		        Case "GridLinesHorizontal"
		          isParameter = True
		          GridLinesHorizontal = val(node.FirstChild.Value)
		        Case "GridLinesVertical"
		          isParameter = True
		          GridLinesVertical = val(node.FirstChild.Value)
		        Case "HasHeading"
		          isParameter = True
		          HasHeading = Str2Bool(node.FirstChild.Value)
		        Case "ScrollBarHorizontal"
		          isParameter = True
		          ScrollBarHorizontal = Str2bool(node.FirstChild.Value)
		        Case "ScrollBarVertical"
		          isParameter = True
		          ScrollBarVertical = Str2bool(node.FirstChild.Value)
		        Case "DefaultRowHeight"
		          isParameter = True
		          DefaultRowHeight = val(node.FirstChild.Value)
		          'Case "ColumnsResizable"
		          'isParameter = True
		          'ColumnsResizable = Str2Bool(node.FirstChild.Value)
		        Case "AutoHideScrollbars"
		          isParameter = True
		          AutoHideScrollbars = Str2Bool(node.FirstChild.Value)
		        Case "Hierarchical"
		          isParameter = True
		          Hierarchical = Str2Bool(node.FirstChild.Value)
		        end select
		      End If
		    End Select
		    
		    If not isParameter then
		      HasBackColorEven = False
		      For j = 0 to node.ChildCount-1
		        contents = node.Child(j)
		        
		        Select case contents.Name
		        Case "backcolor"
		          currentStyle.BackColor = Str2Color(contents.FirstChild.Value)
		        Case "backcoloreven"
		          currentStyle.BackColorEven = Str2Color(contents.FirstChild.Value)
		          HasBackColorEven = True
		        Case "bold"
		          currentStyle.Bold = Str2BoolWeak(contents.FirstChild.Value)
		        Case "HighlightColor"
		          currentStyle.HighlightColor = Str2Color(contents.FirstChild.Value)
		        Case "Italic"
		          currentStyle.Italic = Str2BoolWeak(contents.FirstChild.Value)
		        Case "TextAlign"
		          currentStyle.TextAlign = Val(contents.FirstChild.Value)
		        Case "TextColor"
		          currentStyle.TextColor = Str2Color(contents.FirstChild.Value)
		        Case "TextFont"
		          currentStyle.TextFont = contents.FirstChild.Value
		        Case "texthighlightcolor"
		          currentStyle.TextHighlightColor = Str2Color(contents.FirstChild.Value)
		        Case "textsize"
		          currentStyle.TextSize = val(contents.FirstChild.Value)
		        Case "Underline"
		          currentStyle.Underline = Str2BoolWeak(contents.FirstChild.Value)
		        End Select
		      Next
		    End If
		    
		    //New version 1.7.1
		    If currentStyle <> Nil and not HasBackColorEven then
		      currentStyle.BackColorEven = currentStyle.BackColor
		    End If
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ParseStyleJSON(StyleNode As JSONItem)
		  
		  Dim node, topContents, contents As JSONItem
		  Dim UpdateStyle As Boolean
		  'Dim currentStyle As PropertyListStyle
		  Dim isParameter As Boolean
		  'Dim HasBackColorEven As Boolean
		  
		  For each name As String in StyleNode.Keys
		    
		    isParameter = False
		    
		    Select Case name
		    Case "styles"
		      node = StyleNode.Value(name)
		      For index as Integer = 0 to node.Count-1
		        topcontents = node.ValueAt(index)
		        
		        Dim stylename As String = topcontents.KeyAt(0)
		        contents = topContents.Value(stylename)
		        
		        'For each stylename as String in node.Keys
		        'contents = node.Value(stylename)
		        UpdateStyle = contents.Lookup("updateStyle", False)
		        Select Case stylename
		        Case "header"
		          If not UpDateStyle then
		            headerStyle = new PropertyListStyle(contents, stylename)
		          End If
		          
		        Case "name"
		          If not UpDateStyle then
		            nameStyle = new PropertyListStyle(contents, stylename)
		          End If
		          
		        Case "value"
		          If not UpDateStyle then
		            valueStyle = new PropertyListStyle(contents, stylename)
		          End If
		          
		        Case "defaultvalue"
		          If not UpDateStyle then
		            defaultvalueStyle = new PropertyListStyle(contents, stylename)
		          End If
		          
		        End Select
		      Next
		      
		    Case "ColonString"
		      ColonString = StyleNode.Value(name)
		    Case "PropertyString"
		      PropertyString = StyleNode.Value(name)
		    Case "ValueString"
		      ValueString = StyleNode.Value(name)
		    Case "TransparentString"
		      TransparentString = StyleNode.Value(name)
		    Case "Border"
		      Border = StyleNode.Value(name)
		    Case "ColorGutter"
		      ColorGutter = StyleNode.Value(name)
		    Case "ColumnWidths"
		      ColumnWidths =StyleNode.Value(name)
		    Case "CustomGridLinesHorizontal"
		      CustomGridLinesHorizontal = StyleNode.Value(name)
		    Case "CustomGridLinesVertical"
		      CustomGridLinesVertical = StyleNode.Value(name)
		    Case "GridLinesHorizontal"
		      GridLinesHorizontal = StyleNode.Value(name)
		    Case "GridLinesVertical"
		      GridLinesVertical = StyleNode.Value(name)
		    Case "HasHeading"
		      HasHeading = StyleNode.Value(name)
		    Case "ScrollBarHorizontal"
		      ScrollBarHorizontal = StyleNode.Value(name)
		    Case "ScrollBarVertical"
		      ScrollBarVertical = StyleNode.Value(name)
		    Case "DefaultRowHeight"
		      DefaultRowHeight = StyleNode.Value(name)
		    Case "AutoHideScrollbars"
		      AutoHideScrollbars = StyleNode.Value(name)
		    Case "Hierarchical"
		      Hierarchical = StyleNode.Value(name)
		    Case "MacOSStyle"
		      MacOSStyle = StyleNode.Value(name)
		      
		      
		    End Select
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reload()
		  //After editing a line with "GetLine", you need to reload the contents of the ListBox.
		  //All values are kept when using this Method.
		  
		  Dim oldScroll As Integer = me.ScrollPosition
		  
		  LoadRows(True)
		  
		  me.ScrollPosition = oldScroll
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RemoveRows(HeaderIndex As Integer, CurrentIndex As Integer)
		  Dim newLine, HeaderLine As PropertyListLine
		  CurrentIndex = CurrentIndex + 1
		  
		  For i as Integer = HeaderIndex to UBound(Lines)
		    newLine = Lines(i)
		    
		    If i = HeaderIndex and not newLine.isHeader then
		      Return
		    End If
		    
		    If newLine.isHeader then
		      If i > HeaderIndex then
		        Return
		      End If
		      
		      HeaderLine = newLine
		      If newLine.Visible then
		        
		      Else
		        //This should never happen
		        Break
		        
		        Continue
		      End If
		    Else
		      If newLine.Parent <> HeaderLine then
		        Return
		      End If
		      
		      If newLine.Visible then
		        me.RemoveRow(CurrentIndex)
		      End If
		    End If
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RoundShade(p As Picture, X As Double, Y As Double, Arc As Double, ShadeArc As Double, CenterColor As Color = &c0, ExteriorColor As Color = &cFFFFFF) As Picture
		  Dim s As RGBSurface
		  Dim i, j As Integer
		  
		  s = p.RGBSurface
		  
		  Dim pW, pH As Integer
		  pW = p.Width
		  pH = p.Height
		  Dim length As Double
		  Dim tmpC As Integer
		  
		  Dim ColW As Integer = ExteriorColor.red - CenterColor.red
		  Dim ColStart As Integer
		  If ColW<0 then
		    ColStart = max(ExteriorColor.Red, CenterColor.Red)
		  Else
		    ColStart = min(ExteriorColor.Red, CenterColor.Red)
		  End If
		  
		  
		  for j = 0 to pH
		    for i = 0 to pW
		      length = Sqrt((X-i)^2+(Y-j)^2)
		      
		      If length<= Arc then
		        s.Pixel(i,j)=CenterColor
		      Elseif length<=Arc+ShadeArc then
		        tmpC = ((length-Arc) / ShadeArc) * ColW + ColStart
		        s.Pixel(i,j)=RGB(tmpC, tmpC, tmpC)
		      Else
		        s.Pixel(i,j)=ExteriorColor
		      End If
		    next
		  next
		  
		  Return p
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Str2Bool(value As String) As Boolean
		  If value.InStr("false")>0 or value.InStr("no")>0 then
		    Return False
		  End If
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Str2BoolWeak(value As String) As Boolean
		  If value.InStr("True")>0 or value.InStr("yes")>0 then
		    Return True
		  End If
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Str2Color(Value As String) As Color
		  //Tester en mettant &h à la place de &c
		  
		  Dim c As Variant
		  
		  If Value.Left(2)="&c" then
		    c = Value
		  ElseIf Value.Left(1)="#" then
		    c = "&c" + Value.mid(2)
		    
		  Else
		    c = "&c" + Value
		  End If
		  If c.StringValue = "&c" then c = &c0
		  
		  Return c.ColorValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function StringToPicture(s As String) As Picture
		  #If RBVersion < 2010.03
		    //Creating Temp file
		    Dim f as FolderItem = SpecialFolder.Temporary
		    f = f.Child("temp.png")
		    
		    //Writing to file
		    Dim bs As BinaryStream
		    #if RBVersion >= 2009.03
		      bs = BinaryStream.Create(f, True)
		    #else
		      bs = f.CreateBinaryFile("")
		    #endif
		    bs.Write(DecodeBase64(s))
		    bs.Close
		    
		    //Return Picture
		    Return f.OpenAsPicture
		  #else
		    
		    Dim mb As new MemoryBlock(0)
		    mb = DecodeBase64(s)
		    
		    Return Picture.FromData(mb)
		  #endif
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toJSON(SaveValues As Boolean = True, SaveStyle As Boolean = True, SaveAllOptions As Boolean = False) As JSONItem
		  //If you need to store the properties and values before loading a new definition file, use this method to get a JSONItem of the contents.
		  //If '''SaveValues''' is false, only the property names are saved.
		  //The style of the Listbox (colors of headers, textfont, textsize, alignment…) can also be loaded from the XML definition. If you want to save the current style with the property and values, "SaveStyle" needs to be True.
		  //'''SaveAllOptions''' enables saving all options common display options from the Listbox Class.
		  
		  
		  //Delete this
		  If not Registered then
		    DemoMessage()
		  End If
		  
		  Dim js As JSONItem
		  Dim root, node, Contents, Param as JSONItem
		  Dim i, index as Integer
		  Dim HeaderLine(), theLine As PropertyListLine
		  'Dim NodeHierarchy As JSONItem
		  
		  js = new JSONItem
		  
		  //root
		  root = new JSONItem
		  js.Append root
		  root.Value("version") = kVersion
		  
		  //name
		  root.Value("name") = SyntaxName
		  
		  //comment
		  root.Value("comment") = SyntaxComment
		  
		  //Buttons
		  If UBound(CustomButtons) > -1 then
		    node = new JSONItem
		    
		    For i = 0 to Ubound(CustomButtons)
		      Contents = new JSONItem
		      Contents.Value("id") = CustomButtons(i).ID
		      Contents.Value("text") = CustomButtons(i).Caption
		      node.Append Contents
		    Next
		    root.Value("buttons") = node
		  End If
		  
		  //contents
		  node = new JSONItem
		  
		  
		  
		  
		  HeaderLine.Append Nil
		  index = 0
		  //Headers and Param
		  For i = 0 to UBound(Lines)
		    theLine = Lines(i)
		    
		    If theLine.Parent <> HeaderLine(index) then
		      HeaderLine.Remove(index)
		      Contents = nil
		      index = index-1
		    End If
		    
		    
		    If theLine.isHeader then
		      HeaderLine.Append(theLine)
		      contents = Lines(i).toJson(SaveValues)
		      node.append Contents
		      index = index + 1
		    Else
		      If Contents <> Nil then
		        If Contents.HasName("items") then
		          Param = Contents.Value("items")
		          Param.Append  Lines(i).toJSON(SaveValues)
		        Else
		          Param = new JSONItem
		          Param.Append Lines(i).toJSON(SaveValues)
		          
		          Contents.Value("items") = Param
		        End If
		      else
		        node.Append Lines(i).toJSON(SaveValues)
		      End If
		    End If
		  Next
		  
		  root.Value("contents") = node
		  
		  //Style
		  If SaveStyle or SaveAllOptions then
		    node = new JSONItem
		    
		    If SaveStyle then
		      Contents = New JSONItem
		      Contents.Append headerStyle.toJSON
		      Contents.Append nameStyle.toJSON
		      Contents.Append valueStyle.toJSON
		      node.Value("styles") = Contents
		    End If
		    
		    If SaveAllOptions then
		      node.Value("colonString") = ColonString
		      node.Value("propertyString") = PropertyString
		      node.Value("valueString") = ValueString
		      node.Value("transparentString") = TransparentString
		      
		      #if RBVersion >=2008.03
		        node.Value("border") = Border
		      #endif
		      
		      node.Value("colorGutter") = ColorGutter
		      node.Value("columnWidths") = ColumnWidths
		      node.Value("customGridLinesHorizontal") = CustomGridLinesHorizontal
		      node.Value("customGridLinesVertical") = CustomGridLinesVertical
		      node.Value("gridLinesHorizontal") = GridLinesHorizontal
		      node.Value("gridLinesVertical") = GridLinesVertical
		      node.Value("hasHeading") = HasHeading
		      node.Value("scrollBarHorizontal") = ScrollBarHorizontal
		      node.Value("scrollBarVertical") = ScrollBarVertical
		      node.Value("defaultRowHeight") = DefaultRowHeight
		      
		      node.Value("autoHideScrollbars") = AutoHideScrollbars
		      node.Value("hierarchical") = Hierarchical
		      node.Value("macOSStyle") = mMacOSStyle
		      
		    End If
		    
		    root.Value("style") = node
		  End If
		  
		  
		  
		  Return root
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toXML(SaveValues As Boolean = True, SaveStyle As Boolean = True, SaveAllOptions As Boolean = False) As String
		  //If you need to store the properties and values before loading a new definition file, use this method to get a XML string of the contents.
		  //If '''SaveValues''' is false, only the property names are saved.
		  //The style of the Listbox (colors of headers, textfont, textsize, alignment…) can also be loaded from the XML definition. If you want to save the current style with the property and values, "SaveStyle" needs to be True.
		  //'''SaveAllOptions''' enables saving all options common display options from the Listbox Class.
		  
		  
		  //Delete this
		  If not Registered then
		    DemoMessage()
		  End If
		  
		  dim xml as XmlDocument
		  Dim root, node, Contents, Param as XMLNode
		  Dim i, index as Integer
		  Dim HeaderLine(), theLine As PropertyListLine
		  Dim NodeHierarchy() As XmlNode
		  
		  xml = new XmlDocument
		  
		  //root
		  root = xml.AppendChild(xml.CreateElement("PropertyListBox"))
		  root.SetAttribute("version",kversion)
		  
		  //name
		  node = root.AppendChild(xml.CreateElement("name"))
		  node.AppendChild(xml.CreateTextNode(SyntaxName))
		  
		  //comment
		  node = root.AppendChild(xml.CreateElement("comment"))
		  node.AppendChild(xml.CreateTextNode(SyntaxComment))
		  
		  //Buttons
		  For i = 0 to Ubound(CustomButtons)
		    node = root.AppendChild(xml.CreateElement("button"))
		    node.SetAttribute("id", str(CustomButtons(i).id))
		    node.SetAttribute("text", CustomButtons(i).Caption)
		  Next
		  
		  //contents
		  contents = root.AppendChild(xml.CreateElement("contents"))
		  
		  NodeHierarchy.Append contents
		  HeaderLine.Append Nil
		  index = 0
		  //Headers and Param
		  For i = 0 to UBound(Lines)
		    theLine = Lines(i)
		    
		    If theLine.Parent <> HeaderLine(index) then
		      HeaderLine.Remove(index)
		      NodeHierarchy.Remove(index)
		      index = index-1
		    End If
		    
		    
		    If theLine.isHeader then
		      HeaderLine.Append(theLine)
		      NodeHierarchy.append Lines(i).appendToXMLNode(NodeHierarchy(index), SaveValues)
		      index = index + 1
		    Else
		      Call Lines(i).appendToXMLNode(NodeHierarchy(index), SaveValues)
		    End If
		  Next
		  
		  //Style
		  If SaveStyle or SaveAllOptions then
		    node = root.AppendChild(xml.CreateElement("style"))
		    If SaveStyle then
		      headerStyle.appendToXMLNode(node)
		      nameStyle.appendToXMLNode(node)
		      valueStyle.appendToXMLNode(node)
		    End If
		    
		    If SaveAllOptions then
		      param = node.AppendChild(xml.CreateElement("ColonString"))
		      param.AppendChild(xml.CreateTextNode(ColonString))
		      
		      param = node.AppendChild(xml.CreateElement("PropertyString"))
		      param.AppendChild(xml.CreateTextNode(PropertyString))
		      
		      param = node.AppendChild(xml.CreateElement("ValueString"))
		      param.AppendChild(xml.CreateTextNode(ValueString))
		      
		      param = node.AppendChild(xml.CreateElement("TransparentString"))
		      param.AppendChild(xml.CreateTextNode(TransparentString))
		      
		      #if RBVersion >=2008.03
		        param = node.AppendChild(xml.CreateElement("Border"))
		        param.AppendChild(xml.CreateTextNode(str(Border)))
		      #endif
		      
		      param = node.AppendChild(xml.CreateElement("ColorGutter"))
		      param.AppendChild(xml.CreateTextNode(Str(ColorGutter)))
		      
		      param = node.AppendChild(xml.CreateElement("ColumnWidths"))
		      param.AppendChild(xml.CreateTextNode(ColumnWidths))
		      
		      param = node.AppendChild(xml.CreateElement("CustomGridLinesHorizontal"))
		      param.AppendChild(xml.CreateTextNode(str(CustomGridLinesHorizontal)))
		      
		      param = node.AppendChild(xml.CreateElement("CustomGridLinesVertical"))
		      param.AppendChild(xml.CreateTextNode(str(CustomGridLinesHorizontal)))
		      
		      param = node.AppendChild(xml.CreateElement("CustomGridLinesColor"))
		      param.AppendChild(xml.CreateTextNode("#" + FormatColor(CustomGridLinesColor).Mid(3)))
		      
		      param = node.AppendChild(xml.CreateElement("GridLinesHorizontal"))
		      param.AppendChild(xml.CreateTextNode(str(GridLinesHorizontal)))
		      
		      param = node.AppendChild(xml.CreateElement("GridLinesVertical"))
		      param.AppendChild(xml.CreateTextNode(str(GridLinesVertical)))
		      
		      param = node.AppendChild(xml.CreateElement("HasHeading"))
		      param.AppendChild(xml.CreateTextNode(str(HasHeading)))
		      
		      param = node.AppendChild(xml.CreateElement("ScrollBarHorizontal"))
		      param.AppendChild(xml.CreateTextNode(str(ScrollBarHorizontal)))
		      
		      param = node.AppendChild(xml.CreateElement("ScrollBarVertical"))
		      param.AppendChild(xml.CreateTextNode(str(ScrollBarVertical)))
		      
		      param = node.AppendChild(xml.CreateElement("DefaultRowHeight"))
		      param.AppendChild(xml.CreateTextNode(str(DefaultRowHeight)))
		      
		      'param = node.AppendChild(xml.CreateElement("ColumnsResizable"))
		      'param.AppendChild(xml.CreateTextNode(str(ColumnsResizable)))
		      
		      param = node.AppendChild(xml.CreateElement("AutoHideScrollbars"))
		      param.AppendChild(xml.CreateTextNode(str(AutoHideScrollbars)))
		      
		      param = node.AppendChild(xml.CreateElement("Hierarchical"))
		      param.AppendChild(xml.CreateTextNode(str(Hierarchical)))
		      
		      param = node.AppendChild(xml.CreateElement("MacOSStyle"))
		      param.AppendChild(xml.CreateTextNode(str(mMacOSStyle)))
		      
		    End If
		  End If
		  
		  
		  
		  Return xml.ToString.ReplaceAll("><", ">" + EndOfLine + "<")
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TrueRow(row As Integer, forLines As Boolean = True) As Integer
		  //#Ignore in LR
		  
		  If row = -1 then Return row
		  
		  Dim upTo as Integer = row
		  Dim ReturnValue As Integer = row
		  Dim headerVisible As Boolean = True
		  Dim headerExpanded As Boolean
		  Dim theLine, HeaderLine As PropertyListLine
		  Dim toAdd As Integer
		  Dim U As Integer = UBound(Lines)
		  
		  
		  #if DebugBuild
		    Dim name As String
		  #endif
		  
		  If forLines then
		    toAdd = 1
		  Else
		    toAdd = -1
		  End If
		  
		  For i as Integer = 0 to upTo
		    If i > U then
		      ReturnValue = ReturnValue - 1
		      exit
		    End If
		    theLine = Lines(i)
		    
		    #if DebugBuild
		      name = theLine.Name
		    #endif
		    
		    If theLine.isHeader then
		      HeaderLine = theLine
		      If Hierarchical then
		        headerExpanded = theLine.expanded
		      else
		        headerExpanded = True
		      End If
		      If theLine.Visible then
		        headerVisible = True
		      Else
		        headerVisible = False
		      End If
		    End If
		    
		    If not theLine.Visible or not headerVisible or (HeaderLine <> Nil and theLine.Parent = HeaderLine and not headerexpanded) then
		      If forLines then
		        upTo = upTo + toAdd
		      End If
		      ReturnValue = ReturnValue + toAdd
		      If i = upTo then
		        ReturnValue = -1
		      End If
		    End If
		  Next
		  
		  Return ReturnValue
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValuesForHeader(HeaderName As String, onlyVisible As Boolean = False) As Dictionary
		  //You might need to get all values and property names for a given header. Pass the Header name and you will get a dictionary containing all property names with their respective values. 
		  //Some lines in the header might be hidden. If you do not want to get those values too, set “onlyVisible” to True.
		  
		  #pragma BackgroundTasks false
		  #pragma BoundsChecking false
		  #pragma NilObjectChecking false
		  #pragma StackOverflowChecking false
		  
		  Dim theLine As PropertyListLine
		  Dim dict As new Dictionary
		  
		  Dim foundHeader As Boolean
		  For i as Integer = 0 to UBound(Lines)
		    theLine = Lines(i)
		    If foundHeader and theLine.isHeader then
		      Exit
		    End If
		    If theLine.isHeader = True and theLine.Name = headerName then
		      foundHeader = True
		      Continue for i
		    End If
		    If foundHeader then
		      
		      if onlyVisible then //only visible lines
		        If theLine.Visible then
		          dict.Value(theLine.Name) = theLine.Value
		        End If
		        
		      Else
		        dict.Value(theLine.Name) = theLine.Value
		      end if
		    End if
		  Next
		  
		  Return Dict
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ButtonPressed(PropertyName As String, ButtonCaption As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CellAction(row As integer, column As integer, PropertyName As String, Value As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CellClick(row As integer, column As integer, x As Integer, y As Integer, PropertyName As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CellColorClick(Byref C As Color) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CellCustomEdit(row As Integer, column As Integer, CellType As Integer, PropertyName As String, ByRef PropertyValue As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CellValueChanged(row As integer, column As integer, PropertyName As String, Value As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ContentsChanged(ContentsName As String, Comment As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DoubleClick()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadEmptyList(base As MenuItem)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadingValueList(ValueName As String) As String()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldTriggerAutocomplete(Key as string, hasAutocompleteOptions as boolean) As boolean
	#tag EndHook


	#tag Note, Name = Description
		This control is a subclass of the Listbox that was designed to act like REALbasic’s Property Listbox visible in the IDE when editing window contents, or the project tab.
		
		The control is XML-driven, which means that the best way to display something in it, is to load an XML definition file specially made for it.
		
		The creation of the XML file can be done with the "PropertyListbox Creator". This helps to show all available options for each type of cell, and also helps users who aren’t used to writing XML files.
		
		To use this control, just drag it in a window, and in the open event, load an XML file, using the method: "me. LoadFromXML(XMLString As String)".
	#tag EndNote

	#tag Note, Name = Events
		#Event ButtonPressed
		The user clicked on a button displayed on a Header line.
		PropertyName is the name of the line. ButtonCaption is the caption displayed on the Button.
		
		#Event CellAction
		Same as ListBox:
		If a cell is editable, a CellAction event occurs when the user finishes editing a cell. Row and Column are zero-based.
		"Finishing editing" is defined as exiting the cell after clicking in it. Tabbing out of the editable cell or clicking another cell triggers this event. Clicking a checkbox in a checkbox cell also qualifies as "finishing editing."
		The user doesn't necessarily have to change the contents.
		With two new parameters: PropertyName and Value.
		
		#Event CellClick
		Same as Listbox:
		The user has clicked on the Row, Column cell. Row and Column are zero-based.
		The parameters X and Y are the x and y coordinates of the mouse click relative to the top-left corner of the cell that was clicked. X and Y are on the same scale of reference as the coordinates used by the Graphics property of the CellBackgroundPaint event.
		To give the user the ability to edit the cell, change the CellType to Editable (ListBox.TypeEditable) and then call the EditCell method. The user will then get a focusing ring around the cell and the current text will become editable. When the user tabs out of the cell, the changes will be saved. You will get the CellAction event.
		CellClick returns a Boolean. Returning True means that the event will not be processed further (i.e., editable cells won't be editable and ListBox selection won't change).
		With one new parameter: PropertyName which contains the name of the line that was clicked.
		
		#Event CellColorClick
		The user has clicked on the "Select Color" button in a TypeColor cell.
		Return True if you handle the color selection (by displaying your own colorwheel for example).
		
		#Event CellValueChanged
		The Value for a Line has changed. This event fires for all types of Cells except editable cells where the user types directly in the PropertyListBox. In this case, CellAction is fired.
		
		#Event ContentsChanged
		The PropertyListBox has received a new XML definition.
		ContentsName is the name of the definition (included in <name>...</name> tags) and Comment is an optional comment (included in <comment>...</comment> tags).
		
		#Event DoubleClick
		The user has double-clicked on the ListBox.
		The indexes of the cell that was double-clicked are not passed, but you can determine them using the RowFromXY and ColumnFromXY methods. See the example in the Notes section for the ListBox control.
		If the PropertyListBox is Hierarchical and a Header was double-clicked, this event doesn't fire and the Header is Collapsed or Expanded instead.
		
		#Event LoadingValueList
		The list of AutoComplete or ContextualMenu items need to be loaded.
		This enables having dynamic lists depending on the contents of the PropertyListBox or any other parameter from your App. Return an Array of Strings.
		In older versions of REALbasic (prior to 2009), the PropertyListBox might crash if you do not return an empty array instead of returning Nil.
		
		#Event Open
		#Ignore in Language Reference
		
		#Event ShouldTriggerAutocomplete
		key is the current pressed key, hasAutocompleteOptions is True if there are any autocompleteOptions for the word where the caret is.
		Return True if you want to trigger the autoComplete mechanism
	#tag EndNote

	#tag Note, Name = History
		===Version 1.8.2 - Released November 26, 2016===
		*Fix:
		**Correction for Xojo 2016r4
		
		===Version 1.8.1 - Released October 20, 2015===
		*Fix:
		**Correction for Xojo 2015r3 and 64bit apps
		
		===Version 1.8 - Released October 9, 2015===
		*New:
		**Export and Load data in JSON format
		
		===Version 1.7.2 - Released April 18, 2014===
		*New:
		**Can display alternate background color
		**Updated some drawing related to Retina
		
		
		===Version 1.6.1 - Released March 01, 2013===
		*New:
		**ChangeSize function, to increase or decrease text size.
		**LoadFromRecordSet, Load data from a RecordSet.
		**LoadEmptyList Event
		**Retina Ready
		*Fix:
		**Minor bug fixes
		
		===Version 1.5.1 - Released December 28, 2012===
		*Fix:
		**Compilation problem
		
		===Version 1.5.0 - Released November 24, 2012===
		*New:
		**TypeNumericUpDown constant
		     Display a numeric value with up/down arrows
		*Fix:
		**PopupArrow missing the tip pixel in newer versions of RealStudio
		**NilObjectException if the focus is lost when opening the window containing the PropertyListBox
		**Caption in buttons for Windows HiDPI screens
		
		===Version 1.4.0 - Released December 27, 2011===
		*New Properties :
		**ColorGutter for coloring the gutter (left part of the listbox) with the Headerbackground color
		**CustomGridLinesVertical
		**CustomGridLinesHorizontal
		**CustomGridLinesColor
		Custom Grid Lines in order to change the color of the grid lines. Only ThinSolid style is supported for the moment
		
		
		===Version 1.3 - Released December 27, 2011===
		*Fix:
		**UnsupportedFormatException in RealStudio 2011r3 and 2011r4
		
		
		===Version 1.2.1===
		*Fix:
		**OutOfBoundsException in PropertyListbox.CellValue
		
		
		===Version 1.2 - Released===
		*New property for Lines:
		**Comment
		     Store any information you want in the Comment
		*New Line type:
		**TypePicture
		     Selects a FolderItem and opens it as a picture.
		*New Event:
		**CellColorClick
		     Fires when the select color button in TypeColor cells is clicked. Return True if you handle the color selection (by displaying your own colorwheel for example)
		
		
		
		===Version 1.1 - Released February 03, 2009===
		*New property for Editable lines: Numeric As Boolean and ColorNegative As Boolean
		     If Numeric is True, when the Editable cell looses the focus, the Value is evaluated as a maths function
		     If ColorNegative is True and the value is smaller than 0, the text will be red
		*New property for all lines (including Header): Caption As String
		     Enables to have a global name for a line and a different caption than the name. This is very useful for multi-language apps
		     When loading an XML definition, if the caption isn't defined, the name value is copied in the caption value.
		*New button for TypeColor cells
		*List can now be hierarchical
		*New Event: CellClick
		     Fires when a cell is clicked before doing anything else (editing cell, pressing button, opening window, ...)
		*New property for FolderItem lines: Folder As Boolean
		     If Folder is true, then the cell will fire SelectFolder instead of GetOpenFolderItem
		
		*New Function in PropertyListLine: ParentName() As String
		     Returns the Name of the Line's Parent if it has a Parent (Header)
		
		
		*Fix:
		**Cellvalue now returns a color if the cell of TypeColor (It used to return the string value of the color)
		**LimitText in RB 2009r5 doesn't bring up an error anymore
		**FolderItem type opens the Dialog window in the current FolderItem path
		**Autocomplete window now displays on the correct screen if using multiple screens.
		
		===Version 1.0 - First Public Release===
		
		
		
		==Note==
		If you get an Unhandled exception or no data when loading an XML definition, add this line of code:
		Return Array("")
		
		In the Event LoadingValueList
	#tag EndNote

	#tag Note, Name = Notes
		<h3>XML definition</h3>
		
		You can use this example as XML definition to load in the PropertyListBox.
		
		<source lang="xml">
		<?xml version="1.0" encoding="UTF-8"?>
		<PropertyListBox version="1.1">
		<name>PropertyListbox Example</name>
		<button id="0" text="Help"/>
		<contents>
		<header visible="True" expanded="True">
		<name>Cell Types</name>
		<param type="1" visible="True">
		<name>Normal</name>
		<value>Normal Text</value>
		</param>
		<param type="2" visible="True">
		<name>CheckBox</name>
		<value>False</value>
		</param>
		<param type="3" visible="True">
		<name>Editable</name>
		<value>Click to edit</value>
		</param>
		<param type="4" visible="True">
		<name>Multiline Text</name>
		<value>Click to edit
		</value>
		</param>
		<param type="5" visible="True" required="True">
		<name>List</name>
		<valuelist>Red|Green|Blue</valuelist>
		</param>
		<param type="6" visible="True">
		<name>Editable List</name>
		<valuelist>Red|Green|Blue</valuelist>
		</param>
		<param type="6" visible="True" autocomplete="True">
		<name>Autocomplete List</name>
		<valuelist>font_list</valuelist>
		</param>
		<param type="7" visible="True">
		<name>Color</name>
		<value>&amp;cDBDFFF</value>
		</param>
		<param type="8" visible="True">
		<name>FolderItem (File)</name>
		</param>
		<param type="8" visible="True" folder="True">
		<name>FolderItem (Folder)</name>
		</param>
		<param type="9" visible="True">
		<name>RadioButton 1</name>
		<value>True</value>
		<helptag>Only one RadioButton per header can be checked at at time.
		RadioButton appear as checkboxes.
		However, RadioButtons and Checkboxes are independant</helptag>
		</param>
		<param type="9" visible="True">
		<name>RadioButton 2</name>
		<value>False</value>
		<helptag>Only one RadioButton per header can be checked at at time.
		RadioButton appear as checkboxes.
		However, RadioButtons and Checkboxes are independant</helptag>
		</param>
		<param type="9" visible="True">
		<name>RadioButton 3</name>
		<value>False</value>
		<helptag>Only one RadioButton per header can be checked at at time.
		RadioButton appear as checkboxes.
		However, RadioButtons and Checkboxes are independant</helptag>
		</param>
		<param type="10" visible="True">
		<name>Rating</name>
		<value>3</value>
		</param>
		</header>
		<header visible="True" expanded="True" button="0">
		<name>Header with Button</name>
		<param type="2" visible="True">
		<name>Show Invisible Lines</name>
		<value>False</value>
		</param>
		<param type="1" visible="False">
		<name>Invisible Line 1</name>
		</param>
		<param type="1" visible="False">
		<name>Invisible Line 2</name>
		</param>
		<param type="2" visible="False">
		<name>Show Invisible Header</name>
		<value>False</value>
		</param>
		</header>
		<header visible="False" expanded="True">
		<name>Invisible Header</name>
		<param type="1" visible="True">
		<name>No value</name>
		</param>
		</header>
		</contents>
		<style>
		<header UpdateStyle="False">
		<backColor>#DBDFFF</backColor>
		<bold>True</bold>
		<highlightcolor>#3399FF</highlightcolor>
		<italic>False</italic>
		<textalign>0</textalign>
		<textcolor>#000000</textcolor>
		<textfont>System</textfont>
		<texthighlightcolor>#FFFFFF</texthighlightcolor>
		<textsize>0</textsize>
		<underline>False</underline>
		</header>
		<name UpdateStyle="False">
		<backColor>#FFFFFF</backColor>
		<bold>False</bold>
		<highlightcolor>#3399FF</highlightcolor>
		<italic>False</italic>
		<textalign>2</textalign>
		<textcolor>#000000</textcolor>
		<textfont>System</textfont>
		<texthighlightcolor>#FFFFFF</texthighlightcolor>
		<textsize>0</textsize>
		<underline>False</underline>
		</name>
		<value UpdateStyle="False">
		<backColor>#FFFFFF</backColor>
		<bold>False</bold>
		<highlightcolor>#3399FF</highlightcolor>
		<italic>False</italic>
		<textalign>0</textalign>
		<textcolor>#000000</textcolor>
		<textfont>System</textfont>
		<texthighlightcolor>#FFFFFF</texthighlightcolor>
		<textsize>0</textsize>
		<underline>False</underline>
		</value>
		<ColonString>:</ColonString>
		<PropertyString>Property</PropertyString>
		<ValueString>Value</ValueString>
		<TransparentString>transparent</TransparentString>
		<Border>True</Border>
		<ColumnWidths>50% 50%, 1*</ColumnWidths>
		<GridLinesHorizontal>0</GridLinesHorizontal>
		<GridLinesVertical>0</GridLinesVertical>
		<HasHeading>True</HasHeading>
		<ScrollBarHorizontal>False</ScrollBarHorizontal>
		<ScrollBarVertical>True</ScrollBarVertical>
		<DefaultRowHeight>-1</DefaultRowHeight>
		<AutoHideScrollbars>True</AutoHideScrollbars>
		<Hierarchical>True</Hierarchical>
		</style>
		</PropertyListBox>
		</source>
		
		
		
	#tag EndNote

	#tag Note, Name = See Also
		
		BBCodeStorage, PropertyListButton, PropertyListLine, PropertyListStyle classes.
		PropertyListModule module.
		Listbox control.
	#tag EndNote


	#tag Property, Flags = &h0
		#tag Note
			This property is only used by the AutoComplete Window.
		#tag EndNote
		AutoCompleteMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			#New Version 1.2
			If True, the PropertyName Captions are parsed and displayed using BBCode.
		#tag EndNote
		BBCode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected ButtonCalendar As Picture
	#tag EndProperty

	#tag Property, Flags = &h1
		#tag Note
			#newinversion 1.7.0
			The Left position of the Calendar Icon
		#tag EndNote
		Protected ButtonCalendarLeft As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Edit this property if you want to change the default button that is displayed for TypeColor lines.
		#tag EndNote
		ButtonColor As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Edit this property if you want to change the default button that is displayed for TypeMultiline and TypeFolderItem lines.
		#tag EndNote
		ButtonEdit As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Edit this property if you want to change the default button that is displayed for TypeList and TypeEditableList lines.
		#tag EndNote
		ButtonPopupArrow As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Edit this property if you want to change the default button that is displayed for TypeNumericUpDown
		#tag EndNote
		ButtonPopupArrowUp As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Property names are followed by ":" when displayed. You can change the colon by any other String.
		#tag EndNote
		ColonString As String = ":"
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			newinversion 1.4.0
			If True, the gutter (left part of the listbox) is colored with the Headerbackground color.
		#tag EndNote
		ColorGutter As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected ColorSet As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected currentSuggestionWindow As Window
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Access to the Custom Buttons, loaded by a XML-definition.
		#tag EndNote
		CustomButtons() As PropertyListButton
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			newinversion 1.4.0
			Color of the GridLines
		#tag EndNote
		CustomGridLinesColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			newinversion 1.4.0
			Uses the Listbox GridLines constants
			See [http://docs.realsoftware.com/index.php/Listbox#Grid_Lines] for more information
		#tag EndNote
		CustomGridLinesHorizontal As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			newinversion 1.4.0
			Uses the Listbox GridLines constants
			See [http://docs.realsoftware.com/index.php/Listbox#Grid_Lines] for more information
		#tag EndNote
		CustomGridLinesVertical As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected DataVersion As Single
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected DefaultHelpTag As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The default row type used when no row type is specified.
		#tag EndNote
		DefaultType As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Access to the class that describes the style used for Property values that differ from the default value.
		#tag EndNote
		defaultvalueStyle As PropertyListStyle
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			Not used for the moment
			
		#tag EndNote
		Private DisplayMask As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected hasFocus As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected HasRankCell As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Access to the class that describes the style used for headers.
		#tag EndNote
		headerStyle As PropertyListStyle
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected isIBeam As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The last edited Cell in the Listbox.
		#tag EndNote
		LastEditCell As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			If you get errors when loading a definition file, use this property to know what was the problem.
		#tag EndNote
		LastError() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			When a CellValueChanged event is fired, this property contains the value that was previously stored in the Cell.
			Only for TypeList and TypeEditableList rows.
		#tag EndNote
		LastValue As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			Gets the amount of Lines in the PropertyListBox. LineCount is 1 based.
			Even invisible Lines are counted.
			
		#tag EndNote
		#tag Getter
			Get
			  return UBound(Lines) + 1
			End Get
		#tag EndGetter
		LineCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected Lines() As Propertylistline
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			If True, all buttons take a Mac OS style. This property is True by default when generating the App for Mac OS.
		#tag EndNote
		#tag Getter
			Get
			  return mMacOSStyle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value <> mMacOSStyle then
			    mMacOSStyle = value
			    LoadButtons(True)
			    If CustomButtons.Ubound > -1 then
			      Call LoadFromXML(toXML(True, False))
			    End If
			  End If
			End Set
		#tag EndSetter
		MacOSStyle As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mMacOSStyle As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPropertystring As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRowHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValuestring As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Access to the class that describes the style used for the Property names.
		#tag EndNote
		nameStyle As PropertyListStyle
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			If the Listbox.HasHeading property is True, this is the String used in the First column.
		#tag EndNote
		#tag Getter
			Get
			  return mPropertystring
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mPropertystring = value
			  If HasHeading then
			    me.InitialValue = mPropertystring + chr(9) + mValuestring
			  End If
			End Set
		#tag EndSetter
		PropertyString As String
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected RankMouseOver(2) As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			If True, colors in TypeColor rows are displayed in REALbasic format (&cFF00FF for example). If False, the colors are displayed in HTML format (#FF00FF).
		#tag EndNote
		RBColorDisplay As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private registered As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			This is the picture used in TypeRating rows.
		#tag EndNote
		Star As Picture
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  if SuggestionWndReference <> nil then
			    return PropertyListSuggestion(SuggestionWndReference.Value)
			  else
			    return nil
			  end if
			End Get
		#tag EndGetter
		Private SuggestionWnd As PropertyListSuggestion
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private SuggestionWndReference As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			An XML-definition has a Name property that cannot be changed. If you need to edit some global-definition property, you can use SyntaxComment.
		#tag EndNote
		SyntaxComment As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SyntaxName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			If a TypeColor row can be transparent, this is the displayed string that indicates that the row value is transparent.
		#tag EndNote
		TransparentString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected UrlPositions() As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			If the Listbox.HasHeading property is True, this is the String used in the second column.
		#tag EndNote
		#tag Getter
			Get
			  return mValuestring
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mValuestring = value
			  If HasHeading then
			    me.InitialValue = mPropertystring + chr(9) + mValuestring
			  End If
			End Set
		#tag EndSetter
		ValueString As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		#tag Note
			Access to the class that describes the style used for Property values.
		#tag EndNote
		valueStyle As PropertyListStyle
	#tag EndProperty


	#tag Constant, Name = BackwardCompatibility, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DebugLines, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kCalIcon, Type = String, Dynamic = False, Default = \"iVBORw0KGgoAAAANSUhEUgAAABAAAAAPCAYAAADtc08vAAAAAXNSR0IArs4c6QAAAARnQU1BAACx\rjwv8YQUAAAAJcEhZcwAACxIAAAsSAdLdfvwAAACDSURBVDhPtZLRCYAwDESzkjiSkJ0KjpTfzhO9\r0JRaabFVAw/P6B1XKMUYjRBUR1nXoGZmFh0F5hzgLyMwsz1T/bNPGhFJqq/hIaIPA7AE+7Jd8H1N\rswFMPqWGyeefACwBTCW+r2k2wEefnn4dgHtgAWX9J+B/kAMgZrgdYYYcYGIK0gMW2qPc1rpNxAAA\rAABJRU5ErkJggg\x3D\x3D", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kProductKey, Type = String, Dynamic = False, Default = \"PropertyListbox", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kReleaseDate, Type = Double, Dynamic = False, Default = \"20161126", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kRetinaStar, Type = String, Dynamic = False, Default = \"iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAEJGlDQ1BJQ0MgUHJvZmlsZQAAOBGF\n\nVd9v21QUPolvUqQWPyBYR4eKxa9VU1u5GxqtxgZJk6XtShal6dgqJOQ6N4mpGwfb6baqT3uBNwb8\n\nAUDZAw9IPCENBmJ72fbAtElThyqqSUh76MQPISbtBVXhu3ZiJ1PEXPX6yznfOec7517bRD1fabWa\n\nGVWIlquunc8klZOnFpSeTYrSs9RLA9Sr6U4tkcvNEi7BFffO6+EdigjL7ZHu/k72I796i9zRiSJP\n\nwG4VHX0Z+AxRzNRrtksUvwf7+Gm3BtzzHPDTNgQCqwKXfZwSeNHHJz1OIT8JjtAq6xWtCLwGPLzY\n\nZi+3YV8DGMiT4VVuG7oiZpGzrZJhcs/hL49xtzH/Dy6bdfTsXYNY+5yluWO4D4neK/ZUvok/17X0\n\nHPBLsF+vuUlhfwX4j/rSfAJ4H1H0qZJ9dN7nR19frRTeBt4Fe9FwpwtN+2p1MXscGLHR9SXrmMgj\n\nONd1ZxKzpBeA71b4tNhj6JGoyFNp4GHgwUp9qplfmnFW5oTdy7NamcwCI49kv6fN5IAHgD+0rbyo\n\nBc3SOjczohbyS1drbq6pQdqumllRC/0ymTtej8gpbbuVwpQfyw66dqEZyxZKxtHpJn+tZnpnEdrY\n\nBbueF9qQn93S7HQGGHnYP7w6L+YGHNtd1FJitqPAR+hERCNOFi1i1alKO6RQnjKUxL1GNjwlMsiE\n\nhcPLYTEiT9ISbN15OY/jx4SMshe9LaJRpTvHr3C/ybFYP1PZAfwfYrPsMBtnE6SwN9ib7AhLwTrB\n\nDgUKcm06FSrTfSj187xPdVQWOk5Q8vxAfSiIUc7Z7xr6zY/+hpqwSyv0I0/QMTRb7RMgBxNodTfS\n\nPqdraz/sDjzKBrv4zu2+a2t0/HHzjd2Lbcc2sG7GtsL42K+xLfxtUgI7YHqKlqHK8HbCCXgjHT1c\n\nAdMlDetv4FnQ2lLasaOl6vmB0CMmwT/IPszSueHQqv6i/qluqF+oF9TfO2qEGTumJH0qfSv9KH0n\n\nfS/9TIp0Wboi/SRdlb6RLgU5u++9nyXYe69fYRPdil1o1WufNSdTTsp75BfllPy8/LI8G7AUuV8e\n\nk6fkvfDsCfbNDP0dvRh0CrNqTbV7LfEEGDQPJQadBtfGVMWEq3QWWdufk6ZSNsjG2PQjp3ZcnOWW\n\ning6noonSInvi0/Ex+IzAreevPhe+CawpgP1/pMTMDo64G0sTCXIM+KdOnFWRfQKdJvQzV1+Bt8O\n\nokmrdtY2yhVX2a+qrykJfMq4Ml3VR4cVzTQVz+UoNne4vcKLoyS+gyKO6EHe+75Fdt0Mbe5bRIf/\n\nwjvrVmhbqBN97RD1vxrahvBOfOYzoosH9bq94uejSOQGkVM6sN/7HelL4t10t9F4gPdVzydEOx83\n\nGv+uNxo7XyL/FtFl8z9ZAHF4bBsrEwAAAAlwSFlzAAAROQAAETkBG9mTRgAAAsJJREFUWAnVV0tr\n\nU0EY7c0TkiDNAzEPknCxFawuXfmojStx50L/hLh05aIuBKm7/gH3LrpwLeLSP1CwhqQmxcRHHq2Q\n\nBBKSeE7IhMt15ubeiSgODDPzzXfOd+abx03W1v7nYprmNdZV1uDTBRcKhZLP5/vAyr4uj7aAUCj0\n\nDMFnhf2/KoArNgzjhgjKvm4WtDIQCAR2RXDRymxizqn1LAAr3fH7/TftpLRxzm5fNvYsAPu9qyJ1\n\nmlNhPAkoFou3sd+3VGSco49qXmb3JMDNPrvxsQoxrANrP5FInIvH4xuwbUyn003cty3UB1YfVX8y\n\nmbxGPURGPsGn3O12y51O56fMfyYgk8lcikQi9wGwBjwvA+jaIOi7EIQFlfv9/kGj0Tgy1lFSqdQx\n\nVreuS66Dg6BT1KLvFAXKBjokK2LOqtXq2ewQIh13oebHioSu4Yj1bTgc3iNgcQjz+fwW7vFbbMUF\n\n10wajtj/Rq/XK3H/CV9cw3q9fghl26hfNHhdQcB9MhgMtkVwghYZEAzIhIlMvEMmCsL2J1qs/DPS\n\nXqrVasdWvt8EcDKdThei0ShFmFZn3T5WXsE528HKT+wcUgF0SiaTWTxEFLFpB3kZY+VHeITutNtt\n\n6dYuzoCddA7Ys9u9jiHgpSo4uZQC5oEuew0o8XfkWCbgioTQq8mRw1EAXsirXqPZ/ZdxKAVks9kk\n\nwGk7odcxOcilwikFBINBx9SpCGV2Jy6lAPzGc0w/7vbX0Wj0iJV9WWBhc+IKCCdJK80AgnVR9/Al\n\n2wemP8e9wj+kx3gznqDG3XLRT5kB++HBfe6Nx+PnrVbLRPAXwIrg5OnTxjn60JdGUexcws5WKQAk\n\nXTqgHYJ0v9lsmpVK5Sl/P9AuK5yjD32JIZZ+gkuGUT7FuVzuYjgcvo43/D0IazLwMhu/KbFY7CE+\n\nv2/wHfi4zP+fzP8C/X8fQdsVTYEAAAAASUVORK5CYII\x3D", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kVersion, Type = String, Dynamic = False, Default = \"1.9.0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeColor, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeDatePicker, Type = Double, Dynamic = False, Default = \"13", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TypeEditableList, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeFolderItem, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeList, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeMultiline, Type = Double, Dynamic = False, Default = \"4", Scope = Public
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
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBorder"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLinesHorizontalStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Borders"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - None"
				"2 - ThinDotted"
				"3 - ThinSolid"
				"4 - ThickSolid"
				"5 - DoubleThinSolid"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLinesVerticalStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Borders"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - None"
				"2 - ThinDotted"
				"3 - ThinSolid"
				"4 - ThickSolid"
				"5 - DoubleThinSolid"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHeader"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHorizontalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasVerticalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropIndicatorVisible"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoHideScrollbars"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowResizableColumns"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowDragging"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowReordering"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowExpandableRows"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RowSelectionType"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="RowSelectionTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Single"
				"1 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
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
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Appearance"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialValue"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HeadingIndex"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultRowHeight"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollWidth"
			Visible=false
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollOffset"
			Visible=false
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresSelection"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataSource"
			Visible=true
			Group="Database Binding"
			InitialValue=""
			Type="String"
			EditorType="DataSource"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataField"
			Visible=true
			Group="Database Binding"
			InitialValue=""
			Type="String"
			EditorType="DataField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Database Binding"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PropertyString"
			Visible=false
			Group="Behavior"
			InitialValue="Property"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RBColorDisplay"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultType"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColonString"
			Visible=false
			Group="Behavior"
			InitialValue=":"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ValueString"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Star"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastEditCell"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoCompleteMode"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TransparentString"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MacOSStyle"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastValue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SyntaxComment"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BBCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonEdit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonPopupArrow"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorGutter"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CustomGridLinesHorizontal"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CustomGridLinesVertical"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CustomGridLinesColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonPopupArrowUp"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
