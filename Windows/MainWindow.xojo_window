#tag Window
Begin Window MainWindow
   BackColor       =   &cFF000000
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   679
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   1024153599
   MenuBarVisible  =   True
   MinHeight       =   521
   MinimizeButton  =   True
   MinWidth        =   610
   Placement       =   0
   Resizeable      =   True
   Title           =   "PropertyListBox Demo"
   Visible         =   True
   Width           =   700
   Begin PropertyListBox PropertyListBox1
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   True
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
      ColumnCount     =   2
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
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   360
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
      Top             =   46
      Transparent     =   True
      TransparentString=   ""
      Underline       =   False
      ValueString     =   ""
      Visible         =   True
      Width           =   298
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin PushButton PushButton1
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Open Creator"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   575
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   421
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   105
   End
   Begin PushButton PushButton2
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "<- Load"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   562
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   12
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   105
   End
   Begin PushButton Pb_ToXML
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "toXML ->"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   137
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   12
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   105
   End
   Begin CheckBox HierarchicalBox
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Hierarchical"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   334
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   453
      Transparent     =   True
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   113
   End
   Begin ListBox EventsList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
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
      Height          =   239
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   0
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   418
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   298
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin CheckBox MacOSBox
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Mac OS style"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   472
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   453
      Transparent     =   True
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   113
   End
   Begin CheckBox ScrollBarHorizontal
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Horizontal Scrollbar"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   334
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   476
      Transparent     =   True
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   156
   End
   Begin CustomEditField EditField1
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AutoCloseBrackets=   False
      AutocompleteAppliesStandardCase=   True
      AutoIndentNewLines=   True
      BackColor       =   &cFFFFFF00
      Backdrop        =   0
      Border          =   True
      BorderColor     =   &c88888800
      BracketHighlightColor=   &cFFFF0000
      CaretColor      =   &c00000000
      CaretLine       =   0
      CaretPos        =   0
      ClearHighlightedRangesOnTextChange=   True
      DirtyLinesColor =   &cFF999900
      disableReset    =   False
      DisplayDirtyLines=   False
      DisplayInvisibleCharacters=   False
      DisplayLineNumbers=   True
      DisplayRightMarginMarker=   False
      DoubleBuffer    =   False
      EnableAutocomplete=   False
      Enabled         =   True
      EnableLineFoldings=   False
      enableLineFoldingSetting=   False
      EraseBackground =   False
      GutterBackgroundColor=   &cEEEEEE00
      GutterSeparationLineColor=   &c88888800
      GutterWidth     =   0
      Height          =   344
      HighlightBlocksOnMouseOverGutter=   True
      HighlightMatchingBrackets=   True
      HighlightMatchingBracketsMode=   0
      ignoreRepaint   =   False
      IndentPixels    =   16
      IndentVisually  =   False
      Index           =   -2147483648
      InitialParent   =   ""
      KeepEntireTextIndented=   False
      Left            =   330
      leftMarginOffset=   4
      LineNumbersColor=   &c88888800
      LineNumbersTextFont=   "System"
      LineNumbersTextSize=   9
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaxVisibleLines =   0
      ReadOnly        =   False
      RightMarginAtPixel=   0
      RightScrollMargin=   150
      Scope           =   0
      ScrollPosition  =   0
      ScrollPositionX =   0
      selLength       =   0
      selStart        =   0
      SelText         =   ""
      Stats           =   ""
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      TabWidth        =   4
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextHeight      =   0.0
      TextLength      =   0
      TextSelectionColor=   &c00000000
      TextSize        =   0
      ThickInsertionPoint=   True
      Tooltip         =   ""
      Top             =   46
      Transparent     =   True
      Visible         =   True
      Width           =   334
   End
   Begin Splitter Splitter1
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      enableLock      =   False
      EraseBackground =   True
      Height          =   360
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   318
      Lock            =   False
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Maximum         =   60
      Minimized       =   False
      Minimum         =   60
      restorePos      =   0
      Scope           =   0
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   46
      Transparent     =   True
      Visible         =   True
      Width           =   12
   End
   Begin ScrollBar vScrollbar
      AllowAutoDeactivate=   True
      AllowFocus      =   True
      AllowLiveScrolling=   True
      Enabled         =   True
      Height          =   344
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   664
      LineStep        =   1
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumValue    =   100
      MinimumValue    =   0
      PageStep        =   20
      Scope           =   0
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   46
      Transparent     =   True
      Value           =   0
      Visible         =   True
      Width           =   16
   End
   Begin ScrollBar hScrollbar
      AllowAutoDeactivate=   True
      AllowFocus      =   True
      AllowLiveScrolling=   True
      Enabled         =   True
      Height          =   16
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   330
      LineStep        =   1
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MaximumValue    =   100
      MinimumValue    =   0
      PageStep        =   20
      Scope           =   0
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   390
      Transparent     =   True
      Value           =   0
      Visible         =   True
      Width           =   334
   End
   Begin CheckBox BBCodeBox
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "BBCode"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   595
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   453
      Transparent     =   True
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   77
   End
   Begin CheckBox GutterBox
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Color Gutter"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   530
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   476
      Transparent     =   True
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   127
   End
   Begin Label Label1
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   334
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   19
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "GridLinesHorizontal:"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   501
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   156
   End
   Begin PopupMenu PopupMenu1
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "0 - Default\r\n1 - None\r\n2 - ThinDotted\r\n3 - ThinSolid"
      Italic          =   False
      Left            =   530
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      SelectedRowIndex=   0
      TabIndex        =   20
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   500
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   134
   End
   Begin PopupMenu PopupMenu2
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "0 - Default\r\n1 - None\r\n2 - ThinDotted\r\n3 - ThinSolid"
      Italic          =   False
      Left            =   530
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      SelectedRowIndex=   0
      TabIndex        =   21
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   530
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   134
   End
   Begin Label Label2
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   334
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   22
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "GridLinesVertical:"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   530
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   126
   End
   Begin Label Label3
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   334
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   23
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "GridLinesColor:"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   563
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   126
   End
   Begin ColorPick ColorPick1
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   False
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   False
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   530
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      myColor         =   &c00000000
      Scope           =   0
      TabIndex        =   24
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   564
      Transparent     =   True
      Visible         =   True
      Width           =   20
   End
   Begin Label Label4
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   334
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   25
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Change Size:"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   596
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   BeginSegmented SegmentedControl SegmentedControl1
      Enabled         =   True
      Height          =   24
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   530
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacControlStyle =   0
      Scope           =   0
      Segments        =   "+\n\nFalse\r-\n\nFalse"
      SelectionType   =   2
      TabIndex        =   21
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   592
      Transparent     =   True
      Visible         =   True
      Width           =   64
   End
   Begin Label Label5
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   334
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   27
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Quick Style:"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   628
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin PopupMenu PopupMenu3
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Default\r\nAlternRows\r\nDark\r\nLight Orange"
      Italic          =   False
      Left            =   530
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      SelectedRowIndex=   0
      TabIndex        =   28
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   625
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   134
   End
   Begin PushButton Pb_ToXML1
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "toJSON ->"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   29
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   12
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   105
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  
		  Call PropertyListBox1.LoadFromXML(PropertyListboxExample)
		  
		  Pb_ToXML.Push
		  
		  'LoadDefinition("PropertyListbox Example.txt")
		  
		  Dim D As new date
		  PropertyListBox1.CellValue("Date Picker", False) = d.SQLDate
		  
		  'EditField1.Text = ppt
		  'PushButton2.Push
		  
		  me.Height = me.Height + (394-352)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub LoadDefinition(file As String)
		  Dim f As new FolderItem
		  
		  f = f.child("Resources")
		  If not f.Exists then
		    f = new FolderItem
		    f = f.Parent
		    f = f.child("Resources")
		  End If
		  
		  f = f.Child(file)
		  
		  If f <> Nil and f.Exists then
		    Dim stream As TextInputStream
		    stream = stream.Open(f)
		    
		    
		    Call PropertyListBox1.LoadFromXML(stream.ReadAll)
		    
		    Pb_ToXML.Push
		    
		  else
		    MsgBox("Some files are missing in the Resource folder")
		    
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected Xdown As Integer
	#tag EndProperty


	#tag Constant, Name = ppt, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<PropertyListBox version\x3D\"1.2\">\r<name>PropertyListbox Example</name>\r<button id\x3D\"0\" text\x3D\"Help\"/>\r<contents>\r<header visible\x3D\"True\" expanded\x3D\"True\">\r<name>Cell Types</name>\r<param type\x3D\"1\" visible\x3D\"True\">\r<name>Normal</name>\r<value>Normal Text</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>CheckBox</name>\r<value>False</value>\r</param>\r<param type\x3D\"3\" visible\x3D\"True\">\r<name>Editable</name>\r<value>Click to edit</value>\r</param>\r<param type\x3D\"4\" visible\x3D\"True\">\r<name>Multiline Text</name>\r<value>Click to edit\r</value>\r</param>\r<param type\x3D\"5\" visible\x3D\"True\" required\x3D\"True\">\r<name>List</name>\r<valuelist>Red|Green|Blue</valuelist>\r</param>\r<param type\x3D\"6\" visible\x3D\"True\">\r<name>Editable List</name>\r<valuelist>Red|Green|Blue</valuelist>\r</param>\r<param type\x3D\"6\" visible\x3D\"True\" autocomplete\x3D\"True\">\r<name>Autocomplete List</name>\r<valuelist>font_list</valuelist>\r</param>\r<param type\x3D\"6\" visible\x3D\"True\" autocomplete\x3D\"false\">\r<name>Custom Edit</name>\r<valuelist>font_list</valuelist>\r</param>\r<param type\x3D\"7\" visible\x3D\"True\">\r<name>Color</name>\r<value>&amp;cDBDFFF</value>\r</param>\r<param type\x3D\"8\" visible\x3D\"True\">\r<name>FolderItem (File)</name>\r</param>\r\r<param type\x3D\"8\" visible\x3D\"True\" folder\x3D\"True\">\r<name>FolderItem (Folder)</name>\r</param>\r\r<param type\x3D\"9\" visible\x3D\"True\">\r<name>RadioButton 1</name>\r<value>True</value>\r<helptag>Only one RadioButton per header can be checked at at time.\rRadioButton appear as checkboxes.\rHowever\x2C RadioButtons and Checkboxes are independant</helptag>\r</param>\r<param type\x3D\"9\" visible\x3D\"True\">\r<name>RadioButton 2</name>\r<value>False</value>\r<helptag>Only one RadioButton per header can be checked at at time.\rRadioButton appear as checkboxes.\rHowever\x2C RadioButtons and Checkboxes are independant</helptag>\r</param>\r<param type\x3D\"9\" visible\x3D\"True\">\r<name>RadioButton 3</name>\r<value>False</value>\r<helptag>Only one RadioButton per header can be checked at at time.\rRadioButton appear as checkboxes.\rHowever\x2C RadioButtons and Checkboxes are independant</helptag>\r</param>\r<param type\x3D\"10\" visible\x3D\"True\">\r<name>Rating</name>\r<value>3</value>\r</param>\r<param type\x3D\"11\" visible\x3D\"True\">\r<name>Picture</name>\r<value>3</value>\r</param>\r</header>\r<header visible\x3D\"True\" expanded\x3D\"True\" button\x3D\"0\">\r<name>Header with Button</name>\r<param type\x3D\"3\" visible\x3D\"True\" numeric\x3D\"True\">\r<name>Enter a math formula</name>\r<value>5+3*2</value>\r</param>\r<param type\x3D\"2\" visible\x3D\"True\">\r<name>Show Invisible Lines</name>\r<value>False</value>\r</param>\r<param type\x3D\"1\" visible\x3D\"False\">\r<name>Invisible Line 1</name>\r</param>\r<param type\x3D\"1\" visible\x3D\"False\">\r<name>Invisible Line 2</name>\r</param>\r<param type\x3D\"2\" visible\x3D\"False\">\r<name>Show Invisible Header</name>\r<value>False</value>\r</param>\r</header>\r<header visible\x3D\"False\" expanded\x3D\"True\">\r<name>Invisible Header</name>\r<param type\x3D\"1\" visible\x3D\"True\">\r<name>No value</name>\r</param>\r</header>\r</contents>\r<style>\r<header UpdateStyle\x3D\"False\">\r<backColor>#DBDFFF</backColor>\r<bold>True</bold>\r<highlightcolor>#3399FF</highlightcolor>\r<italic>False</italic>\r<textalign>0</textalign>\r<textcolor>#000000</textcolor>\r<textfont>System</textfont>\r<texthighlightcolor>#FFFFFF</texthighlightcolor>\r<textsize>0</textsize>\r<underline>False</underline>\r</header>\r<name UpdateStyle\x3D\"False\">\r<backColor>#FFFFFF</backColor>\r<bold>False</bold>\r<highlightcolor>#3399FF</highlightcolor>\r<italic>False</italic>\r<textalign>2</textalign>\r<textcolor>#000000</textcolor>\r<textfont>System</textfont>\r<texthighlightcolor>#FFFFFF</texthighlightcolor>\r<textsize>0</textsize>\r<underline>False</underline>\r</name>\r<value UpdateStyle\x3D\"False\">\r<backColor>#FFFFFF</backColor>\r<bold>False</bold>\r<highlightcolor>#3399FF</highlightcolor>\r<italic>False</italic>\r<textalign>0</textalign>\r<textcolor>#000000</textcolor>\r<textfont>System</textfont>\r<texthighlightcolor>#FFFFFF</texthighlightcolor>\r<textsize>0</textsize>\r<underline>False</underline>\r</value>\r<defaultvalue UpdateStyle\x3D\"False\">\r<backColor>#FFDDAA</backColor>\r<bold>False</bold>\r<highlightcolor>#3399FF</highlightcolor>\r<italic>False</italic>\r<textalign>0</textalign>\r<textcolor>#000000</textcolor>\r<textfont>System</textfont>\r<texthighlightcolor>#FFFFFF</texthighlightcolor>\r<textsize>0</textsize>\r<underline>False</underline>\r</defaultvalue>\r<ColonString>:</ColonString>\r<PropertyString>Property</PropertyString>\r<ValueString>Value</ValueString>\r<TransparentString>transparent</TransparentString>\r<Border>True</Border>\r<ColumnWidths>50% 50%\x2C 1*</ColumnWidths>\r<GridLinesHorizontal>0</GridLinesHorizontal>\r<GridLinesVertical>0</GridLinesVertical>\r<HasHeading>True</HasHeading>\r<ScrollBarHorizontal>False</ScrollBarHorizontal>\r<ScrollBarVertical>True</ScrollBarVertical>\r<DefaultRowHeight>-1</DefaultRowHeight>\r<AutoHideScrollbars>True</AutoHideScrollbars>\r<Hierarchical>True</Hierarchical>\r</style>\r</PropertyListBox>", Scope = Protected
	#tag EndConstant


