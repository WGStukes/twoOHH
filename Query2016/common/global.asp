
<%
'--------------------Set Connection Variables------------'


Dim connString1
Dim connString2
Dim connString3
Dim connString4


Dim LogonPassword1
Dim LogonPassword2

	LogonPassword1 = "SPSProdpassword2!"
	LogonPassword2 = "SPSProdpassword1!"


connString1="DSN=CHL_Prod;PWD=" & LogonPassword2

connString2="DSN=PAX_Prod;PWD=" & LogonPassword2
connString3="DSN=ORL_Prod;PWD=" & LogonPassword2
connString4="DSN=CHL_Prod;PWD=" & LogonPassword2
Dim connections(3)
	connections(0) = connString1
	connections(1) = connString3
	connections(2) = connString2
Dim sites(3)
	sites(0) = "CHLK"
	sites(1) = "ORL"
	sites(2) = "PAX"
%>