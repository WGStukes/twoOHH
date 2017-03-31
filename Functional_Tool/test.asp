<!DOCTYPE html>
	<!--#include file = 'common/spsFunctionsb.asp'-->
	<html>
		<head>

			<link type="text/css" rel="stylesheet" href="style/calendar.css"/>
		 	<link type="text/css" rel="stylesheet" href="style/test.css"/>
			<script type="text/javascript" src="common/calendar.js"></script>
			<script type="text/javascript" src="common/bft.js"></script>
		 	<script type="text/javascript" src="common/test.js"></script>

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
		<div class='wrapper2'>
<%
'					Dim doc_no
'					Dim fc
'					Dim dc
'					Dim signer
'					Dim desc
'					Dim status
'
'						doc_no = UCASE(Request.Form("doc_no"))
'
'					IF doc_no <> "" THEN
'						setConnection(doc_no)
'						getSigners()
'						getCreators()
'							SET fc = getFuncData(doc_no)
'							SET dc = getDocObject(doc_no)
'							SET signer = getContactData(fc.org_id, fc.addr_id, fc.cntct_id)
'
'							SELECT CASE fc.doc_status
'									CASE 1
'										status = "Released"
'									CASE 0
'										status = "Unreleased"
'										SET ur = getUnreleased(doc_no)
'										SET sig = getSignature(ur.addr_id, ur.org_id, ur.cntct_id)
'
'									CASE NULL
'										status = dc.status
'									CASE ELSE
'										status = dc.status
'							END SELECT
'						ELSE
'							status = "Released"
'
'					END IF
'
'
%>
			<script> var doc_no = '<%=doc_no%>'</script>
			<div class = 'banner'>
				<div class = 'cLogo'>
				</div>
				<div class='navy'></div>
			</div>
<!----------------------------------------- SideBar Menu---------------------------------------------------------------->
			<div class='tabs'>
			<ul>
				<li><a href="#"  onfocus = "activate('hme')">2.0 Contracts Home</a></li>
				<hr>
					&nbsp;Available Tools:
				<li><a href="#"  onfocus = "activate('unr')">Unrelease/Rerelease Tool</a></li>
				<li><a href="#"  onfocus = "activate('sig')">Signature Reassignment</a></li>
				<li><a href="#"  onfocus = "activate('wkl')">Workload Reassignment</a></li>
				<li><a href="#"  onfocus = "activate('dte')">Date Reassignment</a><li>
				<li><a href="#"  onfocus = "activate('cre')">Creator Reassignment</a></li>
				<li><a href="#"  onfocus = "activate('des')">Description Tool</a></li>
				<li><a href="#"  onfocus = "activate('pal')">PALT Code Tool</a></li>
				<li><a href="#"  onfocus = "activate('req')">Requestor Code Tool</a></li>
			</ul>
			</div>

<!-----------------------------------------Document Number Entry-------------------------------------------------------->
		<div class='formField'>
			<div class='pageTitle'>BSO Functional Tools</div>
				</br>
			<fieldset>
				<legend> Enter a Document Number </legend>
				<form name='docno' title='Document Number' method='post'  onkeyup='return ckChar()' onsubmit='return validate()'>
					<label for='document_no'>Document Number:&nbsp;&nbsp;</label>
					<input id='document_no' maxlength='24' name='doc_no' size='30' value=''/>&nbsp;&nbsp;
					<input type='submit' onclick='return ckChar()' value='Search'/><br/>
					<span id='exTxt'>
						<small>

							Document Types Accepted:</br> Purchase Requests, Purchase Request Modifications, Solicitations, Solicitation Amendments,</br> Awards, Award Modfication, Delivery Order, Delivery Order Modifcations
						</small>
					</span>
				</form>
			</fieldset>
			</br>
		</div>

