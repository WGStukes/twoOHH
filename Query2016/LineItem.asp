<!DOCTYPE html>
<!--#include file='spsFunctions.asp'-->
<html>
<head>
	<title>Line Item Page</title>
	<link rel="stylesheet" type="text/css" href="style/query.css"/>
	<link rel="stylesheet" type="text/css" href="style/clin.css"/>

	<script type="text/javascript" src="common/spsQuery.js"></script>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
<%
doc_no = Request.QueryString("doc_no")
Dim objType
	setConnection(doc_no)
	objId = getObjId(doc_no)
	objType = getObjType(objId)

%>
</head>
	<body>
		<div class ="wrapper">
				<%=printBanner("Line Item List", doc_no)%>
					<fieldset id = 'fs1'>
						<legend> Document Retrieval </legend>
						<%=printHeader()%>
					</fieldset>
		 </div><!--wrapper1-->
		 <div class='wrapper'>
<%
Dim totalCost(1024)
Dim totalFund
Dim totalCostAmt


SET objConn =Server.CreateObject("ADODB.Connection")
	objConn.Open connString

	objConn.CommandTimeout =10

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandText = "exec Query_getFunding ?"
		objCmd.CommandTimeout = 10


	SET objPar=objCmd.CreateParameter("@doc_no",200,1,32,doc_no)
	objCmd.Parameters.Append objPar

	SET objRS=objCmd.Execute()
		WHILE(objRS.EOF = FALSE)
			totalCost(count) = objRS("totalCost")
			totalCostAmt= totalCostAmt+totalCost(count)
		count = count +1
		objRS.MoveNext
		WEND

objRS.Close
objConn.Close

SET objConn = Nothing
SET objCmd = Nothing
SET objPar = Nothing
SET objRS = Nothing


			obj_id = getObjId(doc_no)
			clin_id = getClinId(obj_id)

				Dim 	cnt
				Dim		clin_cd(1024)
				Dim 	optionFlg(1024)
				Dim		clin_comm(1024)
				Dim		clin_mstrip(1024)
				Dim		clin_descrip(1024)
				Dim		clin_nsn(1024)
				Dim		clin_price(1024)
				Dim		clin_quant(1024)
				Dim		clin_pr(1024)
				Dim		clin_num(1024)
				Dim		clin_exp(1024)
				Dim		clin_Rc(1024)
				Dim		clin_Acrn(1024)
				Dim		clin_cin(1024)
				Dim		clin_costCd(1024)
				Dim		clin_fundAmt(1024)
				Dim		clin_fscCD(1024)
				Dim		clin_fscDesc(1024)
				Dim		clin_cont(1024)
				Dim		clin_issue(1024)
				Dim		clin_fundST(1024)
				Dim 	clin_chg(1024)
				'Dim 	clin_ext_am(1024)'
			cnt = 0


		SET objConn = Server.CreateObject("ADODB.Connection")
			objConn.Open connString
			objConn.CommandTimeout = 10

		SET objCmd = Server.CreateObject("ADODB.Command")
			objCmd.ActiveConnection = objConn
			objCmd.CommandTimeout = 10
			objCmd.CommandText = "exec Query_getClinData ?"

		SET objPar = objCmd.CreateParameter("@doc_no",200,1,32,doc_no)
			objCmd.Parameters.Append objPar

		SET objRS= objCmd.Execute()

totalFund=0
				WHILE(objRS.EOF = FALSE)
						clin_cd(cnt) = objRS("clin_cd")
						optionFlg(cnt) = objRS("optionFlg")
						clin_comm(cnt) = objRS("clin_comm")
						clin_mstrip(cnt) = objRS("clin_mstrip")
						clin_descrip(cnt) = objRS("clin_descrip")
						clin_nsn(cnt) = objRS("clin_nsn")
						clin_price(cnt) = objRS("clin_price")
						clin_quant(cnt) = objRS("clin_quant")
						clin_pr(cnt) = objRS("clin_pr")
						clin_num(cnt) = objRS("clin_num")
						clin_exp(cnt) = objRS("clin_exp")
						clin_Rc(cnt) = objRS("clin_Rc")
						clin_Acrn(cnt) = objRS("clin_Acrn")
						clin_cin(cnt) = objRS("clin_cin")
						clin_costCd(cnt) = objRS("clin_costCD")
						clin_fundAmt(cnt) = objRS("clin_fundAmt")
						clin_fscCD(cnt) = objRS("clin_fscCd")
						clin_fscDesc(cnt) = objRS("clin_fscDesc")
						clin_cont(cnt) = objRS("clin_cont")
						clin_issue(cnt) = objRS("clin_issue")
						clin_fundST(cnt) = objRS("clin_fundST")
						clin_chg(cnt) = objRS("sap_chg_obj")
					'	clin_ext_am(cnt) = objRS("clin_ext_am")'

					IF optionFlg(cnt) = 1 THEN
						totalOpt = totalOpt + totalCost(cnt)
					ELSEIF optionFlg(cnt) = 0 THEN
						baseAmt = baseAmt + totalCost(cnt)
					END IF

								totalFund=totalFund + clin_fundAmt(cnt)
								cnt=cnt +1
								objRS.MoveNext


					WEND
			totalCntrAmt = totalOpt + baseAmt

		objRS.Close
		objConn.Close
	%>
	<fieldset>
		<legend>Funding Data Summary</legend>
