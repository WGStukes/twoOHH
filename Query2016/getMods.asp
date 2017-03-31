<!--#include file='spsFunctions.asp'-->
	<%
		 response.expires=-1
		 'get the q parameter from URL'
		 q=(request.querystring("q"))
	Dim del
		del = left(q,1)
	doc_no = mid(q,2)
	'doc_no = left(doc,16)
	setConnection(doc_no)

	obj_id = getObjId(doc_no)
	getRelatedDocs(obj_id)
	objType = getObjType(obj_id)

	IF objType = "" THEN
		objType = getObjType2(doc_no)
	END IF

	IF del = 1 THEN
					IF UBound(delArray) = 0  AND objType = "DEL" THEN
						response.write("<a href = 'panelFunctions.asp?doc_no="& doc_no &"'target= '_self'>" & right(doc_no,4) & "</a></br>")
					ELSE
						for each x in delArray
							if LEN(x) = 23 THEN
								y=right(x,6)
							elseif LEN(x) = 21 THEN
								'y=right(x,4)'
								y=x
							else
								y=x
							end if
							if y <> doc_no then
								if y <> "" then
									response.write("<a href = 'panelFunctions.asp?doc_no="& x &"'target= '_self'>" & y & "</a></br>")
								end if
							end if
						next
					END IF
	ELSEIF del = 0 THEN
					IF UBound(delOnly) = 0 AND objType = "DEL" THEN
						response.write("<a href = 'panelFunctions.asp?doc_no="& doc_no &"'target= '_self'>" & doc_no & "</a></br>")
					ELSE
						for each x in delOnly
							if LEN(x) = 23 THEN
								y=right(x,6)
							elseif LEN(x) = 21 THEN
								'y=right(x,4)'
								y=x
							else
								y=x
							end if
							if y <> doc_no then
								if y <> "" then
									response.write("<a href = 'panelFunctions.asp?doc_no="& x &"'target= '_self'>" & y & "</a></br>")
								end if
							end if
						next
					END IF
	END IF

 	%>