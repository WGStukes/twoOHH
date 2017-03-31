<!DOCTYPE html>
<!--#include file = 'spsFunctionsb.asp'-->
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>BSO Function Tools</title>
		<link rel='stylesheet' type='text/css' href='style/ft.css'>
		 <link type="text/css" rel="stylesheet" href="style/calendar.css"/>
		 <script type="text/javascript" src="common/calendar.js"></script>
		<script type="text/javascript" src="common/bft.js"></script>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
	</head>


<%
Dim doc_no
'Dim fc
Dim dc
'Dim signer
'Dim desc
'Dim status

doc_no = UCASE(Request.Form("doc_no"))
Response.Write doc_no

IF doc_no <> "" THEN
	setConnection(doc_no)
'	getSigners()
'	getCreators()
	
'	SET fc = getFuncData(doc_no)
	SET dc = getDocObject(doc_no)
'	SET signer = getContactData(fc.org_id, fc.addr_id, fc.cntct_id)

'	SELECT CASE fc.doc_status
'		CASE 1
'			status = "Released"
'		CASE 0
'			status = "Unreleased"
'			SET ur = getUnreleased(doc_no)
'			SET sig = getSignature(ur.addr_id, ur.org_id, ur.cntct_id)
'		CASE NULL
'			status = dc.status
'		CASE ELSE
'			status = dc.status
'	END SELECT
'ELSE
'	status = "Released"

response.write dc.docNum
response.write dc.fullname
response.write dc.description
response.write dc.owner
response.write dc.objType
response.write dc.sol_dt
response.write dc.uid
END IF



%>
	


	<body>



	doc_no = UCASE(Request.Form("doc_no"))
Response.Write doc_no



<%=mess%>
	</br>

	<%=obj_id%>
	</br>
	<%=cats.icon_id%>
	</br>
	<%=frogs%>
         
	<legend> Description Tool</legend>
					<span id = 'description'>
							<div class='descriptionOld'>
							   Current Description:<br/>
									<div class='txtArea'><%=dc.description%></div><!--txtArea-->
							</div>

							<div class='descriptionNew'>
								New Description:<br/>
								<textarea id='NewDesc' onpropertychange = 'return setDescription(this.value)'  rows='3' cols='35'> </textarea>
							
							<div class= 'submit'>
								<input type = 'button' onclick = "return verify('des', doc_no)" value = 'Update'>
							</div>
					</span><!--description-->
					</fieldset>
						<br/>

					<fieldset id = 'fs4'>
				


	</body>

<%
END IF
%>

</html>