#tag EndWindowCode

#tag Events PropertyListBox1
	#tag Event
		Function LoadingValueList(ValueName As String) As String()
		  Dim newA() As String
		  if ValueName = "font_list" then
		    For i as Integer = 0 to FontCount - 1
		      If font(i).left(1) <> "@" then
		        newA.Append Font(i)
		      End If
		    Next
		    newA.Sort
		    Return newA
		  End If
		  Return Nil
		End Function
	#tag EndEvent
	#tag Event
		Sub ButtonPressed(PropertyName As String, ButtonCaption As String)
		  #Pragma Unused ButtonCaption
		  
		  EventsList.AddRow "ButtonPressed( " + PropertyName + " )"
		  EventsList.ScrollPosition = EventsList.ListCount
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellValueChanged(row As integer, column As integer, PropertyName As String, Value As String)
		  #Pragma Unused row
		  #Pragma Unused column
		  
		  EventsList.AddRow "CellValueChanged( " + PropertyName + " = " + Value + " )"
		  EventsList.ScrollPosition = EventsList.ListCount
		  
		  If PropertyName = "Header with Button.Show Invisible Lines" then
		    me.GetLine("Invisible Line 1").visible = (Value = "True")
		    me.GetLine("Invisible Line 2").visible = (Value = "True")
		    me.GetLine("Show Invisible Header").visible = (Value = "True")
		    me.Reload
		  elseif PropertyName = "Header with Button.Show Invisible Header" then
		    me.GetLine("Invisible Header").visible = (Value = "True")
		    me.Reload
		    
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ContentsChanged(ContentsName As String, Comment As String)
		  #Pragma Unused Comment
		  
		  EventsList.AddRow "ContentsChanged( " + ContentsName + " )"
		  EventsList.ScrollPosition = EventsList.ListCount
		  
		  HierarchicalBox.Value = me.Hierarchical
		  MacOSBox.value = me.MacOSStyle
		End Sub
	#tag EndEvent
	#tag Event
		Function ShouldTriggerAutocomplete(Key as string, hasAutocompleteOptions as boolean) As boolean
		  If hasAutocompleteOptions and Key = chr(9) then
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub CellAction(row As integer, column As integer, PropertyName As String, Value As String)
		  #Pragma Unused row
		  #Pragma Unused column
		  
		  EventsList.AddRow "CellAction( " + PropertyName + " = " + Value + " )"
		  EventsList.ScrollPosition = EventsList.ListCount
		End Sub
	#tag EndEvent
	#tag Event
		Function CellClick(row As integer, column As integer, x As Integer, y As Integer, PropertyName As String) As Boolean
		  EventsList.AddRow "CellClick( " + PropertyName + " )"
		  EventsList.ScrollPosition = EventsList.ListCount
		  
		  
		  //Prevent Changing value with this code
		  dim Line As PropertyListLine = me.GetLine(row)
		  
		  If Line is Nil then Return False
		  If Line.Type = Line.TypeNumericUpDown then
		    If x > me.Column(column).WidthActual - me.ButtonPopupArrow.Width then
		      //Updown arrow clicked
		      
		      If Y > me.RowHeight\2 then //Down arrow clicked
		        
		        //Prevent value going below 0
		        If val(me.cell(row, column))=0 then
		          EventsList.AddRow "Prevent value<0"
		          EventsList.ScrollPosition = EventsList.ListCount
		          Return True
		        End If
		        
		      else //Up arrow clicked
		        
		        //Prevent value going over 10
		        If val(me.cell(row, column))=10 then
		          EventsList.AddRow "Prevent value>10"
		          EventsList.ScrollPosition = EventsList.ListCount
		          Return True
		        End If
		        
		      end if
		    End If
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Function CellCustomEdit(row As Integer, column As Integer, CellType As Integer, PropertyName As String, ByRef PropertyValue As String) As Boolean
		  #Pragma Unused row
		  #Pragma Unused column
		  #Pragma Unused CellType
		  
		  If PropertyName = "Cell Types.Custom Edit" then
		    PropertyValue = CustomEdit.ShowModal(PropertyValue)
		    
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub LoadEmptyList(base As MenuItem)
		  Dim mn As new MenuItem("Empty list")
		  mn.Enabled = False
		  
		  base.Append mn
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton1
	#tag Event
		Sub Action()
		  CreatorWindow.Show
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton2
	#tag Event
		Sub Action()
		  'Dim ms As Double = Microseconds
		  
		  Dim result As Boolean
		  
		  If EditField1.Text.Trim.Left(1) = "{" then //JSON
		    Dim js As new JSONItem
		    try
		      js.Load(EditField1.Text)
		      result = PropertyListBox1.LoadFromJSON(js)
		    Catch
		      result = False
		    end try
		  End If
		  
		  If result = False then
		    result = PropertyListBox1.LoadFromXML(EditField1.Text)
		  End If
		  
		  If result = False then
		    MsgBox "Error loading xml or JSON"
		  Else
		    'StaticText1.Text = "Done in " + Format((Microseconds - ms)/1000, "0.000") + "ms"
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Pb_ToXML
	#tag Event
		Sub Action()
		  'Dim ms As Double = Microseconds
		  EditField1.Text = FixIndention(PropertyListBox1.toXML(True, True, True))
		  'StaticText2.Text = "Done in " + Format((Microseconds - ms)/1000, "0.000") + "ms"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HierarchicalBox
	#tag Event
		Sub Action()
		  PropertyListBox1.Hierarchical = me.Value
		  PropertyListBox1.Reload
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MacOSBox
	#tag Event
		Sub Action()
		  PropertyListBox1.MacOSStyle = me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ScrollBarHorizontal
	#tag Event
		Sub Action()
		  PropertyListBox1.ScrollBarHorizontal = me.Value
		  If me.Value then
		    PropertyListBox1.ColumnWidths = str(PropertyListbox1.Width \ 2 + 2) + "," +  str(PropertyListbox1.Width \ 2 + 2)
		  else
		    PropertyListBox1.ColumnWidths = ("*,*")
		  End If
		  PropertyListBox1.Reload
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EditField1
	#tag Event
		Sub Open()
		  me.SetScrollbars(hScrollbar, vScrollbar)
		  me.HighlightBlocksOnMouseOverGutter = False
		  
		  Dim def As new HighlightDefinition
		  If not def.loadFromXml(xmlsyntax) then
		    MsgBox("fail")
		    
		  End If
		  
		  me.SyntaxDefinition = def
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub HighlightingComplete()
		  me.Redraw
		End Sub
	#tag EndEvent
	#tag Event
		Function KeyDown(key as string) As boolean
		  If Keyboard.ControlKey and key = chr(01) then
		    me.SelectAll
		    Return true
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events vScrollbar
	#tag Event
		Sub ValueChanged()
		  EditField1.ScrollPosition = me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events hScrollbar
	#tag Event
		Sub ValueChanged()
		  EditField1.ScrollPositionX = me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BBCodeBox
	#tag Event
		Sub Action()
		  PropertyListBox1.BBcode = me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GutterBox
	#tag Event
		Sub Action()
		  PropertyListBox1.ColorGutter = me.Value
		  PropertyListBox1.InvalidateCell(-1, -1)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupMenu1
	#tag Event
		Sub Change()
		  PropertyListBox1.CustomGridLinesHorizontal = me.ListIndex
		  PropertyListBox1.InvalidateCell(-1, -1)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupMenu2
	#tag Event
		Sub Change()
		  PropertyListBox1.CustomGridLinesVertical = me.ListIndex
		  PropertyListBox1.InvalidateCell(-1, -1)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ColorPick1
	#tag Event
		Sub ColorChange()
		  PropertyListBox1.CustomGridLinesColor = me.myColor
		  PropertyListBox1.InvalidateCell(-1, -1)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  me.myColor = &cFF0000
		  PropertyListBox1.CustomGridLinesColor = me.myColor
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SegmentedControl1
	#tag Event
		Sub Action(itemIndex as integer)
		  If itemIndex = 0 then
		    PropertyListBox1.ChangeSize(1)
		  elseif itemIndex = 1 then
		    PropertyListBox1.ChangeSize(-1)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupMenu3
	#tag Event
		Sub Change()
		  Select case me.SelectedRow
		    
		    
		  Case "Default" 
		    LoadDefinition("Default-Style.xml")
		  Case "AlternRows" 
		    LoadDefinition("AlternRows-Style.xml")
		  Case "Dark" 
		    LoadDefinition("Dark-Style.xml")
		  Case "Light Orange" 
		    LoadDefinition("Orange-Style.xml")
		  else
		    Messagebox("Unknown style")
		    
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Pb_ToXML1
	#tag Event
		Sub Action()
		  'Dim ms As Double = Microseconds
		  Dim jsItem As JSONItem = PropertyListBox1.toJSON(True, True, True)
		  
		  If jsItem <> Nil then
		    jsItem.Compact = False
		    EditField1.Text = jsItem.ToString
		    
		  End If
		  'StaticText2.Text = "Done in " + Format((Microseconds - ms)/1000, "0.000") + "ms"
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
		Name="ImplicitInstance"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
