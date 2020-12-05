<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>단어, 필답 연습</title>
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link type="text/css" rel="stylesheet" href="/css/style.css" />
    <link type="text/css" rel="stylesheet" href="/css/style2.css" />
    <link
      href="https://fonts.googleapis.com/css?family=Oswald:400,700&display=swap"
      rel="stylesheet"
    />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link
      href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap"
      rel="stylesheet"
    />
    <link
      type="text/css"
      href="https://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css"
      rel="stylesheet"
    />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

 <style>
    body {
	background: #ddd;
}

body, input[type=text], input[type=password], button {
	margin: 0;
	font-size: 16px;
	font-family: sans-serif;
}

#panels, #panels > div {
	position: absolute;
}

#panels {
	max-width: 800px;
	margin: auto;
	box-shadow: 0 0 50px rgba(0,0,0,0.3);
	background: #efefef;
}

#panels > div {
	left: 0;
	right: 0;
}

#panels {
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	overflow: hidden;
}

#panels .topbar {
	top: 0;
	color: white;
	background-color: #5991B1;
	z-index: 3;
	cursor: default;
	height: 37px;
}

#panels .topbar.night {
	background-color: #48569E;
}

#panels .topbar.night.fall {
	height: 100%;
}

#panels .topbar .itsnight {
	position: absolute;
	top: 100%;
	left: 0;
	right: 0;
	text-align: center;
	opacity: 0;
	display: none;
}

#panels .topbar.night.fall .itsnight {
	display: block;
	opacity: 0.8;
	top: 50%;
	transform: translateY(-50%);
}

#panels .topbar .itsnight i {
	font-size: 3em;
	display: block;
	margin-bottom: 10px;
}

#panels .topbar .status {
	padding: 10px;
	height: 16px;
}

#panels .topbar .time {
	opacity: 0.6;
}

#panels .topbar .controls {
	float: right;
	font-size: 0;
	margin-right: 10px;
}

#panels .topbar .controls button {
	padding: 10px;
	font-size: 14px;
	border: 0;
	height: 37px;
	margin: 0;
	margin-left: 2px;
	background: none;
	color: white;
	outline: none;
}

#panels .players,
#panels .chatlog {
	top: 0;
	bottom: 0;
	padding: 46px 10px;
}

#panels .players > div,
#panels .players > div .bubble,
#panels .topbar,
#panels .players,
#panels .chatlog,
#panels .topbar .itsnight {
	transition: all 0.3s ease-in-out;
}

#panels .players > div {
	overflow: hidden;
	position: absolute;
	border: 1px solid transparent;
}

#panels .players > div .selection {
	display: none;
}

#panels .players.selectable > div {
	padding: 10px 15px;
	border-color: rgba(0,0,0,0.3);
	border-radius: 3px;
	cursor: pointer;
	box-sizing: border-box;
	background: white;
}

#panels .players.selectable > div:hover {
	background: none;
}

#panels .players.selectable > div.selected {
	color: white;
	background: red;
}

#panels .players.selectable > div .bubble {
	font-size: 0;
}

#panels .players.selectable > div .selection {
	display: inline;
}

#panels .chatlog {
	left: auto;
	right: -310px;
	width: 280px;
	border-left: 1px solid rgba(0,0,0,0.3);
	box-shadow: 0 0 30px rgba(0,0,0,0.4), 0 0 0 9999px rgba(0,0,0,0.1);
	opacity: 0;
	background: #eee;
}

#panels .chatlog.show {
	transform: translateX(-310px);
	opacity: 1;
}

#panels .chatlog .server {
	font-size: 0.8em;
	text-align: center;
	color: #b70000;
	margin: 5px 0;
}

#panels .action {
	bottom: 0;
	border-top: 1px solid rgba(0,0,0,0.3);
	z-index: 4;
}

#panels .action input,
#panels .action button,
#panels .action .disabled {
	padding: 10px;
	border: 0;
	display: block;
	box-sizing: border-box;
	outline: none;
	height: 36px;
	background: white;
}

#panels .action input {
	width: 100%;
}

#panels .action button {
	position: absolute;
	right: 0;
	top: 0;
	background: none;
	padding: 10px 16px;
}

#panels .action .choose button {
	position: static;
	width: 100%;
}

#panels .action .disabled {
	text-align: center;
}

