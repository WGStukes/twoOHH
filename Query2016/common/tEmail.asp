<html xmlns="http://www.w3.org/1999/xhtml">
	<head>

	</head>
	<body>
<%
		Dim	eMail
		Dim	fmAddr
		Dim	toAddr
		Dim	arg_name
		Dim	arg_subj
		Dim	body
		Dim	encl
		Dim	arg_phone
		Dim	arg_msg
		Dim	arg_refer

		toAddr    = Request.Form("arg_to")
		fmAddr    = Request.Form("arg_email")
		arg_name  = Request.Form("arg_name")
		arg_subj  = Request.Form("arg_subject")
		arg_phone = Request.Form("arg_phone")
		arg_msg   = Request.Form("arg_msg")
		arg_refer = Request.Form("arg_referring")

		if (fmAddr = "") then
			fmAddr = "Anonymous@wdcontracts.navair.navy.mil"
		end if
		if (arg_name = "") then
			arg_name = "Anonymous"
		end if
		if (arg_phone = "") then
			arg_phone = "Not given."
		end if
		if (arg_msg = "") then
			arg_msg = "Not given."
		end if

		body    = ""
		body    = body & "Name:     " & arg_name  & vbCrLf
		body    = body & "Email:    " & fmAddr    & vbCrLf
		body    = body & "Phone:    " & arg_phone & vbCrLf
		body    = body & "Prgm:     " & arg_refer & vbCrLf
		body    = body & "Comments: " & vbCrLf & arg_msg & vbCrLf
		encl    = ""
		'encl    = Request.Form("arg_encl")

		'SET eMail = CreateObject("CDONTS.NewMail")
		'eMail.Send fmAddr, toAddr, arg_subj, body, 0
		'SET	eMail = Nothing

		SET eMail = CreateObject("CDO.Message")
		eMail.MimeFormatted = false
		eMail.From          = fmAddr
		eMail.To            = toAddr
		eMAil.Subject       = arg_subj
		eMail.TextBody      = body

		eMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing"     ) = 2
		eMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver"    ) = "SDNI-CLIN127Relay.nadsuswe.nads.navy.mil"
		eMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
		eMail.Configuration.Fields.Update

		eMail.Send

		SET eMail = Nothing
		Dim tktDt
			tktDt = "Your ticket was submitted on " & date & " at " & time & vbCrLf
		Dim thnk
			thnk = "Thank you for contacting the BSO Help Desk " & vbCrLf
		Dim subj
			subj = "Ticket Subject: " & arg_subj & vbCrLf
		Dim comm
			comm = "Ticket Comments: " & vbCrLf & arg_msg & vbCrLf
		Dim help
			help = "Should you need more assistance Please contact the BSO Help Desk " & vbCrLf
		Dim helpPhn
			helpPhn = "Help Desk Phone: (760)939-3292" & vbCrLf
		Dim helpEml
			helpEml = "Help Desk Email: M_CHLK_NW-2.0-HELPDESK_UD@navy.mil" & vbCrLf
		mesg = ""
		mesg = mesg & thnk & vbCrLf
		mesg = mesg & tktDt & vbCrLf
		mesg = mesg & subj & vbCrLf
		mesg = mesg & comm & vbCrLf
		mesg = mesg & help & vbCrLf
		mesg = mesg & helpPhn & vbCrLf
		mesg = mesg & helpEml & vbCrLf


		SET uMail = CreateObject("CDO.Message")
		uMail.MimeFormatted = false
		uMail.From          = toAddr
		uMail.To			= fmAddr
		uMail.Subject 		= "Help Desk Ticket Submission " & date & " @ " & time
		uMail.TextBody 		= mesg

		uMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing"     ) = 2
		uMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver"    ) = "SDNI-CLIN127Relay.nadsuswe.nads.navy.mil"
		uMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
		uMail.Configuration.Fields.Update

		uMail.Send

		Set uMail = Nothing

%>
	<form name='docno' title='Document Number' method='POST' action='error.asp'>
		<input type='hidden' id='document_no' name='doc_no'  size='30' value='<%=doc_no%>'><br>
	</form>
	<script type='text/javascript'>
	<!--
		formObj = document.docno;
		formObj.submit();
	// -->
	</script>
<%
	</body>
</html>

