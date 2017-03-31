// File: spsQuery.js TEST
// Author: Jeremy McClellan
//Modifier: William Stukes
// Updated: 2/22/2017

			/*-------------------------||-------------------------*/

function addRemove(input,id) {								
var x;
	x=input.checked;
		if(x==true){
			document.getElementById(id).style.display="";
			 }else{
			 document.getElementById(id).style.display="none";
				 }
	}

/*-------------------------|strip out spaces & special characters|-------------------------*/	

function ckChar(){
		var ckNum;
		var num = document.docno.doc_no.value;
		var ckSp= /\s+/g;
		var ckQt=/[\[\]{}"';/\.,`~:<>?=+_!()*&^$#@\\|]/g;
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

/*-------------------------|sort value and add dashes|-------------------------*/		
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
--------------------------------------------------------------------------------------------------
	 if((num.substr(0,4)=='1300')||(num.substr(0,4)=='0010')){
		if((num.length == 10)&&(num.substr(num.length-1,1)!=='%')){
			document.docno.action = 'panelFunctions.asp';
			return true;==
		}
		else if((num.length >= 6)&&(num.length <=10)){
			if(num.substr(num.length-1,1)!='%'){	
				newNum = num + '%';
			}
			else if(num.substr(num.length-1,1) == '%'){
				newNum = num;
			}
			document.docno.doc_no.value = newNum;
			document.docno.action = 'wcList.asp';
			return true;
		
		}
		
		else if((num.length >10)&&(num.length <= 15)){
			newNum = num;
			
			if((newNum.substr(10,1) !== '-')&&(newNum.substr(10,1)!=='%')){
				newNum = newNum.substr(0,10) + '-' + newNum.substr(10);	
			}
			
			if((newNum.substr(newNum.length-1,1)!=='%')&&(newNum.length !=15)){
				newNum = newNum + '%';
				document.docno.action = 'wcList.asp';
				document.docno.doc_no.value = newNum;
				return true;
			}
			
			else if((newNum.length == 15)&&(newNum.substr(newNum.length-1,1)!=='%')){
				document.docno.action = 'panelFunctions.asp';
				document.docno.doc_no.value = newNum;
				return true;
				
			}
		document.docno.action = 'wcList.asp';
		document.docno.doc_no.value = newNum;
		return true;
		}
		
		else if((num.length == 16)&&(num.substr(num.length-1)=='%')){
			document.docno.action = 'wcList.asp';
			return true;
		}
		else if((num.length == 16)&&(num.substr(num.length-1)=='%')){
			newNum = num.substr(0,15);
			document.docno.doc_no.value = newNum;
			document.docno.action = 'panelFunctions.asp';
			return true;
		}	
		
		
//		else if((num.length > 15)&&(num.length <= 20)){
//			newNum = num;
//			if(num.substr(10,1) !== '-'){
//				newNum = newNum.substr(0,10) + '-' + newNum.substr(10);
///			}
//			if((num.substr(15,1) !== '-')&&(num.substr(15,1)!=='%')){
//				newNum = newNum.substr(0,15) + '-' + newNum.substr(15);
//			}
//			if(num.substr(15,1) =='%'){
//				document.docno.action = 'wcList.asp';
//				document.docno.doc_no.value = newNum;
//				return true;
//			}
//			if((newNum.length == 20)&&(newNum.substr(num.length -1,1) !== '%')){
//				document.docno.doc_no.value = newNum;
//				document.docno.action = 'panelFunctions.asp';
//				return true;	
//			}
//			else if(newNum.substr(num.length -1,1) == '%'){
//				document.docno.doc_no.value = newNum;
//				document.docno.action = 'wcList.asp';
//				return true;	
//			}
//			else if((newNum.length > 15)&&(newNum.length < 20)&&(newNum.substr(newNum.length-1,1) !== '%')){
//				newNum = newNum + '%';
//				document.docno.doc_no.value = newNum;
//				document.docno.action = 'wcList.asp';
//				return true;
//			}
//		}
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
			 document.docno.action = 'wcList.asp';
			 return true;
		}
		else if(newNum.length == 16){
			 if(newNum.substr(newNum.length-1,1)=='%'){
			 	document.docno.doc_no.value = newNum;
				document.docno.action = 'wcList.asp';
			return true;
			}
			else if(newNum.substr(newNum.length-1,1)!='%'){
				document.docno.doc_no.value = newNum;
				document.docno.action = 'panelFunctions.asp';
				return true;			
			}	
		}
		else if((newNum.length > 16)&&(newNum.length < 23)){
			if(newNum.substr(newNum.length-1,1) == '%'){
				document.docno.doc_no.value = newNum;
				document.docno.action = 'wcList.asp';
				return true;	
			}
			else if((newNum.length==21)&&(newNum.substr(17,1)!='P')&&(newNum.substr(newNum.length-1,1)!== '%')){
				document.docno.doc_no.value = newNum;
				document.docno.action = 'panelFunctions.asp';
				return true;	
			}
			else if(newNum.substr(newNum.length-1,1)!=='%'){
				newNum = newNum + '%';
				document.docno.doc_no.value = newNum;
				document.docno.action = 'wcList.asp';
				return true;			
			}
		}
		else if(newNum.length == 23){
			if(newNum.substr(newNum.length-1,1)!='%'){
				document.docno.doc_no.value = newNum;
				document.docno.action = 'panelFunctions.asp';
				return true;
			}
			else if(newNum.substr(newNum.length-1,1)=='%'){
				document.docno.doc_no.value = newNum;
				document.docno.action = 'wcList.asp';
				return true;
			}
		}
		else if((newNum.length ==24)&&(newNum.substr(newNum.length-1)=='%')){
			newNum = newNum.substr(0,23)
			document.docno.doc_no.value = newNum;
			document.docno.action = 'panelFunctions.asp';
		return true;
		}
	}
return false;
}

