<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title>QUIZ GENERATOP LOGIN</title>
<!-- 카카오 REST API 사용을 위해 꼭 쓰기 -->
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js">
</script>
<script type="text/javascript">

function doRegUserCheck(f) {

	if (f.user_id.value == "") {
		alert("아이디를 입력하세요.");
		f.user_id.focus();
		return false;
	}
	
	if (f.password.value == "") {
		alert("비밀번호를 입력하세요.");
		f.password.focus();
		return false;
	}
}
</script>
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
.kakao{
padding: 10px;
margin-top:20px;
}
</style>
</head>
<body>
	<div class="contain">
		<h1>Quiz Generator</h1>
		<div class="inputs">
		    <form name="f" method="post" action="/LoginPost.do" onsubmit="return doRegUserCheck(this);"> 
				<label>아이디   </label> <input type="text" placeholder="아이디" class="input" name="user_id"> 
				<label>비밀번호</label> <input type="password"placeholder="비밀번호" class="input" name="password">
				<button class="go" type="submit">로그인</button>
				<button class="go" type="button" onclick="location.href='/insertMember.do'">회원가입</button>
			</form>
			
			<div class="kakao">
				<!--client key는 REST API 키 redirect key는 개발자 플랫폼에 등록된 거-->
				<!--<c:if test="${userId eq null}">-->
				<a
					href="https://kauth.kakao.com/oauth/authorize?client_id=fb949699752a4185310c104921155f37&redirect_uri=http://localhost:8080/main/mainPage.do&response_type=code"><img
					src="../../img/kakao_login_medium_wide.png"> </a>
				<!--</c:if> -->
			</div>
		</div>
	</div>
</body>
</html>