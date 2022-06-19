<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- <link rel="stylesheet" type="text/css" media="screen" href="../resources/css/jquery-ui-1.10.4.custom.css" /> -->
<link rel="stylesheet" type="text/css" media="screen" href="/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" media="screen" href="/css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" media="screen" href="/css/jquery-ui.structure.css" />
<link rel="stylesheet" type="text/css" media="screen" href="/css/jquery-ui.theme.min.css" />
<link rel="stylesheet" type="text/css" media="screen" href="/css/master.css" />

<script src="/js/jquery.js" type="text/javascript"></script>  
<script src="/js/grid.locale-kr.js" type="text/javascript"></script>
<script src="/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="login">
	  <h1>Infomation</h1>
	  <form method="get" action="" id="form">
	    <p><input type="text" name="name" value="" placeholder="Name"></p>
	    <p><input type="text" name="age" value="" placeholder="Age"></p>
	    <p><input type="text" name="phone_num" value="" placeholder="Phone Number"></p>
	    <p class="submit"><input type="button" id="submit" name="commit" value="Insert"></p>
	  </form>
	</div>
   	<table id="rowed5"></table>
</body>

<script>
var lastsel2;

jQuery("#rowed5").jqGrid({
	datatype: "local",
	height: 250,
   	colNames:[ ' ','Name', 'Age', 'Phone Number'],
   	colModel:[
   		{name:'myac', width: 50, fixed:true, sortable : false, formatter:'actions', formatoptions:{keys:true, delbutton:true}},
   		{name:'name',index:'name', width:150,editable: true,editoptions:{size:"20",maxlength:"30"}},
   		{name:'age',index:'stock', width:60, editable: true,editoptions:{size:"20",maxlength:"30"}},
   		{name:'phone_num',index:'ship', width:240, editable: true, editoptions:{size:"20",maxlength:"30"}}		
   	],
	editurl: "server.php",
	caption: "AddressBook"

});


$(function(){
    $('#submit').on("click",function () {
        var form = $("#form").serialize();
        console.log(form);
        
        $.ajax({
            type: "get",
            url: "/address/save",
            data: form,
            dataType: 'json',
            success: function (data) {
            	alert(data["message"]);
            },
            error: function (data) {
            	alert(data["message"]);
            }
        });
    });
});

</script>
</html>