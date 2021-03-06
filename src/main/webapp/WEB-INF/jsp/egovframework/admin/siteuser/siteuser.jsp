<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags'%>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type='text/javascript'>

function initControl()
{
    var table = $('#list').DataTable( {
		serverSide:true
		, processing:true
        , ajax: {
            url: '/admin/getSiteUserListAjax.do',
            type: 'POST'
        }
		, order: [[ 0, 'desc' ]]
        , columns: [
            { 'data': 'seq', visible:false },
			{ 'data': 'userName' 
                , createdCell:function (td, cellData, rowData, row, col) {
        			    $(td).css('cursor', 'pointer');
   	              	    $(td).click(function(e){
   	              		    var rowData = table.row( $(this).closest('tr') ).data();
   	              	
	   	              	    postAjax('/admin/selectSiteUserAjax.do', {seq:rowData.seq}, function(data, status){
		   	              	    $.each(data.data, function(i, att){
		              			    if($('#lbl' + i).length > 0)
		              			    {
		              				    $('#lbl' + i).text(att);
		              			    }
		              		    });
		   	              	    
		   	              	    var address = "";
		   	              	    if(data.data.userAddressZonecode){
		   	              	   		address += "("+data.data.userAddressZonecode+")"
		   	              	    }
		   	              		if(data.data.userAddress){
		   	              			address += data.data.userAddress;
		   	              		}
			   	              	if(data.data.userAddressDetail){
		   	              			address += " " + data.data.userAddressDetail;
		   	              		}
		   	              	    $("#lbluserAddress").text(address);

		   	         		    $('#modalSiteUserView').data('seq', rowData.seq);
		   	         		    $('#modalSiteUserView').modal();
                            });
   	            	
            		    });
                } },
			{ 'data': 'userId' },
			{ 'data': 'userEmail' },
			{ 'data': 'userPhone' },

            {
	            className:      'text-center',
	            orderable:      false,
	            data:           function(rowObject, f, u, table)
	            {
		            var actionButtonItem = "";
		
		            actionButtonItem += "<a href='#' class='dropdown-item' data-seq='"+rowObject.seq+"' role='dataEdit'><i class='icon-pencil5'></i>??????</a>";
		            actionButtonItem += "<a href='#' class='dropdown-item' data-seq='"+rowObject.seq+"' role='dataRemove'><i class='icon-x'></i>??????</a>";	
		
		            var actionButtonHtml = "";
		            actionButtonHtml += "<div class='list-icons'>";
		            actionButtonHtml += "	<div class='dropdown'>";
		            actionButtonHtml += "<a href='#' class='list-icons-item' data-toggle='dropdown'>";
		            actionButtonHtml += "<i class='icon-menu9'></i>";
		            actionButtonHtml += "</a>";
		            actionButtonHtml += "<div class='dropdown-menu dropdown-menu-right'>";
		            actionButtonHtml += actionButtonItem;
		            actionButtonHtml += "</div>";
		            actionButtonHtml += "</div>";
		            actionButtonHtml += "</div>";
		
		            return actionButtonHtml;
	            },
	            'defaultContent': ''
            },
        ],     
        buttons: {
        	dom: {
                button: {
                    className: 'btn btn-primary'
                }
            },
            buttons: [
                {
                    text: '????????? ??????',
                    attr:{
                    	'data-toggle':'modal',
                    	'data-target':'#modalSiteUserSave'
                    },
                    action: function(e, dt, node, config) {
                    }
                }
            ],
        }
    } );
	
	//validate add method
	//jQuery.validator.addMethod('addCheck', function(value, element) {
	//        return (value.length > 0);
	//    }, 'This field is required.'
	//);
	
	$('#siteuserForm').validate({
		rules:{
			userName:{required:true},
			userId:{required:true},

		}
	});

	$.each($('#siteuserForm').validate().settings.rules, function(key, value){
	    $('#' + key).parent().prev().html(function(idx, oldHtml){
		    if(oldHtml.indexOf('*') < 0)
			    return '* ' + oldHtml;
	    })
    });
}