#panels .action .choose,
#panels .action .disabled {
	display: none;
}
        #info{background-color: black; left; margin-left: 50px; font-size : 30px;}
        #inputContents{text-align: center; border-top-style: solid; border-top-color: black; padding-top: 5px;}
        #contents{width: 1200px; height: 800px; margin: 0 auto;}
        #tajaContents{width:100%; height: 95%; position: relative}
        #inputText{display:inline-block}
        #inputBtn{display:inline-block;}
    </style>
</head>
<body>
<div id="content">
      <div class="navbar navbar-fixed-top">
        <nav class="navbar-inner header">
          <div class="container">
<a href="/main/mainPage.do">
            <div class="brand" style="color : #f89406">QUIZ GENERATOR</div>
            </a>
            <ul class="nav pull-right">
              <li>
                <a class="nav-link" href="/main/MyPage.do"> MYPAGE </a>
              </li>
              <li>
                <a class="nav-link"> BOARD </a>
              </li>
            </ul>
            <div class="triangle-down center">
              <p>
                <i id="toggle" class="fa fa-chevron-down fa-2x isDown"></i>
              </p>
            </div>
          </div>
        </nav>
        <br />
      </div>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@점수랑 오타수 화면에 뜨는 부분@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
    <div id="info">
        <div id="score" class="btn btn-success"></div>
        <div id="life" class="btn btn-success"></div>
    </div>
    
    <div id="contents">
        <!-- 밑에 있는 tajaContents Div 안에 답을 적어주는 거임-->
        <div id="tajaContents"></div>
        <div id="inputContents">
            <div id="inputText">
                <input type="text" id="tajaText" class="btn btn-success">
            </div>
            <div id="inputBtn">
                <button id="tajaBtn" class="btn btn-success">문제시작</button>
            </div>
        </div>
    </div>
 <script>
    // ########################내려오게 할 단어의 목록을 배열로 선언 차후 문제 지문과 답 매핑하기 ###########################
var taja = ["니 이름은? ", "강서캠 위치는?", "수시 2차 면접일을 숫자로", "회장이름은?"];
     // 실제 입력되는 답안과 비교해서 맞으면 taja와 같은 인자값에 있는 값이 화면에서 사라짐 ##### 
var dap = ["최별규", "우장산", "1216", "양원석"];


// 밑에 선언한 tajaContents 안에 글자로 된 Div 들어감
var tajaContents = document.getElementById("tajaContents");

// tajaDiv를 다루기 위한 배열
var newObj = [];

// taja의 각 글자마다 top을 주기위한 배열 초기화 (글자를 내려오게 하기 위해 style 의 top을 이용
var plusTop = new Array(taja.length);
for (let i = 0; i < plusTop.length; i++) {
    plusTop[i] = 0;
}

// 글자의 div 크기를 고정해놓음 크기 수정(글자 크기 수정)
const TAJAWIDTH = 100;
const TAJAHEIGHT = 30;

// 그려지는 것 보다 내려오는게 간격이 더 짧게 함( setInterval의 시간 변수) 차후 옵션으로 수정가능하게 하기
const DRAWTIME = 1000;
const DOWNTIME = 600;

// 생명 변수
var life = 0;
var lifeDiv = document.getElementById("life");
lifeDiv.innerHTML = "틀린 문제 수 : " + life;

// 점수 변수
var score = 0;
var scoreDiv = document.getElementById("score");
scoreDiv.innerHTML = "정답 수 : " + score;

// taja배열의 index 값에 대한 변수
var idx = 0;

// 화면에 글자를 뿌려주기 위한 메서드
function drawTaja() {
    var randomPick = 0;
    var temp = null;

    /* 랜덤으로 taja배열을 섞어줄 때 사용 $$$$ 질문과 답의 인자값 같게 해주려고 미사용
    for (let i = 0; i < taja.length; i++) {
        randomPick = Math.round(Math.random() * (taja.length - 1));
        temp = taja[randomPick];
        taja[randomPick] = taja[i];
        taja[i] = temp;
    } */

   // 일정한 간격으로 화면에 단어를 하나씩 뿌려주기 위한 setInteval 메서드 
    var drawInterval = setInterval(function () {

        var leftWidth = Math.round(Math.random() * 1200);
        var tajaDiv = document.createElement("div");
        tajaDiv.classList.add("tajaWord");
        tajaDiv.style.width = TAJAWIDTH + "px";
        tajaDiv.style.height = TAJAHEIGHT + "px";
        tajaDiv.style.position = "absolute";
        tajaDiv.style.textAlign = "center";
        tajaDiv.innerHTML = taja[idx++];
        tajaContents.appendChild(tajaDiv);
        // leftWidth 변수가 0 < leftWidth < 1200 으로 설정되어있기 때문에
        // 글자의 width값 까지 더하게 되면 tajaContents의 범위를 넘어갈 수 있습니다.
        // 그래서 그 범위를 넘어가게 되면 안넘어가게 하기 위한 재설정해주는 부분입니다.
        if (leftWidth + TAJAWIDTH >= tajaContents.offsetWidth) {
            tajaDiv.style.left = (leftWidth - TAJAWIDTH) + "px";
        } else {
            tajaDiv.style.left = leftWidth + "px";
        }

        // 각각의 tajaDiv를 다루기 위해 newObj 배열에 담는다.
        newObj.push(tajaDiv);

        // 화면에 글자가 다 뿌려지면 더 이상 글자를 뿌려주기 위한
        // setInterval() 을 중지시킨다. ( 그렇지 않으면 글자가 다 뿌려진 이후에도 계속 동작하게 됩니다.)
        if (newObj.length === taja.length) {
            clearInterval(drawInterval);
        }
    }, DRAWTIME);
}
    </script>
    <script>
    // 글자를 내려주기 위한 메서드
