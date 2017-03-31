<!DOCTYPE html>
<!--#include file='spsFunctions.asp'-->
<html>
<head>
	<title>SPS Query W/C Search</title>
	<link rel='stylesheet' type='text/css' href='style/query.css'/>



	<%
Dim str
	On Error Resume Next
	doc_no = Request.Form("doc_no")
	Dim connFlag



	%>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
	<script type="text/javascript" src="common/spsQuery.js"></script>
</head>
<body>
	<div class ="wrapper">

			<div class='banner'></div><!--banner-->
					<div class='navy'>
						<a href = '#'>Contracts Home</a>
						<p><i>
							<%
							Select Case site_id
								Case "CHLK"
									response.write("<i>China Lake Database Connected</i>")
								Case "PAX"
									response.write("<i>PAX Database Connected</i>")
								Case "ORL"
									response.write("<i>Orlando Database Connected</i>")
								Case Else
									response.write("<i>CHLK Database Connected</i>")
							End Select
							%>
						</i></p>
					</div><!--navy-->
					<div class='title'>
						<h2>
							SPS Query Panel
						</h2>
							<h3>
								<%=doc_no%>
							</h3>
					</div><!--title-->
					<fieldset id = 'fs1'>
						<legend> Document Retrieval </legend>
							<br/><br/>

<!-- ==============================Form and Field========================================================= -->
<div align='center'class='formField'>

	<form name='docno' title='Document Number' method='post'  onkeyup='return ckChar()' onsubmit='return validate()'>
	<label for='document_no'>New Query:&nbsp;&nbsp;</label>
	<input id='document_no' maxlength='24' name='doc_no' size='30' value=''/>&nbsp;&nbsp;
	<input type='submit' onclick='return ckChar()' value='Search'/><br/>
	<span id='exTxt'><small> </small></span>

			<hr align='center' width='75%'>

					</br>
							<input name='CHLK' value= '' checked id = "CHLK" type="checkbox" onclick=" return addRemove(this,'pane1')">
							China Lake Database
							<input name='PAX' value= '' checked id = "PAX" type="checkbox" onclick=" return addRemove(this,'pane2')">
							PAX River Database
							<input name='ORL' value= '' checked id = "ORL" type="checkbox" onclick=" return addRemove(this,'pane3')">
							Orlando Database

				</form>

</div><!--formField-->
</fieldset>
</div><!--wrapper-->
<div class='wrapper'>
	<fieldset>
		<legend>China Lake Database</legend>
<%
SET chlk = setSite(connString1, doc_no)
IF chlk.site_id <> -1 THEN
	connString = chlk.connection
	%>
		<span id='pane1'>
			<%=getTable(chlk.connection,doc_no)%>
		</span>
	<%
	connString = NOTHING
END IF
%>
	</fieldset>
</div><!--wrapper-->
<div class='wrapper'>
	<fieldset>
		<legend>PAX Database</legend>
<%
SET pax = setSite(connString2, doc_no)
IF pax.site_id <> -1 THEN
	connString = pax.connection
	%>
		<span id= 'pane2'>
			<%=getTable(pax.connection, doc_no)%>
		</span>
	<%
	connString = NOTHING
END IF
objConn.Close
	%>
	</fieldset>
</div><!--wrapper-->
<div class='wrapper'>
	<fieldset>
		<legend>Orlando Database</legend>
<%
SET orl = setSite(connString3, doc_no)
IF orl.site_id <> -1 THEN
	connString = orl.connection

	%>
		<span id = 'pane3'>
			<%=getTable(orl.connection, doc_no)%>
		</span>
	<%
	connString = NOTHING
END IF
%>
	</fieldset>
</div><!--wrapper-->

<%=printFooter()%>


</body>

</html>