<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 화면</title>
<style type="text/css">
<style type="text/css">
*{
  box-sizing:border-box;
  margin:0;
  padding:0;
}
body{
  font-family: Arial;
  position:relative;
  background: #272727;
}

.contain{
  positon:relative;
  width:100%;
  height:100vh;
  text-align: center;
}
h1{
  font-size:40px;
  color:aliceblue;
}

.inputs{
  text-align:center;
  position:absolute;
  top:50%;
  width:450px;
  color:aliceblue;
  padding:50px;
  height:auto;
  left:50%;
  transform:translate(-50%,-50%);
}

.input{
  width:100%;
  margin: 15px 0;
  outline: none;
  padding: 15px 12px;
  color:aliceblue;
  border:none;
  border-radius:20px;
  box-shadow: 5px 5px 10px rgba(0,0,0,0.7) ,-5px -5px 10px rgba(255,255,255,0.1);
  background:transparent;
}

.input:focus{
    box-shadow: inset 5px 5px 10px rgba(0,0,0,0.7) , inset -5px -5px 10px rgba(255,255,255,0.1);
}

.go{
  text-align:center;
  outline:none;
  text-decoration:none;
  margin-top:10px;
  color:aliceblue;
  background:transparent;
  width:80px;
  border:none;
  height:80px;
  border-radius:50%;
  margin-left: 20px;
 box-shadow: 5px 5px 10px rgba(0,0,0,0.7) ,-5px -5px 10px rgba(255,255,255,0.1); 
}

.go:focus{
      box-shadow: inset 5px 5px 10px rgba(0,0,0,0.7) , inset -5px -5px 10px rgba(255,255,255,0.1);
}
</style>
<script type="text/javascript">
    // 이메일 인증 서비스 만들기
	// 회원가입 유효성 체크 
	function doRegUserCheck(f) {

		if (f.user_name.value == "") {
			alert("이름을 입력하세요.");
			f.user_name.focus();
			return false;
		}

		if (f.password.value == "") {
			alert("비밀번호을 입력하세요.");
			f.password.focus();
			return false;
		}

		if (f.password2.value == "") {
			alert("비밀번호확인 입력하세요.");
			f.password2.focus();
			return false;
		}

		if (f.email.value == "") {
			alert("이메일을 입력하세요.");
			f.email.focus();
			return false;
		}

		if (f.sex.value == "") {
			alert("성별을 입력하세요.");
			f.sex.focus();
			return false;
		}

		if (f.user_an.value == "") {
			alert("닉네임 입력하세요.");
			f.user_an.focus();
			return false;
		}
	}
     // <!-- 이메일 전송을 위한 함수-->
	function emailCheckProc() {
		var emailCheck = document.getElementById("email").value;
		if(emailCheck == ""){
			alert("이메일을 입력해주세요");
			email.focus();
			return false;
		}else{
		console.log(emailCheck);
		alert("이메일발송이 완료되었습니다.");
		location.href="/user/createEmailCheck.do"
		}
	}
</script>


</head>

<body>
	<div class="contain">
		<div class="inputs">
			<h1>QUIZ GENERATOR 가입</h1>

			<form name="f" method="post" action="insertMember.do" onsubmit="return doRegUserCheck(this);">
				<label>이름 </label> <input type="text" placeholder="이름" class="input" name="user_name"> 
				<label>아이디 </label> <input type="text" placeholder="아이디" class="input" name="user_id"> 
				<label>비밀번호</label> <input type="password" placeholder="비밀번호" class="input" name="password">
				<label>비밀번호 확인</label> <input type="password" placeholder="비밀번호 확인" class="input" name="password2">
					
				<div>
					<label>이메일</label><input type="email" placeholder="이메일"
						class="input" name="password">
					<button type="button" class=" " id="emailCheck"
						onclick="emailCheckProc();">인증문자발송</button>
				</div>
				<br>
				<div>
					<label>인증번호 확인</label> <input type="email" placeholder="인증번호"
						class="input" name="인증">
					<button type="button" class="login100-form-btn" id="emailAuth">
						이메일 인증</button>
				</div>
				<br> <input type="hidden" path="random" id="radom"
					value="${random }" />

				<div class="container-login100-form-btn p-t-10">
					<button type="submit" class="login100-form-btn">완료</button>
				</div>
			</form>
			<br>
			<div class="container-login100-form-btn p-t-10">
				<a href="/Login.do" class="login100-form-btn"> <!-- href 앞에 /와 끝에 .do를 붙혀라 -->
					취소
				</a>
			</div>
		</div>
	</div>
</body>
</html>