/* function showField(input,id) {		
	if((input.value == 'IDIQ')||(input.value == 'ACR')){
		document.getElementById(id).style.display="none";
	}else{
		document.getElementById(id).style.display="";
	}
}
*/

function verify(input,doc){
	var msg = "";

	if(input == 'desc'){
		msg = "You are about to update the Description field for: \n " + doc + "\n Do you wish to continue?";
	}else if(input == 'sig'){
		msg = "You are about to update the Signature field for: \n" + doc + "\n Do you wish to continue?";
	}else if(input == 'cre'){
		msg = "You are about to update the Creator field for: \n" + doc + "\n Do you wish to continue?";
	}else if(input == 'unr'){
		msg = "You are about to Unrelease the following document: \n" + doc + "\n Do you wish to continue?";		
	}else if(input == 'dtm'){
		msg = "You are about to update the Applied and Effective Date fields for: \n" + doc + "\n Do you wish to continue?";
	}else if(input == 'des'){
		msg = "You are about to update the Description field for:\n" + doc + "\n Do you wish to continue?";
	}else if(input == 'rel'){
		msg = "You are about to Release the following document:\n" + doc + "\n Do you wish to continue?";
	}		
	if(confirm(msg)== true){
		return unrelease(doc, input);
	
	}else{
		return false;
	} 
}


function unrelease(doc, input){
	var dStr = doc;
	var rsn;
	var e;	
	var n;
	

		
		if(input=="unr"){
			rsn= reason;
		}else if(input =="des"){
			rsn = description;
		}else if(input =="sig"){
			rsn = document.getElementById("signer").value;
		}else if(input =="cre"){
			e = document.getElementById("CRAP");
			rsn = e.options[e.selectedIndex].Text;
			alert(rsn);
		}else if(input == 'dtm'){
			rsn = document.getElementById("apld_date").value + "|" + document.getElementById("eff_date").value;
		
			}
	
		var xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					if(input == "unr"){
					rsn = reason;
					document.getElementById("unrelease").innerHTML = xmlhttp.responseText;
					}else if(input =="rel"){
					document.getElementById("rerelease").innerHTML = xmlhttp.responseText;
					}else if(input =="des"){
					document.getElementById("description").innerHTML = xmlhttp.responseText;
					}else if(input =="sig"){
					document.getElementById("signature").innerHTML = xmlhttp.responseText;
					}else if(input =="cre"){
					document.getElementById("creator").innerHTML = xmlhttp.responseText;
					}else if(input =="dtm"){
					document.getElementById("getDate").innerHTML = xmlhttp.responseText;
					}
				}
			}
				
			//	xmlhttp.open("GET", "unrelease.asp?q="+ input + "|" + dStr + "|" + rsn, true);
			//	xmlhttp.send();

		}
var reason;								
var description;
function setValue(val){
	reason = val;	
}								

