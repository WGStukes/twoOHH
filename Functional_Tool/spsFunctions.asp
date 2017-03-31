	<!--#include file = 'common/global.asp'-->
	<!--#include file = 'common/spsClasses.asp'-->
					<%
'doc_no = "N68936-08-D-0016-0001"

'+#############################################################################################################################################+'
'|	 TITLE: spsFunctions.asp		AUTHOR: Jeremy McClellan			LAST REVISION:	9/3/2015	               *'
'+=============================================================================================================================================+'
'|														CONTENTS		       *'
'+=============================================================================================================================================+'
'|	ID	Function Name			Stored Procedure Executed			Calls Function/SUB 		Page Utilized  *'
'+---------------------------------------------------------------------------------------------------------------------------------------------+'
'|	*f1:	docLocation(docNo)		None						f51						'
'|	*f2:	errorLog(loc, docNo, eType)	None						f49						'
'|	*f3:	formField()			None						NONE						'
'|	*f4:	getArchiveDt(docNo)		Query_getArchDt					NONE						'
'|	*f5:	getAward(obj_id)		Query_getAward					NONE						'
'|	*f6:	getAwdData(awdObjId)		Query_getAwdContacts				NONE						'
'|	*f7:	getCageCd(orgId,addId)		Query_getCageCd					NONE						'
'|	*f8:	getChangeReason(objId)		Query_getChgRsn					NONE						'
'|	*f9:	getClinData(clinId)		Query_getClinData2				NONE						'
'|	*f10:	getClinId(obj_id)		Query_getClinId					NONE						'
'|	*f11:	getClinInfo(doc_no, clin_no)	Query_getClinInfo				NONE						'
'|	*f12:	getContactData(orgId,addId)	Query_getContactInfo				NONE						'
'|	*f13:	getDocData(docNo)		NONE						f4,f5,f6,f12,f15,f22,f36,f38,f39,f48		'
'|	*f14:	getDocList(doc_no, conn)	Query_getDocList				NONE						'
'|	*f15:	getDocObject(docNo)		Query_getDocData				NONE						'
'|	*f16:	getFundAmt(objId)		Query_getClinObject				NONE						'
'|	*f17:	getFunding(docNo)		Query_getFunding				NONE						'
'|	*f18:	getLocation(objId)		Query_getLocation				NONE						'
'|	*f19:	getMasterDocNo(objId)		Query_getMasterDocno				NONE						'
'|	*f20:	getModPanel(docNo)		NONE						f5,f8,f12,f15,f22,f39,f48			'
'|	*f21:	getObjData(docNo)		Query_getDskObj					NONE						'
'|	*f22:	getObjId(docNo)			Query_getObjId					NONE						'
'|	*f23:	getObjType(objId)		Query_getObjType2				NONE						'
'|	*f24:	getObjType2(docNo)		Query_getObjType				NONE						'
'|	*f25:	getOrgName(orgId)		Query_getOrgName				NONE						'
'|	*f26:	getPaltInfo()			Query_getPaltInfo				NONE						'
'|	*f27:	getPrData(docNo)		NONE						f22,f37,f39,f48					'
'|	*f28:	getRelated(doc,objId,cmdText)	Query_get_ancestors,Query_get_descendants	f36						'
'|	*f29:	getRelatedDocs(obj_id)		Query_get_ancestors,Query_get_descendants	NONE						'
'|	*f30:	getSapObj(docNo)		Query_getSapObjs				f35						'
'|	*f31:	getSapObjs(sap_no,conn)		Query_getSapObjs				NONE						'
'|	*f32:	getSapTable()			NONE						f30						'
'|	*f33:	getSolicitation(doc_no)		NONE						f8,f13,f22,f39					'
'|	*f34:	getTable(conn, doc_no)		NONE 						NONE						'
'|	*f35:	getTableList(docNo, num)	NONE						f22,f36,f48					'
'|	*f36:	getThisType(obj, num)		NONE						NONE						'
'|	*f37:	getUid(objId)			Query_getUid					NONE						'
'|	*f38:	getUidFrmName(fullNm)		Query_getUidFromName				NONE						'
'|	*f39:	getUserData(uid)		Query_getUserData				NONE						'
'|	*f40:	getVendorData(docNo)		NONE						f5,f7,f12,f22,f25				'
'|	*f41:	getWkldData(objId)		Query_getWkldData				NONE						'
'|	*f42:	getWkldPanel(objId)		Query_getWkldAssign				f19,f41						'
'|	*f43:	lineItemData(doc_no, clin_no)	NONE						f11						'
'|	*f44:	lineItemPanel(cnt)		NONE						NONE						'
'|	*f45:	logUse(loc)			NONE						NONE						'
'|	*f46:	getNotes(objId)			Query_getDskNote				NONE						'
'|	*f47:	notePanel(doc_no)		NONE						f22,f46						'
'|	*f48:	objectData(docNo)		Query_getDocData				NONE						'
'|	*f49:	sendError(database,doc,error) 	NONE						NONE						'
'|	*f50:	setConnection(docNo)		NONE						f52						'
'|	*f51:	setLocation(objId)		NONE						f18						'
'|	*f52:	testObjId(docNo,conn)		Query_getObjId 					NONE						'
'+---------------------------------------------------------------------------------------------------------------------------------------------+'
'==============================================================================================================================================='
'###############################################################################################################################################'
'								Connection Functions								'
'-----------------------------------------------------------------------------------------------------------------------------------------------'
ON Error Resume Next
Dim connString
Dim objConn
Dim site_id
Dim chlk
Dim pax
Dim orl
Dim prArray()
ReDim prArray(0)

Dim delArray()
ReDim delArray(0)

Dim delOnly()
ReDim delOnly(0)

Dim solArray()
ReDim solArray(0)

Dim awdArray()
ReDim awdArray(0)
Dim eCount
	eCount = 0


'*f1:-------------------------------------------------------------------------------------------------------------------------------------------'


Function docLocation(docNo)
on error resume next
	Dim thisId
	thisId = getObjId(docNo)

	str = ""
	str = str & "<table>"
	str = str & "<th id='Location' colspan='2'> Current Location</th>"
	str = str & "<tr>"
	str = str & "<td>"
	str = str & setLocation(thisId)
	str = str & "</td>"
	str = str & "</tr>"
	str = str & "</table>"
	docLocation = str
End Function


'*f2:-------------------------------------------------------------------------------------------------------------------------------------------'


'*f3:-------------------------------------------------------------------------------------------------------------------------------------------'


Function formField()
on error resume next
	str = ""
	str = str & "<div align ='center' class='formField'>"
	str = str & "<form name='docno' title='Document Number' method='post'  onkeyup='return ckChar()' onsubmit='return validate()'>"
	str = str & "<label for='document_no'>Document Number:&nbsp;&nbsp;</label>"
	str = str & "<input id='document_no' maxlength='24' name='doc_no' size='30' value=''/>&nbsp;&nbsp;"
	str = str & "<input type='submit' onclick='return ckChar()' value='Search'/><br/>"
	str = str & "<span id='exTxt'><small> </small></span>"
	str = str & "</form>"

	str = str & "</div><!--formfield-->"
	formField = str
End Function


'*f4:-------------------------------------------------------------------------------------------------------------------------------------------'


Function getArchiveDt(docNo)
	ON Error Resume Next
Dim archiveDt


SET objCmd = Server.CreateObject("ADODB.Command")
	objCmd.ActiveConnection = objConn
	objCmd.CommandType = adCmdText
	objCmd.CommandTimeout =10
	objCmd.CommandText="exec Query_getArchDt ?"
SET objPar = objCmd.CreateParameter("@doc_no",200,1,32,docNo)
	objCmd.Parameters.Append objPar

SET objRS = objCmd.Execute()
	IF(objRS.EOF = FALSE) THEN
		archiveDt = objRS("arch_dt")
	ELSE
		archiveDt= "<i>Unavailable</i>"
	END IF
objRS.Close

SET objRS = NOTHING
SET objCmd = NOTHING
SET objPar = NOTHING

getArchiveDt = archiveDt
End Function


'*f5:-------------------------------------------------------------------------------------------------------------------------------------------'


Function getAward(obj_id)
on error resume next

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandText = "exec Query_getAward ?"
		objCmd.CommandTimeout = 10
		objCmd.CommandType = adCmdText

	SET objPar=objCmd.CreateParameter("@obj_id",3,1,10,obj_id)
	objCmd.Parameters.Append objPar

	SET objRS=objCmd.Execute()
	SET this = new award
	IF (objRS.EOF = False) THEN
					this.sap 		= objRS("sap_po_no")
					this.relDate	= objRS("awd_rel_dt")
					this.effDate	= objRS("awd_effect_dt")
					this.awdType	= objRS("awd_type_desc")
					this.adminOrgId = objRS("admin_org_id")
					this.adminAddId = objRS("admin_addr_id")
					this.vendOrgId 	= objRS("vend_org_id")
					this.vendAddId 	= objRS("vend_addrr_id")
					this.vendCntct 	= objRS("vend_cntct_id")
					this.payOrgId 	= objRS("pay_org_id")
					this.payAddId	= objRS("pay_addr_id")
					this.koOrgId 	= objRS("ko_org_id")
					this.koAddId 	= objRS("ko_addr_id")
					this.koCntct	= objRS("ko_cntct_id")
					this.isuOrgId 	= objRS("isu_org_id")
					this.isuAddrId  = objRS("isu_addr_id")
					this.cloDt		= objRS("clo_data")
					this.archiveDt	= objRS("arch_dt")
				ELSE
					this.sap = ""
					this.relDate = ""
					this.effDate = ""
					this.awdType = ""
					this.adminOrgId = ""
					this.adminAddId = ""
					this.vendOrgId = ""
					this.vendAddId = ""
					this.vendCntct = ""
					this.payOrgId = ""
					this.payAddId = ""
					this.koOrgId = ""
					this.koAddId = ""
					this.koCntct = ""
					this.isuOrgId = ""
					this.isuAddrId = ""
					this.cloDt		= ""
					this.archiveDt	= ""
					END IF

			objRS.Close

	SET objRS = Nothing
	SET objPar = Nothing
	SET objCmd = Nothing
	SET getAward=this
end function


'*f6:-------------------------------------------------------------------------------------------------------------------------------------------'


Function getAwdData(awdObjId)
on error resume next

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandText = "exec Query_getAwdContacts ?"
		objCmd.CommandTimeout = 10
		objCmd.CommandType = adCmdText

	SET objPar=objCmd.CreateParameter("@obj_id",3,1,10,awdObjId)
	objCmd.Parameters.Append objPar

	SET objRS=objCmd.Execute()

	SET this = new awdData
	IF(objRS.EOF = False) THEN

				this.grpId = objRS("GroupID")
				this.docNo = objRS("DocNo")
				this.VendorName = objRS("VendorName")
	 			this.objDescr = objRS("description")
				this.specName = objRS("SpecName")
				this.pcoName = objRS("PcoName")
		ELSE
				this.grpId= ""
				this.docNo = ""
				this.VendorName = ""
				this.objDescr = ""
				this.specName = ""
				this.pcoName = ""
		END IF
objRS.Close

SET objRS = Nothing
SET objPar = Nothing
SET objCmd = Nothing

SET getAwdData= this
end function


'*f7:-------------------------------------------------------------------------------------------------------------------------------------------'


Function getCageCd(orgId,addId)
on error resume next

		SET objCmd = Server.CreateObject("ADODB.Command")
			objCmd.ActiveConnection = objConn
			objCmd.CommandText = "exec Query_getCageCd ?, ?"
			objCmd.CommandTimeout = 10
			objCmd.CommandType = adCmdText

		SET objPar=objCmd.CreateParameter("@vendOrgId",3,1,10,orgId)
			objCmd.Parameters.Append objPar

		SET objPar1 = objCmd.CreateParameter("@vendAddId",3,1,10,addId)
			objCmd.Parameters.Append objPar1

		SET objRS = objCmd.Execute()

	IF(objRS.EOF = False) THEN
		cageCd = objRS("cage_cd")
		ELSE
		cageCd = "EMPTY"
		END IF

	objRS.Close

getCageCd = cageCd

SET objCmd = NOTHING
SET objPar = NOTHING
SET objRS = NOTHING
End Function


'*f8:-------------------------------------------------------------------------------------------------------------------------------------------'


