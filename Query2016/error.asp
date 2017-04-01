<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file='spsFunctions.asp'-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>
	Error Page!
</title>
<%doc_no  = UCase(Request.Form("doc_no"))%>
<link rel = "stylesheet" type = "text/css" href = "style/Query.css"/>
<script type="text/javascript" src="common/spsQuery.js"></script>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
</head>
<body>
<div class = "wrapper">
	<%=printBanner("Error Page", doc_no)%>
<div align='center' color = 'red'>
--<b>Unable to Locate Document</b>--</br> Please check the document number and try again.</br> If you have further issues contact the BSO HelpDesk at (760)939-3292 for assistance.
</div>
<fieldset>
	<legend>Document Location </legend>
<%=printHeader()%>
</fieldset>
</div><!--wrapper-->
</body>
</html>