function initEvent() {
	

	$(document).on('click', 'a[role=dataEdit]', function(){
				
    	$('#modalSiteUserSave').data('seq', $(this).data('seq'));
		$('#modalSiteUserSave').modal();
    });  
    
    $(document).on('click', 'a[role=dataRemove]', function(){
    	var seq = $(this).data('seq');
    	
        sweetConfirm('????????? ?????????????????????????', '', function(){
            postAjax('/admin/deleteSiteUserAjax.do', {seq:seq}, function(data, status){
        		showAjaxMessage(data);
        			
        		if(data.isSuccess === '1')
        		{
	        		$('#list').DataTable().ajax.reload();
        		}
        	});
        });
    });

    $('#btnSiteUserDataEdit').click(function(){
    	$('#modalSiteUserSave').data('seq', $('#modalSiteUserView').data('seq'));
    	$('#modalSiteUserSave').modal();
    });
    
    $('#modalSiteUserSave').on('show.bs.modal', function(e) {
        if ($('#modalSiteUserSave').data('seq'))
    	{
            postAjax('/admin/selectSiteUserAjax.do', {seq:$(this).data('seq')}, function(data, status){
                var formInput = $('#siteuserForm input[type!=radio],#siteuserForm textarea');
        		
        	    $(formInput).each(function(i, input){
                    var inputValue = data.data[$(input).attr('name')];
        		    $(input).val(htmlDecode(inputValue));
                });

                $("#userPwd").val("");
            });
        }
    });

    $('#modalSiteUserSave').on('hidden.bs.modal', function(e) {
    	initForm('siteuserForm');
        $('#modalSiteUserSave').data('seq', "");
        
    });
    
    $('#btnSiteUserDataSave').click(function(){
        if ($('#siteuserForm').valid())
		{
            var isUserIdOk = $("#isUserIdOk").val();
            if(isUserIdOk !== "1"){
            	toastr.warning("????????? ??????????????? ????????? ?????????.");
            	return;
            }
            var formData = $('#siteuserForm').serializeObject();

            ajax($('#modalSiteUserSave div.modal-content'), '/admin/mergeSiteUserAjax.do', formData, function(data, status){
                showAjaxMessage(data);
                if (data.isSuccess === '1')
                {
				    $('#list').DataTable().ajax.reload(null, false);
				    $('#modalSiteUserSave').modal('hide');
                }
            });
        }
    });
    
    $("#btnFindAddress").click(function(){
		 new daum.Postcode({
		        oncomplete: function(data) {
		            $("#userAddress").val(data.address);
		            $("#userAddressZonecode").val(data.zonecode);
		        }
		    }).open();
	});
    
    $("#userId").blur(function(){
    	var userId = $("#userId").val();
    	if(userId){
	    	postAjax("/admin/checkSiteUserIdAjax.do", {userId:userId}, function(data, status){
	    		showAjaxMessage(data);
	    		if(data.isSuccess === "1")
	    			$("#isUserIdOk").val("1");
	    		else
	    			$("#isUserIdOk").val("0");
	    	});
    	}
    });
    
   /*  $("#btnCheckUserId").click(function(){
    	
    	var userId = $("#userId").val();
    	if(!userId){
    		toastr.warning("???????????? ????????? ?????????.");
    		return;
    	}
    	
    	postAjax("/admin/checkSiteUserIdAjax.do", {userId:userId}, function(data, status){
    		showAjaxMessage(data);
    		if(data.isSuccess === "1")
    			$("#isUserIdOk").val("1");
    		else
    			$("#isUserIdOk").val("0");
    	});
    }); */
}
</script>

<div class='card'>
	<div class='card-header header-elements-inline'>
		<h5 class='card-title font-weight-bold'><i class='icon-chevron-right mr-1'></i>?????????</h5>
        <div class='header-elements'>
			<div class='list-icons ml-3'>
          		<!-- <a class='list-icons-item' data-action='collapse'></a> -->
          		<a class='list-icons-item' data-action='reload'></a>
          		<!-- <a class='list-icons-item' data-action='remove></a> -->
          	</div>
       	</div>
	</div>
    <div class='card-body'>
		<table id='list' class='table table-hover'>
			<colgroup>
				<col style=''>
				<col style='width: 10%;'>
				<col style='width: 10%;'>
				<col style='width: 10%;'>

				<col style='width: 100px;'>
			</colgroup>
			<thead>
				<tr>
					<th>seq</th>
					<th>????????????</th>
					<th>?????? ?????????</th>
					<th>?????? ?????????</th>
					<th>?????? ????????????</th>

					<th>??????</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
</div>	


