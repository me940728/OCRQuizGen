<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
	
	<link type="text/css" rel="stylesheet" href="http://jcrop-cdn.tapmodo.com/v0.9.12/css/jquery.Jcrop.min.css"/>
	<style type="text/css">
    .imgArea { text-align:center; }
    canvas, #uploadFile, #editBtn, #cutBtn, #canBtn { display:none; }
    body { overflow:auto; };
	</style>

    <title>문제 작업장</title>

    <!-- Bootstrap Core CSS -->
    <link type="text/css" rel="stylesheet" href="../../css/bootstrap.min.css"  >

    <!-- Custom CSS -->
    <link type="text/css" rel="stylesheet" href="../../css/grayscale.css"  >

    <!-- Custom Fonts -->
    <link type="text/css" href="../../font-awesome/css/font-awesome.min.css" rel="stylesheet" >
    <link type="text/css" href="http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" >
    <link type="text/css" href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="http://jcrop-cdn.tapmodo.com/v0.9.12/js/jquery.Jcrop.min.js"></script>
<script type="text/javascript" src="../../js/pixelate.js"></script>
<script type="text/javascript" src="../../js/html2canvas.js"></script>
<!-- jQuery -->
<!--  <script type="text/javascript" src="../../js/jquery.js"></script>-->
<!-- Bootstrap Core JavaScript -->
<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
<!-- Plugin JavaScript -->
<script type="text/javascript" src="../../js/jquery.easing.min.js"></script>
<!-- Custom Theme JavaScript -->
<script type="text/javascript" src="../../js/grayscale.js"></script>
<script type="text/javascript">

    let jcropApi = null;
	let cnt = 0;

    // @breif 이미지 크롭 영역지정 UI 나타내기
    function imgCropDesignate() {

        let editWidth = $("#editImg").width();
        let editHeight = $("#editImg").height();

        // @breif jcrop 실행시 크롭영역을 미리 세팅
        let x1 = window.screen.width / 2 - editWidth;
        let y1 = window.screen.height / 2 - editHeight;
        let x2 = editWidth / 1.5;
        let y2 = editHeight / 1.5;

        // @breif jcrop 실행
        $("#editImg").Jcrop({
              bgFade : true
            , bgOpacity : .2
            , setSelect : [ x1, y1, x2, y2 ]
            , onSelect : updateCoords
        }, function() {
            jcropApi = this;

        });

        $("#editBtn").css("display", "none");
        $("#cutBtn").css("display", "inline");
        $("#canBtn").css("display", "inline");
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
    	if (cnt == 0) $(".btn").css("width","50%");
    	else $(".btn").css("width", "10%");
        if(parseInt($("#wLength").val()) == "NaN") {
            alert("이미지를 크롭한 이후\n자르기 버튼을 클릭하세요.");
            return false;

        } else {

			let crop_img = "#editImg"+cnt;
			let edit_img = "#editImg";
			let crop_img_sel = document.querySelector(".crop_img");
			//let imgArea_sel = document.querySelector(".imgArea");
			let new_img = document.createElement("img");
			//imgArea_sel.appendChild(new_img);
			crop_img_sel.appendChild(new_img);
			new_img.setAttribute("id",crop_img);
			
            let editImage = new Image();
            editImage.src = $("#editImg").attr("src");

            editImage.onload = function() {

                // @breif 캔버스 위에 이미지 그리기
                let canvas = document.querySelector("canvas");
                let canvasContext = canvas.getContext("2d");
                
                // @breif 캔버스 크기를 이미지 크기와 동일하게 지정
                canvas.width = $("#wLength").val();
                canvas.height = $("#hLength").val();
                canvasContext.drawImage(
                      this
                    , $("#xAxis").val()      // 자르기를 시작할 x좌표
                    , $("#yAxis").val()      // 자르기를 시작할 y좌표
                    , $("#wLength").val()    // 잘라낸 이미지의 넓이
                    , $("#hLength").val()    // 잘라낸 이미지의 높이
                    , 0                           // 캔버스에 이미지를 배치할 x좌표
                    , 0                           // 캔버스에 이미지를 배치할 y좌표
                    , $("#wLength").val()    // 사용할 이미지의 넓이(이미지 스트레칭 또는 축소)
                    , $("#hLength").val()    // 사용할 이미지의 높이(이미지 스트레칭 또는 축소)
                );
				
                // @breif 편집한 캔버스의 이미지를 화면에 출력한다.
                let dataURI = canvas.toDataURL("image/jpeg");
				let crop_id = document.getElementById(crop_img);
				let edit_id = document.getElementById(edit_img);
				
				crop_id.setAttribute("src", dataURI);
				crop_id.style.width = $("#wLength").val();
				crop_id.style.height = $("#hLength").val();
                //jQuery("#editImg"+cnt).attr("src", dataURI);
				
                let temp_img = document.createElement("img");
                temp_img.setAttribute("src", "../../../img/black.png");
                
                temp_img.style.position = "absolute";
                temp_img.style.left = $("#xAxis").val() + "px";
                temp_img.style.top = $("#yAxis").val() + "px";
                temp_img.style.width = $("#wLength").val() + "px";
                temp_img.style.height = $("#hLength").val() + "px";
                
                let temptemp = document.querySelector(".imgArea");
                temptemp.appendChild(temp_img);
				// 원본 이미지를 모자이크 크기만큼 그리기
                canvasContext.drawImage(canvas, $("#xAxis").val(), $("#yAxis").val(), $("#wLength").val(), $("#hLength").val());
                
                $(".imgArea").css("position", "relative");
				
             	// 이미지 사이즈 크기 조절 시에 대한 안티앨리어싱 끄기
                canvasContext.msImageSmoothingEnabled = false;
                canvasContext.mozImageSmoothingEnabled = false;
                canvasContext.webkitImageSmoothingEnabled = false;
                canvasContext.imageSmoothingEnabled = false;
                
                // 이미지를 원본 사이즈로 다시 그리면 모자이크 완성
                canvasContext.drawImage(canvas, $("#xAxis").val(), $("#yAxis").val(), $("#wLength").val(), $("#hLength").val(), $("#xAxis").val(), $("#yAxis").val(), canvas.width, canvas.height);
                
                /*var pixelate = new Pixelate(qrepImage, {
					  amount: 0.7, // default: 0, pixelation percentage amount (range from 0 to 1)
				});*/
                //crop_id.onload = drawImageActualSize; // Draw when image has loaded
				
                // @breif 이미지의 크기는 자른 이미지와 동일하게 지정
                //$("#editImg"+cnt).css("width", $("#wLength").val());

                //$("#editImg"+cnt).css("height", $("#hLength").val());
				cnt++;
                imgCropDesignate();
            };

            //$("#cutBtn").css("display", "none");

            // @details JCROP을 종료한다.
            jcropApi.destroy();
	    	jcropApi = null;

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
    function uploadImgFilePrinted() {

        // @details 업로드 파일 정보를 받아온다.
        let fileInfo = document.getElementById("uploadFile").files[0];
        let reader = new FileReader();

        reader.onload = function() {

            // @details 업로드 이미지 출력
            $("#editImg").attr("src", reader.result);

            // @details 이미지 크기를 제목 영영과 같게 출력
            //$("#editImg").css("width", $("h1").width());


            // @details 이미지 업로드 기능 제거, 추가 업로드 방지
            $("#editImg").parent("a").removeAttr("onClick");
            
            // @details 편집버튼 노출
            $("#editBtn").css("display", "inline");

            $("#imgArea").css("postion", "relative");
            
            $("#editImg").css("width", "100%");
            $("#editImg").css("height", "100%");
            
            canvasDrawImage(function() {

            	alert("이미지 업로드가 완료되었습니다.");
            });
        };

        if(fileInfo) {      	
            // @details readAsDataURL을 통해 업로드한 파일의 URL을 읽어 들인다.
            reader.readAsDataURL(fileInfo);
        }
    }

    // @breif 캔버스 이미지 생성
    function canvasDrawImage(callback) {

        let prepImage = new Image();
        prepImage.src = $("#editImg").attr("src");

        prepImage.onload = function() {

            // @details 캔버스 위에 이미지 그리기
            // $("canvas") 와같은 명령은 사용할 수 없다.
            let canvas = document.querySelector("canvas");
            let canvasContext = canvas.getContext("2d");

            canvas.width = $("#editImg").width();
            canvas.height = $("#editImg").height();
            canvasContext.drawImage(this, 0, 0, $("#editImg").width(), $("#editImg").height());

            // @details 캔버스의 이미지
            let dataURI = canvas.toDataURL("image/jpeg");
            $("#editImg").attr("src", dataURI);
            
            callback();
        };
    }
    
    // 되돌리기
    function cancelCropImage() {
    	
    	if (cnt > 0) {
	    	let cropImg = document.querySelector(".crop_img");
	    	let shade = document.querySelector(".imgArea");
	    	
	    	cropImg.removeChild(cropImg.lastChild);
	    	shade.removeChild(shade.lastChild);
	    	
	    	cnt--;
    	}
    	if (cnt == 0) $(".btn").css("width","50%")
    	else $(".btn").css("width", "10%");
    	
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
    	html2canvas(document.querySelector(".imgArea"))
    	//id container 부분만 스크린샷
    	.then(function (canvas) {
    		//jpg 결과값
    		drawImg(canvas.toDataURL('image/jpeg'));
    		//이미지 저장
    		saveAs(canvas.toDataURL(), 'file-name.jpg');
    		}).catch(function (err) {
    			console.log(err);
    			});
    	}
    
    function drawImg(imgData) {
    	console.log(imgData);
    	//imgData의 결과값을 console 로그롤 보실 수 있습니다.
    	return new Promise(function resolve() {
    		//내가 결과 값을 그릴 canvas 부분 설정
    		var canvas = document.getElementById('canvas');
    		var ctx = canvas.getContext('2d');
    		//canvas의 뿌려진 부분 초기화
    		ctx.clearRect(0, 0, canvas.width, canvas.height);
    		
    		var imageObj = new Image();
    		imageObj.onload = function () {
    			ctx.drawImage(imageObj, 10, 10);
    			//canvas img를 그리겠다.
    			}; imageObj.src = imgData;
    			//그릴 image데이터를 넣어준다.
    			
    	}, function reject() { });
    	
    }
    
    function saveAs(uri, filename) {
    	var link = document.createElement('a');
    	if (typeof link.download === 'string') {
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

<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">

    <!-- Navigation -->
    <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-main-collapse">
                    <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand page-scroll" href="#page-top">
                    <i class="fa fa-play-circle"></i>  <span class="light">Start</span> Bootstrap
                </a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse navbar-right navbar-main-collapse">
                <ul class="nav navbar-nav">
                    <!-- Hidden li included to remove active class from about link when scrolled up past about section -->
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#about">About</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#download">Download</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#contact">Contact</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Intro Header -->
    <header class="intro">
        <div class="intro-body">
            <div class="container">
                <!--
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <h1 class="brand-heading">Grayscale</h1>
                        <p class="intro-text">A free, responsive, one page Bootstrap theme.<br>Created by Start Bootstrap.</p>
                        <a href="#about" class="btn btn-circle page-scroll">
                            <i class="fa fa-angle-double-down animated"></i>
                        </a>
                    </div>
                </div>
                -->
            </div>
        </div>
    </header>

    <!-- About Section -->
    <section id="about" class="container content-section text-center">
    <input type="hidden" id="xAxis" value="0" placeholder="선택영역의_x좌표"/>
	<input type="hidden" id="yAxis" value="0" placeholder="선택영역의_y좌표"/>
	<input type="hidden" id="wLength" value="0" placeholder="선택영역의_w넓이"/>
	<input type="hidden" id="hLength" value="0" placeholder="선택영역의_h높이"/>
	<input type="file" id="uploadFile" onChange="uploadImgFilePrinted();" accept="image/*"/>
<div class="contents">
    <h1>이미지&nbsp;자르기<span>샘플</span></h1>
    <div class="imgArea" style="float:left; width:50%;">
        <a href="javascript:;" onClick="$('#uploadFile').click();">
            <img id="editImg" src="../../img/comedy-mask-xxl.png"/>
        </a>
        <br/>
    </div>
    <div class="crop_img" style="float:right; width:40%;"></div>
    <div class="btn" style="float:right; width:50%;" >
    	<input id="editBtn" type="button" onClick="imgCropDesignate();" value="편집"/>
        <input id="cutBtn" type="button" onClick="imgCropApply();" value="자르기" style="text-align:center;"/>
        <br/>
        <input id="canBtn" type="button" onClick="cancelCropImage();" value="되돌리기" style="text-align:center;"/>
        <!-- 전체 부분
        <button onclick=bodyShot()>bodyShot</button>-->
        <!-- 일부분-->
        <button onclick=partShot();>partShot</button>

        <!-- 결과화면을 그려줄 canvas 
        <canvas id="canvas" width="900" height="600" style="border:1px solid #d3d3d3;"></canvas>-->
    </div>
    <canvas id="canvas" style="display:none;"></canvas>
</div>
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                
            </div>
        </div>
    </section>

    <!-- Download Section -->
    <section id="download" class="content-section text-center">
        <div class="download-section">
            <div class="container">
                <div class="col-lg-8 col-lg-offset-2">
                    <h2>Download Grayscale</h2>
                    <p>You can download Grayscale for free on the preview page at Start Bootstrap.</p>
                    <a href="http://startbootstrap.com/template-overviews/grayscale/" class="btn btn-default btn-lg">Visit Download Page</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="container content-section text-center">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <h2>Contact Start Bootstrap</h2>
                <p>Feel free to email us to provide some feedback on our templates, give us suggestions for new templates and themes, or to just say hello!</p>
                <p><a href="mailto:feedback@startbootstrap.com">feedback@startbootstrap.com</a>
                </p>
                <ul class="list-inline banner-social-buttons">
                    <li>
                        <a href="https://twitter.com/SBootstrap" class="btn btn-default btn-lg"><i class="fa fa-twitter fa-fw"></i> <span class="network-name">Twitter</span></a>
                    </li>
                    <li>
                        <a href="https://github.com/IronSummitMedia/startbootstrap" class="btn btn-default btn-lg"><i class="fa fa-github fa-fw"></i> <span class="network-name">Github</span></a>
                    </li>
                    <li>
                        <a href="https://plus.google.com/+Startbootstrap/posts" class="btn btn-default btn-lg"><i class="fa fa-google-plus fa-fw"></i> <span class="network-name">Google+</span></a>
                    </li>
                </ul>
            </div>
        </div>
    </section>

    <!-- Map Section -->
    <div id="map"></div>

    <!-- Footer -->
    <footer>
        <div class="container text-center">
            <p>Copyright &copy; Your Website 2014</p>
        </div>
    </footer>



</body>

</html>
