<!DOCTYPE html>
<!--#include file='spsFunctions.asp'-->
<html>
<head>
	<title>Line Item Page</title>
	<link rel="stylesheet" type="text/css" href="style/query.css"/>
	<link rel="stylesheet" type="text/css" href="style/pf.css"/>

	<script type="text/javascript" src="common/spsQuery.js"></script>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
<%
doc_no = Request.QueryString("doc_no")

setConnection(doc_no)
%>
</head>

<body>
		<div class='wrapper'>
				<%=printBanner("Line Item Funding", doc_no)%>
					<fieldset id = 'fs1'>
						<legend> Document Retrieval </legend>
						<%=printHeader()%>
					</fieldset>
		</div><!--wrapper1-->
		<div class='wrapper'>
			<div class= 'contain'>

<%
Dim totalCost(1024)
Dim totalFund
totalFund=0

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
			totalFund= totalFund+totalCost(count)
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
				Dim 	month(1024)
				Dim 	year(1024)
				Dim 	day(1024)
				Dim		date(1024)
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
					WHILE(objRS.EOF = FALSE)
						clin_cd(cnt) = objRS("clin_cd")
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

						year(cnt) = left(clin_exp(cnt), 4)
						month(cnt) =mid(clin_exp(cnt),5,2)
						day(cnt) = right(clin_exp(cnt),2)
						date(cnt) = year(cnt) & "-" & month(cnt) & "-" & day(cnt)
						cnt=cnt +1



						objRS.MoveNext
					WEND
		objRS.Close
		objConn.Close

	%>
<div class="contain">
</br></br>
<table>
<a class='return' href='LineItem.asp?doc_no=<%=doc_no%>'target= '_self'>Return to Line Items for: <%=doc_no%></a>
<tr class='clinRw'>
<th class='clin2'>CLIN</th>
<th class='acrn'>Contract ACRN</th>
<th class='fst'>Funding Strip</br></th>
<th class='cc'>Cost Code</th>
<th class='cin'>CIN Number</th>
<th class='funds'>Funding Amount</th>
<th class='wkExp'>Funds/Work Expiration Date</th>
</tr>
<%
function clinFunding(count)
	Dim ii
		ii= count
		str = ""
		str = str & "<td>" & clin_cd(ii) & "</td>"
		str = str & "<td>" & clin_Acrn(ii) & "</td>"
		str = str & "<td>" & clin_fundST(ii) & "</td>"
		str = str & "<td>" & clin_costCd(ii) & "</td>"
		str = str & "<td>" & clin_cin(ii) & "</td>"
		str = str & "<td>" & FormatCurrency(clin_fundAmt(ii)) & "</td>"
		str = str & "<td>" & date(ii) & "</td>"
		str = str & "</tr>"
	clinFunding=str
End function

	for ii=0 to cnt-1
			result = ii mod 2
		IF result = 0 THEN tr = "<tr style='background-color:#E6E6E6'>" ELSE tr ="<tr style='background-color:white'>" END IF
		response.write(tr & clinFunding(ii))
	Next
%>
</table>
	</div><!--contain-->
</div><!--wrapper-->



</body>

</html>