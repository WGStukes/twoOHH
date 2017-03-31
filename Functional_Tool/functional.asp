<!DOCTYPE html>

	<!--#include file = 'spsFunctions.asp'-->
	<html>
		<head>
			<title>Functional Tool</title>
			<link rel='stylesheet' type='text/css' href='style/ft.css'>
			 <link type="text/css" rel="stylesheet" href="style/calendar.css"/>
			 <script type="text/javascript" src="common/calendar.js"></script>
			<script type="text/javascript" src="common/bft.js"></script>
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
Dim signer
'Dim desc
'Dim status

doc_no = UCASE(Request.Form("doc_no"))
Response.Write doc_no


IF doc_no <> "" THEN

	'these functions retrieve data
	setConnection(doc_no)
	getSigners()
'	getCreators()
	
	SET fc = getFuncData(doc_no)
	SET dc = getDocObject(doc_no)
	SET signer = getContactData(fc.org_id, fc.addr_id, fc.cntct_id)


'	SELECT CASE fc.doc_status
'		CASE 1
'			status = "Released"
'		CASE 0
'			status = "Unreleased"
'		SET ur = getUnreleased(doc_no)
'			SET sig = getSignature(ur.addr_id, ur.org_id, ur.cntct_id)
'		CASE NULL
'			status = dc.status
'		CASE ELSE
'			status = dc.status
'	END SELECT
'ELSE
'	status = "Released"

	''these functions set data

	'set description
	If des <>""THEN

'	setDescription(objId, usrId, desc, rsn)

	END IF

	'set creator
	If des <>""THEN

	'write code to run the set description procedure/function

	END IF

	'set signiture
	If des <>""THEN

	'write code to run the set description procedure/function

	END IF


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
			<fieldset>
					<br/>

		<legend> Date Reassignment Tool </legend>
						<span id = 'getDate'>
							<div class = 'txt'>
							<br/>
								Current Dates:<br/><br/><br/>
								New Dates:
							</div>

							<div class = 'apld'>
								Applied Date:<br/>

									<input type = 'text' size = '32' value = '<%=fc.apld_dt%>' readonly><br/><br/>
									<input id = 'apld_date' name = 'date' type = 'text' size = '32'>
							</div>
							<div class = 'effc'>
								 Effective Date: <br/>
									<input type = 'text' size = '32' value = '<%=fc.awd_rel_dt%>' readonly><br/><br/>
									<input id = 'eff_date' type = 'text' size = '32'>
							</div>

						<div class= 'submit'>
							<input type = 'button' onclick = "return verify('dtm', doc_no)" value = 'Update'>
						</div>
						</span><!--getDate-->
					</fieldset>
						<br/>

					<fieldset id = 'fs3'>

					<legend> Creator Reassignment Tool </legend>
						<span id = 'creator'>
							<div class = 'cntr'>
								<div class = 'crtrOld'>
							  		<div class= 'left'>Current Creator:</div>
									<input type= 'text' size = '40' value = '<%=dc.creator%>' readonly>
								</div>

								<div class= 'crtrNew'>
							  		<div class= 'left'>New Creator:</div>
											<select id = 'CRAP'>
											<option value='default' selected = "selected">Select an creator</option>

								<% FOR ii=0 TO UBOUND(creators)-1
														IF creators(ii) <> "" THEN

														%>
													<option value = "<%=ii%>"><%=trim(creators(ii))%> </option>
												<%
													END IF
												NEXT %>

								%>
											</select>
								</div>
							</div>

							<br/>
								<div class= 'submit'>
									<input type = 'button' onclick = "return verify('cre',doc_no)" value = 'Update'>
								</div>

						</span><!--creator-->
					</fieldset>
					<br/>

<fieldset id = 'fs5'>
							<legend> Signature Reassignment Tool </legend>
						<span id = "signature">
							<div class='cntr'>

								<div class = 'sgntrOld'>
							  		<div class= 'left'>Current Signature:</div>
									<input type= 'text' size = '40' value = '<%=signer.name%>' readonly>
								</div>

								<div class= 'sgntrNew'>
									<div class= 'left'>New Signature:</div>
											<select id = 'signer' name = 'signer'>
													<option value='default' selected = "selected">Select an Signer</option>
												<% FOR ii=0 TO UBOUND(signers)-1
														IF signers(ii) <> "" THEN

														%>
													<option><%=signers(ii)%> </option>
												<%
													END IF
												NEXT %>
											</select>
								<!--	<input type = 'text' onkeyup="showHint(this.value)" size = '40'>
									Suggestions: <span id="txtHint"></span> -->
								</div>
							</div>
								<br/>

								<div class= 'submit'>
									<input type = 'button' onclick = "return verify('sig',doc_no)" value = 'Update'>

								</div>
						</span><!--signature-->

					</fieldset>
						<br/>

<fieldset id = 'fs6'>
						<legend> PALT Code Reassignment </legend>
							<%
								Dim paltObjId
								Dim paltWkl
								Dim paltCd

									paltObjId = getObjId(doc_no)
								SET paltWkl = getWkldData(paltObjId)
								 	paltCd = paltWkl.paltCode
									getPaltList()
							%>
						<div class = 'cntr'>
							<div class = 'paltOld'>
								<div class = 'left'> Current PALT Value </div>
									<input type = 'text' size = '40' value = '<%=paltCd%>' readonly>
							</div><!--paltOld-->


							<div class= 'paltNew'>
									<div class= 'left'>New PALT Value:</div>
											<select id = 'palt' name = 'palt'>
													<option value='default' selected = "selected">Select an PALT Code</option>
												<% FOR ii=0 TO UBOUND(paltCodes)-1
														IF paltCodes(ii) <> "" THEN

														%>
													<option><%=paltCodes(ii)%> </option>
												<%
													END IF
												NEXT %>
											</select>
							</div><!--paltNew-->

						</div><!--cntr-->
							<br/>
								<div class= 'submit'>
									<input type = 'button' onclick = "return verify('pal',doc_no)" value = 'Update'>
								</div>


					</fieldset>
					<br/>

<fieldset>
						<legend> Requestor Code Reassignment </legend>
							<div class= 'cntr'>
								<div class = 'reqOld'>
									<div class = 'left'> Current Requestor Code </div>
										<input type = 'text' size = '40' value = '<%=reqCd%>' readonly>
								</div><!--reqOld-->

								<div class= 'reqNew'>
										<div class= 'left'>New Requestor Code Value:</div>
											<input type='text' size = '40'>
								</div><!--reqNew-->
										<br/>
								<div class= 'submit'>
									<input type = 'button' onclick = "return verify('req', doc_no) " value = 'Update'>
								</div><!--submit-->
							</div><!--cntr-->

					</fieldset>






		

			</div><!--wrapper-->




		</body>
	</html>				