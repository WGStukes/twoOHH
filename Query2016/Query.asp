<% ENABLESESSIONSTATE="False"%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>SPS Query</title>
		<link rel="stylesheet" type="text/css" href="style/query.css"/>

			<script type="text/javascript" src="common/spsQuery.js"></script>
			<meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
	</head>

	<body>
		<div class ="wrapper">

			<div class='banner'></div><!--banner-->
					<div class='navy'>
						<a href = '#'>Contracts Home</a>
						<p><i>WD Contracts 2.0</i></p>
					</div><!--navy-->
					<div class='title'>
						<h2>
							SPS Query
						</h2>
					</div><!--title-->
					<fieldset id = 'fs1'>
						<legend> Document Retrieval </legend>
							</br></br>
								<div align ='center' class='formField'>
									<form name='docno' title='Document Number' method='post'  onkeyup='return ckChar()' onsubmit='return validate()'>
										<label for='document_no'>Document Number:&nbsp;&nbsp;</label>
										<input id='document_no' maxlength='24' name='doc_no' size='30' value=' '/>&nbsp;&nbsp;
										<input type='submit' onclick='return ckChar()' value='Search'/><br/>"
										<span id='exTxt'><small>Example: &quot1300375371&quot, &quot1300375371-0001&quot, &quot13003753%&quot </small></span>
									</form>
								</div>
							</br></br>
							<hr width = "75%">
							<div class='footer'>
									<a href="https://wdcontracts.navair.navy.mil/contracts/internal/default.asp">Contracts Home </a>
								| 	<a href="https://wdcontracts.navair.navy.mil/contracts/tools/PR_Search2016/helpTicket.asp">Report an Issue</a>
								| 	<a href="#" onclick='return showAbout()'> About</a>
							</div><!--footer-->
					</fieldset>
		 </div><!--wrapper-->
	</body>
</html>
