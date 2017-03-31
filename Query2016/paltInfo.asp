<!DOCTYPE html>
<!--#include file='spsFunctions.asp'-->
<html>
<head>
	<title>SPS Query PALT Ref</title>
	<link rel='stylesheet' type='text/css' href='style/query.css'/>


	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
	<script type="text/javascript" src="common/spsQuery.js"></script>
</head>
<body>
		<div class ="wrapper">
			<%=printBanner("Palt Information Reference", "")%>
					<fieldset id = 'fs1'>
						<%=printHeader()%>

					</fieldset>
		 </div><!--wrapper1-->
		<div class='wrapper'>
			<fieldset>
				<legend>Palt Code Information</legend>

		<%
			setConnection("1300375371")
			response.write(getPaltInfo())
		%>
</div>
				</fieldset>
</div><!--wrapper-->
		<%=printFooter()%>



</body>

</html>