Function getChangeReason(objId)
on error resume next

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandText = "exec Query_getChgRsn ?"
		objCmd.CommandType = adCmdText

	SET objPar = objCmd.CreateParameter("@obj_id",3,1,32,objId)
		objCmd.Parameters.Append objPar

	SET objRS = objCmd.Execute()
		IF(objRS.EOF = FALSE) THEN
			changeReason = objRS("chg_rsn")
		ELSE
			changeReason = "<i>Unavailable</i>"

		END IF
	objRS.Close
	getChangeReason = changeReason

	SET objCmd = NOTHING
	SET objRS = NOTHING
	SET objPar = NOTHING
End Function


'*f9:-------------------------------------------------------------------------------------------------------------------------------------------'


function getClinData(clinId)
on error resume next


SET objCmd = Server.CreateObject("ADODB.Command")
	objCmd.CommandTimeout = 10
	objCmd.ActiveConnection = objConn
	objCmd.CommandType = adCmdText
	objCmd.CommandText = "exec Query_getClinData2 ?"

SET objPar = objCmd.CreateParameter("@clin_id",3,1,10,clinId)
	objCmd.Parameters.Append objPar

SET objRS = objCmd.Execute()
	set this = new ClinData
		IF (objRS.EOF = False) THEN
			 this.clinNum = objRS("clin_no")
			 this.description = objRS("description")
			 this.sapNum = objRS("sap_pr_no")
			 this.sapClinNum = objRS("sap_clin_no")
			 this.sapCode = objRS("sap_code")
			 this.sapChgObj = objRS("sap_chg_obj")
			 this.costCd = objRS("cost_cd")
			 this.clinType = objRS("clin_type")
			 this.fundAmt = objRS("fund_amt")
			 this.prcAmt = objRS("ext_prc_am")
		Else
			 this.clinNum = "<i>Not Available</i>"
			 this.description = "<i>Not Available</i>"
			 this.sapNum = "<i>Not Available</i>"
			 this.sapClinNum = "<i>N/A</i>"
			 this.sapCode = "<i>Not Available</i>"
			 this.sapChgObj = "<i>Not Available</i>"
			 this.costCd = "<i>Not Available</i>"
			 this.clinType="<i>Not Available</i>"
			 this.fundAmt="<i>Not Available</i>"
			 this.prcAmt = "<i>Not Available</i>"
			END IF
		objRS.Close

		set getClinData = this

	SET objRS = NOTHING
	SET objPar = NOTHING
	SET objCmd = NOTHING

end function


'*f10:------------------------------------------------------------------------------------------------------------------------------------------'

Function getClinId(obj_id)
On Error Resume Next

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandText = "exec Query_getClinId ?"
		objCmd.CommandTimeout = 10
		objCmd.CommandType = adCmdText

	SET objPar=objCmd.CreateParameter("@obj_id",3,1,10,obj_id)
	objCmd.Parameters.Append objPar



	SET objRS=objCmd.Execute()
		IF(objRS.EOF = FALSE)THEN
			clin_id = objRS("clin_id")

		ELSE
			clin_id = ""
		END IF


objRS.Close


SET objRS = NOTHING
SET objPar = NOTHING
SET objCmd = NOTHING

 getClinId = clin_id
End Function


'*f11:------------------------------------------------------------------------------------------------------------------------------------------'


Function getClinInfo(doc_no, clin_no)
on error resume next
		SET objCmd = Server.CreateObject("ADODB.Command")
			objCmd.ActiveConnection = objConn
			objCmd.CommandText = "exec Query_getClinInfo ?, ?"
			objCmd.CommandTimeout = 10
			objCmd.CommandType = adCmdText

		SET objPar=objCmd.CreateParameter("@doc_no",200,1,32,doc_no)
			objCmd.Parameters.Append objPar

		SET objPar1 = objCmd.CreateParameter("@clin_no",200,1,11,clin_no)
			objCmd.Parameters.Append objPar1

	SET objRS = objCmd.Execute()

	SET this = new ClinInfo
		IF(objRS.EOF = False)THEN
			this.clin_no = objRS("clin_no")
			this.description = objRS("description")
			this.req_no = objRS("req_no")
			this.mfg_part_number = objRS("mfg_part_number")
			this.milstrip = objRS("milstrip")
			this.project = objRS("project")
			this.fsc_code = objRS("fsc_code")
			this.mdaps_code = objRS("mdaps_code")
			this.naics_code = objRS("naics_code")
			this.prog_code = objRS("prog_code")
			this.nsn = objRS("nsn")
			this.contract_type = objRS("contract_type")
			this.fob = objRS("fob")
			this.add_mark = objRS("add_mark")
			this.startDt = objRS("startDt")
			this.endDt = objRS("endDt")
			this.delType=objRS("delType")
			this.ext_desc = objRS("ext_desc")
			this.ship_dodaan = objRS("ship_dodaan")
			this.ship_poc = objRS("ship_poc")
			this.ship_phone = objRS("ship_phone")
			this.ship_address=objRS("ship_address")
		ELSE
			this.clin_no = "<i>Unavailable</i>"
			this.description = "<i>Unavailable</i>"
			this.req_no = "<i>Unavailable</i>"
			this.mfg_part_number = "<i>Unavailable</i>"
			this.milstrip = "<i>Unavailable</i>"
			this.project = "<i>Unavailable</i>"
			this.fsc_code = "<i>Unavailable</i>"
			this.mdaps_code = "<i>Unavailable</i>"
			this.naics_code = "<i>Unavailable</i>"
			this.prog_code = "<i>Unavailable</i>"
			this.nsn = "<i>Unavailable</i>"
			this.contract_type = "<i>Unavailable</i>"
			this.fob = "<i>Unavailable</i>"
			this.add_mark = "<i>Unavailable</i>"
			this.startDt = "<i>Unavailable</i>"
			this.endDt = "<i>Unavailable</i>"
			this.delType = "<i>Unavailable</i>"
			this.ext_desc = "<i>Unavailable</i>"
			this.ship_phone = "<i>Unavailable</i>"
			this.ship_dodaan ="<i>Unavailable</i>"
			this.ship_poc = "<i>Unavailable</i>"
			this.ship_address = "<i>Unavailable</i>"
		END IF
	SET getClinInfo = this
	objRS.Close

	SET objRS = NOTHING
	SET objCmd = NOTHING
	SET objPar = NOTHING

END FUNCTION


'*f12:------------------------------------------------------------------------------------------------------------------------------------------'


Function getContactData(orgId,addId, cntct)
on error resume next

		SET objCmd = Server.CreateObject("ADODB.Command")
			objCmd.ActiveConnection = objConn
			objCmd.CommandText = "exec Query_getContactInfo ?, ?, ?"
			objCmd.CommandTimeout = 10
			objCmd.CommandType = adCmdText

		SET objPar=objCmd.CreateParameter("@addr_id",3,1,10,addId)
			objCmd.Parameters.Append objPar

		SET objPar1 = objCmd.CreateParameter("@org_id",3,1,10,orgId)
			objCmd.Parameters.Append objPar1


		SET objPar2 = objCmd.CreateParameter("@cntct_id",3,1,10,cntct)
			objCmd.Parameters.Append objPar2


		SET objRS = objCmd.Execute()
		set this=new Contact


			IF(objRS.EOF = FALSE) THEN
				this.name = objRS("cntct_name")
				this.phone = objRS("cntct_phone")
				this.fax = objRS("cntct_fax")
				this.email = objRS("cntct_email")
				this.street = objRS("cntct_street")
				this.city = objRS("cntct_city")
				this.state = objRS("cntct_state")
				this.zip = objRS("cntct_zip")
				this.orgCd = objRS("short_cd")
				ELSE
				this.name = ""
				this.phone = ""
				this.fax = ""
				this.email = ""
				this.street=""
				this.city=""
				this.state = ""
				this.zip = ""
				this.orgCd = ""
				END IF
		objRS.Close


	set getContactData = this
	SET objCmd = Nothing
	SET objPar = Nothing
	SET objRS = Nothing
end function


'*f13:------------------------------------------------------------------------------------------------------------------------------------------'


function getDocData(docNo)
on error resume next
Dim str
Dim status
Dim awd_id
Dim obj
Dim cntct
Dim user
Dim objDat
Dim awd
Dim uid
Dim ko
	awd_id = getObjID(docNo)
	archDt = getArchiveDt(docNo)
	set obj = objectData(docNo)
	set cntct = getAwdData(awd_id)
	set objDat = getDocObject(docNo)
	set user = getUserData(objDat.uid)
	set awd = getAward(awd_id)
	uid = getUidFrmName(cntct.pcoName)
	set ko = getContactData(awd.koOrgId, awd.koAddId)
	objectType = getThisType(obj.objType,docNo)
		IF obj.stamp_id = "" THEN
			status = "<i>Unavailable</i>"
			stamp_id = "<i>Unavailable</i>"
		ELSEIF obj.stamp_id = 3 then
			status = "Closed-out"
			stamp_id = "Closed"
		ELSEIF obj.stamp_id = 1 then
			status = "Released"
			stamp_id = "Released"
		ELSEIF obj.stamp_id = 4 then
			status = "Cancelled"
			stamp_id = "Cancelled"
		ELSE
			status = "Approved"
			stamp_id = "Approved"
		END IF

			str = ""
			str = str & "<table><b>"
		IF objType = "DEL" then
			str = str & "<th id='PrPanel' colspan = '2'>Delivery Order Status Panel</th>"
		Else
			str = str & "<th id='PrPanel' colspan = '2'>Award Status Panel</th>"
		End If
			str = str &"<tr> <th>SAP PO Number:</td> <td colspan = '2'>"
		IF awd.sap = "<I>Unavailable</I>" THEN
			str = str & awd.sap
		ELSE
			str = str &"<a href = 'sapPo.asp?doc_no="& awd.sap &"'target= '_self'> " & awd.sap & "</a>"
		END IF
			str = str &"</th>  </tr>"
			str = str & "<tr > <th>Current Status:	</th>			<td> " & status & "</td>  </tr>"
			str = str & "<tr > <th>Description:		</th>			<td> " & obj.description & " </td>  </tr>"
			str = str & "<tr > <th>Cur. SPS User:	</th>			<td> " & obj.fullName & "</td>  </tr>"
			str = str & "<tr > <th>SPS User Title:	</th>			<td> " & user.title & "</td>  </tr>"
			str = str & "<tr > <th>SPS User Phone:	</th>			<td> " & user.phone & " </td>  </tr>"
			str = str & "<tr > <th>SPS User FAX:	</th>			<td> " & user.fax & "</td>  </tr>"
			str = str & "<tr > <th>SPS User Email:	</th>			<td>"  & user.email & "</td>  </tr>"
			str = str & "<tr > <th>Ko Name:			</th>			<td>"
		IF cntct.pcoName = "" THEN
			str = str &  ko.name
		ELSE
			str = str & cntct.pcoName
		END IF
			str = str & "</td>  </tr>"
			str = str & "<tr > <th>Ko Phone:		</th>			<td> " & ko.phone & "</td>  </tr>"
			str = str & "<tr > <th>Award Date:		</th>			<td> " & obj.awdDt & "</td>  </tr>"
			str = str & "<tr > <th>Effective Date:	</th>			<td> " & obj.applDt & "</td>  </tr>"
		IF obj.stamp_id = 3 THEN
			str = str & "<tr > <th>Retention Date:  </th>			<td> "
			str = str & awd.archiveDt
			str = str & "</td> </tr>"
			str = str & "<tr > <th>Destruction date:  <br/>Accession No:<br/>Location:<br/>Box Number:<br/>Shipped Date<br/>Details<br/>Request Date: <br/>Returned Date:</th>  <td><pre><b>"& awd.cloDt &"</b></pre></td> </tr>"
			str = str & "</table>"
		ELSE
			str = str & "</table>"
		END IF
getDocData = str

SET awd_id = NOTHING
SET obj = NOTHING
SET cntct = NOTHING
SET objDat = NOTHING
SET user = NOTHING
SET awd = NOTHING
SET uid = NOTHING
SET ko = NOTHING
End Function


'*f14:------------------------------------------------------------------------------------------------------------------------------------------'


function getDocList(doc_no, conn)
On Error Resume Next
Dim docList(1024)
Dim docNo
dim count
Dim result

docNo = doc_no
count = 0

SET objCmd = Server.CreateObject("ADODB.Command")
	objCmd.ActiveConnection = objConn
	objCmd.CommandTimeout = 10
	objCmd.CommandType = adCmdText
	objCmd.CommandText = "exec Query_getDocList ?"

SET objPar = objCmd.CreateParameter("@doc_no",200,1,32,docNo)
	objCmd.Parameters.Append objPar