function reduce(){
document.getElementById("exTxt").style.visibility="hidden";
document.getElementById("parent").innerHTML ="<div onClick='return listDocTypes()' class='parent' id='parent'>Click Here to See Examples</div>";
}


function listDocTypes(){
	//alert("Purchase Request Number: '1300375371'\nContract Number: 'N68936-08-D-0016'\nBasic Modification: 'N68936-08-D-0016-P00001'\nDelivery Order Mod: 'N68936-08-D-0016-003001'\nSAP PO Number: '4530077316'\nWildcard Search (%): '13003753%', 'N68936-08-D-0016%' \nNote: Wildcard searches allow the user query for a list of documents like the user entered number.\nTo perform a wildcard search follow the number entered by the percentage sign(%)")
	
		document.getElementById("exTxt").style.visibility='visible';
		document.getElementById("parent").innerHTML="<div id ='parent' onclick = 'return reduce()'>Close Examples</div>";
		document.getElementById("exTxt").style.zIndex="3";
		document.getElementById("exTxt").style.position="absolute";
		document.getElementById("exTxt").style.borderTop="3px solid navy";
		document.getElementById("exTxt").style.borderBottom="1px solid navy";
		document.getElementById("exTxt").style.marginTop="50px";
		document.getElementById("exTxt").style.marginLeft="675px";
		document.getElementById("exTxt").style.color="navy";
		document.getElementById("exTxt").style.background="white";
		document.getElementById("exTxt").style.width="375px";
		document.getElementById("exTxt").style.padding="5px";
		document.getElementById("exTxt").style.textAlign="left";
		document.getElementById("exTxt").innerHTML="Purchase Request Number- &quot1300375371&quot</br>Purchase Request Modification- &quot1300375371-0001&quot </br>Award- &quotN68936-08-D-0016&quot</br>Basic Award Modification- &quotN68936-08-D-0016-P00001&quot</br>Solicitation- &quotN68936-07-R-0014&quot</br>Solicitation Amendments- &quotN68936-07-R-0014-0001&quot</br>Delivery Orders- &quotN68936-08-D-0016-0001&quot</br>Delivery Order Mods-&quotN68936-08-D-0016-000101&quot"

	}
function showAbout()
	{
	alert("Query was developed by the NAWCWD Contracts Business Systems Office (BSO)")
	}

