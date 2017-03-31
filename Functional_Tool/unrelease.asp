<!--#include file='common/spsFunctionsb.asp'-->
<%
	Dim str
	Dim obj
	Dim u
	Dim sign
	Dim doc
	Dim stat
	Dim q
	Dim s
	Dim rsn
	Dim cur
	Dim a
		response.expires=-1
			 q=(request.querystring("q"))

	a =	split(q,"|")
		stat = trim(a(0))
		doc  = trim(a(1))
		rsn  = trim(a(2))
	IF stat = "dtm" THEN
		rsn2 = trim(a(3))
	END IF
		setConnection(doc)
		obj = getObjId(doc)
	IF stat = "unr" THEN
			unreleaseAwd doc,rsn
		SET u = getUnreleased(doc)
		SET sign = getSignature(u.addr_id, u.org_id, u.cntct_id)
				str = ""
			IF u.doc_status = 0 THEN
				str = str & "<div align='center'>Your Document Has Been Successfully Unreleased </br></div>"
				str = str & "<div class='chgTxt'>"
				str = str & "Change Reason Details:</br>"
				str = str & "		<textarea align='right' id = 'chgRsn' rows='4' cols='35' readonly>" & rsn & "</textarea>"
				str = str & "</div>"
				str = str & "<div class = 'orig'>"
				str = str & "	Current Document Status:"
				str = str & "		<table>"
				str = str & "			<tr><th colspan='2'><div class='tHeader'>Rerelease Data</div> 	</th></tr>"
				str = str & "			<tr><th>Applied Date:	</th>	<td>" & u.apld_dt & 	"	</td></tr>"
				str = str & "			<tr><th>Release Date:	</th>	<td>" & u.awd_rel_dt & 	"	</td></tr>"
				str = str & "			<tr><th>Signature:		</th>	<td>" & sign.name & 	"	</td></tr>"
				str = str & "			<tr><th>Title: 			</th>	<td>" & sign.title & 	"	</td></tr>"
				str = str & "			<tr><th>Organization:	</th>	<td>" & sign.orgCd & 	"	</td></tr>"
				str = str & "		</table>"
				str = str & "</div>"

			ELSE
				str = str & "There was an error while unreleasing the document. Please contact the BSO Help Desk for further assistance"
			END IF
	ELSEIF stat = "rel" THEN
		releaseAwd(doc)
		SET cur = getFuncData(doc)
			IF cur.doc_status = 1 THEN
				str = str & "Document Successfully released"
			ELSE
				str = str & "There was an error while trying to release the document. Please contact Jeremy McClellan at the BSO"
			END IF
	ELSEIF stat = "des" THEN
		setDescription obj, "Jeremy",rsn, "Description Field Update"
			str = str & "The Description for the document number: " & doc & " has been updated."
	ELSEIF stat = "sig" THEN
		setSig rsn, obj
			str = str & "Signature Successfully reassigned as " & rsn & " for " & doc
	ELSEIF stat = "cre" THEN
		setCreator rsn, obj
			str = str & "Creator Successfully Reassigned as " & rsn & " for " & doc
	ELSEIF stat = "dtm" THEN
		setDates rsn, rsn2, obj
			str = str & "Applied Date Successfully Set As:  " & rsn & "</br> Effective Date Successfully Set As:  " & rsn2
	END IF
	response.write(str)


%>