function downTaja() {
    //글자가 뿌려진 이후에는 일정한 간격으로 글자를 내려줘야 함
    setInterval(function () {
    	var totalCount = taja.length;
    	// 총 문제수에서 40프로 이상 틀리면 죽는 것으로 설정함
    	var lifeCount = Math.round(taja.length * 0.4);
        for (let i = 0; i < taja.length; i++) {
            if (i < newObj.length) {
                newObj[i].style.top = plusTop[i] + "px";
                // 글자의 범위가 경계(바닥) 바깥으로 나갔을 경우 제거
                if (plusTop[i] + TAJAHEIGHT >= tajaContents.offsetHeight) {
                    if (tajaContents.contains(newObj[i])) {
                        tajaContents.removeChild(newObj[i]);
                        life++;
                        lifeDiv.innerHTML = "틀린 수 : " + life;

                        // 목숨을 모두 잃었을 때 - 실패
                        if (life === lifeCount) {
                            alert('총' + totalCount + '문제 중에서'+ lifeCount + '개를  틀려 불합격 입니다.');
                            alert('총 ' + score + '점을 획득! 합격!');
                            location.reload();
                        }

                        // life가 남은상태로 게임이 끝났을 경우 - 성공
                        if (newObj.length === taja.length) { // 화면에 단어가 다 뿌려진 이후
                            if (!tajaContents.hasChildNodes()) { // 뿌려진 단어가 화면에 존재하지 않을 경우
                                alert('다음 단계로 이동합니다.(준비중)');
                                alert('총 ' + score + '점을 획득하였습니다.');
                                location.reload();
                            }
                        }

                    }
                }
                plusTop[i] += 30;
            }
        }
    }, DOWNTIME);

}


var tajaText = document.getElementById("tajaText");
tajaText.addEventListener("keydown", function (e) {
    // enter 눌렀을 때
    if (e.keyCode === 13) {
        for (let i = 0; i < newObj.length; i++) {
            // 타자 친 단어와 배열에 저장된 값이 일치하면 동일한 인자갑을 가진 화면의 배열 값 삭제 
            if (tajaText.value === dap[i]) {
                tajaContents.removeChild(newObj[i]);
                score += 1;
                scoreDiv.innerHTML = "SCORE : " + score;

                // 더이상 화면에 뿌려질 단어가 없고
                // life를 다 소진하지않고 clear 했을 경우
                if (newObj.length === taja.length) {
                    if (!tajaContents.hasChildNodes()) {
                        alert('다음 단계로 이동합니다.(준비중)');
                        alert('총 ' + score + '점을 획득하였습니다.');
                        location.reload();
                    }

                }

            }
        }
        // enter 눌렀을 때 input 창 초기화
        tajaText.value = "";
    }
});

// 클릭 횟수에 대한 변수
var count = 0;

// 시작하기
var tajaBtn = document.getElementById("tajaBtn");
tajaBtn.addEventListener("click", function () {
    // 버튼을 눌렀을 때마다 메서드가 실행되므로 최초 1회만 실행되도록 count변수로 막음 ==
    if (count === 0) {
        drawTaja();
        downTaja();
    }
    count++;
});
    </script>
    <script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/animejs/2.2.0/anime.min.js"
      type="text/javascript"
    ></script>
    <script
      src="https://www.curtainsjs.com/build/curtains.min.js"
      type="text/javascript"
    ></script>
    <script src="/js/script.js" type="text/javascript"></script>
</body>
</html>