<div id='modalSiteUserSave' class='modal fade'>
	<div class='modal-dialog modal-xl'>
		<div class='modal-content'>
			<div class='modal-header bg-primary text-white'>
				<h5 class='modal-title'>????????? ??????</h5>
				<button type='button' class='close' data-dismiss='modal'>&times;</button>
			</div>

			<form id='siteuserForm' name='siteuserForm' class='form-horizontal'>
                <input id='seq' name='seq' type='hidden' />
                <input id='isUserIdOk' name='isUserIdOk' type='hidden' />
                <div class='modal-body'>
				
                    <div class='datatable-scroll'>
	                    <table class='detailtable mb-3'>
	                    	<colgroup>
	                    		<col style='width:20%'/>
	                    		<col style=''/>
	                    	</colgroup>
	                    	<tbody>

                            <tr>
                                <th>????????????</th>
                                <td>
                                	<input id='userName' name='userName' maxlength='20' class='form-control' type='text' placeholder='????????????'>                                	
                                </td>
                            </tr>
                            <tr>
                                <th>?????? ?????????</th>
                                <td>
                                	<input id='userId' name='userId' maxlength='20' class='form-control' type='text' placeholder='?????? ?????????'>
                                	<span class='text-primary font-weight-semibold'>* ???????????? ???????????? ????????? ??????????????? ???????????? ???????????????. </span>
                                	<!-- <button id='btnCheckUserId' type='button' class='btn btn-primary'>????????????</button> -->
                               	</td>
                            </tr>
                            <tr>
                                <th>?????? ????????????</th>
                                <td><input id='userPwd' name='userPwd' maxlength='50' class='form-control' type='password' placeholder='?????? ????????????'></td>
                            </tr>
                            <tr>
                                <th>?????? ?????????</th>
                                <td><input id='userEmail' name='userEmail' maxlength='200' class='form-control' type='text' placeholder='?????? ?????????'></td>
                            </tr>
                            <tr>
                                <th>?????? ????????????</th>
                                <td><input id='userPhone' name='userPhone' maxlength='100' class='form-control' type='text' placeholder='?????? ????????????'></td>
                            </tr>
                            <tr>
                                <th>??????</th>
                                <td>
                                	<input id='userAddressZonecode' name='userAddressZonecode' maxlength='6' class='form-control d-inline' type='text' placeholder='????????????' style='width:100px;'>
                                	<button type='button' class='btn btn-primary' id='btnFindAddress'>????????????</button>
                                	<input id='userAddress' name='userAddress' maxlength='100' class='form-control mt-1' type='text' placeholder='??????' style='width:600px;'>
                                	<input id='userAddressDetail' name='userAddressDetail' maxlength='50' class='form-control mt-1' type='text' placeholder='?????? ??????' style='width:600px;'>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                </div>
			</form>
            <div class='modal-footer border-top'>
				<button type='button' class='btn bg-primary text-white' id='btnSiteUserDataSave'>??????</button>
				<button type='button' class='btn bg-primary text-white' data-dismiss='modal'>??????</button>
			</div>
		</div>
	</div>
</div>

<div id='modalSiteUserView' class='modal fade'>
	<div class='modal-dialog modal-xl'>
		<div class='modal-content'>
			<div class='modal-header bg-primary text-white'>
				<h5 class='modal-title'>????????? ??????</h5>
				<button type='button' class='close' data-dismiss='modal'>&times;</button>
			</div>
            <div class='modal-body'>
                
                    <div class='datatable-scroll'>
	                    <table class='detailtable mb-3'>
	                    	<colgroup>
	                    		<col style='width:20%'/>
	                    		<col style=''/>
	                    	</colgroup>
	                    	<tbody>

                            <tr>
                                <th>????????????</th>
                                <td><label id='lbluserName'></label></td>
                        
                            </tr>
                            <tr>
                                <th>?????? ?????????</th>
                                <td><label id='lbluserId'></label></td>
                        
                            </tr>
                            <tr>
                                <th>?????? ?????????</th>
                                <td><label id='lbluserEmail'></label></td>
                        
                            </tr>
                            <tr>
                                <th>?????? ????????????</th>
                                <td><label id='lbluserPhone'></label></td>
                        
                            </tr>
                            <tr>
                                <th>?????? ??????</th>
                                <td><label id='lbluserSex'></label></td>
                        
                            </tr>
                            <tr>
                                <th>???????????? ?????????</th>
                                <td><label id='lblupdatePwdDate'></label></td>
                        
                            </tr>
                            <tr>
                                <th>??????</th>
                                <td><label id='lbluserAddress'></label></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class='modal-footer border-top'>
				<button type='button' class='btn bg-primary text-white' data-dismiss='modal' id='btnSiteUserDataEdit'>??????</button>
                <button type='button' class='btn bg-primary text-white' data-dismiss='modal'>??????</button>
			</div>
		</div>
	</div>
</div>
