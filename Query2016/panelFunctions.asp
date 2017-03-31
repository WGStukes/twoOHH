<% ENABLESESSIONSTATE="False"%>
 <!DOCTYPE html>
 <!--#include file = 'spsFunctions.asp'-->
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>SPS Query</title>
	    <link rel="stylesheet" type="text/css" href="style/query.css"/>
		<link rel="stylesheet" type="text/css" href="style/pf.css"/>

			<script type="text/javascript" src="common/spsQuery.js"></script>
			<meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
<%
				doc_no= Trim(UCASE(Request.Form("doc_no")))
					IF doc_no = "" THEN
							doc_no = Trim(UCASE(request.QueryString("doc_no")))
						IF doc_no = "" THEN
							response.redirect("error.asp")
						END IF
					END IF
				setConnection(doc_no)
IF connString = -1 THEN

%>
		<form name='docno' title='Document Number' method='POST' action='error.asp'>
				<input type='hidden' id='doc_no' name='doc_no'  size='30' value= '<%=doc_no%>'<br>
		</form>
			<script type='text/javascript'>
				<!--
					formObj = document.docno;
					formObj.submit();
				// -->
			</script>
<%
ELSE
		obj_id = getObjId(doc_no)
		objType = getObjType(obj_id)
	IF objType = "" THEN
		objType = getObjType2(doc_no)
	END IF

			getRelatedDocs(obj_id)
		SET wkData = getWkldData(obj_id)
		SET master = getMasterDocNo(wkData.wkObjId)
		SET obj1 = objectData(doc_no)
			stamp_id = obj1.stamp_id
			getNotes(obj_id)

		SELECT Case objType
			Case "AWD"
				leftPane= getDocData(doc_no)
				rightPane= getVendorData(doc_no)
				headerPane="Award Status"
			Case "MOD"
				leftPane= 	getModPanel(doc_no)
				rightPane= getVendorData(doc_no) & "<br/>" & getWkldPanel(obj_id) & "<br/><br/><br/><br/>"
				headerPane= "Modification Status"
			Case "SOL"
				leftPane= getSolicitation(doc_no)
				'rightPane=getWkldPanel(obj_id)'
				headerPane="Solicitation Status"
			Case "AMD"
				leftPane = getSolicitation(doc_no)
				'rightPane=getWkldPanel(obj_id)'
				headerPane="Solicitation Amendment Status"
			Case "REQ"
				leftPane= getPrData(doc_no)
				rightPane=getWkldPanel(obj_id)
					IF LEN(doc_no) > 10 THEN
						headerPane = "PR Modification Status"
				 	ELSE
						headerPane="Purchase Request Status"
					END IF
			Case "DEL"
				leftPane= getDocData(doc_no)
				rightPane= getVendorData(doc_no)
				headerPane= "Delivery Order/Task Order Status"
			Case "DOM"
				leftPane= getModPanel(doc_no)
				rightPane= getVendorData(doc_no) & "<br/>" & getWkldPanel(obj_id) & "<br/><br/><br/><br/>"
				headerPane="Delivery Order/Task Order <br/>&nbsp;&nbsp;&nbsp;&nbsp; Modification Status"

END Select
%>
<script>
	var x
	var lim = "<%=UBound(noteArray)%>";
	var dLim = "<%=UBound(delOnly)%>";
	var doc = "<%=doc_no%>";
	var str;
	var dStr;
	x=0

	function showNote(id) {

		if(id=="+"){
			if(x < lim -1){
				x=x+1;
			}
		}else if(id=="-"){
			if(x >0){
				x=x-1;
			}
		}
	str = x+doc

	    if (x.length == 0) {
	        document.getElementById("txtNote").innerHTML = "";
	        return;
	    } else {
	        var xmlhttp = new XMLHttpRequest();
	        xmlhttp.onreadystatechange = function() {
	            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
	                document.getElementById("txtNote").innerHTML = xmlhttp.responseText;
	            }
	        }
	        xmlhttp.open("GET", "getNote.asp?q="+str, true);
	        xmlhttp.send();
	    }
	}

	function getMods(){
		var mod = document.getElementById("getMods").checked;
		if(mod == true){
		dStr = 1;
		}else if(mod == false){
		dStr = 0;
		}

		dStr = dStr + doc
		        var xmlhttp = new XMLHttpRequest();
		        xmlhttp.onreadystatechange = function() {
		            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
		                document.getElementById("delivery").innerHTML = xmlhttp.responseText;
		            }
		        }
		        xmlhttp.open("GET", "getMods.asp?q="+dStr, true);
	        xmlhttp.send();
	}
