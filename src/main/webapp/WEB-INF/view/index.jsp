<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" media="screen" href="/css/master.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<title>AddressBook</title>
</head>
<body>
	<div class="login">
	  <h1>고리타분한 주소록</h1>
	  <form method="get" action="" id="form">
	    <p><input type="text" id="name" name="name" value="" placeholder="Name"></p>
	    <p><input type="number" id="age" name="age" min="1" value="" placeholder="Age"></p>
	    
	    <p>
	    	<input type="text" id="phone_num" name="phone_num" value="" maxlength='13' placeholder="Phone Number">
	    	<input type="hidden" id="no" name="no">
	    </p>
	    
	    <p class="submit">
	    	<input type="button" class="btn" id="new" name="new" value="new">
		    <input type="button" class="btn" id="save" name="save" value="save">
		    <input type="button" class="btn" id="delete" name="delete" value="delete">
	    </p>
	  </form>
	</div>
	
	<div class="list">
		<ul class="list-group" id="list-group">
		</ul>
	</div>
</body>

<script>
fn_selectList();

function fn_setFormData(no, name, age, phoneNum){
	$('#name').val(name);
	$('#age').val(age);
	$('#phone_num').val(phoneNum);
	$('#no').val(no);
}

function fn_validate(){
	if(!$('#name').val()){return false;}
	if(!$('#age').val()){return false;}
	if(!$('#phone_num').val()){return false;}
	
	return true;
}

function fn_setList(list){
	if(list.length == 0){
		fn_setFormData('','','','');	
	}
	
	$(list).each(function (i){
		var addressBook = list[i];
		
		var html;
	    if(i == 0){
	    	html = "<li class='list-group-item active'> &nbsp;&nbsp;";
	    	fn_setFormData(addressBook.no, addressBook.name, addressBook.age, addressBook.phone_num);
	    }else{
	    	html = "<li class='list-group-item'> &nbsp;&nbsp;";
	    }
	    html += "<h3 class='list-group-item-heading'>" + addressBook.name + "</h3>";
	    html += "<p class='list-group-item-text'><span class='comp'>" + addressBook.phone_num + "</span><span class='badge badge-success float-right'>"+ addressBook.age +"</span></p>";
	    html += "<span class='hiddenNo' hidden='hidden'>" + addressBook.no + "</span>";
	    html += "</li>";
		
		$('#list-group').append(html);
	});	
}

function fn_selectList(){
	 $.ajax({
         type: "get",
         url: "/address/search",
         dataType: 'json',
         success: function (data) {
        	 $('ul').empty();
        	 fn_setList(data["data"]);
         },
         error: function (data) {
         	alert(data["data"]);
         }
     });
}

function fn_alert(alert_icon, alert_title, alert_text){
	Swal.fire({
        icon: alert_icon,                
        title: alert_title,    
        text: alert_text,
    });	
}
$(function(){
    $('#new').on("click",function () {
    	fn_setFormData('','','','');
    });
});

$(function(){
    $('#save').on("click",function () {
        var form = $("#form").serialize();
        
        if(!fn_validate()){
        	fn_alert('warning', '등록 / 수정','입력정보 중 빈 값이 존재합니다.');
        	return false;
        }
        
        $.ajax({
            type: "get",
            url: "/address/save",
            data: form,
            dataType: 'json',
            success: function (data) {
            	fn_alert('success', '등록 / 수정',data["message"]);
            	fn_selectList();
            },
            error: function (data) {
            	alert(data["message"]);
            }
        });
    });
});

$(function(){
    $('#delete').on("click",function () {
    	var no = $('#no').val();
    	
    	var phone_num = $('.active').children('.list-group-item-text').children('.comp').text();
    	var subPNum = phone_num.substring(0, 2); 
    	
    	if(no == null){
    		fn_alert('warning', '삭제', "저장 후 삭제해주세요.");
    		return false;
    	}
    	
    	if(subPNum != "02"){
    		fn_alert('warning', '삭제', "02로 시작하는 연락처만 삭제가능합니다.");
    		return false;
    	}
    	
        var form = $("#form").serialize();
        
        $.ajax({
            type: "get",
            url: "/address/delete",
            data: form,
            dataType: 'json',
            success: function (data) {
            	fn_alert('success', '삭제', data["message"]);
            	fn_selectList();
            },
            error: function (data) {
            	alert(data["message"]);
            }
        });
    });
});

$(document).on("click", ".list-group li", function(){
	$('.active').removeClass('active');
	$(this).addClass('active');
	
	fn_setFormData($(this).children('.hiddenNo').text(), 
				   $(this).children('.list-group-item-heading').text(), 
			       $(this).children('.list-group-item-text').children('.badge').text(), 
			       $(this).children('.list-group-item-text').children('.comp').text());
});

$(document).on("change", "input[name^=age]", function() {
    var val= $(this).val();

    if(val < 1 || val > 20) {
    	fn_alert('warning', '입력', "1~20 범위로 입력해 주십시오.");
        $(this).val('');
        $(this).focus();
    }
});

$(document).on("change", "input[name^=name]", function() {
	var regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
    var val = $(this).val();
    if (regexp.test(val)) {
    	fn_alert('warning', '입력', "한글만 입력가능 합니다.");
        $(this).val(val.replace(regexp, ''));
        $(this).focus();
    }
});
</script>
</html>