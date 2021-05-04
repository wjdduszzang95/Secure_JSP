function inputCheck(){
	if(document.regForm.id.value==""){
		alert("아이디를 입력해 주세요");
		document.regForm.id.focus();
		return;
	}
	if(document.regForm.pwd.value==""){
		alert("비밀번호를 입력해 주세요");
		document.regForm.pwd.focus();
		return;
	}
	if(document.regForm.repwd.value==""){
		alert("비밀번호를 입력해 주세요");
		document.regForm.repwd.focus();
		return;
	}
	if(document.regForm.name.value==""){
		alert("이름을 입력해 주세요");
		document.regForm.name.focus();
		return;
	}

	if(document.regForm.pwd.value != document.regForm.repwd.value){
		alert("비밀번호가 일치하지 않습니다");
		document.regForm.repwd.focus();
		return;
	}
	document.regForm.submit();
}