SET objRS = objCmd.Execute()
		WHILE(objRS.EOF = False)
			docList(count) = objRS("obj_usr_num")
			count=count + 1
		objRS.MoveNext
 		WEND
 	objRS.Close

 FOR ii = 0 TO count-1
	getTableList trim(docList(ii)),ii

 NEXT


SET objCmd = NOTHING
SET objPar = NOTHING
SET objRS = NOTHING
 end Function


'*f15:------------------------------------------------------------------------------------------------------------------------------------------'


Function getDocObject(docNo)
 on error resume next

 SET objCmd = Server.CreateObject("ADODB.Command")
 	objCmd.CommandTimeout = 10
 	objCmd.ActiveConnection = objConn
 	objCmd.CommandType = adCmdText
 	objCmd.CommandText = "exec Query_getDocData ?"
 SET objPar = objCmd.CreateParameter("@doc_no",200,1,24,docNo)
 	objCmd.Parameters.Append objPar

 SET objRS = objCmd.Execute()
 SET this = new docObject
 		IF(objRS.EOF = False) THEN
 			this.docNum = objRS("docno")
 			this.fullname=objRS("fullname")
 			this.description =objRS("description")
 			this.owner = objRS("owner")
 			this.objType = objRS("object_type")
 			this.approval = objRS("approval")
 			this.cancelled = objRS("cancelled")
 			this.released = objRS("released")
 			this.req_dt = objRS("req_date")
 			this.sol_dt = objRS("sol_date")
 			this.awd_dt = objRS("awd_date")
 			this.chg_dt = objRS("chg_date")
 			this.uid = objRS("uid")
 			this.clo_dt = objRS("clo_dt")
 			this.apl_dt = objRS("apl_date")
			this.creator = objRS("creator")
 			this.approvalCode = this.approval+this.released+this.cancelled




 				SELECT case this.approvalCode
 				 	case 110
 				 		this.status = "Released"
 				 	case 100
 				 		this.status = "Approved"
 				 	case 001
 				 		this.status = "Cancelled"
 				 	case ""
 				 		this.status = "Unreleased"
 	 				END SELECT
 		END IF

 	objRS.Close
 SET objRS = NOTHING
 SET objCmd = NOTHING
 SET objPar = NOTHING
 	SET getDocObject = this
  end function


'*f16:------------------------------------------------------------------------------------------------------------------------------------------'


function getFundAmt(objId)
on error resume next
 set this = new ClinData


 SET objCmd = Server.CreateObject("ADODB.Command")
 	objCmd.ActiveConnection = objConn
 	objCmd.CommandTimeout = 10
 	objCmd.CommandType = adCmdText
 	objCmd.CommandText = "exec Query_getClinObject ?"

 SET objPar = objCmd.CreateParameter("@obj_id",3,1,10,objId)
 	objCmd.Parameters.Append objPar

 SET objRS = objCmd.Execute()
        		IF(objRS.EOF = False) THEN
        			this.fundAmt = objRS("amount")
        			this.optAmt = objRS("tac_amt")
        		ELSE
        			this.fundAmt = "<i>Not Available</i>"
        			this.optAmt = "<i>Not Available</i>"
        		END IF
        	objRS.Close
        	set getFundAmt = this


 SET objCmd = NOTHING
 SET objPar = NOTHING
 SET objRS = NOTHING
     end function


'*f17:------------------------------------------------------------------------------------------------------------------------------------------'


     Function getFunding(docNo)
	 on error resume next
	 Dim count
	 Dim totalCost(1024)
	 Dim this(1024)
	 count = 0

	 	SET objCmd = Server.CreateObject("ADODB.Command")
	 		objCmd.ActiveConnection = objConn
	 		objCmd.CommandText = "exec Query_getFunding ?"
	 		objCmd.CommandTimeout = 10
	 		objCmd.CommandType = adCmdText

	 	SET objPar=objCmd.CreateParameter("@doc_no",200,1,32,docNo)
	 	objCmd.Parameters.Append objPar

	 	SET objRS=objCmd.Execute()
	 		WHILE(objRS.EOF = FALSE)
	 			totalCost(count) = objRS("totalCost")
	 			response.write(totalCost(count) & "<br/>")
	 		count = count +1
	 		objRS.MoveNext
	 		WEND

	 objRS.Close
	 SET objCmd = Nothing
	 SET objPar = Nothing
	 SET objRS = Nothing

	 End Function


'*f18:------------------------------------------------------------------------------------------------------------------------------------------'


Function getLocation(objId)
	on error resume next
	Dim curObjId
	Dim location
	Dim parent_id
	Dim description

	curObjId = objId


SET objCmd = Server.CreateObject("ADODB.Command")
	objCmd.ActiveConnection = objConn
	objCmd.CommandTimeout = 10
	objCmd.CommandType = adCmdText
	objCmd.CommandText = "exec Query_getLocation ?"


SET this = new spsLocation

SET objPar = objCmd.CreateParameter("@obj_id",3,1,10,curObjId)
	objCmd.Parameters.Append objPar

SET objRS = objCmd.Execute()
	IF(objRS.EOF = FALSE) THEN
		this.parent_id = objRS("parent_id")
		this.description = objRS("description")
	END IF

objRS.Close

SET objRS   = NOTHING
SET objPar  = NOTHING
SET objCmd  = NOTHING

SET getLocation = this
End Function


'*f19:------------------------------------------------------------------------------------------------------------------------------------------'


Function getMasterDocNo(objId)
On error resume next

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandText = "exec Query_getMasterDocno ?"
		objCmd.CommandTimeout = 10
		objCmd.CommandType = adCmdText

	SET objPar=objCmd.CreateParameter("@obj_id",3,1,10,objId)
	objCmd.Parameters.Append objPar

	SET objRS=objCmd.Execute()
SET this = new wkldData
		IF(objRS.EOF = False) THEN
			this.masterDoc = objRS("doc")
			this.docType = objRS("action")
		ELSE
			this.masterDoc = "unavailable"
			this.docType = "unavailable"
		END IF
	objRS.Close

	SET getMasterDocNo = this

SET objCmd = NOTHING
SET objPar = NOTHING
SET objRS = NOTHING
End Function


'*f20:------------------------------------------------------------------------------------------------------------------------------------------'


Function getModPanel(docNo)
on error resume next
obj_id = getObjId(docNo)
set objDat = getDocObject(docNo)
set obj = objectData(docNo)
set user = getUserData(objDat.uid)
set awd = getAward(obj_id)
chgRsn = getChangeReason(obj_id)
set ko = getContactData(awd.koOrgId, awd.koAddId)

		IF obj.stamp_id = 3 then
			status = "Closed-out"
			stamp_id = "Closed"
		ELSEIF obj.stamp_id = 1 then
			status = "Released"
			stamp_id = "Released"
		ELSEIF obj.stamp_id = 4 then
			status = "Cancelled"
			stamp_id = "Cancelled"
		ELSE
			status = "Approved"
			stamp_id = "Approved"
	END IF


	str = ""
	str = str &"<table><b><small>"
	str = str &"<th id='PrPanel' colspan = '3'>Modification Status Panel</th>"
	str = str &"<tr> <th>SAP PO Number:</td> <td colspan = '2'>"
IF awd.sap = "<I>Unavailable</I>" THEN
	str = str & awd.sap
ELSE
	str = str &"<a href = 'sapPo.asp?doc_no="& awd.sap &"'target= '_self'> " & awd.sap & "</a>"
END IF
	str = str &"</th>  </tr>"
	str = str &"<tr> <th>Current Status:</td> <td colspan = '2'> " & status & " </th>  </tr>"
	str = str &"<tr> <th>Description: </td> <td colspan = '2'>  " & obj.description & " </th>  </tr>"
	str = str &"<tr> <th>Current SPS User: </td> <td colspan = '2'>" & obj.fullName & "</th>  </tr>"
	str = str &"<tr> <th>SPS User Title:</td> <td colspan = '2'> " & user.title & "</th>  </tr>"
	str = str &"<tr> <th>SPS User Phone:</td> <td colspan = '2'> " & user.phone & " </th>  </tr>"
	str = str &"<tr> <th>SPS User Fax:</td> <td colspan = '2'>  " & user.fax & " </th>  </tr>"
	str = str &"<tr> <th>SPS User Email:</td> <td colspan = '2'> " & user.email & " </th>  </tr>"
	str = str &"<tr> <th>Ko Name:</td> <td colspan = '2'>" & ko.name & " </th>  </tr>"
	str = str &"<tr> <th>Ko Phone:</td> <td colspan = '2'> " & ko.phone & " </th>  </tr>"
	str = str &"<tr> <th id='PrPanel'></th> <th id='PrPanel'> Basic </th><th id='PrPanel'> Modification </th></tr>"
	str = str &"<tr> <th> Award Date: </th> <td>"& obj.awdDt &"</td><td> " & obj.applDt & " </td></tr>"
	str = str &"<tr> <th> Effective Date: </th> <td>" & awd.relDate  & " </td><td> " & obj.chgDt & "</td></tr>"
	str = str &"<tr> <th> Change:<br/>(From SF-30 Block 14)</th> <td colspan = '2'> " & chgRsn & " </td>  </tr>"
If obj.stamp_id = 3 THEN
	str = str &"<tr> <th> Retention Date: </th> <td colspan = '2'>"& awd.archiveDt &"  </td>  </tr>"
	str = str &"<tr> <th> Destruction Date:<br/>Accession No:<br/>Location:<br/>Box Number:<br/>Shipped Date:<br/>Details<br/>Request Date:<br/> Returned Date:</th> <td colspan = '2'> <pre><b>" & awd.cloDt & "</b> </pre> </td>  </tr>"
	str = str &"</small></table>"
ELSE
	str = str &"</small></table>"
END IF

getModPanel = str

SET awd_id = NOTHING
SET objDat = NOTHING
SET obj = NOTHING
SET user = NOTHING
SET awd = NOTHING
SET chgRsn = NOTHING
SET ko = NOTHING

End Function


'*f21:------------------------------------------------------------------------------------------------------------------------------------------'


Function getObjData(docNo)
on error resume next

SET objCmd = Server.CreateObject("ADODB.Command")
	objCmd.CommandTimeout = 10
	objCmd.ActiveConnection = objConn
	objCmd.CommandType = adCmdText
	objCmd.CommandText = "exec Query_getDskObj ?"

SET objPar = objCmd.CreateParameter("@doc_no",200,1,24,docNo)
	objCmd.Parameters.Append objPar

SET objRS = objCmd.Execute()

SET this = new objectID
	IF (objRS.EOF = False) THEN
				this.object_id= objRS("object_id")
				this.description = objRS("description")
				this.comments = objRS("comments")
				this.koNoteId = objRS("koNoteId")
				this.requisitionDate = objRS("req_dt")

			ELSE
			this.object_id = ""
			this.description = ""
			this.comments = ""
			this.koNoteId = ""
			this.requisitionDate =""

			END IF
	objRS.Close

SET objRS = Nothing
SET objPar = Nothing
SET objCmd = Nothing

SET getObjData=this
End Function


'*f22:------------------------------------------------------------------------------------------------------------------------------------------'


Function getObjId(docNo)
Dim objid
on error resume next

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandText = "exec Query_getObjId ?"
		objCmd.CommandTimeout = 10
		objCmd.CommandType = adCmdText

	SET objPar=objCmd.CreateParameter("@docNo",200,1,32,docNo)
	objCmd.Parameters.Append objPar

	SET objRS=objCmd.Execute()

		IF(objRS.EOF = FALSE)THEN
			objid = objRS("obj_id")
		ELSE
			objid = -1
		END IF
	objRS.Close


SET objCmd = Nothing
SET objPar = Nothing
SET objRS = Nothing

getObjId = objid

END Function


'*f23:------------------------------------------------------------------------------------------------------------------------------------------'


Function getObjType(objId)

On Error Resume Next

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandType=adCmdText
		objCmd.CommandText = "exec Query_getObjType2 ?"
	SET objPar = objCmd.CreateParameter("@obj_id",3,1,10, objId)
		objCmd.Parameters.Append objPar

	SET objRS = objCmd.Execute()
		IF(objRS.EOF = FALSE) THEN
			objType = objRS("objType")
		ELSE
			objType = "Unavailable"
		END IF


	objRS.Close

	SET objCmd = NOTHING
	SET objPar = NOTHING
	SET objRS = NOTHING
	getObjType = objType
end function


'*f24:------------------------------------------------------------------------------------------------------------------------------------------'


