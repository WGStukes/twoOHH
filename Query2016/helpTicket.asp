<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>
		BSO Help Desk
	</title>
<link rel="stylesheet" type="text/css" href="style/pf.css"/>
<link rel="stylesheet" type="text/css" href="style/query.css
<script type="text/javascript" src="common/helpDesk.js"></script>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
</head>
	<body>
			<div class='menubar'>
				<div align='right'>
						<div class='captchr'>
								WD Contracts 2.0
							</div><!--capthr-->
					</div><!--alignRight-->
				<ul id="navbar">
					<li>
							<a href="https://wdcontracts.navair.navy.mil/contracts/internal/default.asp">Contracts Home </a>
					</li>
					<li>
						<a href="https://wdcontracts.navair.navy.mil/contracts/tools/Query2016/Query.asp">
							Query
						</a>
					</li>
			</ul>
	</div><!--menubar-->
				<div class='header'>
			  		<div class='textl'> <i>Online Help Desk</i></div><!--textl-->
					<div class='captchl'> SPS Ticket Submission</div><!--captchl-->
			</div><!--header-->

		<div class='wrapper'>

			<div class='hContainer'>
				<form id="mainform" name="mainform" method="POST" onSubmit="return validate()" target="_self" action="/contracts/common/01a2_sendMail.asp">
					<input type="hidden" name="arg_to"        value="jeremy.r.mcclellan.ctr@navy.mil" />
					<input type="hidden" name="arg_referring" value="ContractsWebSite" />


								<div class='head2'><i>	What kind of report would you like to submit?</i> </div><!--head-->


							<div class='head3'>

										<input type="radio" name="arg_subject" alt="CHANGE REQUEST" value="CHANGE REQUEST" checked="checked" />CHANGE REQUEST&nbsp;
										<input type="radio" name="arg_subject" alt="PROBLEM REPORT"     value="PROBLEM REPORT"    />PROBLEM REPORT &nbsp;
										<input type="radio" name="arg_subject" alt="TECH SUPPORT"    value="TECH SUPPORT"   />TECH SUPPORT&nbsp;
										<input type="radio" name="arg_subject" alt="OTHER"    value="OTHER"   />OTHER&nbsp; </br></br>



									*Enter a Description of the Problem or the Change Request:</br>&nbsp;&nbsp;&nbsp;&nbsp; <span id="charCount">250</span> Characters Remaining<span id='usrComm'></br></span>
									</div><!--head3-->


									<div>
									<textarea id='comments' name="arg_msg" rows="5" cols="40" maxlength='255' wrap="hard" onkeydown="return charLimit(this)" onkeyup="return characterCount(this)" onblur= "ckChar()"  ></textarea>
									</br></div>


							<div class='head2'><i>	Tell us how to get in touch with you: </i></div>
							<div class='head3'>
											<table id = 'user' align='center'>
																<tr><td></td><td><small><div id='error'></div></small></td></tr>
																<tr><td></td><td><small><div id='error2'></div></small></td></tr>
																<tr><td></td><td><small><div id='error3'></div></small></td></tr>
																<tr>
																	<td colspan="1"><span id='usrName'>*Name:</span></td><td>

																		<span id='name'><input type="text" name="arg_name" size="40" maxlength='25' alt="Your Name" style="color: #000;"  value=""  onfocus="return chColor(this)"  onblur="return ckChar()" /></span><div id="nm_msg"></div>
																	</td>
																</tr>

																<tr>
																	<td colspan="1"><span id='usrEmail'>*Email:</span></td><td>
																		<span id='email'><input type="text" name="arg_email" size="40" maxlength='40' alt="Your Email Address" style="color: #BDBDBD;"  onfocus="return chColor(this)" value="example@navy.mil" onblur="return ckChar()" /></span>
																	</td>
																</tr>

																<tr>
																	<td   colspan="1"><span id='usrPhne'>*Phone:</span></td><td>
																	<span id='phone'><input type="text" name="arg_phone" size="40" alt="Your Telephone Number" maxlength='13' style="color: #BDBDBD;"  onfocus="return chColor(this)" value="xxx-xxx-xxxx" onblur="return ckChar()" /></span>
																	</td>
																</tr>

											</table>

							</div><!--head3-->
				<p>
					<input name="B1" type="submit" alt="Send this form"  value="Submit Ticket" />&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="B2" type="reset"  alt="Clear this form" value="Clear" />
				</p>

					</form>
				</div><!--hcontainer-->


				<div class = 'hContainer' align='center'>
							<a href="https://wdcontracts.navair.navy.mil/contracts/internal/default.asp">Contracts Home </a>
						|	<a href="https://wdcontracts.navair.navy.mil/contracts/tools/Query2016/Query.asp">Query</a>
						| 	<a href="https://wdcontracts.navair.navy.mil/contracts/tools/Query2016/helpTicket.asp">Report an Issue</a>
						|	<a target="_blank" href="https://wdcontracts.navair.navy.mil/contracts/tools/Query2016/Query User Manual.pdf">User Guide </a>
						| 	<a href="#" onclick='return showAbout()'> About</a>
				</div>
			</div><!--wrapper-->
		</body>
	</html>