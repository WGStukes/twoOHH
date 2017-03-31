<!--#include file='common/spsFunctions.asp'-->
	<%

		 response.expires=-1
		 'get the q parameter from URL'
		 q=(request.querystring("q"))
	setConnection(q)
 object_id = getObjId(q)
Dim ft

	SET ft = getFuncData(q)
		response.write(ft.applied & ", " & ft.apld_dt & ", " & ft.awd_rel_dt & ", " & ft.cntct_id)

%>