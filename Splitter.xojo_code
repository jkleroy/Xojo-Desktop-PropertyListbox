#tag Class
Protected Class Splitter
Inherits Canvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  me.SetFocus
		  if IsContextualClick then
		    If Me.Name="splitter" then
		      
		      ToggleMinimized(False, True)
		    End If
		  Else
		    mXAnchor = X
		    mYAnchor = Y
		  End If
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  ' Find out how many pixels the splitter must move until the mouse
		  ' is once again centered over the origin point.
		  ' Resize all the split-controls by this amount.
		  ' Move the splitter itself so it sits underneath the mouse.
		  Dim distance As Integer
		  If IsVertical Then
		    distance = X - mXAnchor
		    If Me.Left + distance < Minimum Then
		      distance = Minimum - Me.Left
		    End If
		    If Me.Left + Me.Width + distance > Me.Window.Width - Maximum Then
		      distance = Me.Window.Width - Maximum - Me.Left - Me.Width
		    End If
		    VerticalSplit distance
		  Else
		    distance = Y - mYAnchor
		    If Me.Top + distance < Minimum Then
		      distance = Minimum - Me.Top
		    End If
		    If Me.Top + Me.Height + distance > Me.Window.Height - Maximum Then
		      distance = Me.Window.Height - Maximum - Me.Top - Me.Height
		    End If
		    HorizontalSplit distance
		  End If
		  Minimized = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  PickCursor
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Moved()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  If me.Name = "Splitter2" then
		    'Minimized = False
		    ToggleMinimized(True)
		    restorePos = MainWindow.Width - 100
		  Else
		    restorePos = Minimum
		  End If
		  PickCursor
		  
		  If LockPicture = Nil then
		    CreateLock
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  
		  ' Draw a little handle at the middle of the splitter region.
		  Dim x,y As Integer
		  If Me.Active And Me.Enabled Then
		    x = Me.Width / 2
		    y = Me.Height / 2
		    DrawHandlePoint(g,x,y)
		    If IsVertical Then
		      DrawHandlePoint(g,x,y-4)
		      DrawHandlePoint(g,x,y-8)
		      DrawHandlePoint(g,x,y+4)
		      DrawHandlePoint(g,x,y+8)
		    Else
		      DrawHandlePoint(g,x+4,y)
		      DrawHandlePoint(g,x+8,y)
		      DrawHandlePoint(g,x-4,y)
		      DrawHandlePoint(g,x-8,y)
		    End If
		  End If
		  
		  If IsVertical and enableLock then
		    g.DrawPicture LockPicture, (me.Width - LockPicture.Width)\2, me.Height - LockPicture.Height - 4
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Shared Sub CreateLock()
		  LockPicture = New Picture(6,7,32)
		  Dim s As RGBSurface = LockPicture.RGBSurface
		  
		  s.Pixel(1,0) = &c777777
		  s.Pixel(2,0) = &c
		  
		  s.pixel(1,0) = &c777777
		  s.pixel(2,0) = &c222222
		  s.pixel(3,0) = &c0
		  s.pixel(4,0) = &c777777
		  
		  s.pixel(0,1) = &cDDDDDD
		  s.pixel(1,1) = &c222222
		  s.pixel(2,1) = &cFFFF33
		  s.pixel(3,1) = &c0
		  s.pixel(4,1) = &c111111
		  
		  For i as Integer = 2 to 6
		    s.pixel(0, i)= &c333333
		  Next
		  s.pixel(1,2) = &c444444
		  s.pixel(2,2) = &c555555
		  s.pixel(3,2) = &c333333
		  s.pixel(4,2) = &c222222
		  s.pixel(5,2) = &c0
		  
		  s.pixel(1,3) = &cBBBBBB
		  s.pixel(2,3) = &cDDDDDD
		  s.pixel(3,3) = &cAAAAAA
		  s.pixel(4,3) = &c555555
		  s.pixel(5,3) = &c111111
		  
		  s.pixel(1,4) = &c444444
		  s.pixel(2,4) = &c555555
		  s.pixel(3,4) = &cAAAAAA
		  s.pixel(4,4) = &c555555
		  s.pixel(5,4) = &c0
		  
		  s.pixel(1,5) = &cBBBBBB
		  s.pixel(2,5) = &cDDDDDD
		  s.pixel(3,5) = &cAAAAAA
		  s.pixel(4,5) = &c555555
		  s.pixel(5,5) = &c0
		  
		  s.pixel(1,6) = &c444444
		  s.pixel(2,6) = &c555555
		  s.pixel(3,6) = &c333333
		  s.pixel(4,6) = &c222222
		  s.pixel(5,6) = &c0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DrawHandlePoint(g As Graphics, x As Integer, y As Integer)
		  g.Pixel(x,y) = &c333333
		  g.Pixel(x+1,y+1) = &cFFFFFF
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub HorizontalSplit(distance As Integer)
		  ' Find all the controls to either side of the splitter.
		  ' Adjust their dimensions to match the specified distance.
		  Dim ctr As Integer
		  Dim item As RectControl
		  Dim okToMove As Boolean
		  For ctr = 0 To Me.Window.ControlCount-1
		    If Me.Window.Control( ctr ) IsA RectControl Then
		      item = RectControl( Me.Window.Control( ctr ) )
		      ' is this within the splitter's area of influence?
		      okToMove = Not(item Is Me)
		      okToMove = okToMove And item.Left >= Me.Left
		      okToMove = okToMove And (item.Left + item.Width) <= (Me.Left + Me.Width)
		      okToMove = okToMove And item.Parent = me.Parent
		      If okToMove Then
		        ' is this above the splitter or below?
		        If item.Top > Me.Top Then
		          'below
		          item.Height = item.Height - distance
		          item.Top = item.Top + distance
		        Else
		          item.Height = item.Height + distance
		        End If
		      End If
		    End If
		  Next
		  Me.Top = Me.Top + distance
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsVertical() As Boolean
		  Return Height > Width
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub PickCursor()
		  If IsVertical Then
		    Me.MouseCursor = System.Cursors.SplitterEastWest
		  Else
		    Me.MouseCursor = System.Cursors.SplitterNorthSouth
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ToggleMinimized(BottomRight As Boolean = False, UserClick As Boolean = false)
		  If Lock and not UserClick then Return
		  If Minimized Then //restore
		    If IsVertical Then
		      If not BottomRight then
		        VerticalSplit min(restorePos, self.Window.Width - Maximum - me.Width) - me.Left
		      else
		        VerticalSplit max(Minimum, restorePos) - me.Left
		      End If
		    Else
		      HorizontalSplit restorePos-me.Top
		    End If
		    Minimized = False
		  Else // Minimize
		    If IsVertical Then
		      restorePos = me.Left
		      If BottomRight Then
		        VerticalSplit Me.Window.Width - Maximum - Me.Left - Me.Width
		      Else
		        VerticalSplit Minimum - Me.Left
		      End If
		    Else
		      restorePos = me.Top
		      If BottomRight Then
		        HorizontalSplit Me.Window.Height - Maximum - Me.Top - Me.Height
		      Else
		        HorizontalSplit Minimum - Me.Top
		      End If
		    End If
		    Minimized = True
		  End If
		  Moved()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub VerticalSplit(distance As Integer)
		  ' Find all the controls to either side of the splitter.
		  ' Adjust their dimensions to match the specified distance.
		  Dim ctr As Integer
		  Dim item As RectControl
		  Dim okToMove As Boolean
		  For ctr = 0 To Me.Window.ControlCount-1
		    If Me.Window.Control( ctr ) IsA RectControl Then
		      item = RectControl( Me.Window.Control( ctr ) )
		      ' is this within the splitter's area of influence?
		      okToMove = Not(item Is Me)
		      okToMove = okToMove And item.Top >= Me.Top
		      okToMove = okToMove And  (item.Top + item.Height) <= (Me.Top + Me.Height)
		      okToMove = okToMove And item.Parent = Me.Parent
		      
		      'If item.Name="verticalSB" then okToMove=False
		      If me.Name = "Splitter1" then
		        If item.Name="vscrollbar" then
		          okToMove=False
		        Elseif item.Name = "Splitter2" then
		          okToMove = False
		        Elseif item.Name = "PropertyList" then
		          okToMove = False
		        End If
		      Elseif me.Name = "Splitter2" then
		        If item.Name = "Skin_EditField" then 
		          okToMove = False
		        ElseIf item.Name = "splitter1" then
		          okToMove = False
		        Elseif item.Name = "horizontalSB" then
		          okToMove = False
		        elseif item.Name = "verticalSB" then
		          okToMove = False
		        End If
		        
		      End If
		      
		      If okToMove Then
		        ' is this to the left of the splitter or the right?
		        If item.Left > Me.Left Then
		          'to the right
		          if item isa ScrollBar then
		            //if item is a scrollbar then verify it first
		            if item.Width>item.Height then
		              //item is a vertical scroll bar so we resize it
		              item.Width = item.Width - distance
		            end if
		            item.Left = item.Left + distance
		          Else
		            item.Width = item.Width - distance
		            item.Left = item.Left + distance
		          end if
		        Else
		          if item isa ScrollBar then
		            if item.Width>item.Height then
		              item.Width = item.Width + distance
		            Else
		              item.left=item.left+distance
		            end if
		          Else
		            item.Width = item.Width + distance
		          end if
		        End If
		      End If
		    End If
		  Next
		  Me.Left = Me.Left + distance
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Moved()
	#tag EndHook


	#tag Property, Flags = &h0
		enableLock As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Lock As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Shared LockPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h4
		Maximum As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Minimized As Boolean
	#tag EndProperty

	#tag Property, Flags = &h4
		Minimum As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mXAnchor As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mYAnchor As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		restorePos As Integer
	#tag EndProperty


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
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
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
			Name="enableLock"
			Visible=true
			Group="Position"
			InitialValue="0"
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
			Visible=false
			Group="Position"
			InitialValue=""
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
			Name="Backdrop"
			Visible=false
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Minimum"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Maximum"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="restorePos"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Minimized"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Lock"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
