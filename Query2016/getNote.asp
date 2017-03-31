<!--#include file='spsFunctions.asp'-->
	<%
		 response.expires=-1
		 'get the q parameter from URL'
		 q=(request.querystring("q"))
	doc_no = mid(q,2)
	cnt = left(q,1)

setConnection(doc_no)
noteID = getObjId(doc_no)
	response.write(connString)
Dim noteArray2()

On Error Resume Next
ReDim noteArray2(0)

	Dim objConn
	Dim objCmd
	Dim objRS
	Dim objPar
	Dim noteCnt
	Dim dskNote(8)
	Dim str
		noteCnt = 0
		ii=0
	SET objConn = Server.CreateObject("ADODB.Connection")
		objConn.Open connString

	SET objCmd = Server.CreateObject("ADODB.Command")
		objCmd.CommandTimeout = 10
		objCmd.ActiveConnection = objConn

		objCmd.CommandText = "exec Query_getDskNote ?"

	SET objPar = objCmd.CreateParameter("@obj_id",3,1,15,noteID)
		objCmd.Parameters.Append objPar

	SET objRS = objCmd.Execute
		WHILE(objRS.EOF = False)
			dskNote(noteCnt)=objRS("dskNote")
				Redim Preserve noteArray2(Ubound(noteArray2)+1)
				noteArray2(ii) = dskNote(ii)

		ii=ii+1
		noteCnt = noteCnt + 1

		objRS.MoveNext
		WEND

		objRS.Close
		objConn.Close
	SET objConn = NOTHING
	SET objCmd = NOTHING
	SET objPar = NOTHING
	SET objRS = NOTHING

	response.write("<div class = 'noteColor'>Note "& cnt+1 & ": </div><!--noteColor-->" & noteArray2(cnt))
 	%>