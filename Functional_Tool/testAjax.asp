<!DOCTYPE html>

	<!--#include file = 'common/spsFunctionsb.asp'-->
	<html>
		<head>
			<title>FILETEST</title>
			<link rel='stylesheet' type='text/css' href='style/ft.css'>
			<script type="text/javascript" src="common/bft.js"></script>
<%
	Dim object_id
	doc_no = UCase(Request.Form("doc_no"))
%>
	<script>


		function getMods(){
			var dStr = '<%=doc_no%>'
				var xmlhttp = new XMLHttpRequest();
				        xmlhttp.onreadystatechange = function() {
				            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				            	var newAr = new Array();
				            		newAr = xmlhttp.responseText.split(",")



				                document.getElementById("test1").innerHTML = newAr[0];
				                document.getElementById("test2").innerHTML = newAr[1];
				                document.getElementById("test3").innerHTML = newAr[3];

				            }
				        }
				        xmlhttp.open("GET", "DisCurrData.asp?q="+dStr, true);
			        xmlhttp.send();
			}



		function testValue(){
			var x = document.getElementById("doc_no");
				alert(x);
		}
	</script>
		<head>

			<body>

<form action = "testAjax.asp">
Document Number: <%=doc_no%>
<input id = "doc_no" type="text" name="doc_no">
<input type="submit" onclick = 'return testValue()' value="Retrieve">
</form>
					<span id = 'test1'>blah</span></br>
					<span id = 'test2'>blah2</span></br>
					<span id = 'test3'>blah3</span></br>
					<%response.write(object_id)%>
			</body>
	</html>