Function getObjType2(docNo)

On Error Resume Next

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandType=adCmdText
		objCmd.CommandText = "exec Query_getObjType ?"
	SET objPar = objCmd.CreateParameter("@doc_no",200,1,32, docNo)
		objCmd.Parameters.Append objPar

	SET objRS = objCmd.Execute()
		IF(objRS.EOF = FALSE) THEN
			objType = ("objType")
		ELSE
			objType = "Unavailable"
		END IF
	objRS.Close

	SET objCmd = NOTHING
	SET objPar = NOTHING
	SET objRS = NOTHING
	getObjType = objType
end function


'*f25:------------------------------------------------------------------------------------------------------------------------------------------'


Function getOrgName(orgId)
on error resume next


		SET objCmd = Server.CreateObject("ADODB.Command")
			objCmd.ActiveConnection = objConn
			objCmd.CommandText = "exec Query_getOrgName ?"
			objCmd.CommandTimeout = 10
			objCmd.CommandType = adCmdText

		SET objPar=objCmd.CreateParameter("@org_id",3,1,10,orgId)
			objCmd.Parameters.Append objPar

		SET objRS = objCmd.Execute
		IF(objRS.EOF = False) THEN
			orgName = objRS("org_name")
			ELSE
			orgName = "Unavailable"
			END IF
		objRS.Close

getOrgName = orgName

SET objCmd = NOTHING
SET objPar = NOTHING
SET objRS = NOTHING

End Function


'*f26:------------------------------------------------------------------------------------------------------------------------------------------'


Function getPaltInfo()
Dim paltCd(60)
Dim paltDesc(60)
Dim paltDays(60)
Dim str
Dim count

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandText = "exec Query_getPaltInfo"
		objCmd.CommandTimeout = 10

	SET objRS = objCmd.Execute()
		WHILE(objRS.EOF = False)

			paltCd(count) = objRS("paltCd")
			paltDesc(count) = objRS("paltDesc")
			paltDays(count) = objRS("paltDays")
			count = count +1
			objRS.MoveNext
		WEND


str = ""
str = str & "<table>"
str = str & "<tr>"
str = str & "	<th class='paltCd'>PALT Code</th> <th class= 'paltDesc'> PALT Description </th> <th class = 'paltDays'>PALT Days</th>"
str = str & "</tr>"
	For ii = 0 to count -1
	result = ii mod 2
	IF result = 0 THEN tr = "<tr style='background-color:#E6E6E6'>" ELSE tr ="<tr style='background-color:white'>" END IF
	 		str = str & tr
	 		str = str & "<td>" & paltCd(ii) & "</td>"
	 		str = str & "<td>" & paltDesc(ii) & "</td>"
	 		str = str & "<td>" & paltDays(ii) & "</td>"
	 		str = str & "</tr>"
	Next
str = str & "</table>"
getPaltInfo = str

End Function

Dim paltCodes(60)

Function getPaltList()
Dim count
	count = 0
	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandText = "exec Query_getPaltInfo"
		objCmd.CommandTimeout = 10

	SET objRS = objCmd.Execute()
	While (objRS.EOF = False)
		paltCodes(count) = objRS("paltCd")
	count = count + 1
	objRS.MoveNext
	Wend

End Function


'*f27:------------------------------------------------------------------------------------------------------------------------------------------'


Function getPrData(docNo)
on error resume next
	objId = getObjId(docNo)
	uid = getUid(objId)
	set user = getUserData(uid)
	set obj= objectData(docNo)
	docLen = LEN(docNo)
		IF obj.stamp_id = 3 then
			status = "Closed-out"
			stamp_id = "Closed"
		ELSEIF obj.stamp_id = 1 then
			status = "Released"
			stamp_id = "Released"
		ELSEIF obj.stamp_id = 4 then
			status = "Cancelled"
			stamp_id = "Cancelled"
		ELSE
			status = "Approved"
			stamp_id = "Approved"
	END IF

			str = ""
			str = str & "<table><b><small>"
			IF docLen > 10 THEN
			str = str & " 		<th id = 'PrPanel' colspan = '2'>PR Modification Status Panel</th>"
			ELSE
			str = str & "	    <th id='PrPanel' colspan = '2'>Purchase Request Status Panel</th>"
			END IF
			str = str & "			<tr> <th width='25%'>Current Status:</th>		<td> " & status & " </td>  </tr>"
			IF docLen > 10 THEN
			str = str & " 	<tr> <th>Release Date:	</th>		<td> "
			IF obj.stamp = 4 THEN
			str = str & "<i>Not Applicable</i> "
			ELSE
			str = str & obj.applDt
			END IF
			str = str & "</td></tr>"
			END IF
			str = str & "			<tr> <th>Request Date:	</th>		<td> " & obj.reqDt & "</td>  </tr>"
			str = str & "			<tr> <th>Description:	</th>		<td> " & obj.description & "</td> </tr>"
			str = str & "			<tr> <th>Current User:	</th>		<td> " & obj.fullname & " </td>  </tr>"
			str = str & "			<tr> <th>User Title:	</th>		<td> " & user.title & "  </td>  </tr>"
			str = str & "			<tr> <th>User Phone:	</th>		<td> " & user.phone & "</td>  </tr>"
			str = str & "			<tr> <th>User Fax:		</th>  		<td> " & user.fax & " </td>  </tr>"
			str = str & "			<tr> <th>User Email:		</td>  	<td> " & user.email & "</td>  </tr>"
			str = str & "<tr> <th>Comments:		</th>"
			str = str & "							<td>" & obj.comments
			str = str & "</td>  </tr>"
			str = str & "</small></b></table>"
	getPrData = str

SET user = NOTHING
SET obj = NOTHING
SET objId = NOTHING
SET uid = NOTHING

End Function


'*f28:------------------------------------------------------------------------------------------------------------------------------------------'


Function getRelated(doc,objId,cmdText)
On Error Resume Next
Dim objConnection
	Dim count
	Dim obj_id
	Dim docNumber(2048)
	Dim object(2048)
	Dim obj_type(2048)
	Dim applied(2048)
	Dim cancelled(2048)
	Dim conformed(2048)
	Dim jj
	Dim docArray()
	ReDim docArray(0)
	Dim typeArray()
	ReDim typeArray(0)
	Dim idArray()
	ReDim idArray(0)


	SET objCommand = Server.CreateObject("ADODB.Command")
		objCommand.ActiveConnection = objConn
		objCommand.CommandText = cmdText
		objCommand.CommandType = adCmdText
		objCommand.CommandTimeout = 10

	SET objParameter = objCommand.CreateParameter("@obj_id",3,1,10,objId)
		objCommand.Parameters.Append objParameter

	SET objRecordSet = objCommand.Execute()

	jj = 0
		WHILE (objRecordSet.EOF = False)

				docNumber(count) = objRecordSet("DOC_NO")
				object(count) = objRecordSet("OBJ_ID")
				obj_type(count) = objRecordSet("OBJ_TYPE")
				applied(count) = objRecordSet("APPLIED")
				cancelled(count) = objRecordSet("CANCELLED")
				conformed(count) = objRecordSet("CONFORMED")
			IF docNumber(count) <> docNumber(count-1) THEN
				ReDim preserve typeArray(Ubound(typeArray) +1)
					typeArray(jj) = obj_type(count)

				ReDim preserve docArray(Ubound(docArray)+1)
					docArray(jj) = docNumber(count)

				ReDim preserve idArray(Ubound(idArray) +1)
					idArray(jj) = object(count)
					jj = jj +1
					END IF
			count=count+1
			objRecordSet.MoveNext

		WEND

		objRecordSet.Close

	SET objCommand = NOTHING
	SET objParameter = NOTHING

for ii = 0 to Ubound(docArray)
	docNo = docArray(ii)
	thisType = trim(typeArray(ii))
	simpType = getThisType(thisType,docNo)

SELECT CASE doc
			CASE "REQ"
				IF simpType = "REQ" THEN
					response.write("<a href = 'panelFunctions.asp?doc_no="& docNo &"'target= '_self'>" & TRIM(docNo) & "</a><br/>")
				END IF
			CASE "SOL"
				IF simpType = "SOL" THEN
					response.write("<a href = 'panelFunctions.asp?doc_no="& docNo &"'target= '_self'>"& TRIM(docNo) & "</a><br/>")
				ELSEIF simpType = "AMD" THEN
					response.write("<a href = 'panelFunctions.asp?doc_no="& docNo &"'target= '_self'>"& TRIM(right(docNo,4)) & "</a><br/>")
				END IF
			CASE "AWD"
				IF simpType = "AWD" THEN
					response.write("<a href = 'panelFunctions.asp?doc_no="& docNo &"'target= '_self'>" & TRIM(docNo) & "</a><br/>")
				ELSEIF simpType= "MOD" THEN
					response.write("<a href = 'panelFunctions.asp?doc_no="& docNo &"'target= '_self'>"& TRIM(right(docNo,6)) & "</a><br/>")
				END IF
			CASE "DEL"
				IF simpType = "DEL" THEN
					response.write("<a href = 'panelFunctions.asp?doc_no="& docNo &"'target= '_self'>"& TRIM(right(docNo,4)) & "</a><br/>")

				ELSEIF simpType = "DOM" THEN
					response.write("<a href = 'panelFunctions.asp?doc_no="& docNo &"'target= '_self'>"& TRIM(right(docNo,6)) & "</a><br/>")

				END IF
END SELECT

next

End Function


'*f29:------------------------------------------------------------------------------------------------------------------------------------------'


Function getRelatedDocs(obj_id)

		ON ERROR RESUME NEXT

		Dim arrConn
		Dim arrCmd
		Dim arrPar
		Dim arrRS
		Dim count
		Dim doc_no(2048)
		Dim doc_type(2048)
		Dim jj
		Dim docArray()
		Dim typeArray()
		ReDim docArray(0)
		ReDim typeArray(0)
		count = 0
			jj = 0



			SET arrCmd = Server.CreateObject("ADODB.Command")
				arrCmd.ActiveConnection = objConn
				arrCmd.CommandType = adCmdText
				arrCmd.CommandText = "exec Query_get_ancestors ?"
				arrCmd.CommandTimeount = 10
			SET arrPar = arrCmd.CreateParameter("@obj_id",3,1,12,obj_id)
				arrCmd.Parameters.append arrPar

			SET arrRS = arrCmd.Execute()
				WHILE(arrRS.EOF = False)
					doc_no(count) = arrRS("DOC_NO")
					doc_type(count) = arrRS("OBJ_TYPE")
					doc_type(count) = trim(doc_type(count))
					IF doc_no(count) <> doc_no(count-1) THEN
					ReDim preserve docArray(Ubound(docArray)+1)
						 docArray(jj) = doc_no(count)
					ReDim preserve typeArray(Ubound(typeArray)+1)
						 typeArray(jj) = getThisType(doc_type(count),doc_no(count))
					jj=jj+1
					END IF
					count=count +1
					arrRS.MoveNext
				WEND
				arrRS.Close


			SET arrPAR = NOTHING
			SET arrCmd = NOTHING

			SET arrRS = NOTHING

	SET arrCmd2 = Server.CreateObject("ADODB.command")
		arrCmd2.ActiveConnection= objConn
		arrCmd2.CommandText = "exec Query_get_descendants ?"
		arrCmd2.CommandType = adCmdText

	SET arrPar2 = arrCmd2.CreateParameter("@obj_id",3,1,12,obj_id)
		arrCmd2.Parameters.Append arrPar2

				SET arrRS2 = arrCmd2.Execute()
					WHILE(arrRS2.EOF = False)
						doc_no(count) = arrRS2("DOC_NO")
						doc_type(count) = arrRS2("OBJ_TYPE")
						doc_type(count) = trim(doc_type(count))
						IF doc_no(count) <> doc_no(count-1) THEN
						ReDim preserve docArray(Ubound(docArray)+1)
							 docArray(jj) = doc_no(count)
						ReDim preserve typeArray(Ubound(typeArray)+1)
							 typeArray(jj) = getThisType(doc_type(count),doc_no(count))
						jj=jj+1
						END IF
						count=count +1
            			arrRS2.MoveNext
				WEND

		arrRS2.Close


	SET arrCmd2 = NOTHING
	SET arrPar2 = NOTHING


