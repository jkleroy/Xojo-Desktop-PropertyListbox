#tag Window
Begin Window PropertyListSuggestion
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   BalloonHelp     =   ""
   CloseButton     =   False
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   26
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   1040
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   10
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   False
   Title           =   ""
   Visible         =   True
   Width           =   120
   Begin ListBox optionList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   15
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   0
      GridLinesVerticalStyle=   0
      HasBorder       =   True
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   26
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   120
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin Timer Timer1
      Enabled         =   True
      Index           =   -2147483648
      InitialParent   =   ""
      LockedInPosition=   False
      Period          =   10
      RunMode         =   0
      Scope           =   0
      TabPanelIndex   =   "0"
   End
   Begin Timer Timer2
      Enabled         =   True
      Index           =   -2147483648
      InitialParent   =   ""
      LockedInPosition=   False
      Period          =   12
      RunMode         =   0
      Scope           =   0
      TabPanelIndex   =   "0"
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  //#Ignore this Window in LR
		  #if TargetWin32
		    Const WS_BORDER = &H800000
		    ChangeWindowStyle( self, WS_BORDER, false )
		    
		    Const WS_CAPTION = &h00C00000
		    ChangeWindowStyle( self, WS_CAPTION, false )
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  
		  If DatePicker then
		    DrawPicker(g)
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddChildWindowOrderedAbove(wParent as Window, wChild as Window)
		  //# Adds a given window as a child window of the window.
		  
		  //@After the childWindow is added as a child of the window, it is maintained in relative position _
		  // indicated by orderingMode for subsequent ordering operations involving either window. _
		  // While this attachment is active, moving childWindow will not cause the window to move _
		  // (as in sliding a drawer in or out), but moving the window will cause childWindow to move.
		  
		  //@Note that you should not create cycles between parent and child windows. _
		  // For example, you should not add window B as child of window A, then add window A as a child of window B.
		  
		  //@This code will summon the ChildWindow but leaves it inactive. _
		  // You'll still have to manually call the ChildWindow.Show method to 'activate' the ChildWindow.
		  
		  #if TargetCocoa then
		    declare sub addChildWindow lib "Cocoa" selector "addChildWindow:ordered:" (WindowRef As Integer, ChildWindowRef as Integer, OrderingMode as Integer)
		    
		    addChildWindow wParent.Handle, wChild.Handle, 1
		  #else
		    #pragma Unused wParent
		    #pragma Unused wChild
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub cancel()
		  //cancel action
		  hide
		  
		  StartTimer
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ChangeWindowStyle(w as Window, flag as Integer, set as Boolean)
		  #if TargetWin32
		    Dim oldFlags as Integer
		    Dim newFlags as Integer
		    Dim styleFlags As Integer
		    
		    Const SWP_NOSIZE = &H1
		    Const SWP_NOMOVE = &H2
		    Const SWP_NOZORDER = &H4
		    Const SWP_FRAMECHANGED = &H20
		    
		    Const GWL_STYLE = -16
		    
		    Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (hwnd As Integer,  _
		    nIndex As Integer) As Integer
		    Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (hwnd As Integer, _
		    nIndex As Integer, dwNewLong As Integer) As Integer
		    Declare Function SetWindowPos Lib "user32" (hwnd as Integer, hWndInstertAfter as Integer, _
		    x as Integer, y as Integer, cx as Integer, cy as Integer, flags as Integer) as Integer
		    
		    oldFlags = GetWindowLong(w.Handle, GWL_STYLE)
		    
		    if not set then
		      newFlags = BitwiseAnd( oldFlags, Bitwise.OnesComplement( flag ) )
		    else
		      newFlags = BitwiseOr( oldFlags, flag )
		    end
		    
		    
		    styleFlags = SetWindowLong( w.Handle, GWL_STYLE, newFlags )
		    styleFlags = SetWindowPos( w.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE +_
		    SWP_NOSIZE + SWP_NOZORDER + SWP_FRAMECHANGED )
		    
		  #else
		    #Pragma Unused w
		    #Pragma Unused flag
		    #Pragma Unused set
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DrawPicker(gg As Graphics)
		  //In DebugBuild we check performance of drawing
		  #if DebugBuild
		    Dim ms As Double = Microseconds
		  #endif
		  
		  
		  
		  Dim i, u As Integer
		  Dim text As String
		  Dim x, xx, y As Single
		  Dim DrawDate As Date
		  Dim DayWidth As Single = gg.Width / 7
		  Dim DayHeight As Single
		  Dim Pos As Integer
		  Dim Today As Date = New Date
		  
		  Dim HeaderHeight As Integer = owner.RowHeight
		  
		  
		  //Setting FirstDate
		  DrawDate = New Date(FirstDate)
		  
		  DayHeight = (gg.Height - HeaderHeight) / WeeksPerMonth
		  
		  
		  
		  
		  gg.DrawingColor = MyColors.PBackground
		  gg.FillRect(0, 0, gg.Width, gg.Height)
		  
		  gg.TextSize = 0 'TextSize
		  
		  //Header Background
		  If Transparent then
		    If me.TrueWindow.Backdrop <> Nil then
		      gg.DrawPicture(me.TrueWindow.Backdrop, 0, 0, gg.Width, HeaderHeight, me.Left, me.Top)
		    else
		      
		      If me.TrueWindow.HasBackColor then
		        gg.DrawingColor =me.TrueWindow.BackColor
		      else
		        #if TargetMacOS
		          gg.DrawingColor = &cEDEDED
		        #else
		          gg.DrawingColor = FillColor
		        #endif
		      End If
		      gg.FillRect(0, 0, gg.Width, HeaderHeight)
		    End If
		  else
		    gg.DrawingColor = MyColors.Header
		    gg.FillRect(0, 0, gg.Width, HeaderHeight)
		  End If
		  
		  y = (HeaderHeight-gg.TextHeight) \ 2
		  'gg.DrawingColor = MyColors.PArrow
		  'gg.Pixel(2, y) = gg.ForeColor
		  'gg.Pixel(gg.Width-3, y) = gg.ForeColor
		  '
		  'For i = 3 to 6
		  'gg.DrawLine(i, y-i+2, i, y+i-2)
		  'gg.DrawLine(gg.Width-i-1, y-i+2, gg.Width-i-1, y+i-2)
		  'Next
		  
		  'DrawArrows(gg)
		  
		  
		  
		  //Drawing Month
		  gg.DrawingColor = MyColors.Title
		  gg.Bold = True
		  text = MonthNames(DisplayMonth.Month) + " " + str(DisplayMonth.Year)
		  gg.DrawString(text, (gg.Width-gg.StringWidth(text))\2, (22-gg.TextHeight)\2 + gg.TextAscent)
		  
		  //Drawing Day names
		  'gg.TextSize = 0
		  gg.Bold = MyStyle.PDayNameBold
		  If MyStyle.PDayNamePos = 0 then
		    Pos = 0
		    xx = 1
		  elseif MyStyle.PDayNamePos = 1 then
		    Pos = 1
		    xx = 0
		  else
		    Pos = 2
		    xx = 1
		  End If
		  
		  y = HeaderHeight-3
		  
		  For i = 0 to 6
		    If (FirstDayOfWeek + i) = 7 then
		      text = TitleCase(DayNames(7))
		    else
		      text = TitleCase(DayNames((FirstDayOfWeek + i) mod 7))
		    End If
		    If gg.StringWidth(text) > DayWidth-2 then
		      text = text.Left(1)
		    End If
		    
		    gg.DrawingColor = MyColors.DayName
		    If Pos = 0 then
		      gg.DrawString(text, DayWidth * i + xx, y, DayWidth-xx*2, True)
		    elseif Pos = 1 then
		      gg.DrawString(text, DayWidth * i + max(1, (DayWidth - gg.StringWidth(text)) \ 2), y, DayWidth-2, True)
		      
		    else
		      x =DayWidth * i + xx - min(DayWidth-xx, gg.StringWidth(text))
		      gg.DrawString(text, DayWidth * i + xx - min(xx-3, gg.StringWidth(text)), y, DayWidth, True)
		    End If
		  Next
		  
		  //Drawing day numbers
		  y = HeaderHeight
		  If MyStyle.PDayNumberPos = 0 then
		    Pos = 0
		    xx = 1
		  elseif MyStyle.PDayNumberPos = 1 then
		    Pos = 1
		    xx = 0
		  else
		    Pos = 2
		    xx = 1
		  End If
		  x = xx
		  u = WeeksPerMonth * 7
		  gg.Bold = MyStyle.PDayNumberbold
		  For i = 1 to u
		    
		    //MouseOver
		    If i = LastDayOver or (DisplayDate <> Nil and DrawDate.SQLDate = DisplayDate.SQLDate) then
		      gg.DrawingColor = MyColors.PSelected
		      gg.FillRect(x, y, Ceil(DayWidth), Ceil(DayHeight))
		      
		      //Selected
		      'ElseIf SelStart <> Nil and SelEnd <> nil and DrawDate.SQLDate >= SelStart.SQLDate and DrawDate.SQLDate <= SelEnd.SQLDate then
		      'gg.DrawingColor = MyColors.PSelected
		      'gg.FillRect(x, y, Ceil(DayWidth), Ceil(DayHeight))
		      
		      //Today Background
		    ElseIf DrawDate.SQLDate = Today.SQLDate then
		      gg.DrawingColor = MyColors.Today
		      gg.FillRect(x, y, Ceil(DayWidth), Ceil(DayHeight))
		    End If
		    
		    text = str(DrawDate.Day)
		    
		    If DrawDate.Month <> DisplayMonth.Month then
		      If gg.ForeColor <> MyColors.PDayNumber then
		        gg.DrawingColor = MyColors.PDayNumber
		      End If
		    else
		      If gg.ForeColor <> MyColors.PDayNumberActive then
		        gg.DrawingColor = MyColors.PDayNumberActive
		      End If
		    End If
		    If Pos = 0 then
		      gg.DrawString(text, x, y+(DayHeight-gg.TextHeight)\2 + gg.TextAscent)
		    elseif Pos = 1 then
		      gg.DrawString(text, x + (DayWidth - gg.StringWidth(text))\2, y+(DayHeight-gg.TextHeight)\2 + gg.TextAscent)
		    else
		      gg.DrawString(text, x - gg.StringWidth(text), y+(DayHeight-gg.TextHeight)\2 + gg.TextAscent)
		    End If
		    
		    
		    DrawDate.Day = DrawDate.Day + 1
		    If i mod 7 = 0 then
		      y = y + DayHeight
		      x = xx
		    else
		      x = x + DayWidth
		    End If
		  Next
		  
		  'If Border then
		  gg.DrawingColor = MyColors.Border
		  gg.DrawRect(0, 0, gg.Width, gg.Height)
		  'End If
		  
		  
		  //Drawing day frames
		  'gg.DrawingColor = MyColors.Line
		  'For i = 1 to 6
		  'x = DayWidth * i
		  'gg.DrawLine(x, HeaderHeight, x, Height-1)
		  'Next
		  '
		  'For i = 0 to WeeksPerMonth-1
		  'y = HeaderHeight + DayHeight * i
		  'gg.DrawLine(0, y, Width-1, y)
		  'Next
		  
		  
		  //Drawing border
		  'If Border then
		  'gg.DrawingColor = MyColors.Border
		  'gg.DrawRect(0, HeaderHeight, Width, Height-HeaderHeight)
		  'End If
		  
		  
		  
		  //In DebugBuild we check performance of drawing
		  #if DebugBuild
		    ms = (Microseconds-ms)/1000
		    'DrawInfo = str(ms)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetLocaleInfo(type as Integer, mb as MemoryBlock, ByRef retVal as String) As Integer
		  #if TargetWin32
		    
		    Dim LCID As Integer = &H400
		    
		    Soft Declare Function GetLocaleInfoA Lib "kernel32" (Locale As integer, LCType As integer, lpLCData As ptr, cchData As integer) As Integer
		    Soft Declare Function GetLocaleInfoW Lib "kernel32" (Locale As integer, LCType As integer, lpLCData As ptr, cchData As integer) As Integer
		    
		    dim returnValue as Integer
		    dim size as Integer
		    
		    if mb <> nil then size = mb.Size
		    
		    if System.IsFunctionAvailable( "GetLocaleInfoW", "Kernel32" ) then
		      if mb <> nil then
		        returnValue = GetLocaleInfoW( LCID, type, mb, size ) * 2
		        retVal = ReplaceAll( DefineEncoding( mb.StringValue( 0, returnValue ), Encodings.UTF16 ), Chr( 0 ), "" )
		      else
		        returnValue = GetLocaleInfoW( LCID, type, nil, size ) * 2
		      end if
		    else
		      if mb <> nil then
		        returnValue = GetLocaleInfoA( LCID, type, mb, size ) * 2
		        retVal = ReplaceAll( DefineEncoding( mb.StringValue( 0, returnValue ), Encodings.ASCII ), Chr( 0 ), "" )
		      else
		        returnValue = GetLocaleInfoA( LCID, type, nil, size ) * 2
		      end if
		    end if
		    
		    return returnValue
		    
		  #else
		    #Pragma Unused type
		    #Pragma Unused mb
		    #Pragma Unused retVal
		    
		  #endif
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetScreen(X As Integer, Y As Integer) As Integer
		  Dim n As Integer = ScreenCount
		  Dim i As Integer
		  Dim possibleScreen As Integer
		  
		  For i = 0 to n
		    If X >= Screen(i).Left and X < Screen(i).Left + Screen(i).Width then
		      possibleScreen = i
		      
		      If Y >= Screen(i).Top and Y < Screen(i).Top + Screen(i).Height then
		        Return i
		      End If
		    End If
		  Next
		  
		  Return possibleScreen
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub loadSuggestions(options() as string, AutoWidth As Boolean)
		  //load options
		  optionList.DeleteAllRows
		  
		  dim option as String
		  Dim maxWidth As Integer
		  
		  
		  
		  for each option in options
		    optionList.AddRow option
		    If AutoWidth then
		      Dim p As new Picture(1, 1, 32)
		      maxWidth = max(MinWidth, max(maxWidth, Ceil(p.Graphics.StringWidth(option)) + 10 ))
		    End If
		  next
		  if optionList.ListCount > 0 then 
		    optionList.ListIndex = 0
		    'mOption = optionList.Text
		  end if
		  
		  If AutoWidth then
		    me.Width = maxWidth
		  End If
		  
		  Dim ScreenIndex As Integer = GetScreen(left, top)
		  If me.top + optionList.ListCount * optionList.DefaultRowHeight + 4 > Screen(ScreenIndex).AvailableHeight + Screen(ScreenIndex).Top then
		    me.Height = Screen(ScreenIndex).AvailableHeight + Screen(ScreenIndex).Top - me.top - 2
		    If AutoWidth then
		      me.Width = me.Width + 17
		    End If
		  Else
		    me.Height = optionList.ListCount * optionList.DefaultRowHeight + 4
		  End If
		  me.Left = DefaultLeft
		  If me.Left + me.Width > Screen(ScreenIndex).AvailableWidth + Screen(ScreenIndex).Left then
		    me.Left = Screen(ScreenIndex).AvailableWidth + Screen(ScreenIndex).Left - me.Width - 2
		  End If
		  'me.Height = min(optionList.ListCount * optionList.DefaultRowHeight + 4, Screen(0).Height/2)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupLocaleInfo()
		  #if TargetWin32
		    
		    Dim i, ret As Integer
		    Dim retVal As String
		    Dim mb as new MemoryBlock( 2048 )
		    
		    //Day Names
		    Const LOCALE_SABBREVDAYNAME1 = 49'&h00000031
		    Const LOCALE_SABBREVDAYNAME2 = &h00000032
		    Const LOCALE_SABBREVDAYNAME3 = &h00000033
		    Const LOCALE_SABBREVDAYNAME4 = &h00000034
		    Const LOCALE_SABBREVDAYNAME5 = &h00000035
		    Const LOCALE_SABBREVDAYNAME6 = &h00000036
		    Const LOCALE_SABBREVDAYNAME7 = &h00000037
		    dim dayConst( 7 ) as Integer
		    dayConst = Array( LOCALE_SABBREVDAYNAME1, LOCALE_SABBREVDAYNAME2, LOCALE_SABBREVDAYNAME3, _
		    LOCALE_SABBREVDAYNAME4, LOCALE_SABBREVDAYNAME5, LOCALE_SABBREVDAYNAME6, LOCALE_SABBREVDAYNAME7 )
		    
		    for i = 0 to 6
		      ret = GetLocaleInfo( dayConst( i ), mb, retVal )
		      DayNames((i+1) mod 7 +1) = Titlecase ( retVal )
		    next
		    
		    //Month Names
		    Const LOCALE_SMONTHNAME1 = 56'&h00000038
		    Const LOCALE_SMONTHNAME2 = &h00000039
		    Const LOCALE_SMONTHNAME3 = &h0000003A
		    Const LOCALE_SMONTHNAME4 = &h0000003B
		    Const LOCALE_SMONTHNAME5 = &h0000003C
		    Const LOCALE_SMONTHNAME6 = &h0000003D
		    Const LOCALE_SMONTHNAME7 = &h0000003E
		    Const LOCALE_SMONTHNAME8 = &h0000003F
		    Const LOCALE_SMONTHNAME9 = &h00000040
		    Const LOCALE_SMONTHNAME10 = &h00000041
		    Const LOCALE_SMONTHNAME11 = &h00000042
		    Const LOCALE_SMONTHNAME12 = &h00000043
		    Const LOCALE_SMONTHNAME13 = &h0000100E
		    dim monthConst( 13 ) as Integer
		    monthConst = Array( LOCALE_SMONTHNAME1, LOCALE_SMONTHNAME2, LOCALE_SMONTHNAME3, _
		    LOCALE_SMONTHNAME4, LOCALE_SMONTHNAME5, LOCALE_SMONTHNAME6, LOCALE_SMONTHNAME7, _
		    LOCALE_SMONTHNAME8, LOCALE_SMONTHNAME9, LOCALE_SMONTHNAME10, LOCALE_SMONTHNAME11, _
		    LOCALE_SMONTHNAME12, LOCALE_SMONTHNAME13 )
		    
		    ReDim MonthNames(12)
		    for i = 0 to 11
		      ret = GetLocaleInfo( monthConst( i ), mb, retVal )
		      MonthNames(i+1) = Titlecase( retVal )
		    next
		    
		    //Day of Week
		    Const LOCALE_IFIRSTDAYOFWEEK  = &h100C
		    ret = GetLocaleInfo( LOCALE_IFIRSTDAYOFWEEK, mb, retVal )
		    FirstDayOfWeek = (Val( retVal ) + 1) mod 7 + 1
		    
		  #else
		    
		    Dim D As New Date
		    
		    For i as integer = 0 to 6
		      DayNames(D.DayOfWeek) = D.LongDate.NthField(" ", 1)
		      D.Day = D.Day + 1
		    Next
		    
		    Dim Field As Integer
		    If IsNumeric(D.LongDate.NthField(" ", 3)) = False then
		      Field = 3
		    elseif IsNumeric(D.LongDate.NthField(" ", 2)) = False then
		      Field = 2
		    else
		      Field = 4
		    End If
		    
		    D.Day = 1
		    D.Month = 1
		    For i as Integer = 1 to 12
		      MonthNames(i) = TitleCase(D.LongDate.NthField(" ", Field))
		      D.Month = D.Month + 1
		    Next
		    
		    FirstDayOfWeek = 1 //Monday
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Show(left as integer, top as integer, rowheight as integer, owner As PropertyListBox, options() As String, LineIndex As Integer, AutoWidth As Boolean = False, FixedWidth As Integer = 0, AutoCompleteMode As Boolean)
		  //get options
		  
		  DefaultLeft = Left
		  
		  me.left = left
		  me.Top = top + rowheight
		  
		  AddchildWindowOrderedAbove(owner.Window, self)
		  
		  //load suggestions
		  loadSuggestions(options(), AutoWidth)
		  
		  
		  
		  'me.Left = Left
		  
		  me.Reference = new WeakRef(owner)
		  self.LineIndex = LineIndex
		  
		  If not AutoWidth and FixedWidth>0 then
		    me.Width = FixedWidth
		  End If
		  
		  Dim ScreenIndex As Integer = GetScreen(left, top)
		  if me.top + me.Height > Screen(ScreenIndex).AvailableHeight + Screen(ScreenIndex).Top then
		    me.ListHeight = Screen(ScreenIndex).AvailableHeight + Screen(ScreenIndex).Top - me.Top - 2
		  else
		    me.ListHeight = me.Height
		  end if
		  If me.Left + me.Width > Screen(ScreenIndex).AvailableWidth + Screen(ScreenIndex).Left then
		    me.Left = Screen(ScreenIndex).AvailableWidth + Screen(ScreenIndex).Left - me.Width - 2
		  End If
		  
		  super.SetFocus
		  optionList.SetFocus
		  If AutoCompleteMode then
		    Super.Show
		  Else
		    Super.ShowModal
		  End If
		  Timer2.Mode = Timer.ModeMultiple
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowDatePicker(left as integer, top as integer, rowheight as integer, owner As PropertyListBox, Value As String, LineIndex As Integer, AutoWidth As Boolean = False, FixedWidth As Integer = 0)
		  //get options
		  
		  DefaultLeft = Left
		  
		  me.left = left
		  me.Top = top + rowheight
		  
		  AddchildWindowOrderedAbove(owner.Window, self)
		  
		  
		  optionList.Visible = False
		  DatePicker = True
		  
		  Dim d As new date
		  
		  If Value <> "" then
		    Try
		      d.SQLDate = Value
		    Catch UnsupportedFormatException
		      
		    End Try
		  End If
		  DisplayDate = new date(d)
		  
		  me.Reference = new WeakRef(owner)
		  self.LineIndex = LineIndex
		  
		  If not AutoWidth and FixedWidth>0 then
		    me.Width = FixedWidth
		  End If
		  me.Height = 8*rowheight
		  
		  Dim ScreenIndex As Integer = GetScreen(left, top)
		  if me.top + me.Height > Screen(ScreenIndex).AvailableHeight + Screen(ScreenIndex).Top then
		    me.ListHeight = Screen(ScreenIndex).AvailableHeight + Screen(ScreenIndex).Top - me.Top - 2
		  else
		    me.ListHeight = me.Height
		  end if
		  If me.Left + me.Width > Screen(ScreenIndex).AvailableWidth + Screen(ScreenIndex).Left then
		    me.Left = Screen(ScreenIndex).AvailableWidth + Screen(ScreenIndex).Left - me.Width - 2
		  End If
		  
		  super.SetFocus
		  optionList.SetFocus
		  'If AutoCompleteMode then
		  'Super.Show
		  'Else
		  Super.ShowModal
		  'End If
		  Timer2.Mode = Timer.ModeMultiple
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartTimer()
		  //this is a workaround to close the window without crashing, don't know why
		  me.Hide
		  timer1.Mode = timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub submit(what as string = "")
		  //submit selected option
		  if optionSubmitted then Return
		  optionSubmitted = true
		  
		  
		  if what ="" then
		    option = optionList.Text
		  else
		    option = what
		  end if
		  
		  
		  If owner.AutoCompleteMode then
		    Dim row, column As Integer
		    row = val(owner.LastEditCell.NthField(",", 1))
		    Column = val(owner.LastEditCell.NthField(",", 2))
		    Dim tmpValue As String = owner.Cell(row,Column)
		    If Instr(tmpValue.NthField(" ", tmpValue.CountFields(" ")), option) = 0 then
		      owner.cell(row, column) = left(tmpValue, len(tmpValue) - len(tmpValue.NthField(" ", tmpValue.CountFields(" ")))) + option
		    Else
		      owner.Cell(row, column) = owner.Cell(row,Column) + option
		    End If
		    owner.GetLine(LineIndex).Value = owner.cell(row, Column)
		  End If
		  
		  Hide
		  
		  StartTimer
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		AdaptWeeksPerMonth As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		DatePicker As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		DayNames(7) As String
	#tag EndProperty

	#tag Property, Flags = &h0
		DefaultLeft As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mDisplayDate
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  If EnableNilDate then
			    mDisplayDate = value
			  else
			    If value is nil then
			      mDisplayDate = new date
			    else
			      mDisplayDate = value
			    End If
			  End If
			  mFirstDate = Nil
			  
			  If EnableNilDate and value is nil then
			    DisplayMonth = New Date
			  else
			    DisplayMonth = New Date(value)
			  End If
			  
			  'DateChanged(value)
			  
			  Refresh(False)
			End Set
		#tag EndSetter
		DisplayDate As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mDisplayMonth
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDisplayMonth = value
			  mFirstDate = Nil
			End Set
		#tag EndSetter
		DisplayMonth As Date
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		EnableNilDate As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  
			  'If mFirstDate is Nil then
			  
			  mFirstDate = New Date
			  mFirstDate.TotalSeconds = DisplayMonth.TotalSeconds
			  mFirstDate.Day = 1
			  mFirstDate.Hour = 0
			  mFirstDate.Minute = 0
			  mFirstDate.Second = 0
			  If AdaptWeeksPerMonth then
			    
			    If mFirstDate.DayOfWeek - FirstDayOfWeek < 0 then
			      mFirstDate.Day = mFirstDate.Day - (mFirstDate.DayOfWeek - FirstDayOfWeek) - 7
			    else
			      mFirstDate.Day = mFirstDate.Day - (mFirstDate.DayOfWeek - FirstDayOfWeek)
			    End If
			    
			    Dim DrawDate As Date = New Date(DisplayMonth)
			    DrawDate.Day = 1
			    DrawDate.Month = DrawDate.Month + 1
			    DrawDate.Day = DrawDate.Day - 1
			    DrawDate.Hour = 0
			    DrawDate.Minute  =0
			    DrawDate.Second = 0
			    
			    WeeksPerMonth = Ceil((DrawDate.TotalSeconds - mFirstDate.TotalSeconds + 86400) / 604800)
			    
			  else
			    
			    WeeksPerMonth = 6
			    
			    If mFirstDate.DayOfWeek - FirstDayOfWeek <= 0 then
			      mFirstDate.Day = mFirstDate.Day - (mFirstDate.DayOfWeek - FirstDayOfWeek) - 7
			    else
			      mFirstDate.Day = mFirstDate.Day - (mFirstDate.DayOfWeek - FirstDayOfWeek)
			    End If
			  End If
			  
			  'End If
			  
			  return New Date(mFirstDate)
			End Get
		#tag EndGetter
		Protected FirstDate As Date
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		FirstDayOfWeek As Byte
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected LastDayOver As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		LineIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ListHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDisplayDate As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDisplayMonth As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFirstDate As Date
	#tag EndProperty

	#tag Property, Flags = &h0
		MonthNames(12) As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOption As String
	#tag EndProperty

	#tag Property, Flags = &h0
		MyColors As Colors
	#tag EndProperty

	#tag Property, Flags = &h0
		MyStyle As PPTLStyles
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  StartTimer()
			  return mOption
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mOption = value
			End Set
		#tag EndSetter
		option As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private optionSubmitted As boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  if me.Reference <> nil then
			    return PropertyListBox(me.Reference.Value)
			  else
			    return nil
			  end if
			End Get
		#tag EndGetter
		Private owner As PropertyListBox
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Reference As weakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Transparent As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected WeeksPerMonth As Integer
	#tag EndProperty


	#tag Constant, Name = kversion, Type = Double, Dynamic = False, Default = \"1.2", Scope = Public
	#tag EndConstant


	#tag Structure, Name = Colors, Flags = &h1
		Header As Color
		  DayName As Color
		  Today As Color
		  PDayNumber As Color
		  PDayNumberActive As Color
		  Border As Color
		  PSelected As Color
		  PBackground As Color
		  Title As Color
		PArrow As Color
	#tag EndStructure

	#tag Structure, Name = PPTLStyles, Flags = &h1
		PDayNumberPos As Byte
		  PDayNamePos As Byte
		  PDayNameBold As Boolean
		PDayNumberBold As Boolean
	#tag EndStructure


