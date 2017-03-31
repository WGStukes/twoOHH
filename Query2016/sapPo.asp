<!DOCTYPE html>
<!--#include file='spsFunctions.asp'-->
<html>
<head>
	<title>SPS Query W/C Search</title>
	<link rel='stylesheet' type='text/css' href='style/lineItem.css'/>
	<link rel='stylesheet' type='text/css' href='style/lineItem2.css'/>
	<script type="text/javascript" src="common/spsQuery.js"></script>
	<%
	doc_no = UCASE(Request.Form("doc_no"))
	IF doc_no = "" THEN
	   doc_no = UCASE(request.QueryString("doc_no"))
	END IF



setConnection(doc_no)
	%>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
</head>
<body>
<div class='wrapper'>
		<div class='menubar'>
		<ul id="navbar">
			<li><a href = 'https://wdcontracts.navair.navy.mil/contracts/internal/default.asp'>Contracts Home</a></li>
			<li><a href = 'https://wdcontracts.navair.navy.mil/contracts/tools/Query/Query.asp'>Query</a></li>
			<li><a href = 'https://wdcontracts.navair.navy.mil/contracts/tools/PR_Search/PR_Search.asp'>PR Search</a></li>
		</ul>
				<div align='right'>
							<div class='captchr'><%
																Select Case site_id
																	Case "CHLK"
																		response.write("<i>China Lake Database Connected</i>")
																	Case "PAX"
																		response.write("<i>PAX Database Connected</i>")
																	Case "ORL"
																		response.write("<i>Orlando Database Connected</i>")
																	Case Else
																		response.write("<i>CHLK Test Database Connected</i>")
								End Select %>
								</div><!--captchr-->
				</div><!--alignRight-->
		</div><!--menubar-->


		<div class='header'>

		<div class='textl'> <i>Query</i></div><!--textl-->
		<div class='captchl'> SAP PO Search </br> <% response.write(" " & doc_no) %></div><!--captchl-->


<%=formField()%>


	</div><!--header-->
</br></br></br>
<%

getSapTable()


%>

<div class='footer'>
</div><!--footer-->
</div><!--wrapper-->


</body>

</html>