Dim ii
Dim delCnt
Dim solCnt
Dim awdCnt
Dim prCnt
Dim doCnt
ii=0
delCnt=0
solCnt = 0
awdCnt = 0
prCnt = 0
doCnt = 0
for each x in typeArray

	SELECT CASE x
		CASE "DEL"
				ReDim preserve delArray(Ubound(delArray)+1)
				ReDim preserve delOnly(Ubound(delOnly)+1)
					delArray(delCnt) = docArray(ii)
					delOnly(doCnt) = docArray(ii)
					delCnt = delCnt +1
					doCnt = doCnt +1
		CASE "DOM"
				ReDim preserve delArray(Ubound(delArray)+1)
					delArray(delCnt) = docArray(ii)
					delCnt = delCnt +1
		CASE "AWD"
				ReDim preserve awdArray(Ubound(awdArray)+1)
					awdArray(awdCnt) = docArray(ii)
					awdCnt = awdCnt + 1
		CASE "MOD"
				ReDim preserve awdArray(Ubound(awdArray)+1)
					awdArray(awdCnt) = docArray(ii)
					awdCnt = awdCnt + 1

		CASE "SOL"
				ReDim preserve solArray(Ubound(solArray)+1)
					solArray(solCnt) = docArray(ii)
					solCnt = solCnt +1
		CASE "AMD"
				ReDim preserve solArray(Ubound(solArray)+1)
					solArray(solCnt) = docArray(ii)
					solCnt = solCnt +1
		CASE "REQ"
				ReDim preserve prArray(Ubound(prArray)+1)
					prArray(prCnt) = docArray(ii)
					prCnt = prCnt +1

	END SELECT
	ii=ii+1
Next


End Function


'*f30:------------------------------------------------------------------------------------------------------------------------------------------'


Function getSapObj(docNo)
on error resume next
Dim this(1024)
Dim count
count = 0


SET objCmd = Server.CreateObject("ADODB.Command")
	objCmd.CommandTimeout = 10
	objCmd.ActiveConnection = objConn
	objCmd.CommandType = adCmdText
	objCmd.CommandText = "exec Query_getSapObjs ?"
SET objPar = objCmd.CreateParameter("@sapNo",200,1,24,docNo)
	objCmd.Parameters.Append objPar

SET objRS = objCmd.Execute()

WHILE(objRS.EOF = False)
			SET this(count) = new docObject
			this(count).docNum = objRS("doc_no")
			this(count).objId = objRS("obj_id")

		count=count + 1
	objRS.MoveNext
WEND
	objRS.Close


SET objRS = NOTHING
SET objCmd = NOTHING
SET objPar = NOTHING

	for ii = 0 to count -1
	getTableList this(ii).docNum, ii
	next
 end function


'*f31:------------------------------------------------------------------------------------------------------------------------------------------'


Function getSapObjs(sap_no,conn)
on error resume next
	Dim objId(1024)
	Dim count
		count = 0

	SET objCmd = Server.CreateObject("ADODB.Command")
	objCmd.ActiveConnection = objConn
	objCmd.CommandText = "exec Query_getSapObjs ?"
		objCmd.CommandTimeout = 10
	SET objPar = objCmd.CreateParameter("@sapNo",200,1,32,sap_no)
		objCmd.Parameters.Append objPar
	SET objRS = objCmd.Execute()
			WHILE(objRS.EOF = FALSE)
				objId(count) = objRS("obj_id")
				count = count +1
				objRS.MoveNext
			WEND

	objRS.Close
	response.write(count)

SET objRS = NOTHING
SET objPar = NOTHING
SET objCmd = NOTHING

End Function


'*f32:------------------------------------------------------------------------------------------------------------------------------------------'


Function getSapTable()
response.write("<div class='container'>")
response.write("<table class = 'listItems'>")
response.write("	<tr>")
response.write("	<th class='docNo'>Document Number</th>")
response.write("	<th class='fullname'>Owner</th>")
response.write("	<th class='status'>Status</th>")
response.write("	<!--<th class='reqDt'>Requisition</th>-->")
response.write("	<th class='description'>Description</th>")
response.write("	<th class='clinType'>Type</th>")
response.write("	</tr>")
getSapObj(doc_no)
response.write("</table>")
response.write("</div><!--Container-->")
End Function


'*f33:------------------------------------------------------------------------------------------------------------------------------------------'


Function getSolicitation(doc_no)
on error resume next
Dim docData
set docData = getDocObject(doc_no)
set user = getUserData(docData.uid)
objId = getObjId(doc_no)
rsn = getChangeReason(objId)
stamp_id = docData.status

			str = str & "<table id = 'PrPanel'><b>"
			IF LEN(doc_no) > 16 THEN
			str = str & " <th id='WkldPanel' colspan = '2'>Solicitation Amendment Status Panel</th>"
			ELSE
			str = str & " <th id='WkldPanel' colspan = '2'>Solicitation Status Panel</th>"
			END IF
			str = str & "	<tr> <th>Current Status:	</th>		<td>" & docData.status & "</td>  </tr>"
			str = str & "	<tr> <th>Issue Date:		</th>		<td>" & docData.sol_dt & "</td>  </tr>"
			str = str & "	<tr> <th>Closing Date:		</th>		<td>" & docData.clo_dt & "</td>  </tr>"
			str = str & "	<tr> <th>Description:		</th>		<td>" & docData.description & "</td>  </tr>"
			str = str & "	<tr> <th>Current SPS User:	</th>		<td>" & user.name & "</td>  </tr>"
			str = str & "	<tr> <th>SPS User Title:	</th>		<td>" & user.title & "</td>  </tr>"
			str = str & "	<tr> <th>User Phone:		</th>		<td>" & user.phone & "</td>  </tr>"
			str = str & "	<tr> <th>User Fax:			</th>  		<td>" & user.fax & "</td>  </tr>"
			str = str & "	<tr> <th>User Email:		</th>  		<td>" & user.email & "</td>  </tr>"
				IF LEN(doc_no) > 16 THEN
					str = str & "<tr><th> Applied Date:	</th>		<td>" & docData.apl_dt & "</td> </tr>"
					str = str & "<tr><th> Effective Date:</th>		<td>" & docData.chg_dt & "</td> </tr>"
					str = str & "<tr><th> Amendment: (From SF-30 <br/> Block 14:</th><td>" & rsn & "</td></tr>"
				END IF
			str = str & "	</b></table>"

getSolicitation = str
End Function


'*f34:------------------------------------------------------------------------------------------------------------------------------------------'


Function getTable(conn, doc_no)
Dim Loc
SELECT Case conn
	Case chlk.connection
		Loc = "<i>China Lake Database Connected</i>"
	Case orl.connection
		Loc = "<i>Orlando Database Connected</i>"
	Case pax.connection
		Loc = "<i>Pax River Database Connected</i>"
	Case Else
		Loc = ""
END SELECT
response.write("<div class='container'>")
response.write("<div class='tableTag'>" & Loc & "</div>")
response.write("<table>")
response.write("	<tr>")
response.write("	<th class='docNo'>Document Number</th>")
response.write("	<th class='fullname'>Owner</th>")
response.write("	<th class='status'>Status</th>")
response.write("	<!--<th class='reqDt'>Requisition</th>-->")
response.write("	<th class='description'>Description</th>")
response.write("	<th class='clinType'>Type</th>")
response.write("	</tr>")
getDocList doc_no, conn
response.write("</table>")
response.write("</div><!--Container-->")
response.write("<br/><br/><br/>")
End Function


'*f35:------------------------------------------------------------------------------------------------------------------------------------------'


 Function getTableList(docNo, num)
 on error resume next
 	obj_id = getObjId(docNo)
 	set obj = objectData(docNo)
result = num mod 2


		IF obj.stamp_id = "" THEN
			status = ""
			stamp_id = ""
		ELSEIF obj.stamp_id  = 3 then
			status   = "Closed-out"
			stamp_id = "Closed"
		ELSEIF obj.stamp_id = 1 then
			status   = "Released"
			stamp_id = "Released"
		ELSEIF obj.stamp_id = 4 then
			status 	 = "Cancelled"
			stamp_id = "Cancelled"
		ELSE
			status 	 = "Approved"
			stamp_id = "Approved"
	END IF

IF result = 0 THEN tr = "<tr style='background-color:#E6E6E6'>" ELSE tr ="<tr style='background-color:white'>" END IF
	IF num >= 0 THEN
 		str = ""
 		str = str & tr
 		str = str & "<td><a href = 'panelFunctions.asp?doc_no="& docNo &"'target= '_self'> " & docNo & "</a></td>"
 		str = str & "<td>" & obj.fullname & "</td>"
 		str = str & "<td>" & stamp_id & "</td>"
 	'	str = str & "<td>" & obj.reqDt & "</td>" '
 		str = str & "<td>" & obj.description & "</td>"
 		str = str & "<td>" & getThisType(obj.objType,docNo) & "</td>"
 		str = str & "</tr>"
 	ELSE
 		str = str & "<td>No Documents Located</td>"
 	END IF

 	response.write(str)

 SET obj = NOTHING
 	SET obj_id = NOTHING
End Function


'*f36:------------------------------------------------------------------------------------------------------------------------------------------'


Function getThisType(obj, num)
on error resume next
Dim this
Dim objType
Dim doc

doc = num
this = obj
	Select Case this
			case "18M"
				objType = "AMD"
			case "26D"
				objType = "DEL"
			case "26M"
				objType = "MOD"
			case "2BN"
				objType = "MOD"
			case "2ON"
				objType = "MOD"
			case "33M"
				objType = "AMD"
			case "33N"
				objType = "MOD"
			case "49A"
				objType = "AWD"
			case "49D"
				objType = "DEL"
			case "49M"
				objType = "AMD"
			case "49N"
				objType = "MOD"
			case "49O"
				objType = "DOM"
			case "49S"
				objType = "SOL"
			case "9ON"
				objType = "MOD"
			case "A26"
				objType = "DEL"
			case "A2N"
				objType = "DOM"
			case "A33"
				objType = "AWD"
			case "A49"
				objType = "DEL"
			case "A55"
				objType = "DEL"
			case "A5N"
				objType = "DOM"
			case "A9N"
				objType = "DOM"
			case "B55"
					objType = "AWD"
			case "B5M"
					IF mid(doc,11,1) = "F" THEN
						objType = "MOD"
				    ELSEIF mid(doc,11,1) = "P" THEN
						objType = "MOD"
					ELSE
						objType = "DOM"
					END IF

			case "BCM"
				objType =  "DOM"
			case "BPA"
				objType =  "AWD"
			case "BPC"
				objType =  "DEL"
			case "BPM"
				objType =  "MOD"
			case "DEL"
				IF mid(doc,11,1) = "F" THEN
					objType =  "AWD"
				ELSEIF mid(doc,11,1) =  "P" THEN
					objType =  "AWD"
				ELSE
					objType = "DEL"
				END IF
			case "F26"
				objType =  "AWD"
			case "F33"
				objType =  "SOL"
			case "G2B"
				objType =  "AWD"
			case "G2O"
				objType =  "AWD"
			case "REQ"
				objType =  "REQ"
			case "RFQ"
				objType =  "SOL"
			case "RQM"
				objType =  "REQ"
			case "X2A"
				objType =  "AWD"
			case "X2O"
				objType =  "AWD"
			case "X49"
				objType =  "AWD"
			case "X55"
				objType =  "DEL"
			case "XB5"
				objType =  "AWD"
		Case Else
			objType ="unavailable"
	End select

	getThisType = objType
End Function


'*f37:------------------------------------------------------------------------------------------------------------------------------------------'


Function getUid(objId)
on error resume next

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandText = "exec Query_getUid ?"
		objCmd.CommandTimeout = 10
		objCmd.CommandType = adCmdText

	SET objPar=objCmd.CreateParameter("@obj_id",3,1,10,objId)
	objCmd.Parameters.Append objPar


	SET objRS=objCmd.Execute()
		IF(objRS.EOF = FALSE)THEN
			userId = objRS("uid")

		ELSE
			userId = ""
		END IF

objRS.Close

SET objCmd = Nothing
SET objPar = Nothing
SET objRS = Nothing


getUid = userId

END Function


'*f38:------------------------------------------------------------------------------------------------------------------------------------------'


function getUidFrmName(fullNm)
on error resume next

SET objCmd = Server.CreateObject("ADODB.Command")
	objCmd.ActiveConnection = objConn
	objCmd.CommandText = "exec Query_getUidFromName ?"
	objCmd.CommandType = adCmdText

SET objPar = objCmd.CreateParameter("@fullname", 200,1,32, fullNm)
	objCmd.Parameters.Append objPar

