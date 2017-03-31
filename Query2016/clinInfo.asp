<!DOCTYPE html>
<!--#include file='spsFunctions.asp'-->
<html>
	<head>
		<title>
			Clin Information
		</title>
		<link rel='stylesheet' type='text/css' href='style/query.css'/>
		<link rel='stylesheet' type='text/css' href='style/pf.css'/>
		<script type="text/javascript" src="common/spsQuery.js"></script>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" >

		<% 'parse the clin number from the passed data'
			passed = Request.QueryString("doc_no")
			clin_no = mid(passed,instr(passed,"/")+1)
			doc_no = left(passed,instr(passed,"/")-1)
			setConnection(doc_no)
		%>
	</head>
	<body>
	<div class='wrapper'>
			<%=printBanner("Clin Detail", doc_no)%>
		<fieldset>
			<legend>Data Retrieval</legend>
				<%=printHeader()%>
			</fieldset>
	</div><!--wrapper-->
	<div class='wrapper'>
		<fieldset>
		<div class='contain'>
		<a class='return' href='LineItem.asp?doc_no=<%=doc_no%>'target= '_self'> Return to <%=doc_no%> Line Items</a>
			<%response.write(lineItemData(doc_no, clin_no))%>
		</div>

		</fieldset>
	</div><!--wrapper-->
		<%=printFooter()%>
	</body>

</html>