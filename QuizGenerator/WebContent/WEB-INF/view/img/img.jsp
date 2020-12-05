<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="poly.service.impl.OcrService"%>
<%@page import="poly.service.IOcrService"%>
<%@page import="poly.dto.OcrDTO"%>
<%@page import="static poly.util.CmmUtil.nvl"%>
<%@page import="poly.controller.ImgController"%>
<%
	String value = nvl((String)request.getAttribute("value"));
	ImgController ic = new ImgController();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>시험문제</title>
<meta name="viewport" content="width=device-width" />
<link type="text/css" rel="stylesheet"
	href="http://jcrop-cdn.tapmodo.com/v0.9.12/css/jquery.Jcrop.min.css" />
<!-- 추가 내용 시작-->
<link type="text/css" rel="stylesheet" href="/css/img.css" />
<!--  추가 내용 끝-->
<style type="text/css">

<!--############ 오렌지 바탕화면 CSS 시작 ############### -->  
    body {
  margin: 0;
  padding: 0;
  overflow: hidden;
}
  .Home {
    display: block;
  }

    .Home-wrapper {
      display: block;
      width: 100%;
      height: 100%;
    }

      .Side-left {
        background-color: #FF6600;
        height: 100%;
        left: -100%;
        overflow: hidden;
        position: absolute;
        top: 0;
        transform: skew(-45deg);
        width: 150%;
        z-index: 5;

      }
        .Side-left-wrapper {
          width: 100%;
          height: 100%;
        }
          .Side-left-image {
            background:url(http://twin-dev.net/experiments/codevember/diagonal-homepage/img/office-day.svg) center no-repeat transparent;
            height: 100%;
            left: 50%;
            position: absolute;
            top: 0;
            transform: skew(45deg);
            width: 100%;
          }

        .Side-right {
          width: 100%;
          height: 100%;
          position: absolute;
          background-color: #FFA500;
        }
          .Side-right-image {
            position: absolute;
            top: 0;
            right: 0;
            width: 100%;
            height: 100%;
            background: url(http://twin-dev.net/experiments/codevember/diagonal-homepage/img/office-night.svg) center no-repeat transparent;
          }

.Signature {
  position: absolute;
  z-index: 100;
  bottom: 20px;
  right: 20px;
  color: #fff;
  line-height: .2;
  font-size: .7em;
  font-family: Open Sans, sans-serif;
}


@media screen and (max-width: 768px) {

  .Side-left {
    top: -65%;
    left: 0;
    transform: skewY(-35deg);
    width: 100%;
  }
    .Side-left-image {
      background-size: 65%;
      left: 0;
      top: 50%;
      transform: skewY(35deg);
    }

  .Side-right-image {
    top: -15%;
    background-size: 65%;
  }

}
<!--############ 오렌지 바탕화면 CSS 끝 ############### --> 
.qna__ques {
	text-align: center;
}

canvas, #uploadFile, .qna__btn__edit, .qna__btn__cut, .qna__btn__enroll
	{
	display: none;
}

html, body {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
}
</style>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript"
	src="http://jcrop-cdn.tapmodo.com/v0.9.12/js/jquery.Jcrop.min.js"></script>
<script type="text/javascript" src="../../../js/pixelate.js"></script>
<script type="text/javascript" src="../../../js/html2canvas.js"></script>
<!--############ 오렌지 바탕화면 스크립트 시작###############-->  
<script type="text/javascript">
   $( document ).ready(function() {

	  $( window ).resize(function() {

	    windowSize = $( window ).width();

	    if (windowSize >= 768) {
	      mouseMove();
	    } else {
	      $(".js-Side-left").css({
	        "left": 0
	      });

	      // Image translation
	      $(".js-Side-left-image").css({
	        "margin-left": 0
	      });

	      $(".js-Side-right-image").css({
	        "right": 0
	      });
	    }
	    
	  });

	  var windowSize = $( window ).width();

	  // 마우스 이벤트 시 작동
	  function mouseMove() {

	    $( ".js-Home-desktop-wrapper" ).mouseover(function( event ) {//mousemove(function( event ) { mouseover(function( event ) 
	      if (windowSize >= 768) {

	        var mouseX = event.pageX,
	          result = mouseX * 100/windowSize,
	          move   = -(windowSize/2) - mouseX;

	        $(".js-Side-left").css({
	          "left": move
	        });

	        // Image translation
	        $(".js-Side-left-image").css({
	          "margin-left": -windowSize - move+(mouseX-(windowSize/2))/40,
	        });

	        $(".js-Side-right-image").css({
	          "right": -(mouseX-(windowSize/2))/40,
	        });
	      }
	    });
	  }

	  mouseMove();
	  
	}); 
</script>
<!--############ 오렌지 바탕화면 스크립트 끝###############--> 
<script type="text/javascript">
      let jcropApi = null;
      let count = 0;
      // @breif 이미지 크롭 영역지정 UI 나타내기
      function imgCropDesignate() {
        let editWidth = $("#editImg").width();
        let editHeight = $("#editImg").height();

        // @breif jcrop 실행시 크롭영역을 미리 세팅

        let x1 = 0;
        let y1 = 0;
        let x2 = 100;
        let y2 = 100;


        /*
        let x1 = window.screen.width / 2 - editWidth;
        let y1 = window.screen.height / 2 - editHeight;
        let x2 = editWidth / 1.5;
        let y2 = editHeight / 1.5;
        */


        // @breif jcrop 실행
        $("#editImg").Jcrop(
          {
            bgFade: true,
            bgOpacity: 0.2,
            setSelect: [x1, y1, x2, y2],
            onSelect: updateCoords,
            maxSize: [10000,100]
          },
          function () {
            jcropApi = this;
          }
        );

        $(".jcrop-holder").css("position", "absolute");
        $(".jcrop-holder").css("right", "0");
        $(".jcrop-holder").css("bottom", "0");
        $(".jcrop-holder").css("width", "100%");
        $(".jcrop-holder").css("height", "100%");

        $(".qna__btn__edit").css("display", "none");
        $(".qna__btn__cut").css("display", "inline");
        $(".qna__btn__enroll").css("display", "inline");
      }

      // @breif 지정된 크롭 한 영역( 좌표, 넓이, 높이 )의 값을 보관하는 함수
      function updateCoords(crap) {
        $("#xAxis").val(crap.x);
        $("#yAxis").val(crap.y);
        $("#wLength").val(crap.w);
        $("#hLength").val(crap.h);
      }

      // @breif 크롭한 영역 잘라내고 추출하기
      function imgCropApply() {
        if (parseInt($("#wLength").val()) == "NaN") {
          alert("이미지를 크롭한 이후\n자르기 버튼을 클릭하세요.");
          return false;
          } else {
            for (cnt = 1; cnt < 6; cnt++) {
            let crop_img = "#crop__img__0" + cnt;
            let crop_id = document.querySelector(crop_img).src;
              if (crop_id !== undefined && crop_id !== "") continue;
            let edit_img = "#editImg";
            let crop_img_sel = document.querySelector(crop_img);
            //let imgArea_sel = document.querySelector(".imgArea");
            //let new_img = document.createElement("img");
            //imgArea_sel.appendChild(new_img);
            //crop_img_sel.appendChild(new_img);
            //new_img.setAttribute("id", crop_img);

            let editImage = new Image();
            editImage.src = $("#editImg").attr("src");

            editImage.onload = function () {
              // @breif 캔버스 위에 이미지 그리기
              let canvas = document.querySelector("canvas");
              let canvasContext = canvas.getContext("2d");

              // @breif 캔버스 크기를 이미지 크기와 동일하게 지정
              canvas.width = $("#wLength").val();
              canvas.height = $("#hLength").val();
              canvasContext.drawImage(
                this,
                $("#xAxis").val(), // 자르기를 시작할 x좌표
                $("#yAxis").val(), // 자르기를 시작할 y좌표
                $("#wLength").val(), // 잘라낸 이미지의 넓이
                $("#hLength").val(), // 잘라낸 이미지의 높이
                0, // 캔버스에 이미지를 배치할 x좌표
                0, // 캔버스에 이미지를 배치할 y좌표
                $("#wLength").val(), // 사용할 이미지의 넓이(이미지 스트레칭 또는 축소)
                $("#hLength").val() // 사용할 이미지의 높이(이미지 스트레칭 또는 축소)
              );

              // @breif 편집한 캔버스의 이미지를 화면에 출력한다.
              let dataURI = canvas.toDataURL("image/jpeg");
              //let crop_id = document.getElementById(crop_img);
              let edit_id = document.querySelector(edit_img);

              crop_img_sel.setAttribute("src", dataURI);
              crop_img_sel.style.width = $("#wLength").val();
              crop_img_sel.style.height = $("#hLength").val();
              //$("#editImg"+cnt).attr("src", dataURI);

              let temp_img = document.createElement("img");
              temp_img.setAttribute("src", "../../../img/0" + cnt + ".jpg");
              temp_img.setAttribute("id", "shade__img__0"+cnt);

              temp_img.style.position = "absolute";
              //temp_left = parseInt($("#xAxis").val()) + document.querySelector("#pic_id").offsetLeft;
              //temp_img.style.left = temp_left + "px";
              temp_img.style.left = $("#xAxis").val() + "px";
              temp_img.style.top = $("#yAxis").val() + "px";
              temp_img.style.width = $("#wLength").val() + "px";
              temp_img.style.height = $("#hLength").val() + "px";

              let temptemp = document.querySelector(".qna__ques__pic");
              temptemp.appendChild(temp_img);
              // 원본 이미지를 모자이크 크기만큼 그리기
              canvasContext.drawImage(
                canvas,
                $("#xAxis").val(),
                $("#yAxis").val(),
                $("#wLength").val(),
                $("#hLength").val()
              );

              $(".qna__ques").css("position", "relative");

              // 이미지 사이즈 크기 조절 시에 대한 안티앨리어싱 끄기
              canvasContext.msImageSmoothingEnabled = false;
              canvasContext.mozImageSmoothingEnabled = false;
              canvasContext.webkitImageSmoothingEnabled = false;
              canvasContext.imageSmoothingEnabled = false;

              // 이미지를 원본 사이즈로 다시 그리면 모자이크 완성
              canvasContext.drawImage(
                canvas,
                $("#xAxis").val(),
                $("#yAxis").val(),
                $("#wLength").val(),
                $("#hLength").val(),
                $("#xAxis").val(),
                $("#yAxis").val(),
                canvas.width,
                canvas.height
              );

              /*var pixelate = new Pixelate(qrepImage, {
              amount: 0.7, // default: 0, pixelation percentage amount (range from 0 to 1)
          });*/
              //crop_id.onload = drawImageActualSize; // Draw when image has loaded

              // @breif 이미지의 크기는 자른 이미지와 동일하게 지정
              //$("#editImg"+cnt).css("width", $("#wLength").val());

              //$("#editImg"+cnt).css("height", $("#hLength").val());
              
		 		console.log("dfdfsdfsdfsdf"+dataURI);

               $.ajax({
                url: '/img/img2.do',
                async : false,
                type : "get",
                data : {base64 : dataURI,
                        num : cnt},
                success: function(data){
                	console.log("성공");
                	console.log(data);
                	document.querySelector("#answer_0"+cnt).setAttribute("value", data);

                	
                }
              }) 
              
              //document.querySelector("#answer_0"+cnt).setAttribute("value", data);
			
              imgCropDesignate();

            };
            
              
              //document.querySelector("#answer_0"+cnt).setAttribute("value", data);
            //$("#cutBtn").css("display", "none");

            // @details JCROP을 종료한다.
            jcropApi.destroy();
            jcropApi = null;
            break;
          }
        }
      }

      /*  function drawImageActualSize() {
    	  // Use the intrinsic size of image in CSS pixels for the canvas element
    	  canvas.width = this.naturalWidth;
    	  canvas.height = this.naturalHeight;

    	  // Will draw the image as 300x227, ignoring the custom size of 60x45
    	  // given in the constructor
    	  canvasContext.drawImage(this, $("#xAxis").val(), $("#yAxis").val());

    	  // To use the custom size we'll have to specify the scale parameters 
    	  // using the element's width and height properties - lets draw one 
    	  // on top in the corner:
    	  canvasContext.drawImage(this, $("#xAxis").val(), $("#yAxis").val(), $("#wLength").val(), $("#hLength").val(), $("#xAxis").val(), $("#yAxis").val(), canvas.width, canvas.height);
			
    } */
      
      // @breif 이미지 업로드 함수
      function uploadImgFilePrinted(up) {
        // @details 업로드 파일 정보를 받아온다.
        
        let fileInfo = document.querySelector("#"+up).files[0];
        //let fileInfo = document.getElementById("uploadFile").files[0];
        let reader = new FileReader();

        reader.onload = function () {
          // @details 업로드 이미지 출력
          $("#editImg").attr("src", reader.result);

          // @details 이미지 크기를 제목 영역과 같게 출력
          //$("#editImg").css("width", $("h1").width());

          // @details 이미지 업로드 기능 제거, 추가 업로드 방지
          $("#editImg").parent("a").removeAttr("onClick");

          // @details 편집버튼 노출
          $(".qna__btn__edit").css("display", "inline");

          $(".qna__ques").css("postion", "relative");

          //$("#editImg").css("width", "470px");
          //$("#editImg").css("height", "664.58px");
          //$("#editImg").css("height", "100%");
          //$("#editImg").css("width", "70.72135785%");
          //$("#editImg").css("width", $("#editImg").height() / 1.414 +"px");
          //$("#editImg").css("padding-bottom", "70.72135785%");

          canvasDrawImage(function () {
            alert("이미지 업로드가 완료되었습니다.");
          });
        };

        if (fileInfo) {
          // @details readAsDataURL을 통해 업로드한 파일의 URL을 읽어 들인다.
          reader.readAsDataURL(fileInfo);
        }
        
      }

      // @breif 캔버스 이미지 생성
      function canvasDrawImage(callback) {
        let prepImage = new Image();
        prepImage.src = $("#editImg").attr("src");

        prepImage.onload = function () {
          // @details 캔버스 위에 이미지 그리기
          // jQuery("canvas") 와같은 명령은 사용할 수 없다.
          let canvas = document.querySelector("canvas");
          let canvasContext = canvas.getContext("2d");

          canvas.width = $("#editImg").width();
          canvas.height = $("#editImg").height();
          canvasContext.drawImage(
            this,
            0,
            0,
            $("#editImg").width(),
            $("#editImg").height()
          );

          // @details 캔버스의 이미지
          let dataURI = canvas.toDataURL("image/jpeg");
          $("#editImg").attr("src", dataURI);

          callback();
        };
      }

      // 되돌리기
      function cancelCropImage(cnt) {
        
        let crp_img = "#crop__img__" + cnt;
        document.querySelector(crp_img).removeAttribute('src');

        let shade_img = "#shade__img__" + cnt;
        let shade_id = document.querySelector(shade_img);
        let input_value = "#answer_" + cnt;
        let input_id = document.querySelector(input_value);
        shade_id.parentNode.removeChild(shade_id);
        input_id.removeAttribute('value');
        //$('shade__img__' + cnt).remove();
        //$( crp_img ).removeAttr( 'src' );

        
        /*if (cnt > 0) {
          let cropImg = document.querySelector(".crop_img");
          let shade = document.querySelector(".qna__ques");

          cropImg.removeChild(cropImg.lastChild);
          shade.removeChild(shade.lastChild);

          cnt--;
        }*/

        //if (cnt == 0) $(".btn").css("width", "50%");
        //else $(".btn").css("width", "10%");
      }

      // 전체 스샷
      /* function bodyShot() { 
    	html2canvas(document.body)
    	//document에서 body 부분을 스크린샷을 함.
    	.then(
    			function (canvas) {
    				//canvas 결과값을 drawImg 함수를 통해서
    				//결과를 canvas 넘어줌.
    				//png의 결과 값
    				drawImg(canvas.toDataURL('image/png'));
    				
    				//appendchild 부분을 주석을 풀게 되면 body
    				//document.body.appendChild(canvas);
    				
    				//특별부록 파일 저장하기 위한 부분.
    				saveAs(canvas.toDataURL(), 'file-name.png');
    				}).catch(function (err) {
    					console.log(err);
    					});
    	} */

      // 부분 스샷
      function partShot() {
        //특정부분 스크린샷
        html2canvas(document.querySelector(".qna__ques"))
          //id container 부분만 스크린샷
          .then(function (canvas) {
            //jpg 결과값
            drawImg(canvas.toDataURL("image/jpeg"));
            //이미지 저장
            saveAs(canvas.toDataURL(), "file-name.jpg");
          })
          .catch(function (err) {
            console.log(err);
          });
      }

      function drawImg(imgData) {
        console.log(imgData);
        //imgData의 결과값을 console 로그롤 보실 수 있습니다.
        return new Promise(
          function resolve() {
            //내가 결과 값을 그릴 canvas 부분 설정
            var canvas = document.getElementById("canvas");
            var ctx = canvas.getContext("2d");
            //canvas의 뿌려진 부분 초기화
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            var imageObj = new Image();
            imageObj.onload = function () {
              ctx.drawImage(imageObj, 10, 10);
              //canvas img를 그리겠다.
            };
            imageObj.src = imgData;
            //그릴 image데이터를 넣어준다.
          },
          function reject() {}
        );
      }

      function saveAs(uri, filename) {
        var link = document.createElement("a");
        if (typeof link.download === "string") {
          link.href = uri;
          link.download = filename;
          document.body.appendChild(link);
          link.click();
          document.body.removeChild(link);
        } else {
          window.open(uri);
        }
      }

    </script>
</head>
<!--################오렌지 바탕화면 시작 div #########-->
<body>

    
   <div class="Home">

    <div class="Home-wrapper js-Home-desktop-wrapper">
 
      <section class="Side-left js-Side-left">
        <div class="Side-left-wrapper"></div>
          <div class="Side-left-image js-Side-left-image"></div>
      </section>

      <section class="Side-right">
        <div class="Side-right-image js-Side-right-image"></div>
      </section>

    </div>
  

<!--################오렌지 바탕화면 끝 div #########-->  

	<input type="hidden" id="xAxis" value="0" placeholder="선택영역의_x좌표" />
	<input type="hidden" id="yAxis" value="0" placeholder="선택영역의_y좌표" />
	<input type="hidden" id="wLength" value="0" placeholder="선택영역의_w넓이" />
	<input type="hidden" id="hLength" value="0" placeholder="선택영역의_h높이" />
	<input type="file" id="uploadFile"
		onChange="uploadImgFilePrinted('uploadFile');" accept="image/*" />
<div class="Home">
	<div class="qna" id="qna">
		<div class="qna qna__ques_o" id="qna__ques">
			<div class="qna__ques qna__ques__title title">
				<h3 class="title">
					<a href="#">과목</a> - <a href="#">소제목</a>
					</h3>
			</div>
			<!-- 선택자 추가-->
			<div class="Home-wrapper js-Home-desktop-wrapper">
			<div class="qna__ques qna__ques__pic">
				<a href="javascript:;" onClick="$('#uploadFile').click();"
					id="pic_id"> <img id="editImg" src="../../../img/user.png">
				</a>
			</div>
			<canvas id="canvas"></canvas>
		</div>
		<div class="btn qna qna__btn" id="qna__btn">
			<div class="btn qna__btn qna__btn__edit">
				<input type="button" value="편집" onClick="imgCropDesignate();" />
			</div>
			<div class="btn qna__btn qna__btn__upload">
				<input type="file" name="file" id="uploadAnother"
					onChange="uploadImgFilePrinted('uploadAnother');" accept="image/*"
					style="display: none;" />
				<div class="button" onClick="$('#uploadAnother').click();">업로드</div>
			</div>
			<div class="btn qna__btn qna__btn__cut">
				<input type="button" value="자르기" onClick="imgCropApply();" />
			</div>
			<div class="btn qna__btn qna__btn__enroll">
				<input type="button" value="등록" />
			</div>
			<div class="btn qna__btn qna__btn__cap">
				<input type="button" value="임시캡쳐" onclick="partShot();" />
			</div>
		</div>
</div>
</div>
		<div class="qna qna__ans" id="qna__ans">
			<div class="qna__ans qna__ans__title title">
				<h3 class="title">
					<a href="#">문제리스트</a>
					</h3>
			</div>
			<div class="qna__ans qna__ans__group" id="qna__ans__group">
				<div class="qna__ans__grp ans__group__01">
					<span class="qna__ans__group__num">01</span>
					<div class="qna__ans__group__pic qna__ans__group__pic__01">
						<img id="crop__img__01">
					</div>
					<span class="qna__ans__group__arrow">-></span> <span
						class="qna__ans__group__answer"> <input type="text"
						class="answer" id="answer_01" />
					</span> <span class="btn qna__ans__group qna__ans__group__btn"> <input
						type="button" value="지우기" class="btn btn__cut btn__cut__01"
						onClick="cancelCropImage('01');" />
					</span>
				</div>
				<div class="qna__ans__grp ans__group__02">
					<span class="qna__ans__group__num">02</span>
					<div class="qna__ans__group__pic qna__ans__group__pic__02">
						<img id="crop__img__02">
					</div>
					<span class="qna__ans__group__arrow">-></span> <span
						class="qna__ans__group__answer"> <input type="text"
						class="answer" id="answer_02" />
					</span> <span class="btn qna__ans__group qna__ans__group__btn"> <input
						type="button" value="지우기" class="btn btn__cut btn__cut__02"
						onClick="cancelCropImage('02');" />
					</span>
				</div>
				<div class="qna__ans__grp ans__group__03">
					<span class="qna__ans__group__num">03</span>
					<div class="qna__ans__group__pic qna__ans__group__pic__03">
						<img id="crop__img__03">
					</div>
					<span class="qna__ans__group__arrow">-></span> <span
						class="qna__ans__group__answer"> <input type="text"
						class="answer" id="answer_03" />
					</span> <span class="btn qna__ans__group qna__ans__group__btn"> <input
						type="button" value="지우기" class="btn btn__cut btn__cut__03"
						onClick="cancelCropImage('03');" />
					</span>
				</div>
				<div class="qna__ans__grp ans__group__04">
					<span class="qna__ans__group__num">04</span>
					<div class="qna__ans__group__pic qna__ans__group__pic__04">
						<img id="crop__img__04">
					</div>
					<span class="qna__ans__group__arrow">-></span> <span
						class="qna__ans__group__answer"> <input type="text"
						class="answer" id="answer_04" />
					</span> <span class="btn qna__ans__group qna__ans__group__btn"> <input
						type="button" value="지우기" class="btn btn__cut btn__cut__04"
						onClick="cancelCropImage('04');" />
					</span>
				</div>
				<div class="qna__ans__grp ans__group__05">
					<span class="qna__ans__group__num">05</span>
					<div class="qna__ans__group__pic qna__ans__group__pic__05">
						<img id="crop__img__05">
					</div>
					<span class="qna__ans__group__arrow">-></span> <span
						class="qna__ans__group__answer"> <input type="text"
						class="answer" id="answer_05" />
					</span> <span class="btn qna__ans__group qna__ans__group__btn"> <input
						type="button" value="지우기" class="btn btn__cut btn__cut__05"
						onClick="cancelCropImage('05');" />
					</span>
				</div>
			</div>
		</div>
		<!--
      <div class="imgArea" style="float: left; width: 50%">
        <a href="javascript:;" onClick="$('#uploadFile').click();" id="pic_id">
          <img id="editImg" src="../../../img/user.png"/ width="50%"
          height="50%">
        </a>
        <br />
      </div>

      <div class="crop_img" style="float: right; width: 40%"></div>
      <div class="btn" style="float: right; width: 50%">
        <input
          id="editBtn"
          type="button"
          onClick="imgCropDesignate();"
          value="편집"
        />
        <input
          id="cutBtn"
          type="button"
          onClick="imgCropApply();"
          value="자르기"
          style="text-align: center"
        />
        <br />
        <input
          id="canBtn"
          type="button"
          onClick="cancelCropImage();"
          value="되돌리기"
          style="text-align: center"
        />
        -->
		<!-- 전체 부분
        <button onclick=bodyShot()>bodyShot</button>-->
		<!-- 일부분-->
		<!--
        <button onclick="partShot()">partShot</button>
-->
		<!-- 결과화면을 그려줄 canvas 
        <canvas id="canvas" width="900" height="600" style="border:1px solid #d3d3d3;"></canvas>-->
	</div>
	<!--
      <canvas id="canvas"></canvas>
      -->
	</div>
	
	<!-- CSS 시그니초 표식 -->
	<aside class="Signature">
      <p>Codevember #1 - Twindev</p>
      <p>Diana Marchal & Nathalie Marchal</p>
    </aside>
  </div>
</body>
</html>