SET objRS = objCmd.Execute()
	IF(objRS.EOF = False) THEN
		userId = objRS("userId")
	ELSE
		userId ="<i>Unavailable<i>"
	END IF
	getUidFrmName = userId
	objRS.Close

	SET objCmd = NOTHING
	SET objPar = NOTHING
	SET objRS = NOTHING
End Function


'*f39:------------------------------------------------------------------------------------------------------------------------------------------'


Function getUserData(uid)
on error resume next

SET objCmd = Server.CreateObject("ADODB.Command")
	objCmd.ActiveConnection = objConn
	objCmd.CommandText = "exec Query_getUserData ?"
	objCmd.CommandTimeout = 10

SET objPar = objCmd.CreateParameter("@uid",200,1,24,uid)
	objCmd.Parameters.Append objPar

SET objRS = objCmd.Execute()
SET this = new Contact
	IF(objRS.EOF = False)THEN
		this.title = objRS("title")
		this.phone = objRS("phone")
		this.fax   = objRS("fax")
		this.email = objRS("email")
		this.name  = objRS("cntct_name")

	ELSE
		this.title = ""
		this.phone = ""
		this.fax = ""
		this.email = ""
		this.name = ""
	END IF
objRS.close

SET objRS = Nothing
SET objPar = Nothing
SET objCmd = Nothing
SET getUserData = this

End Function


'*f40:------------------------------------------------------------------------------------------------------------------------------------------'


function getVendorData(docNo)
on error resume next
Dim awd_id
Dim awd
Dim cageCd
Dim koOrg
Dim isuOrg
Dim vendOrg
Dim payOrg
Dim vend
Dim admin
Dim paying
Dim issue

awd_id = getObjID(docNo)
set awd = getAward(awd_id)
cageCd = getCageCd(awd.vendOrgId, awd.vendAddId)
koOrg1=getOrgName(awd.koOrgId)
isuOrg = getOrgName(awd.isuOrgId)
vendOrg=getOrgName(awd.vendOrgId)
payOrg = getOrgName(awd.payOrgId)
adOrg = getOrgName(awd.adminOrgId)
set vend = getContactData(awd.vendOrgId,awd.vendAddId)
set admin=getContactData(awd.adminOrgId,awd.adminAddId)
set paying=getContactData(awd.payOrgId,awd.payAddId)
set issue =getContactData(awd.isuOrgId,awd.isuAddrId)
	str = ""
	str = str & "<table><b>"
	str = str & "<th id='PrPanel' colspan = '2'>Vendor Information</th>"
	str = str & "<tr><th>Name:</th>			<td>"
		IF vendOrg = "" THEN str = str & "<i>Unavailable</i>" ELSE str = str & vendOrg END IF
	str = str & "</td>"
	str = str & "<tr><th>Cage:</th>			<td>"
		IF cageCd = "EMPTY" THEN str = str & "<i>Unavailable</i>" ELSE str = str & cageCd END IF
	str = str & "</td>"
	str = str & "<tr><th>POC Name:</th>		<td>"
		IF vend.name = "" THEN str=str & "<i>Unavailable</i>" ELSE str = str & vend.name END IF
	str = str & "</td>"
	str = str & "<tr><th>POC Phone:</th>		<td> "
		IF vend.phone = "" THEN str = str & "<i>Unavailable</i>" ELSE str = str & vend.phone END IF
	str = str & " </td>"
	str = str & "<tr><th id='PrPanel' colspan = '2'>Issuing Office</th>"
	str = str & "<tr><td colspan='2'>" & issue.orgCd & "<br/>" & isuOrg & " <br/> " & issue.street & "<br/>" & issue.city & " " & issue.state & " " & issue.zip & "</td>"
	str = str & "<tr><th id='PrPanel' colspan = '2'>Administering Agency</th>"
	str = str & "<tr><td colspan='2'>"& admin.orgCd & "<br/>"  & adOrg & " <br/> " & admin.street & " <br/> " & admin.city & " " & admin.state & " " & admin.zip & "</td>"
	str = str & "<tr><th id='PrPanel' colspan = '2'>Paying Agency</th>"
	str = str & "<tr><td colspan='2'> "& paying.orgCd & "<br/>"  & payOrg & " <br/> " &  paying.street & " <br/> " & paying.city & " "  & paying.state & " " & paying.zip & "  </td>"
	str = str & "</b></table>"


SET awd_id = NOTHING
SET cageCd = NOTHING
SET koOrg = NOTHING
SET vendOrg = NOTHING
SET payOrg = NOTHING
SET vend = NOTHING
SET admin = NOTHING
SET paying = NOTHING
SET issue = NOTHING

	getVendorData = str
end function


'*f41:------------------------------------------------------------------------------------------------------------------------------------------'


Function getWkldData(objId)
on error resume next

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandText = "exec Query_getWkldData ?"
		objCmd.CommandTimeout = 10
		'objCmd.CommandType = adCmdText

	SET objPar=objCmd.CreateParameter("@obj_id",3,1,10,objId)
	objCmd.Parameters.Append objPar

	SET objRS=objCmd.Execute()
	SET this = new wkldData
		IF (objRS.EOF = False) THEN
			this.paltCode= objRS("palt_code")
			this.assignTo = objRS("assignee")
			this.assignBy= objRS("assigner")
			this.assignDt=objRS("assigned_date")
			this.master=objRS("master_document")
			this.acType=objRS("action_type")
			this.wkhdrdesc=objRS("description")
			this.wkStart=objRS("start_date")
			this.wkend=objRS("end_date")
			this.wkAssignDt=objRS("assigned_date")
			this.wkrecDt=objRS("received_date")
			this.wkActEnd=objRS("action_end_date")
			this.wkObjId = objRS("wkld_obj_id")

		ELSE

					this.paltCode= "<i>Unavailable</i>"
					this.assignTo =  "<i>Unavailable</i>"
					this.assignBy=  "<i>Unavailable</i>"
					this.assignDt= "<i>Unavailable</i>"
					this.master= "<i>Unavailable</i>"
					this.acType= "<i>Unavailable</i>"
					this.wkhdrdesc= "<i>Unavailable</i>"
					this.wkStart= "<i>Unavailable</i>"
					this.wkend= "<i>Unavailable</i>"
					this.wkAssignDt= "<i>Unavailable</i>"
					this.wkrecDt= "<i>Unavailable</i>"
					this.wkActEnd= "<i>Unavailable</i>"
					this.wkObjId = "<i>Unavailable(/i>"

		END IF


objRS.Close

SET objRS = NOTHING
SET objCmd = NOTHING
SET objPar = NOTHING

set getWkldData=this
end function


'*f42:------------------------------------------------------------------------------------------------------------------------------------------'


function getWkldPanel(objId)
on error resume next
Dim asType(1024)
Dim assigned_usr_id(1024)
Dim assigning_usr_id(1024)
Dim date_assigned(1024)
Dim desc(1024)
Dim increment

SET wkData = getWkldData(objId)


SET master = getMasterDocNo(wkData.wkObjId)


increment = 0

SET objCmd = Server.CreateObject("ADODB.Command")
	objCmd.ActiveConnection = objConn
	objCmd.CommandTimeout = 10
	objCmd.CommandType = adCmdText
	objCmd.CommandText = "exec Query_getWkldAssign ?"

SET objPar = objCmd.CreateParameter("@obj_id",3,1,10,objId)
	objCmd.Parameters.Append objPar

SET objRS = objCmd.Execute()

		WHILE (objRS.EOF = False)

			asType(increment) = objRS("asType")
			desc(increment) = objRS("descr")
			assigned_usr_id(increment)= objRS("assigned_usr_id")
			assigning_usr_id(increment) = objRS("assigning_usr_id")
			date_assigned(increment) = objRS("date_assigned")

		increment = increment + 1
		objRS.MoveNext

		WEND

	objRS.Close


Dim str
str = ""
str = str & "<table><b><small>"
str = str & "<th id='WkldPanel' colspan='4'>Workload Assignment Panel</th>"
str = str & "<tr>"
str = str & "<th> Description: </th> <td colspan='3'> " & wkData.wkhdrdesc & " </td>"
str = str & "</tr>"
str = str & "<tr> <th> Workload Status: </th> <td colspan='3'> " & asType(increment-1) & " </td></tr>"
str = str & "<tr> <th> Assigned To: </th> <td> " & wkData.assignTo
IF wkData.wkend > date THEN
	str = str & "</td><th>Due: </th><td> " & wkData.wkend
ELSE
	str = str & "</td><th>Completion Date: </th><td> " & wkData.wkActEnd
END IF
str = str & "  </td></tr>"
str = str & "<tr> <th> Assigned By: </th> <td> " & wkData.assignBy & "  </td><th> <a href='paltInfo.asp' target = '_blank'>PALT:</a> </th><td> " & wkData.paltCode & "  </td></tr>"
str = str & "<tr> <th> Master Doc: </th> <td>  " & wkData.master   & "  </td><th> Action Type: </th><td> "
IF master.docType = "" THEN
str = str & "<i>Unavailable</i>"
ELSE
str = str & master.docType
END IF
str = str & "  </td></tr>"
str = str & "<tr> <th> Master Doc#:"
str = str & "</th> <td colspan='3'>"
IF master.masterDoc = "" THEN
str = str & "<i>Unavailable</i>"
ELSE
str = str & TRIM(master.masterDoc)
END IF
str = str & "</td></tr>"
str = str & "<tr><th id='WkldHist' colspan='4'>Workload History Notes </th><tr>"

for i = 0 to increment -1

str = str & "<tr> <td colspan='4' align='center'>"
str = str & asType(i) & " " &  desc(i) & "<br/>"
str = str & "<b>to</b> " & assigned_usr_id(i) & " <b>by</b> " & assigning_usr_id(i) & " <b>at</b> " & date_assigned(i) & " <br/>"
str = str & " </td></tr> "

next

str = str & " </small></table>"

   getWkldPanel = str
SET wkData = NOTHING
SET objCmd = NOTHING
SET objRS = NOTHING
SET objPar = NOTHING
End function


'*f43:------------------------------------------------------------------------------------------------------------------------------------------'


Function lineItemData(doc_no, clin_no)
on error resume next
SET clin = getClinInfo(doc_no, clin_no)

Dim	str
		str = ""
		str = str & "	<table>"
		str = str & "		<tr>"
		str = str & "			<th colspan='4'id = 'PrPanel'>Line Item Detail Panel</th>"
		str = str & "		</tr>"
		str = str & "		<tr>"
		str = str & "			<th>Contract Line Item Number:</th>"
		str = str & "			<td>" & clin.clin_no & "</td>"
		str = str & "			<th>Description</th>"
		str = str & "			<td>" & clin.description & "</td>"
		str = str & "		</tr>"
		str = str & "		<tr>"
		str = str & "			<th> <br/>Extended Desc:<br/><br/></th>"
		str = str & "			<td colspan='3'>" & clin.ext_desc & "</td>"
		str = str & "		</tr>"
		str = str & "		<tr>"
		str = str & "			<th>PR Number:</th>"
		str = str & "			<td>" & clin.req_no & "</td>"
		str = str & "			<th>MFG Part Number:</th>"
		str = str & "			<td>" & clin.mfg_part_number & "</td>"
		str = str & "		</tr>"
		str = str & "		<tr>"
		str = str & "			<th>Federal Supply Code:</th>"
		str = str & "			<td>" & clin.fsc_code & "</td>"
		str = str & "			<th>MDAP/MAIS Code:</th>"
		str = str & "			<td>" & clin.mdaps_code & "</td>"
		str = str & "		</tr>"
		str = str & "		<tr>"
		str = str & "			<th>NAICS Code:</th>"
		str = str & "			<td>" & clin.naics_code & "</td>"
		str = str & "			<th>Program Code:</th>"
		str = str & "			<td>" & clin.prog_code & "</td>"
		str = str & "		</tr>"
		str = str & "		<tr>"
		str = str & "			<th>National Stock Number:</th>"
		str = str & "			<td>" & clin.nsn & "</td>"
		str = str & "			<th>Contract Type:</th>"
		str = str & "			<td>" & clin.contract_type & "</td>"
		str = str & "		</tr>"
		str = str & "		<tr>"
		str = str & "			<th>Fob:</th>"
		str = str & "			<td>" & clin.fob & "</td>"
		str = str & "			<th>Additional Markings:</th>"
		str = str & "			<td>" & clin.add_mark & "</td>"
		str = str & "		</tr>"
		str = str & "	</table>"
		str = str & "	<br/><br/>"
		str = str & "	<table class='addInfo'>"
		str = str & " 			<tr><th colspan='6' id = 'PrPanel'>Additional Information </th></tr>"
		str = str & "			<tr>"
		str = str & "				<th rowspan='2'>Delivery Date</th>"
		str = str & "				<th colspan='2'>Period of Performance</th>"
		str = str & "				<th colspan='3'>Shipping INFO</th>"
		str = str & "			</tr>"
		str = str & "			<tr>"
		str = str & "				<th>Start Date</th>"
		str = str & "				<th>End Date</th>"
		str = str & "				<th>POC Name </th>"
		str = str & "				<th>POC Phone</th>"
		str = str & "				<th>POC Address</th>"
		str = str & "			</tr>"
		str = str & "			<tr>"
	IF clin.delType = "0" THEN str = str & "<td><i>Not Applicable</i></td>" ELSE str = str & "<td>" & clin.startDt & " </td>" END IF
	IF clin.delType = "0" THEN str = str & "<td>" & clin.startDt & " </td>" ELSE str = str & "<td><i>Not Applicable</i></td>" END IF
	IF clin.delType = "0" THEN str = str & "<td>" & clin.endDt & "   </td>" ELSE str = str & "<td><i>Not Applicable</i></td>" END IF
		str = str & "				<td>" & clin.ship_poc & "</td>"
		str = str & "				<td>" & clin.ship_phone & "</td>"
	IF LEFT(clin.ship_address,1) = " " THEN
		str = str & "<td><i>Unavailable</i></td>"
	ELSE
		str = str & "				<td>" & clin.ship_address & "</td>"
	END IF
		str = str & "			</tr>"
		str = str & "	</table>"
	lineItemData = str
