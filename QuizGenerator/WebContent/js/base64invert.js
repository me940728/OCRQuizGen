var data;
    var typeName = '';
    var dataBase64 = '';
    $(function() {

        $(document).on('click','#btnSubmit', function () {
            data = $('#inputText').val().trim();
            if (!data) {
                alert("base64 문자열을 입력하십시오");
                return false;
            }
            $('.loading, #loadingRakko').show();
            $('.hide_show').empty();
            $('.error_area').show();
            var startStr = data.slice(0,5);

            var strBase64 = data;
            if(startStr.toLowerCase() !== 'data:') {
                data = 'data:;base64,'+data;
            } else {
                var stt = strBase64.indexOf(',');
                strBase64 = strBase64.slice(stt+1);
            }
            var checkStart = strBase64.slice(0,4);
            var type;
            
            switch(checkStart) {
                case '/9j/':
                    type = 'jpeg';
                    break;
                case 'iVBO':
                    type = 'png';
                    break;
                case 'R0lG':
                    type = 'gif';
                    break;
                case 'UklG':
                    type = 'webp';
                    break;
                case 'Qk14':
                    type = 'BMP';
                    break;
                case 'PD94':
                    type = 'svg';
                    break;
                case 'AAAB':
                    type = 'ico';
                    break;
                case 'SUkq':
                    type = 'tiff';
                    break;  
                default:
                    type = '';
            }
            var mimeType = 'image/'+type;
            if(type == 'ico') {
                mimeType = 'image/x-icon';
            }
            if(type == 'svg') {
                mimeType = 'image/svg+xml';
                if(data.slice(0,13) == 'data:;base64,') {
                    data = 'data:image/svg+xml'+data.slice(5);
                }
            }
            if (type) {
                loadImgDone(data,type,mimeType);
            } else {
                loadImgFails();
            }
            dataBase64 = data;
            typeName = 'image.'+type;
        });
    });

    function clearText(id){
        $('#'+id).val(null).focus();
    }

    function downloadImg() {
        var fileName = typeName;
        var base64 = dataBase64;
        var blob = base64ImageToBlob(base64);
        var a = $("<a></a>", {
            href: window.URL.createObjectURL(blob),
            download: fileName,
            target: "_blank"
        })[0];

        if (window.navigator.msSaveBlob) {
            window.navigator.msSaveBlob(blob, fileName);
            window.navigator.msSaveOrOpenBlob(blob, fileName);
        } else if (window.URL && window.URL.createObjectURL) {
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
        } else if (window.webkitURL && window.webkitURL.createObject) {
            a.click();
        } else {
            window.open(base64, '_blank');
        }
    }

    /**
     * @param str
     * @return {Blob | Blob}
     */
    function base64ImageToBlob(str) {
        // extract content type and base64 payload from original string
        let pos = str.indexOf(';base64,');
        let type = str.substring(5, pos);
        let b64 = str.substr(pos + 8);
        // decode base64
        let imageContent = atob(b64);
        // create an ArrayBuffer and a view (as unsigned 8-bit)
        let buffer = new ArrayBuffer(imageContent.length);
        let view = new Uint8Array(buffer);
        // fill the view, using the decoded base64
        for (let n = 0; n < imageContent.length; n++) {
            view[n] = imageContent.charCodeAt(n);
        }
        // convert ArrayBuffer to Blob
        let blob = new Blob([buffer], { type: type });
        return blob;
    }

    function loadImgFails() {
        $('.loading, #loadingRakko').hide();
    	$('.result_detail').show();
    	$('.loading, #infor,.class_img').hide();
        $('.result_detail .error_area').show();
    }

    function loadImgDone(data,type,mimeType) {
        $('.loading, #loadingRakko').hide();
        $('.error_area').hide();
        $('.result_detail').css('display','block');

        var i = new Image();

        i.onerror = function() {
            loadImgFails();
        }

        i.onload = function(){
            var width = i.width;
            var height = i.height;
            var stringLength = data.length;
            
            var stt = data.indexOf(',');
            var stringLength = data.slice(stt+1).length;
            
            var size;

            var sizeInBytes = Math.ceil((stringLength * 3 / 4));
            var sizeInKb=sizeInBytes/1000;
            if(sizeInBytes<1000) {
                size = sizeInBytes.toFixed(2) + ' B';
            } else {
                size = sizeInKb.toFixed(2) + ' kB';
            }
            $('.result_detail .class_img').css('display','block');
            $('#img').attr('src', data);
            $('#infor').show();
            $('.resolution').append('<label class="hide_show">'+width+' x '+height+'</label>')
            $('.extension').append('<label class="hide_show">'+type+'</label>')
            $('.mimeType').append('<label class="hide_show">'+mimeType+'</label>')
            $('.size').append('<label class="hide_show">'+size+'</label>')
        };
        i.src = data;
    }