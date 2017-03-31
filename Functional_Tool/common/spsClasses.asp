<%
	Class ft_data
			Public  object_id
			Public	applied
			Public	icon_id
			Public	stamp_id
			Public	current_fl
			Public	apld_dt
			Public	apld_fl
			Public	awd_rel_dt
			Public	cntct_id
			Public	addr_id
			Public	org_id
			Public	par_icon_id
			Public	par_curr
			Public  unrelease_dt
			Public  doc_status
			Public  reason
	END Class


class award
	public sap
	public relDate
	public effDate
	public awdType
	public adminOrgId
	public adminAddId
	public vendOrgId
	public vendAddId
	public vendCntct
	public payOrgId
	public payAddId
	public koOrgId
	public koAddId
	public koCntct
	public isuOrgId
	public isuAddrId
	public cloDt
	public archiveDt
end class

Class Palt
	public paltCd
	public paltDesc
	public paltDays
End Class


class spsLocation
	public parent_id
	public description
	public spsLocation
end class

class awdData
	public grpId
	public docNo
	public VendorName
	public objDescr
	public specName
	public pcoName

end class

Class ClinData
	public clinNum
	public description
	public sapNum
	public sapClinNum
	public sapCode
	public sapChgObj
	public costCd
	public clinType
	public fundAmt
	public prcAmt
	public optAmt
End Class

Class ClinInfo
	public clin_no
	public description
	public req_no
	public mfg_part_number
	public milstrip
	public project
	public fsc_code
	public mdaps_code
	public naics_code
	public prog_code
	public nsn
	public contract_type
	public fob
	public add_mark
	public startDt
	public endDt
	public delType
	public ext_desc
	public ship_dodaan
	public ship_poc
	public ship_phone
	public ship_address
End Class
Class Descendant
	public object_id
	public org_id
	public doc_no
	public obj_type
	public applied
	public cancelled
	public conformed
	public simpType

End Class


Class docObject
	public	docNum
	public	objId
	public	description
	public	owner
	public	objType
	public	approval
	public	cancelled
	public  released
	public	stamp_id
	public  apl_dt
	public	req_dt
	public	sol_dt
	public	awd_dt
	public	chg_dt
	public	clo_dt
	public  approvalCode
	public  status
	public  fullname
	public  uid
	public  creator
END Class

Class Funding
	Public totalCost
End Class


Class Location
	Public connection
	Public logon
	Public document_no
	Public testLocation
	Public status
	Public site_id
	Public object_id

END Class

 Class objectID
 	public object_id
 	public description
 	public comments
 	public koNoteId
 	public requisitionDate
	public owner
End Class

Class Contact
	public name
	public phone
	public fax
	public email
	public street
	public city
	public state
	public zip
	public title
	public orgCd
end Class

Class UserData
	public name
	public title
	public phone
	public fax
	public email
End Class

Class objData
	public description
	public uid
	public docno
	public applDt
	public awdDt
	public solDt
	public chgDt
	public reqDt
	public approval
	public objType
	public owner
	public label
	public cancelled
	public released
	public fullname
	public approvalCode
	public status
	public comments
	public Tcode
	public stamp_id
end Class

Class wkldData
	public paltCode
	public Object
	public descrip
	public assignTo
	public assignBy
	public assignDt
	public master
	public acType
	public wkhdrdesc
	public wkStart
	public wkend
	public wkAssignDt
	public wkrecDt
	public wkActEnd
	public userId
	public wkObjId
	public masterDoc
	public docType
End Class



Class lineItem
	public clin_cd
	public clin_Comm
	public clin_Mstrip
	public clin_Descrip
	public clin_nsn
	public clin_price
	public clin_quant
	public clin_pr
	public clin_num
	public clin_exp
	public clin_Rc
	public clin_Acrn
	public clin_cin
	public clin_costCD
	public clin_fundAmt
	public clin_fscCD
	public clin_fscDesc
	public clin_cont
	public clin_issue
	public clin_fundST
	public obj_id

End Class


Class ArrayList
	Private internalArrayList

	Private Sub Class_Initialize()
		Set internalArrayList = Server.CreateObject("System.Collections.ArrayList")
	End Sub

	Private Sub Class_Terminate()
		Set internalArrayList = Nothing
	End Sub

	Public Sub AddItem(item)
		internalArrayList.Add(item)
	End Sub




	Public Function getItem()
		Dim data, x
			data = "List Contains " & internalArrayList.Count & " item"
				If internalArrayList.Count <>1 Then data = data & "s"
				For x=0 To internalArrayList.Count-1
					data = data & "</br>"
					If IsObject(internalArrayList(x))Then
						data = data & "Array With " & (UBound(internalArrayLIst(x)) + 1) &  " items"
					Else
						data = data & internalArrayList(x)
					End If
				Next
				getItem = data
			End Function

End Class


%>