</script>

	</head>

	<body>
		<div class ="wrapper">
					<%=printBanner("Document Display", doc_no)%>
					<fieldset id = 'fs1'>
						<legend> Document Retrieval </legend>
						<%=printHeader()%>
					</fieldset>
		 </div><!--wrapper1-->
		 <div class = 'wrapper'>
		<fieldset>
			<legend>Related Documents</legend>
			<div class='boxContainer'>

						<div class = 'box'>

								<div class='boxHead'>
									Purchase Requests
								</div>
					 			<div class ='boxInt'>

								<%
									Dim arrCnt
									IF objType = "REQ" THEN	response.write("<a href = 'https://wdcontracts.navair.navy.mil/contracts/tools/PR_Search/testing.asp?doc_no="& doc_no & " 'target= '_blank'>" & vbCrLf & "See PR Document</a>" & vbCrLf & "<br/>" & vbCrLf & "<a href = 'LineItem.asp?doc_no="& doc_no &" 'target= '_self'>" & vbCrLf & "See Line Items" & vbCrLf & "</a>" & vbCrLf & "<br/>")END IF
									IF UBound(prArray) = 0 THEN
										response.write("<i>no PRs/Mods Found</i>")
									ELSE
											IF objType = "DEL" THEN
													arrCnt=1
											ELSEIF objType = "DOM" THEN
												arrCnt = 1
											ELSE
												arrCnt = 0
											END IF

										FOR ii = arrCnt TO UBound(prArray) -1
											x=prArray(ii)
											y=x
											IF y <> doc_no THEN
											response.write("<a href = 'panelFunctions.asp?doc_no="& x &" 'target= '_self'>" & y & "</a><br/>")
											END IF
										NEXT
									END IF


								%>
								</div><!--boxInt-->

							</div><!--box-->

				<!--Solicitation related Documents-->

						<div class= 'box'>
								<div class='boxHead'>
									Solicitations
								</div>

								<div class='boxInt'>
								<%

								IF objType = "SOL" THEN
								response.write("<a href = 'LineItem.asp?doc_no="& doc_no &" 'target= '_self'>" & vbCrLf & "See Line Items " & vbCrLf & "</a>" & vbCrLf & "<br/>")
								ELSEIF objType = "AMD" THEN
									response.write("<a href = 'LineItem.asp?doc_no="& doc_no &" 'target= '_self'>" & vbCrLf & "See Line Items" & vbCrLf & "</a>" & vbCrLf & "<br/>")
								END IF
								IF UBound(solArray) = 0 THEN
								response.write("<i>No SOLs/AMDs Found</i>")
								ELSE
									for each x in solArray
										if LEN(x) = 23 THEN
											y=right(x,6)
										elseif LEN(x) = 21 THEN
											y=right(x,4)
										else
											y=x
										end if
										if y <> doc_no then
											if y <> "" then
											response.write("<a href = 'panelFunctions.asp?doc_no="& x &" 'target= '_self'>" & vbCrLf  & y & "</a>" & vbCrLf & "<br/>")
											end if
										end if
									next
								END IF

								%>
								</div><!--boxInt-->
								</div><!--box2-->

				<!--Award Related documents-->


						<div class= 'box'>
							<div class='boxHead'>
								Awards
							</div>
							<div class='boxInt'>

								<%
							IF objType = "AWD" THEN
								response.write("<a href = 'LineItem.asp?doc_no="& doc_no &" 'target= '_self'>See Line Items</a><br/>")
							ELSEIF objType = "MOD" THEN
									response.write("<a href = 'LineItem.asp?doc_no="& doc_no &" 'target= '_self'>See Line Items</a><br/>")
							END IF

								Dim domCore
									domCore = LEFT(doc_no,16)
								Dim nextObj
									nextObj=getObjId(domCore)

								getRelatedDocs(nextObj)
									IF Ubound(awdArray) = 0 THEN
										response.write("<i> No AWDs/MODs Found </i>")
									ELSE

										if ((awdArray(0) <> domCore)and(objType <> "REQ")and(objType <> "SOL")and(objType <> "AMD")) then
											response.write("<a href = 'panelFunctions.asp?doc_no="& domCore & " 'target = '_self'>" & domCore & "</a><br/>")
										end if

										for ii = 0 to UBound(awdArray) -1
											x = awdArray(ii)
											if LEN(x) = 23 THEN
												y=right(x,6)
											elseif LEN(x) = 21 THEN
												y=right(x,4)
											else
												y=x
											end if
											if y <> doc_no then
												if y <> "" then
													response.write("<a href = 'panelFunctions.asp?doc_no="& x &" 'target= '_self'>" & y & "</a><br/>")
												end if
											end if
										next

									END IF

								%>
							</div><!--boxInt-->
						</div><!--box3-->

				<!--Delivery Orders and Deliver Order Modification documents List-->

						<div class= 'box'>
							<div class='boxHead'>DO/TO's
								<!--the following code inserts a checkbox to toggle between DO/TO's and Mods-->
									<% IF UBound(delArray) <> 0 THEN %>
										<input id = 'getMods' class = 'radio' type='checkbox' onclick='return getMods()'>Mods
									<% END IF %>
							</div><!--boxHead-->
							<div class='boxInt'>
								<%
				<!-- insert "See Line Items link if document is a delivery order"-->
								IF objType = "DEL" THEN
									response.write("<a href = 'LineItem.asp?doc_no="& doc_no &" 'target= '_self'>See Line Items</a><br/>")
								ELSEIF objType="DOM" THEN
									response.write("<a href = 'LineItem.asp?doc_no="& doc_no &" 'target= '_self'>See Line Items</a><br/>")
								END IF
								%>
								<div  id = "delivery">
								<%

									IF UBound(delOnly) = 0 AND objType = "DEL" THEN
										response.write("<a href = 'panelFunctions.asp?doc_no="& doc_no &" 'target= '_self'>" & right(doc_no,4) & "</a><br/>")
									ELSEIF UBound(delOnly) <> 0 THEN
										for each x in delOnly
											if LEN(x) = 23 THEN
												y=right(x,6)
											elseif LEN(x) = 21 THEN
												y=x
											else
												y=x
											end if
											if y <> doc_no then
												if y <> "" then
													response.write("<a href = 'panelFunctions.asp?doc_no="& x &" 'target= '_self'>" & y & "</a><br/>")
												end if
											end if
										next
									ELSE
										response.write("<i>No DO/TO's Found</i>")
									END IF


								%>
								</div><!--delivery-->
					</div><!--boxInt-->
				</div><!--box4-->

			</div><!--boxContainer-->
		</fieldset>
	</div><!--wrapper-->
		<div class='wrapper'>
		<fieldset>
			<legend> Data Tables </legend>
			<div class='contain'>
				<div class='inner'>
				 <%
					 Select Case stamp_id
					 	Case "Released"
					 		stampId = "stampR"
					 	Case "Approved"
					 		stampId = "stampA"
					 	Case "Cancelled"
					 		stampId = "stampC"
					 	Case "Closed"
					 		stampId = "stampCO"
					 	Case Else
					 		stampId = ""
					 END SELECT
		 		%>
		<div class=<%=stampId%> onclick ="this.style.display='none';"></div>
				<div class='paneT'>
						<%=docLocation(doc_no)%>
				</div><!--paneT-->

				<div class='paneL'>
					<%	IF UBound(noteArray) > 0 THEN %>

							<div id = 'notes' class = 'notes'>
								<div id = 'notesTop' class='notesTop'>
									Document Notes Found: <%=UBound(noteArray)%>
								</div>
									<div class='notesInt' id = 'notesInt'>
												<span id="txtNote">
													<%
														FOR ii =0 to Ubound(noteArray)-1
															response.write("<div class = 'noteColor'><br/>Note " & ii+1 & ":</div><!--noteColor--><br/>" & noteArray(ii) & "<br/>")
														NEXT
													%>
												</span>
											<br/><br/>
										</div><!--notesInt-->
								</div>

								<br/>
						<%END IF%>
						<%=leftPane%>
				</div><!--paneL-->
				<div class='paneR'>
						<%=rightPane%>
				</div><!--paneR-->
				</div><!--inner-->
			</div><!--contain-->
		</fieldset>
		 </div><!--wrapper-->
		<%END IF
			response.write(printFooter())
		%>
	</body>
</html>