End Function


'*f44:------------------------------------------------------------------------------------------------------------------------------------------'


function lineItemPanel(cnt)
on error resume next
totPrice = clin_price(cnt)*clin_quant(cnt)
str = ""
str = str & "	<td id='clin'>"
IF clin_cd(cnt) <> "<i>Unavailable</i>" THEN
str = str &"<a href = 'clinInfo.asp?doc_no="& doc_no & "/" & clin_cd(cnt) &"'target= '_self'>" & clin_cd(cnt) & "</a><br/>"
Else
str = str & clin_cd(cnt)
END IF
str = str & "</td>"
str = str & "	<td id='SAPnum'>"& clin_num(cnt) & "</td>"
str = str & " 	<td id='SAPclin'>" & clin_pr(cnt) & "</td>"
str = str & "	<td id='ReqCd'>"& clin_Rc(cnt) &"</td>"
str = str & "	<td id='SAPChg'>"& clin_chg(cnt) &"</td>"
str = str & "	<td id='Appn'>" & LEFT(clin_fundST(cnt),12)& "<br/>" & clin_costCd(cnt) & "</td>"
str = str & "	<td id='descri'>"& clin_descrip(cnt) & "</td>"
str = str & "	<td id='totCost'>"& FormatCurrency(totPrice) & "</td>"
str = str & "	<td id='totFund'>"& FormatCurrency(clin_fundAmt(cnt)) & "</td>"
str = str & "	<td id='clinType'>"& clin_cont(cnt) &"</td>"

lineItemPanel = str
END function


'*f45:------------------------------------------------------------------------------------------------------------------------------------------'





'*f46:------------------------------------------------------------------------------------------------------------------------------------------'


Dim noteArray()
Function getNotes(objId)
On Error Resume Next
ReDim noteArray(0)

	Dim objCmd
	Dim objRS
	Dim objPar
	Dim noteCnt
	Dim dskNote(8)
	Dim str
		noteCnt = 0
		ii=0

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.CommandTimeout = 10
		objCmd.ActiveConnection = objConn

		objCmd.CommandText = "exec Query_getDskNote ?"

	SET objPar = objCmd.CreateParameter("@obj_id",3,1,15,obj_id)
		objCmd.Parameters.Append objPar

	SET objRS = objCmd.Execute
		WHILE(objRS.EOF = False)
			dskNote(noteCnt)=objRS("dskNote")
				Redim Preserve noteArray(Ubound(noteArray)+1)
				noteArray(ii) = dskNote(ii)

		ii=ii+1
		noteCnt = noteCnt + 1

		objRS.MoveNext
		WEND

		objRS.Close

	SET objCmd = NOTHING
	SET objPar = NOTHING
	SET objRS = NOTHING

End Function


'*f47:------------------------------------------------------------------------------------------------------------------------------------------'


Function notePanel(doc_no)
	obj_id = getObjId(doc_no)
	getNotes(obj_id)
	Dim print
		str = ""
		str = str & "<div id = 'notes' class = 'notes'>"
		str = str & "	<div id = 'notesTop' class='notesTop'>"
		str = str & "		Document Notes Found: " & UBound(noteArray)
		str = str & "	</div>"
		str = str & "	<div class='notesInt' id = 'notesInt'>"

			for ii = 0 to UBound(noteArray)-1
		str = str & "<div class='noteColor'>Note " & ii+1 & ":</div> " & noteArray(ii) & "<br/><br/>"
			next
		str = str & "	</div>"
		str = str & "</div><br/>"
	IF Ubound(noteArray) > 0 THEN
		print = str
	Else
		print = ""
	END IF
	notePanel = print
End Function

Function getUid(objId)
on error resume next

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandText = "exec Query_getUid ?"
		objCmd.CommandTimeout = 10
		objCmd.CommandType = adCmdText

	SET objPar=objCmd.CreateParameter("@obj_id",3,1,10,objId)
	objCmd.Parameters.Append objPar


	SET objRS=objCmd.Execute()
		IF(objRS.EOF = FALSE)THEN
			userId = objRS("uid")

		ELSE
			userId = ""
		END IF

objRS.Close

SET objCmd = Nothing
SET objPar = Nothing
SET objRS = Nothing


getUid = userId

END Function


'*f48:------------------------------------------------------------------------------------------------------------------------------------------'


Function objectData(docNo)
 on error resume next
 SET objCmd = Server.CreateObject("ADODB.Command")
 	objCmd.CommandTimeout = 10
 	objCmd.ActiveConnection = objConn
 	objCmd.CommandType = adCmdText
 	objCmd.CommandText = "exec Query_getDocData ?"
 SET objPar = objCmd.CreateParameter("@doc_no",200,1,24,docNo)
 	objCmd.Parameters.Append objPar

 SET objRS = objCmd.Execute()
 SET this = new objData
 	IF(objRS.EOF = FALSE) THEN
 	this.description=objRS("description")
 	this.docno=objRS("docno")
 	this.applDt = objRS("apl_date")
 	this.awdDt=objRS("awd_date")
 	this.solDt=objRS("sol_date")
 	this.chgDt=objRS("chg_date")
 	this.approval=objRS("approval")
 	this.objType=objRS("object_type")
 	this.owner=objRS("owner")
 	this.label=objRS("label")
 	this.cancelled=objRS("cancelled")
 	this.released=objRS("released")
 	this.fullname=objRS("fullname")
 	this.comments = objRS("comments")
 	this.reqDt = objRS("req_date")
 	this.stamp_id = objRS("stamp")


 	ELSE
 	this.description=""
 	this.docno=		""
 	this.applDt =	""
 	this.awdDt=		""
 	this.solDt=		""
 	this.chgDt=		""
 	this.approval=	""
 	this.objType=	""
 	this.owner=		""
 	this.label=		""
 	this.cancelled=	""
 	this.released=	""
 	this.fullname=	""
 	this.comments =	""
 	this.reqDt =	""
 	this.stamp_id = ""
 	END IF
 IF this.objType="RQM" THEN this.TCode ="M" ELSE this.TCode = "P" END IF
 	 this.approvalCode =this.TCode+this.approval+this.released+this.cancelled

 	 SELECT case this.approvalCode
 	 				Case "P110"
 						this.status = "Approved"
 					Case "P011"
 						this.status = "Cancelled"
 					Case "P000"
 						this.status = "Not Approved"
 					Case "M000"
 						this.status = "Not Approved"
 					Case "M010"
 						this.status = "Cancelled"
 					Case "M110"
 						this.status = "Released"
 					Case "M001"
 						this.status = "Released"
 					Case "M011"
 						this.status = "Cancelled"
 					Case "M100"
 				status = "Approved"
 	 		END SELECT
 objRS.Close



 	SET objRS = Nothing
 	SET objPar = Nothing
 	SET objCmd = Nothing

 SET objectData = this

END Function


'*f49:------------------------------------------------------------------------------------------------------------------------------------------'


'*f50:------------------------------------------------------------------------------------------------------------------------------------------'


Function setConnection(doc_no)

SET objConn = Server.CreateObject("ADODB.Connection")
objID = -1
FOR ii = 0 to 3
	objConn.Open connections(ii)
		IF objConn.State <> 1 THEN
			objID = -1
		ELSE
			objID = testObjId(doc_no, connections(ii))
		END IF
				IF objID <> -1 THEN
					connString = connections(ii)
					site_id = sites(ii)
						objConn.Close
					EXIT FOR
				ELSE
					connString = -1
					objConn.Close
			END IF
NEXT

objConn.Open connString

End Function


'*f51:------------------------------------------------------------------------------------------------------------------------------------------'


function setLocation(objId)
on error resume next
dim loc(1024)
dim location
Dim ii



location = ""

For ii=0 to 20

set loc(ii) = getLocation(objId)
	location = loc(ii).description & "\ " & location
		IF loc(ii).parent_id = 0 THEN EXIT FOR

	objId = loc(ii).parent_id

	ii=ii+1

Next

setLocation = location
end function


'*f52:------------------------------------------------------------------------------------------------------------------------------------------'


Function testObjId(docNo,conn)
	Dim objid
	on error resume next

		SET objCmd = Server.CreateObject("ADODB.Command")
			objCmd.ActiveConnection = objConn
			objCmd.CommandText = "exec Query_getObjId ?"
			objCmd.CommandTimeout = 10
			objCmd.CommandType = adCmdText

		SET objPar=objCmd.CreateParameter("@docNo",200,1,32,docNo)
		objCmd.Parameters.Append objPar

		SET objRS=objCmd.Execute()

			IF(objRS.EOF = FALSE)THEN
				objid = objRS("obj_id")
			ELSE
				objid = -1
			END IF
		objRS.Close

	SET objCmd = Nothing
	SET objPar = Nothing
	SET objRS = Nothing
	testObjId= objid
END Function


'f53:------------------------------------------------------------------------------------------------------------------------------------------'


Function setSite(conn, docNo)

	Dim this
	Dim spType
	SET this = new Location
	this.object_id = "Unavailable"
	IF LEFT(docNo,1) = "4" THEN
		spType = "exec Query_getSapObjs ?"
	ELSEIF RIGHT(docNo,1) <> "%" THEN
		spType = "exec Query_getObjId ?"
	ELSEIF RIGHT(docNo,1) = "%" THEN
		spType = "exec Query_testDocList ?"
	ELSE
		spType = -1
	END IF

	SET objConn = Server.CreateObject("ADODB.Connection")
		objConn.Open conn


	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.ActiveConnection = objConn
		objCmd.CommandText = spType
	SET objPar = objCmd.CreateParameter("@doc_no",200,1,32,docNo)
		objCmd.Parameters.Append objPar

	SET objRS = objCmd.Execute()
		IF(objRS.EOF = False) THEN
			this.object_id = objRS("obj_id")
			this.connection = conn
		ELSE
			this.object_id = -1
			this.connection = -1
		END IF
		objRS.Close


			SELECT CASE conn
				CASE connString1
					IF this.object_id <> -1 THEN

						this.site_id = "CHLK"
						site_id = this.site_id

					ELSE
						this.site_id = -1

					END IF
				CASE connString2
					IF this.object_id <>-1 THEN

						this.site_id = "PAX"
						site_id = this.site_id

					ELSE
						this.site_id = -1

					END IF
				CASE connString3
					IF this.object_id <> -1 THEN

						this.site_id = "ORL"
						site_id = this.site_id

	ELSE
						this.site_id = -1


					END IF
				CASE ELSE
					this.site_id = -1

			END SELECT

	SET objRS = NOTHING
	SET objCmd = NOTHING
	SET objPar = NOTHING
	SET setSite = this
End Function