#tag EndWindowCode

#tag Events optionList
	#tag Event
		Function CellClick(row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  #pragma Unused x
		  #pragma Unused y
		  
		  submit(me.cell(row,column))
		End Function
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  'MsgBox str(asc(key))
		  select case asc(key)
		  case 27, 8, 127
		    cancel
		    
		  case 9, 13, 3, 32
		    submit
		    
		  case 28, 29, 30, 31
		    Return False
		    
		  end select
		  Return true
		End Function
	#tag EndEvent
	#tag Event
		Sub LostFocus()
		  If not owner.AutoCompleteMode then
		    cancel
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  Dim index As Integer = me.RowFromXY(X, Y)
		  If me.ListIndex <> index then
		    me.ListIndex = index
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Timer1
	#tag Event
		Sub Action()
		  self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Timer2
	#tag Event
		Sub Action()
		  self.Height = min(ListHeight, self.Height + 5)
		  If self.Height = ListHeight then
		    me.Mode = Timer.ModeOff
		  End If
		End Sub
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
		Name="ImplicitInstance"
		Visible=true
		Group="Appearance"
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
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="300"
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
		InitialValue="False"
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
		Name="option"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LineIndex"
		Visible=false
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ListHeight"
		Visible=false
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLeft"
		Visible=false
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AdaptWeeksPerMonth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="EnableNilDate"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DatePicker"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FirstDayOfWeek"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Byte"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