<!-------------------------------------------Unrelease/Rerelease Tools-------------------------------------------------->
		<span id = 'unr'>
			<div class="tools">
				<% IF status = "Released" THEN %>

				<fieldset id = 'fs2'>


						<legend> Unrelease Tool</legend>
					<span id = 'unrelease'>
						Document Number: <%=doc_no%> <br/>
						Current Document Status: <%=dc.status%>


							<hr>
							<div class = 'chgRsn'>
								<form id = 'chgSelect'>
								Select the reason for the changes:<br/>


										<input type="radio" name="chgRsn" value="IDIQ" 	onclick = "return showField(this,'eda1')">IDIQ
										<input type="radio" name="chgRsn" value="ACR"  	onclick = "return showField(this,'eda1')">Clause Fix
										<input type="radio" name="chgRsn" value="OTR" 	onclick = "return showField(this,'eda1')">Other

								</form>

							</div><!--chgRsn-->
							<hr>
								<form id = 'chgText'>
								Enter the Change Reason Details:<br/>
									<textarea onpropertychange = 'return setValue(this.value)' align='right' rows='4' cols='35'></textarea>
								</form>

								<input id='unrBtn' type = 'button'  onclick = "return verify('unr',doc_no)" value = 'unrelease'>


							<span id = 'eda1' style='display: none;'>

									Edit the EDA Flag:<br/>
										<select name = 'EDA FLAG'>
											<option value='default' selected = "selected">Select an option</option>
											<option value='send'> Send to EDA </option>
											<option value='noSend'> Do not send EDA  </option>
										</select>

							</span>
						</span><!--unrelease-->
					</fieldset>
						<br/>
				<% ELSE %>
					<fieldset id = 'fs2a1'>
						<legend>Rerelease Tool</legend>
						<span id = 'rerelease'>
								<table>
									<tr><th colspan="2"><div class='tHeader'>Rerelease Data</div> 	</th></tr>
									<tr><th>Applied Date:	</th>	<td><%=ur.apld_dt%>				</td></tr>
									<tr><th>Release Date:	</th>	<td><%=ur.awd_rel_dt%>			</td></tr>
									<tr><th>Signature:		</th>	<td><%=sig.name%>				</td></tr>
									<tr><th>Title: 			</th>	<td><%=sig.title%>				</td></tr>
									<tr><th>Organization:	</th>	<td><%=sig.orgCd%>				</td></tr>
								</table>
									Current Document Status: <%=status%>
										<input type = 'text' size = '30'  value = '<%=doc_no%>' readonly>
										<input type = 'button' onclick = "return verify('rel',doc_no)" value = 'Rerelease'>
					</span><!--'rerelease'-->
					</fieldset>
						<br/>
				<%END IF%>

			</div><!--tools1-->
		</span><!--unr-->
<!---------------------------------------------Workload Reassignment Tool--------------------------------------------------------->
		<span id ='wkl'>
			<div class= 'tools'>
				<fieldset id = 'wklAsn'>
					<legend>Workload Reassignment Tool</legend>
					<div class='crWkld'>
						<div class= 'left'>Current Assignment:</div>
						<input type= 'text' size = '40' value = 'replace code w/ asp' readonly>
					</div>
					<div class='newWkld'>
						<div class= 'wklNew'>
							<div class= 'left'>New Assignment:</div>
								<select id = 'CRAP'>
									<option value='default' selected = "selected">Select an creator</option>

								<%
									FOR ii=0 TO UBOUND(creators)-1
										IF creators(ii) <> "" THEN

								%>
									<option value = "<%=ii%>"><%=trim(creators(ii))%> </option>
											<%
													END IF
												NEXT
								%>
											</select>
								</div>
					</div>
				</fieldset>
			</div>
		</span>
<!--------------------------------------------Date Reassignment Tool----------------------------------------------------------------->
		<span id ='dte'>
			<div class= 'tools'>
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
			</div><!--tools3-->
		</span>

<!-----------------------------------------Description Tool------------------------------------------------------------------------->
		<span id = 'des'>
			<div class= 'tools'>
					<fieldset id = 'fs3'>
							<legend> Description Tool</legend>
					<span id = 'description'>
							<div class='descriptionOld'>
							   Current Description:<br/>
									<div class='txtArea'><%=dc.description%></div>
							</div>

							<div class='descriptionNew'>
								New Description:<br/>
								<textarea id='NewDesc' onpropertychange = 'return setDescription(this.value)'  rows='3' cols='35'> </textarea>
							</div>

							<div class= 'submit'>
								<input type = 'button' onclick = "return verify('des', doc_no)" value = 'Update'>
							</div>
					</span>
					</fieldset>
						<br/>
			</div>
		</span>


<!---------------------------------------Creator Reassignment----------------------------------------------------------------------->
		<span id = 'cre'>
			<div class='tools'>
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
			</div><!--tools6-->
		</span>
<!----------------------------------------------------PALT Code Reassignment---------------------------------------------------------->
		<span id = 'pal'>
			<div class='tools'>
					<fieldset id = 'fs5'>
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
			</div><!--tools6-->
		</span>
<!-----------------------------------------------------Requestor Code Reassignment------------------------------------------------------>
		<span id = 'req'>
			<div class= 'tools'>
					<fieldset id = 'fs6'>
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
			</div><!--tools7-->
		</span>
<!--------------------------------------------------Signature Reassignment--------------------------------------------------------------->
		<span id = 'sig'>
			<div class= 'tools'>
				<fieldset id = 'fs7'>
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
			</div><!--tools8-->
		</span>
<!-------------------------------------------------------Footer---------------------------------------------------------------------->
	</div><!--wrapper2-->
	</body>
</html>