'**********************************************************************************************************************************************'
'------------------------------------------------------------Functional Tool Stuff-------------------------------------------------------------'
'**********************************************************************************************************************************************'

	Function getFuncData(docNo)
		'this object locates document data and stores it in an object for later use in logging and unreleasing
	Dim objId
	Dim applied
	Dim icon_id
	Dim stamp_id
	Dim current_fl
	Dim apld_dt
	Dim apld_fl
	Dim awd_rel_dt
	Dim cntct_id
	Dim addr_id
	Dim org_id
	Dim par_icon_id
	Dim par_curr
	Dim this
	Dim funcRS
	Dim funcCmd
	Dim funcPar


	objId = getObjId(docNo)

	SET this = new ft_data
		this.object_id = objId
response.write(this.object_id)
		SET funcCmd = Server.CreateObject("ADODB.Command")
			funcCmd.ActiveConnection = objConn
			funcCmd.CommandText = "exec ft_getCurDat ?"


		SET funcPar = funcCmd.CreateParameter("@obj_id",3,1,10,objId)
			funcCmd.Parameters.Append funcPar

		SET funcRS = funcCmd.Execute()
			IF(funcRS.EOF = False) THEN
				this.applied 	= funcRS("applied")
				this.icon_id 	= funcRS("ur_icon_id")
				this.stamp_id 	= funcRS("stmp_id")
				this.current_fl	= funcRS("current_fl")
				this.apld_dt 	= funcRS("apld_dt")
				this.apld_fl 	= funcRS("apld_fl")
				this.awd_rel_dt = funcRS("awd_rel_dt")
				this.cntct_id 	= funcRS("ko_cntct_id")
				this.addr_id 	= funcRS("ko_addr_id")
				this.org_id 	= funcRS("ko_org_id")
				this.par_icon_id= funcRS("par_ur_icon_id")
	        	this.par_curr 	= funcRS("par_current_fl")
	        	this.doc_status = funcRS("doc_status")
			ELSE
				this.applied 	= "Unavailable"
				this.icon_id 	= "Unavailable"
				this.stamp_id 	= "Unavailable"
				this.current_fl = "Unavailable"
				this.apld_dt 	= "Unavailable"
				this.apld_fl 	= "Unavailable"
				this.awd_rel_dt = "Unavailable"
				this.cntct_id 	= "Unavailable"
				this.addr_id 	= "Unavailable"
				this.org_id 	= "Unavailable"
				this.par_icon_id= "Unavailable"
				this.par_curr 	= "Unavailable"
				this.doc_status = "Unavailable"
			END IF
			funcRS.Close
		SET getFuncData = this

		


	SET funcCmd = NOTHING
	SET funcPar = NOTHING
	SET funcRS  = NOTHING

	End Function


'---------------------------------------------------------------------------------------------------------'


Function getUnreleased(docNo)

Dim objId
Dim this
Dim funcCmd
Dim funcPar
Dim recordNumber

	objId = getObjId(docNo)
		SET this = new ft_data
			this.object_id = objId
		SET funcCmd = Server.CreateObject("ADODB.Command")
			funcCmd.ActiveConnection = objConn
			funcCmd.CommandText = "exec ft_getUnreleased ?"


		SET funcPar = funcCmd.CreateParameter("@obj_id",3,1,10,objId)
			funcCmd.Parameters.Append funcPar

		SET funcRS = funcCmd.Execute()
			IF(funcRS.EOF = False) THEN
				recordNumber 	= funcRS("line_id")
				this.applied 	= funcRS("applied")
				this.icon_id 	= funcRS("ur_icon_id")
				this.stamp_id 	= funcRS("stmp_id")
				this.current_fl = funcRS("current_fl")
				this.apld_dt 	= funcRS("apld_dt")
				this.awd_rel_dt = funcRS("awd_rel_dt")
				this.cntct_id 	= funcRS("ko_cntct_id")
				this.addr_id 	= funcRS("ko_addr_id")
				this.org_id 	= funcRS("ko_org_id")
				this.unrelease_dt	= funcRS("action_date")
				this.doc_status		= funcRS("stat")
				this.reason			= funcRS("reason")

		ELSE
				recordNumber 	= "Unavailable"
				this.applied 	= "Unavailable"
				this.icon_id 	= "Unavailable"
				this.stamp_id 	= "Unavailable"
				this.current_fl = "Unavailable"
				this.apld_dt 	= "Unavailable"
				this.apld_fl 	= "Unavailable"
				this.awd_rel_dt = "Unavailable"
				this.cntct_id 	= "Unavailable"
				this.addr_id 	= "Unavailable"
				this.org_id 	= "Unavailable"
				this.unrelease_dt 	= "Unavailable"
				this.doc_status 	= "Unavailable"
			END IF
		funcRS.Close
		SET getUnreleased = this
	SET funcCmd = NOTHING
	SET funcPar = NOTHING
	SET funcRS  = NOTHING
	End Function

Function getSignature(address, organization, cntctId)

Dim this
Dim sigCmd
Dim sigRS
Dim sigPar
Dim sigPar2
Dim sigPar3


SET this = new Contact

SET sigCmd = Server.CreateObject("ADODB.Command")
	sigCmd.ActiveConnection = objConn
	sigCmd.CommandText = "exec ft_getContactInfo ?,?,?"
		SET sigPar = sigCmd.CreateParameter("@addr_id",3,1,10,address)
			sigCmd.Parameters.Append sigPar
		SET sigPar2 = sigCmd.CreateParameter("@org_id",3,1,10,organization)
			sigCmd.Parameters.Append sigPar2
		SET sigPar3 = sigCmd.Createparameter("@cntct_id",3,1,10, cntctId)
			sigCmd.Parameters.Append sigPar3


SET sigRS = sigCmd.Execute()
	IF(sigRS.EOF = False) THEN
		this.name = sigRS("cntct_name")
		this.title = sigRS("title")
		this.orgCd = sigRS("short_cd")
	ELSE
		this.name =  "Unavailable"
		this.title = "Unavailable"
		this.orgCd = "Unavailable"
	END IF

	sigRS.Close

	SET sigCmd = NOTHING
	SET sigPar = NOTHING
	SET sigPar2 = NOTHING
	SET sigPar3 = NOTHING
	SET sigRS = NOTHING
SET getSignature = this
End Function


'---------------------------------------------------------------------------------------------------------'


	Sub setDescription(objId, usrId, desc, rsn)
		Dim fCmd
		Dim objectId
		Dim userId
		Dim descrip
		Dim reason


			SET fCmd = Server.CreateObject("ADODB.Command")
				fCmd.ActiveConnection = objConn
				fCmd.CommandText = "exec ft_setDescription ?,?,?,?"

			SET objectId = fCmd.CreateParameter("@obj_id",3,1,10,objId)
				fCmd.Parameters.Append objectId
			SET userId = fCmd.CreateParameter("@usrId",200,1,10,userId)
				fCmd.Parameters.Append userId
			SET descrip = fCmd.CreateParameter("@description", 200, 1, 60, desc)
				fCmd.Parameters.Append descrip
			SET reason = fCmd.CreateParameter("@reason",200,1,60, rsn)
				fCmd.Parameters.Append reason

		fCmd.Execute()

	SET fCmd = NOTHING
	SET objectId = NOTHING
	SET userId = NOTHING
	SET descrip = NOTHING
	SET reason = NOTHING

	End Sub

'	 setDescription 739324, "Jeremy", "Tested From the Function Call", "because I Can"


'-----------------------------------------------------------------------------------------'


	Function unreleaseAwd(docNo,rsn)

 	Dim fCmd
 	Dim fRS
 		Dim fPar
 		Dim objId


	 		objId = getObjId(docNo)

	 		SET fCmd = Server.CreateObject("ADODB.Command")
	 			fCmd.ActiveConnection = objConn
	 			fCmd.CommandText = "exec ft_unrelease ?, ?"

	 		SET fPar = fCmd.CreateParameter("@obj_id",3,1,10,objId)
	 			fCmd.Parameters.Append fPar

	 		SET fPar2 = fCmd.CreateParameter("@rsn",200,1,255, rsn)
	 			fCmd.Parameters.Append fPar2

	 		 fCmd.Execute()
	 		SET fCmd = NOTHING
	 		SET fPar = NOTHING

	End Function

sub setSig(nm, obj)

Dim newCmd
Dim newPar
Dim newPar2



	SET newCmd = Server.CreateObject("ADODB.Command")
		newCmd.ActiveConnection = objConn
		newCmd.CommandTimeout = 10
		newCmd.CommandText = "exec ft_setSignature ?,?"

	SET newPar = newCmd.CreateParameter("@nme",200,1,50,nm)
		newCmd.Parameters.Append newPar


	SET newPar2 = newCmd.CreateParameter("@obj_id",3,1,10,obj)
		newCmd.Parameters.Append newPar2

		newCmd.Execute()
	SET newPar = NOTHING
	SET newPar2 = NOTHING
	SET newCmd = NOTHING

End sub


'-----------------------------------------------------------------------------------------'


	Function releaseAwd(docNo)

		Dim fCmd
		Dim fRS
		Dim fPar
		Dim cmdText
		Dim objId
			cmdText = "exec ft_release ?"

			objId = getObjId(docNo)

			SET fCmd = Server.CreateObject("ADODB.Command")
				fCmd.ActiveConnection = objConn
				fCmd.CommandText = cmdText
			SET fPar = fCmd.CreateParameter("@obj_id",3,1,10,objId)
				fCmd.Parameters.Append fPar

			 fCmd.Execute()
			SET fCmd = NOTHING
			SET fPar = NOTHING


	End Function


'-----------------------------------------------------------------------------------------'


Dim signers(50)
function getSigners()
On Error Resume Next

Dim objCmd
Dim objRS

dim count
Dim result



SET objCmd = Server.CreateObject("ADODB.Command")
	objCmd.ActiveConnection = objConn
	objCmd.CommandTimeout = 10
	objCmd.CommandType = adCmdText
	objCmd.CommandText = "exec ft_getWarrants"


SET objRS = objCmd.Execute()
		WHILE(objRS.EOF = False)
			signers(count) = objRS("cntct_nm")
			count=count + 1
		objRS.MoveNext
 		WEND
 	objRS.Close


SET objCmd = NOTHING
SET objRS = NOTHING

 end Function


'---------------------------------------------------------------------------------------------------------------------------'


Dim creators(200)
Function getCreators()
On error resume next

Dim objCmd
Dim objRS

Dim count
Dim result
count = 0
SET objCmd = Server.CreateObject("ADODB.Command")
	objCmd.ActiveConnection = objConn
	objCmd.CommandTimeout = 10
	objCmd.CommandType = adCmdText
	objCmd.CommandText = "exec ft_getCreators"

SET objRS = objCmd.Execute()
	WHILE(objRS.EOF = False)
		creators(count) = objRS("usr_id")
		count= count+1
	objRS.MoveNext
	WEND
objRS.Close

SET objCmd = NOTHING
SET objRS = NOTHING


end Function



'----------------------------------------------------------------------------------------------------------------------------------------------'


sub setCreator(nm, obj)

Dim newCmd
Dim newPar
Dim newPar2



	SET newCmd = Server.CreateObject("ADODB.Command")
		newCmd.ActiveConnection = objConn
		newCmd.CommandTimeout = 10
		newCmd.CommandText = "exec ft_setCreator ?,?"

	SET newPar = newCmd.CreateParameter("@nme",200,1,50,nm)
		newCmd.Parameters.Append newPar


	SET newPar2 = newCmd.CreateParameter("@obj_id",3,1,10,obj)
		newCmd.Parameters.Append newPar2

		newCmd.Execute()
	SET newPar = NOTHING
	SET newPar2 = NOTHING
	SET newCmd = NOTHING

End sub


'--------------------------------------------------------------------------------'


sub setDates(dt1,dt2, obj)

Dim newCmd
Dim newPar
Dim newPar1
Dim newPar2

	SET newCmd = Server.CreateObject("ADODB.Command")
		newCmd.ActiveConnection = objConn
		newCmd.CommandTimeout = 10
		newCmd.CommandText = "exec ft_setDates ?,?,?"

	SET newPar = newCmd.CreateParameter("@app_dt",200,1,50,dt1)
		newCmd.Parameters.Append newPar

	SET newPar1 = newCmd.CreateParameter("@eff_dt",200,1,50,dt2)
		newCmd.Parameters.Append newPar1

	SET newPar2 = newCmd.CreateParameter("@obj_id",3,1,10,obj)
		newCmd.Parameters.Append newPar2

		newCmd.Execute()

	SET newPar = NOTHING
	SET newPar1 = NOTHING
	SET newPar2 = NOTHING
	SET newCmd = NOTHING

End sub


objConn.Close

SET objConn = NOTHING


'--------------------------------------Description Tool --------------------------------'


%>