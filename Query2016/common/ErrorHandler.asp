<%
Dim strErrorMessage
Dim bolErrors

'Initialize variables
strErrorMessage = ""	'The error messages for tech. support
bolErrors = False	'Have we found any errors yet?

'Now our two subs
sub TrapError(strError)
  bolErrors = True	'Egad, we've found an error!

  strErrorMessage = strErrorMessage & strError & ", "
end sub



'If there are any errors, this function will email tech. support
sub ProcessErrors()
  if bolErrors then
    'Send the email
    Dim objCDO
    Set objCDO = Server.CreateObject("CDONTS.NewMail")

    objCDO.To = "jeremy.r.mcclellan.ctr@navy.mil"
    objCDO.From = "jeremy.r.mcclellan.ctr@navy.mil"
    objCDO.Subject = "AN ADO ERROR OCCURRED"
    objCDO.Body = "At " & Now & " the following errors occurred on " & _
		  "the page " & Request.ServerVariables("SCRIPT_NAME") & _
		  ": " & _
                  chr(10) & chr(10) & strErrorMessage

    objCDO.Send

    Set objCDO = Nothing

    'Now, we've got to print out something for the user
    Response.Write "There has been a database error.  Technical Support " & _
                   "has already been notified.  You will be informed when " & _
                   "this issue is resolved.  Thank you for your patience!"
  end if
end sub  
