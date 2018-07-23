function uploadPhoto(){
//        var excelFile = document.getElementById("excelFile").files[0]; // 获取文件
//        console.log("文件:", excelFile);

    var fileName = $("#empPhoto").val();
    if("" == fileName){
        alert("请先选择文件!");
        return;
    }

    //form提交方式(success)
    //$("#uploadForm").submit();

    var formUrl = document.getElementById("photoUploadForm").action;
    var formData = new FormData($( "#photoUploadForm" )[0]); // 将上传文件封装!!!!!
    //console.log("formData:", formData);

    // 请求Ajax
    $.ajax({
        type: "POST",
        url: formUrl, // 可用
        //url: "${}/emp/photo_upload",
        //data: $("#uploadForm").serialize(),// 你的formid,只能提交普通form数据,无法提交文件上传
        data: formData,
        dataType: "json",
        async: false,
        cache: false,
        contentType: false,
        processData: false,
        success: function (data) {
            if(data.state == "0"){
                alert("上传头像失败!" + data.msg);
            }else if(data.state == "1" && data.data == null){
                alert("上传头像成功,数据无误,录入完毕!");
            }else if(data.state == "1" && data.data != null){
                alert("上传头像成功!" + data.msg + ":" + data.data);
            }

            //alert("success!"+data);
            console.log("data:", data);
            alert(data.info);
        },
        error: function (data) {
            alert("网络原因,上传头像失败!");
            //alert("error："+data);
            console.log("error-data:", data);
        }
    });
}