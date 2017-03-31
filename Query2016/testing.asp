<!-- This page recieves the document number information from DispList.asp and DispPr.asp then uses the document number
        in the queries to populate the tables. -->

<!-- #include file="common/global.asp"-->


<head>
	<title> Pr From Display List </title>
</head>
<body>
<%
doc_no = request.querystring("doc_no")
response.write("Retrieving Document Information for: " & doc_no)
%>

	<form name='docno' title='Document Number' method='POST' action='panelFunctions.asp'>
		<input type='hidden' id='doc_no' name='doc_no'  size='30' value= '<%=doc_no%>'<br>
	</form>
	<script type='text/javascript'>
	<!--
		formObj = document.docno;
		formObj.submit();
	// -->
	</script>
</html>
