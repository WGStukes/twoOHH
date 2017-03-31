var ck_phone;
	ck_phone=/^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/;
var ck_email;
	ck_email =/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
var ck_name = /^[A-Za-z\s*]+$/;
var errCnt;
	errCnt = 0;
var maxLength=250;
	function charLimit(arg_msg)
		{
		 if (arg_msg.value.length > maxLength) return false;
		 return true;
		}
		
		
	function characterCount(arg_msg) 
			{
			 var charCount = document.getElementById('charCount');
				if (arg_msg.value.length > maxLength) arg_msg.value = arg_msg.value.substring(0,maxLength);
				if (charCount) charCount.innerHTML = maxLength - arg_msg.value.length;
				return true;
			 }


	function chColor(arg){
		if (arg.value == "Your Name Here"){
			arg.value=''; arg.style.color='#000';
						}
		else if (arg.value =="example@navy.mil"){
			arg.value=''; arg.style.color='#000';
							}
		else if (arg.value =="xxx-xxx-xxxx"){
			arg.value=''; arg.style.color='#000';
						}
					return true;
						}


	function ckChar(){
		var nme;
			nme = document.mainform.arg_name.value;
		var email;
			email = document.mainform.arg_email.value;
		var phone;
			phone = document.mainform.arg_phone.value;
		var messg;
			messg = document.mainform.arg_msg.value;
		var defNme;
			defNme = "Your Name Here";
		var defEml;
			defEml = "example@navy.mil";
		var defPhn;
			defPhn = "xxx-xxx-xxxx";
			
			
		if((nme!="")&&(ck_name.test(nme))&&(nme != defNme))
			{
			document.getElementById("name").style.border="none";
			document.getElementById("usrName").style.color="#036";
			document.getElementById("error").innerHTML="";
				errCnt = errCnt -1;
			}



		if((email!="")&&(ck_email.test(email))&&(email!=defEml))
			{
			document.getElementById("email").style.border="none";
				document.getElementById("usrEmail").style.color = "#036";
					document.getElementById("error2").innerHTML="";
						errCnt = errCnt -1;
			}

		if(document.mainform.arg_email.value=="")
			{
			document.mainform.arg_email.value="example@navy.mil";
				document.mainform.arg_email.style.color="#BDBDBD";
					errCnt=errCnt +1;
			}
		if(document.mainform.arg_phone.value=="")
			{
			document.mainform.arg_phone.value ="xxx-xxx-xxxx";
				document.mainform.arg_phone.style.color="#BDBDBD";
					errCnt=errCnt +1;

			}
		if((phone!="")&&(ck_phone.test(phone))&&(phone!=defPhn))
			{
			 document.getElementById("phone").style.border="none";
				document.getElementById("usrPhne").style.color = "#036";
					document.getElementById("error3").innerHTML="";
						errCnt = errCnt -1;
			}
		if(messg!= ""){
			document.getElementById("usrComm").innerHTML="";
				document.getElementById("comments").style.border="1px inset #A9BCF5";
					 errCnt = errCnt -1;
			       }

		if(nme.length!=0 && email.length!=0 && phone.length!=0 && ck_phone.test(phone) && ck_email.test(email) && ck_name.test(nme)){
			document.getElementById("user").style.border="none";
				}
			}

	function validate()
		{
		var defNme;
			defNme = "Your Name Here";
		var defEml;
			defEml = "example@navy.mil";
		var defPhn;
			defPhn = "xxx-xxx-xxxx";
		var nme;
			nme = document.mainform.arg_name.value;
		var email;
			email = document.mainform.arg_email.value;
		var phone;
			phone = document.mainform.arg_phone.value;
		var messg;
			messg = document.mainform.arg_msg.value;
		var message;
			message = "";

		var nameErr;
			nameErr = "* Name Required<br/>";

		var emailErr;
			emailErr = "* Valid Email Required<br/>";

		var phneErr;
			phneErr = "* Valid Phone Number Required<br/>";
			var revMsg;
			revMsg=messg.replace(/[<>]/g,'/');
			document.mainform.arg_msg.value = revMsg;

				if(document.mainform.arg_msg.value == ""){
					document.getElementById("usrComm").innerHTML="* Comments Required";
						document.getElementById("comments").style.border="1px solid red";
							document.getElementById("usrComm").style.color="red"
							errCnt=errCnt +1
									}

				if((nme=="")||(!ck_name.test(nme))||(nme == defNme)){
					document.getElementById("user").style.border="1px solid red";
						document.getElementById("name").style.border="1px solid red";
							document.getElementById("error").style.color="red";
								document.getElementById("usrName").style.color="red";
								errCnt=errCnt + 1;
									document.getElementById("error").innerHTML=nameErr;
								}

				if((email=="")||(!ck_email.test(email))||(email==defEml)){
					document.getElementById("user").style.border="1px solid red";
						document.getElementById("email").style.border="1px solid red";
							document.getElementById("error2").style.color="red";
								document.getElementById("usrEmail").style.color = "red"
									errCnt=errCnt +1;
									document.getElementById("error2").innerHTML=emailErr;
														}

				if((phone=="")||(!ck_phone.test(phone))||(phone==defPhn)){
					document.getElementById("user").style.border="1px solid red";
						 document.getElementById("phone").style.border="1px solid red";
							document.getElementById("usrPhne").style.color = "red";
								document.getElementById("error3").style.color="red";
								errCnt=errCnt +1;
									document.getElementById("error3").innerHTML=phneErr;
														}

												if(errCnt>0){
												return false;
												}
												return true;
											}