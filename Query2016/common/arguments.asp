<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Report Arguments &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
		<link rel=STYLESHEET type="text/css" href="arguments.css" >
		<script type="text/javascript" src="common_head.js">
		</script>
		<script type="text/javascript">
			<!--
				var	ii;
				var	args = window.dialogArguments;
				var	arguments = window.dialogArguments.split(",");

				function	ReturnArguments ()
				{
					var	ii;

					window.returnValue = "";
					for (ii=0; ii<document.Arguments.elements.length-1; ii++)
					{
						if (window.returnValue != "")
							window.returnValue = window.returnValue + ",";
						window.returnValue = window.returnValue + document.Arguments.elements[ii].name + ",";
						window.returnValue = window.returnValue + document.Arguments.elements[ii].value;
					}
					window.close();
				}

			//-->
		</script>
	</head>
	<body>
		<div class="container">
			<form name="Arguments" method="POST" action="" onSubmit="return false;">
				<table class="arguments">
					<tr>
						<td colspan=2 align=center nowrap>
You are accessing a U.S. Government (USG) information system (IS) that is<br>
provided for USG-authorized use only.<br><br>
By using this IS (which includes any device attached to this IS),  you consent<br>
to the following conditions:<br><br>
1) The USG routinely intercepts and monitors communications on this IS for<br>
purposes including, but not limited to, penetration testing, COMSEC monitoring,<br>
network operations and defense, personnel  misconduct (PM), law enforcement<br>
(LE), and counterintelligence (CI) investigations.<br><br>
2) At any time the USG may inspect and/or seize data stored on this IS and any<br>
device attached to this IS.<br><br>
3) Communications occurring on or data stored on this IS, or any device attached<br>
to this IS, are not private. They are subject to routine monitoring and search.<br><br>
4) Any communications occurring on or data stored on this IS, or any device<br>
attached to this IS, may be disclosed or used for any USG-authorized purpose.<br><br>
5) Security protections may be utilized on this IS to protect certain interests<br>
that are important to the USG. For example, passwords, access cards, encryption<br>
or biometric access controls provide security for the benefit of the USG. These<br>
protections are not provided for your benefit or privacy and may be modified or<br>
eliminated at the USG's discretion.
</td>
					</tr>
					<tr>
						<td colspan=2 align=center nowrap>Then click on the return key</td>
					</tr>
					<tr>
						<th colspan=2 align=center><input type="button" name="returnButton" value="Accept Terms"></th>
					</tr>
				</table>
			</form>
		</div>
		<script type="text/javascript" src="common_body.js">
		</script>
		<script type="text/javascript">
			<!--
				document.Arguments.elements["returnButton"].onclick = ReturnArguments;
				document.Arguments.elements[0].select();
			//-->
		</script>
	</body>
</html>

