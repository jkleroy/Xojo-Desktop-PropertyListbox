#tag Class
Protected Class PropertyListButton
	#tag Method, Flags = &h0
		Sub Constructor(Pic As Picture, Caption As String, ID As Integer)
		  //Constructor for the PropertyListButton class.
		  
		  self.Pic = Pic
		  self.Caption = Caption
		  self.id = ID
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		This class is used to define a button that can be displayed on header lines.
		All buttons must have a unique ID or else the first matching ID will be the displayed button.
		
	#tag EndNote

	#tag Note, Name = See Also
		PropertyListBox, PropertyListLine, PropertyListStyle classes.
		PropertyListModule module.
	#tag EndNote


	#tag Property, Flags = &h0
		#tag Note
			Caption of the Button.
		#tag EndNote
		Caption As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			ID number of the button.
		#tag EndNote
		ID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Picture displayed for the button.
		#tag EndNote
		Pic As Picture
	#tag EndProperty


	#tag Constant, Name = kversion, Type = Double, Dynamic = False, Default = \"1.2", Scope = Public
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
			Name="id"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
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
			Name="Pic"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