<div class='fundData'>
	<table id = ><small>
	<% IF objType <> "REQ" THEN %>
		<tr><th>Total Funding Amount:</th>
			<%IF totalFund = 0.00 THEN%>
			<td><%=FormatCurrency(totalFund)%></td>
			<%ELSE%>
			<td><a href = 'lineItemFunding.asp?doc_no=<%=doc_no%>'target= '_self'>
				<%=FormatCurrency(totalFund)%></a>
			</td>
			<%END IF%>
		</tr>
		<tr><th>Funding This Action: </th>                <td><%=FormatCurrency(totalFund)%></td> </tr>
		<tr><th>Total Contract Base Amount:</th>          <td><%=FormatCurrency(baseAmt)%></td></tr>
		<tr><th>Total Contract Options Amount:</th>       <td><%=FormatCurrency(totalOpt)%></td> </tr>
		<tr><th>Total Contract Amount with Options:</th>  <td><%=FormatCurrency(totalCntrAmt)%></td> </tr>
		<tr><th>Total Contract Amount Exercised:</th>    <td><%=FormatCurrency(totalCostAmt)%></td> </tr>
	</small></table>
	<% ELSE %>
		<tr><th>Total Funding Amount:</th>
			<%IF totalFund = 0.00 THEN%>
			<td><%=FormatCurrency(totalFund)%></td>
			<%ELSE%>
			<td><a href = 'lineItemFunding.asp?doc_no=<%=doc_no%>'target= '_self'>
				<%=FormatCurrency(totalFund)%></a>
			</td>
			<%END IF%>
		</tr>
	</small></table>
	</br></br></br></br></br></br>
	<%END IF%>

</div><!--fundData-->

</fieldset>
</div><!--wrapper-->
<div class='wrapper'>
<fieldset>
	<legend>Clin Funding Data</legend>

<a class='return' href='panelFunctions.asp?doc_no=<%=doc_no%>'target= '_self'> Return to <%=doc_no%></a>
<div id = 'list'>
<table>

<tr>
<th class='clin'>CLIN</th>
<th class='SAPr'>SAP PR</br>CLIN PR</th>
<th class='SAPclin'>SAP CLIN </br></th>
<th class='rc'>REQ</br> Code</th>
<th class='SAPchObj'>SAP CHG OBJ</th>
<th class='appn'>APPN SUBH</br>COST CODE</th>
<th class='description'>Description</th>
<th class='totalCost'>Total</br>Cost</th>
<th class='totalFund'>Total</br>Funding</th>
<th class='clinType'>CLIN</br>Type</th>
</tr>



<%
	FOR jj=0 TO cnt -1

		result = jj mod 2
	IF result = 0 THEN tr = "<tr style='background-color:#E6E6E6'>" ELSE tr ="<tr style='background-color:white'>" END IF
		'response.write(tr & lineItemPanel(jj))'

str = ""
str = str & tr
str = str & "	<td id='clin'><a href = 'clinInfo.asp?doc_no="& doc_no & "/" & clin_cd(jj) &"'target= '_self'>" & clin_cd(jj) & "</a></br></td>"
IF clin_num(jj) <> "<i>Unavailable</i>" THEN str = str & "	<td id='SAPnum'><a href='panelFunctions.asp?doc_no="& clin_num(jj) &"'target= '_self'>"& clin_num(jj) & "</a></td>" ELSE str = str & "<td id='SAPnum'><i>Unavailable</i></td>" END IF
str = str & " 	<td id='SAPclin'>" & clin_pr(jj) & "</td>"
str = str & "	<td id='ReqCd'>"& clin_Rc(jj) &"</td>"
str = str & "	<td id='SAPChg'>"& clin_chg(jj) &"</td>"
str = str & "	<td id='Appn'>"
IF clin_fundST(jj)="<i>Unavailable</i>" THEN
str = str & clin_fundST(jj)
ELSE
str = str &  LEFT(clin_fundST(jj),12)
END IF
str = str & "</br>" & clin_costCd(jj) & "</td>"
str = str & "	<td id='descri'>"& clin_descrip(jj) & "</td>"
str = str & "	<td id='totCost'>"& FormatCurrency(totalCost(jj)) & "</td>"
str = str & "	<td id='totFund'>"& FormatCurrency(clin_fundAmt(jj)) & "</td>"
str = str & "	<td id='clinType'>"
str = str & clin_cont(jj)
str = str & "</td>"
response.write(str & "</tr>")
	Next


%>


</table>
</div><!--list-->

</fieldset>
</div><!--wrapper-->
		<%=printFooter()%>


</body>

</html>