function setDescription(val){
	description = val;
}
function validate(){
var ckNum= /[A-Za-z0-9]{6}(-)?\d{2}(-)?[A-Za-z](-)?\d{4}([-%])?\d{0,6}(%)?([A-Za-z]\d{0,5})?(%)?/;
var ckNum2=/\d{5,10}([-%])?(\d{0,4}(%-)?)?(\d{0,4}(%)?)?/;
var ckNum3=/[\\{}"';:<>?=+_!()*&^$#@\\|]/;
var ckAlpNum=/[A-Za-z0-9-]/g;
var ckIsAlph=/[A-Za-z]/;
var hasDash=/-/g;
var num = document.docno.doc_no.value;	
var lastChar = num.substr(num.length-1,1)
var newNum;

if((num.substr(0,1) == '4')&&(num.length ==10)){
	document.docno.action ='sapPo.asp';
	return true;
	}
	 if((num.substr(0,4)=='1300')||(num.substr(0,4)=='0010')){
		if((num.length == 10)&&(num.substr(num.length-1,1)!=='%')){
			document.docno.action = 'Brannon.asp';
			return true;
		}
		else if((num.length >= 6)&&(num.length <=10)){
			if(num.substr(num.length-1,1)!='%'){	
				newNum = num + '%';
			}
			else if(num.substr(num.length-1,1) == '%'){
				newNum = num;
			}
			document.docno.doc_no.value = newNum;
			document.docno.action = 'Brannon.asp';
			return true;
		
		}
		
		else if((num.length >10)&&(num.length <= 15)){
			newNum = num;
			
			if((newNum.substr(10,1) !== '-')&&(newNum.substr(10,1)!=='%')){
				newNum = newNum.substr(0,10) + '-' + newNum.substr(10);	
			}
			
			if((newNum.substr(newNum.length-1,1)!=='%')&&(newNum.length !=15)){
				newNum = newNum + '%';
				document.docno.action = 'Brannon.asp';
				document.docno.doc_no.value = newNum;
				return true;
			}
			
			else if((newNum.length == 15)&&(newNum.substr(newNum.length-1,1)!=='%')){
				document.docno.action = 'Brannon.asp';
				document.docno.doc_no.value = newNum;
				return true;
				
			}
		document.docno.action = 'Brannon.asp';
		document.docno.doc_no.value = newNum;
		return true;
		}
		
		else if((num.length == 16)&&(num.substr(num.length-1)=='%')){
			document.docno.action = 'Brannon.asp';
			return true;
		}
		else if((num.length == 16)&&(num.substr(num.length-1)=='%')){
			newNum = num.substr(0,15);
			document.docno.doc_no.value = newNum;
			document.docno.action = 'Brannon.asp';
			return true;
		}	
		
	}

else if((num.length >=13)&&(ckIsAlph.test(num))){	
	newNum = num.toUpperCase();    
	if((newNum.substr(6,1)!== "-")&&(newNum.length > 6)){
		newNum = newNum.substr(0,6) + '-' + newNum.substr(6);	
	}
	if((newNum.substr(9,1)!== '-')&&(newNum.length > 9)){
		newNum = newNum.substr(0,9) + '-' + newNum.substr(9);
	}
	if((newNum.substr(11,1)!=='-')&&(newNum.length > 11)){
		newNum = newNum.substr(0,11) + '-' + newNum.substr(11);
	}	
	if((newNum.substr(16,1)!=='-')&&(newNum.length > 16)){
		newNum = newNum.substr(0,16) + '-' + newNum.substr(16);
	}
	if((newNum.length < 16)&&(newNum.length >= 6)){
		if(newNum.substr(newNum.length-1,1)!=='%'){
			newNum = newNum + '%';
		}
		 document.docno.doc_no.value = newNum;
		 document.docno.action = 'Brannon.asp';
		 return true;
	}
	else if(newNum.length == 16){
		 if(newNum.substr(newNum.length-1,1)=='%'){
			document.docno.doc_no.value = newNum;
			document.docno.action = 'Brannon.asp';
		return true;
	}
	else if(newNum.substr(newNum.length-1,1)!='%'){
		document.docno.doc_no.value = newNum;
		document.docno.action = 'Brannon.asp';
		return true;			
		}	
	}
	else if((newNum.length > 16)&&(newNum.length < 23)){
			if(newNum.substr(newNum.length-1,1) == '%'){
				document.docno.doc_no.value = newNum;
				document.docno.action = 'Brannon.asp';
				return true;	
			}
			else if((newNum.length==21)&&(newNum.substr(17,1)!='P')&&(newNum.substr(newNum.length-1,1)!== '%')){
				document.docno.doc_no.value = newNum;
				document.docno.action = 'Brannon.asp';
				return true;	
			}
			else if(newNum.substr(newNum.length-1,1)!=='%'){
				newNum = newNum + '%';
				document.docno.doc_no.value = newNum;
				document.docno.action = 'Brannon.asp';
				return true;			
			}
		}
		else if(newNum.length == 23){
			if(newNum.substr(newNum.length-1,1)!='%'){
				document.docno.doc_no.value = newNum;
				document.docno.action = 'Brannon.asp';
				return true;
			}
			else if(newNum.substr(newNum.length-1,1)=='%'){
				document.docno.doc_no.value = newNum;
				document.docno.action = 'Brannon.asp';
				return true;
			}
		}
		else if((newNum.length ==24)&&(newNum.substr(newNum.length-1)=='%')){
			newNum = newNum.substr(0,23)
			document.docno.doc_no.value = newNum;
			document.docno.action = 'Brannon.asp';
		return true;
		}
	}
return false;
}
function ckChar(){
		var ckNum;
		var num = document.docno.doc_no.value;
		var ckSp= /\s+/g;
		var ckQt=/[\[\]{}"';/.,`~:<>?=+_!()*&^$#@\\|]/g;
		var errCnt=0;

	if(ckSp.test(num)){
		num = num.replace(/\s+/g,"");
		document.getElementById("document_no").value=num;
		}
	if(ckQt.test(num)){
		num = num.replace(ckQt,"");
		
		document.getElementById("document_no").value=num;
	}
	return true;
	}
