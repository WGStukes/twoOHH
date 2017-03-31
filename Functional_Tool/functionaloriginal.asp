<!DOCTYPE html>

	<!--#include file = 'spsFunctionsb.asp'-->
	<html>
		<head>
			<title>FILETEST</title>
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
Dim desc
Dim status

	doc_no = UCASE(Request.Form("doc_no"))
Response.Write doc_no

IF doc_no <> "" THEN
	setConnection(doc_no)
	getSigners()
	getCreators()
		SET fc = getFuncData(doc_no)
		SET dc = getDocObject(doc_no)
		SET signer = getContactData(fc.org_id, fc.addr_id, fc.cntct_id)

		SELECT CASE fc.doc_status
				CASE 1
					status = "Released"
				CASE 0
					status = "Unreleased"
					SET ur = getUnreleased(doc_no)
					SET sig = getSignature(ur.addr_id, ur.org_id, ur.cntct_id)

				CASE NULL
					status = dc.status
				CASE ELSE
					status = dc.status
		END SELECT
	ELSE
		status = "Released"

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
					</div>

					<div class='title'>
						<h2>
							BSO Functional Tools
						</h2>
					</div>

					<fieldset id = 'fs1'>
						<legend> Document Retrieval </legend>
							<%=formField()%>
							 <p color='black' style="text-align:center;">For Example: "N68936-08-P-0001","N68936-02-D-0010-000902",(NO WILD CARDS i.e. "%").</p>
					</fieldset>
						<br/>
				<% IF status = "Released" THEN %>
				<fieldset id = 'fs2'>


						<legend> Unrelease</legend>
					<span id = 'unrelease'>
						<div class = 'chgRsn'>
								<form id = 'chgSelect'>
								Select the reason for the changes:<br/>

									<div align='center'>
										<input type="radio" name="chgRsn" value="IDIQ" onclick = "return showField(this,'eda1')">IDIQ
										<input type="radio" name="chgRsn" value="ACR"  onclick = "return showField(this,'eda1')">Clause Fix
										<input type="radio" name="chgRsn" value="OTR" onclick = "return showField(this,'eda1')">Other
									</div>
								<hr width = '75%'>
								</form>
							</div><!--chgRsn-->

							<div class='chgTxt'>
								<form id = 'chgText'>
								Enter the Change Reason Details:<br/>
									<textarea onpropertychange = 'return setValue(this.value)' align='right' rows='4' cols='35'></textarea>
								</form>
							</div>

							<div class='unrel'>

								<div class='unrelBtn'>
								Current Document Status: <%=dc.status%>
										<input type = 'text' size = '30'  value = '<%=doc_no%>' readonly>
										<input type = 'button'  onclick = "return verify('unr',doc_no)" value = 'unrelease'>
								</div>

							<span id = 'eda1' style='display: none;'>
								<div class='eda' id = 'eda'>
									Edit the EDA Flag:<br/>
										<select name = 'EDA FLAG'>
											<option value='default' selected = "selected">Select an option</option>
											<option value='send'> Send to EDA </option>
											<option value='noSend'> Do not send EDA  </option>
										</select>
								</div><!--eda-->
							</span>
							</div><!--unrel-->
						</span><!--unrelease-->
					</fieldset>
						<br/>
				<% ELSE %>
					<fieldset id = 'fs2a1'>
						<legend>Rerelease Tool</legend>
						<span id = 'rerelease'>
							<div class = 'orig'>
								<table>
									<tr><th colspan="2"><div class='tHeader'>Rerelease Data</div> 	</th></tr>
									<tr><th>Applied Date:	</th>	<td><%=ur.apld_dt%>				</td></tr>
									<tr><th>Release Date:	</th>	<td><%=ur.awd_rel_dt%>			</td></tr>
									<tr><th>Signature:		</th>	<td><%=sig.name%>				</td></tr>
									<tr><th>Title: 			</th>	<td><%=sig.title%>				</td></tr>
									<tr><th>Organization:	</th>	<td><%=sig.orgCd%>				</td></tr>
								</table>
							</div>

							<div class = 'release'>
									Current Document Status: <%=status%>
										<input type = 'text' size = '30'  value = '<%=doc_no%>' readonly>
										<input type = 'button' onclick = "return verify('rel',doc_no)" value = 'Rerelease'>
							</div>
					</span><!--'rerelease'-->
					</fieldset>
						<br/>
				<%END IF%>

				<fieldset id = 'fs2a'>
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
							<legend> Description Tool</legend>
					<span id = 'description'>
							<div class='descriptionOld'>
							   Current Description:<br/>
									<div class='txtArea'><%=dc.description%></div><!--txtArea-->
							</div>

							<div class='descriptionNew'>
								New Description:<br/>
								<textarea id='NewDesc' onpropertychange = 'return setDescription(this.value)'  rows='3' cols='35'> </textarea>
							</div>

							<div class= 'submit'>
								<input type = 'button' onclick = "return verify('des', doc_no)" value = 'Update'>
							</div>
					</span><!--description-->
					</fieldset>
						<br/>

					<fieldset id = 'fs4'>

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
						<div class='close'>
							<input type = 'reset'  value = 'Reset'>
							<input type = 'button' onclick = 'window.close()' value = 'Exit'>
						</div>
			</body>
	</html>