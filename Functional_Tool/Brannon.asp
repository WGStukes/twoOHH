<!DOCTYPE html>

	
	<!--#include file = 'spsFunctionsb.asp'-->
	<html>
		<head>
			<title>Functional Tool</title>
			<link rel='stylesheet' type='text/css' href='style/ft.css'>
			 <link type="text/css" rel="stylesheet" href="style/calendar.css"/>
			 <script type="text/javascript" src="common/calendar.js"></script>
			<script type="text/javascript" src="common/bftb.js"></script>
			<script>
				function init() {
					calendar.set("apld_date");
					calendar.set("eff_date");
 				}
				
				function getData(){
					var dStr = '<%=doc_no%>'
					var xmlhttp = new XMLHttpRequest();
					xmlhttp.onreadystatechange = function() {
						if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
							var newAr = new Array();
							newAr = xmlhttp.responseText.split(",")
							
							document.getElementById("test1").innerHTML = newAr[0];
						        document.getElementById("test2").innerHTML = newAr[1];
						        document.getElementById("test3").innerHTML = newAr[2];
						}
					}
					xmlhttp.open("GET", "DisCurrData.asp?q="+dStr, true);
					xmlhttp.send();
				}

				function showHint(str) {
					if (str.length == 0) {
						document.getElementById("txtHint").innerHTML = "";
						return;
					} else {
						var xmlhttp = new XMLHttpRequest();
						xmlhttp.onreadystatechange = function() {
							if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
								document.getElementById("txtHint").innerHTML = xmlhttp.responseText;
							}
						}
						xmlhttp.open("GET", "common/gethint.asp?q=" + str, true);
						xmlhttp.send();
					}
				}
			</script>
		</head>

		<body onload = "init()">

<%
Dim doc_no
Dim fc
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

<script> var doc_no = '<%=doc_no%>'</script>

			<div class='wrapper'>

				<div class='banner'></div><!--banner-->
				<div class='navy'>
<%
SELECT CASE site_id
	CASE "CHLK"
		response.write("<i>China Lake Database Connected</i>")
	CASE "PAX"
		response.write("<i>PAX Database Connected</i>")
	CASE "ORL"
		response.write("<i>Orlando Database Connected</i>")
	CASE ELSE
		response.write("<i>WD Contracts 2.0</i>")
	END SELECT
%>

				</div><!--navy-->

				<div class='title'><h2>BSO Functional Tools</h2></div>

				<fieldset id = 'fs1'><legend>Document Retrieval</legend>
<%=formField()%>
					 <p color='black' style="text-align:center;">For Example: "N68936-08-P-0001","N68936-02-D-0010-000902",(NO WILD CARDS i.e. "%").</p>
				</fieldset><br/>

				<fieldset id = 'fs3'><legend> Description Tool</legend>
					<span id = 'description'>
						<div class='descriptionOld'>Current Description:<br/>
							<div class='txtArea'><%=dc.description%></div>
						</div>

						<div class='descriptionNew'>New Description:<br/>
							<textarea id='NewDesc' onpropertychange = 'return setDescription(this.value)'  rows='3' cols='35'> </textarea>
						</div>

						<div class= 'submit'>
							<input type = 'button' onclick = "return verify('des', doc_no)" value = 'Update'>
						</div>
					</span><!--description-->
				</fieldset>



			</div><!--wrapper-->




		</body>
	</html>				