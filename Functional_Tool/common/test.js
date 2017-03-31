var activeField;

//this function fires off the show() function to display the active field and the hide() function to hide all other fields
function activate(field){
	show(field);
	hide(field);	
}



//this function receives the name of the field that the user wishes to modify and displays it to the user

function show(field){
	document.getElementById(field).style.display = 'block';	
}



// This function receives the name of the active field and disables any span that isn't the active

function hide(field){
	var fieldAr = new Array();
		fieldAr[0] = "unr";
		fieldAr[1] = "des";		
		fieldAr[2] = "cre";
		fieldAr[3] = "pal";
		fieldAr[4] = "req";		
		fieldAr[5] = "sig";
		fieldAr[6] = "dte";
		fieldAr[7] = "wkl";
	for(ii=0;ii<fieldAr.length;ii++){
		if(fieldAr[ii] != field){
			document.getElementById(fieldAr[ii]).style.display = 'none';
		}
	}
}