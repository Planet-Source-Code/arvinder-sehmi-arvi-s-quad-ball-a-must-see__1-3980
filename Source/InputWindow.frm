VERSION 5.00
Begin VB.Form InputWindow 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Congratulations You Have The New High Score"
   ClientHeight    =   3195
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4680
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "InputWindow.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox NewName 
      Height          =   330
      Left            =   135
      TabIndex        =   1
      Top             =   2160
      Width           =   4380
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Cancel"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   20.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00008000&
      Height          =   465
      Left            =   2790
      TabIndex        =   4
      Top             =   2610
      Width           =   1155
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "OK"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   20.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00008000&
      Height          =   465
      Left            =   705
      TabIndex        =   3
      Top             =   2610
      Width           =   585
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Enter Your Name:"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFF00&
      Height          =   240
      Left            =   135
      TabIndex        =   2
      Top             =   1845
      Width           =   1500
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "You Have Beaten The High Score For Quad-Ball !"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   1635
      Left            =   45
      TabIndex        =   0
      Top             =   -45
      Width           =   4515
   End
End
Attribute VB_Name = "InputWindow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

'¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'
'This Form Is Used To Get The Name Of The High Scorer '
'_____________________________________________________'

Private Sub Form_Load()
 Call Set_Mouse_X_Y(Me.Left / Screen.TwipsPerPixelX + 100, Me.Top / Screen.TwipsPerPixelY + 100)
 ExitInputWindow = False
 Me.Picture = ParentForm.StoryScreen.Picture ' load back image
 Me.Show
 Me.Refresh
 LimitMovement ' start loop to control mouse
End Sub
'Limits Mouse Movemnt
Private Sub LimitMovement()
Do
  If ExitMouse = True Then GoTo nd:
  If ExitInputWindow = True Then GoTo nd:
  Me.ZOrder 0 ' place in front
  DoEvents
  KeepMouseOnForm ' move mouse onto form
 Loop Until ExitMouse = True
nd:
Unload Me
End Sub
Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
 ExitMouse = True
 ExitInputWindow = True
End Sub
'Svae The new Top Score And Scorer Name
Private Sub Label3_Click()
 Call SaveScore(NewName.Text, ParentForm.Score.caption)
 Unload Me
End Sub
'highlights Label 3 On Mouse Move
Private Sub Label3_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 If Label3.Tag = "yes" Then Exit Sub
 Label3.Tag = "yes"
 If Label4.Tag = " yes" Then
  Label4.ForeColor = RGB(0, 90, 0)
  Label4.Top = Label4.Top + 50
  Label4.FontSize = Label4.FontSize - 5
  Label4.Tag = "no"
 End If
 WAVPlay "click.qbs"
 Label3.Top = Label3.Top - 50
 Label3.ForeColor = RGB(0, 255, 0)
 Label3.FontSize = Label3.FontSize + 5
 End Sub
'Exits The Form
Private Sub Label4_Click()
 Dim Result As VbMsgBoxResult
 Result = MsgBox("Are You Sure?, If You Click OK Your New Top Score Will not Be Saved!", vbOKCancel, "Confirmation")
 If Result = vbCancel Then
  Exit Sub
 Else
  ExitMouse = True
  Unload Me
 End If
End Sub
'highlights Label 4 On Mouse Move
Private Sub Label4_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 If Label4.Tag = "yes" Then Exit Sub
 Label4.Tag = "yes"
 If Label3.Tag = " yes" Then
  Label3.ForeColor = RGB(0, 90, 0)
  Label3.Top = Label3.Top + 50
  Label3.FontSize = Label3.FontSize - 5
  Label3.Tag = "no"
 End If
 WAVPlay "click.qbs"
 Label4.ForeColor = RGB(0, 255, 0)
 Label4.Top = Label4.Top - 50
 Label4.FontSize = Label4.FontSize + 5
 End Sub
'unhighlights Labels 3 + 4  On Mouse Move
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 If Label4.Tag = "yes" Then
  Label4.ForeColor = RGB(0, 90, 0)
  Label4.Top = Label4.Top + 50
  Label4.FontSize = Label4.FontSize - 5
  Label4.Tag = "no"
 End If
 If Label3.Tag = "yes" Then
  Label3.ForeColor = RGB(0, 90, 0)
  Label3.Top = Label3.Top + 50
  Label3.FontSize = Label3.FontSize - 5
  Label3.Tag = "no"
 End If
 Label4.ForeColor = RGB(0, 90, 0)
 Label3.ForeColor = RGB(0, 90, 0)
End Sub
' Call This To Make Sure The Mouse doesn't leave The Form
Private Sub KeepMouseOnForm()
If ExitMouse = True Or ExitInputWindow = True Then GoTo nd:
If Get_Mouse_X >= Int((Me.Left + Me.Width) _
 / Screen.TwipsPerPixelX) - 5 Then _
 Set_Mouse_X ((Me.Left + Me.Width) / Screen.TwipsPerPixelX) - 5
If Get_Mouse_X <= Int((Me.Left) _
 / Screen.TwipsPerPixelX) Then _
 Set_Mouse_X ((Me.Left) / Screen.TwipsPerPixelX) + 5
If Get_Mouse_Y <= Int(Me.Top / Screen.TwipsPerPixelY) + 5 Then _
 Set_Mouse_Y (Me.Top / Screen.TwipsPerPixelY) + 5
If Get_Mouse_Y >= Int((Me.Top + Me.Height) / Screen.TwipsPerPixelY) - 5 Then _
 Set_Mouse_Y ((Me.Top + Me.Height) / Screen.TwipsPerPixelY) - 5
nd:
End Sub
