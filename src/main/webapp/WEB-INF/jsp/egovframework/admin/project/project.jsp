<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags'%>

<script type='text/javascript'>

var totalsize = 0.0;
var MAX_TOTAL_SIZE = 30;
Dropzone.autoDiscover = false;

function initControl() {
	$("#projectStart,#projectEnd").datepicker();
	$("#csSeq").select2({minimumResultsForSearch: Infinity});
	
	$("#attachdiv").css({"display":"none"});
	
	var table = $('#list').DataTable( {
	serverSide:true
	, processing:true
    , ajax: {
        url: '/admin/getProjectListAjax.do', //url 정보 수정
        type: 'POST'
    }
	, order: [[ 0, 'desc' ]]
    , columns: [
    	{ 'data': 'seq', visible:false},
    	//무엇을 클릭해야 상세보기 창이 뜨는지 설정하는 코드
    	{ 'data': 'projectName' ,createdCell:function (td, cellData, rowData, row, col){
			
			//td cursor 스타일 변경
   			$(td).css('cursor', 'pointer');
			
	            $(td).click(function(e){
	            	//클릭 이벤트 정의
	            	
	            	//클릭한 td 의 데이터 불러오기
	            	var rowData = table.row( $(this).closest('tr') ).data();
	              	
	            	//클릭한 직원의 상세정보 불러 오기
	              	postAjax('/admin/selectProjectAjax.do', {seq:rowData.seq}, function(data, status){
	              		
	              	
	          
	              		
	              		//상세화면 항목에 데이터 삽입
   	            	$.each(data.data, function(key, value){	   	            		
              			if($('#lbl' + key).length > 0)
              			{
              				$('#lbl' + key).text(value);
              			}
              		});	   	 
	              		
					var fileHtml = "";
	              	
	              	$.each(data.data.projectattachlist, function(key, value){
	              		fileHtml += "<ul class='list list-unstyled mb-0'>"
	              		fileHtml += "<li>"
	              		fileHtml += "<i class='icon-download4 text-success mr-2'></i>"
	              		fileHtml += "<a href='/admin/downloadprojectfile.do?seq="+value.seq+"'>"+value.oriFilename+"</a>"
	              		fileHtml += "</li>"		
	              		fileHtml += "</ul>"
	              	})
	              	
	              	$("#lblprojectattachlist").html(fileHtml)
	              		
	              	
					
	              		//상세화면 seq 지정
   	         		$('#modalView').data('seq', rowData.seq);
   	         		$('#modalView').modal();
                });
       		});
        }, className:'text-center'},
    	{'data': 'csName'},
    	{
            className:      'text-center',
            orderable:      false,
            data:           function(rowObject, f, u, table)
            {
	            var datehtml = "";
            	datehtml+=rowObject.projectStart;
            	datehtml+='~';
            	datehtml+=rowObject.projectEnd;
	
	            return datehtml;
            },
            'defaultContent': ''
        },
 
    	{'data': 'projectExp' },
        {
            className:      'text-center',
            orderable:      false,
            data:           function(rowObject, f, u, table)
            {
	            var actionButtonItem = "";
	
	            actionButtonItem += "<a href='#' class='dropdown-item' data-seq='"+rowObject.seq+"' role='dataEdit'><i class='icon-pencil5'></i>수정</a>";
	            actionButtonItem += "<a href='#' class='dropdown-item' data-seq='"+rowObject.seq+"' role='dataRemove'><i class='icon-x'></i>삭제</a>";	
	
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
                text: '프로젝트 등록', //메뉴명에 맞는 버튼 이름으로 변경
                attr:{
                	'data-toggle':'modal',
                	'data-target':'#modalSave' //저장 모달창 아이디로 변경
                },
                action: function(e, dt, node, config) {
                	
                }
            }
        ],
    }
} );
	
	if($("div#divAttachedFile").length > 0){
		var myDropzone = new Dropzone('div.dropzone',{
			url : "/admin/dragDropUploadAjax.do?type=project",
			maxFiles : 10,
			paramName : "upload",
			maxFilesize : 3,
			addRemoveLinks : true,
			dictDefaultMessage : "파일을 선택해 주십시오.(최대 10개 파일, 각 3MB 최대 30MB 첨부 가능)",
			acceptedFiles : '.xlsx,.xls,image/*,.doc, .docx,.ppt, .pptx,.txt,.pdf,.hwp',
			createImageThumbnails : true,
			success : function(file, response) {
				$("#form").append("<input type='hidden' role='attachSaveFileName' name='attachSaveFileName' value='"+response.saveFileName+"' data-uuid='"+file.upload.uuid+"' />");
				$("#form").append("<input type='hidden' role='attachOriFileName' name='attachOriFileName' value='"+response.fileName+"' data-uuid='"+file.upload.uuid+"' />");
				$("#form").append("<input type='hidden' role='attachFileSize' name='attachFileSize' value='"+file.size+"' data-uuid='"+file.upload.uuid+"' />");
			},
			accept : function(file, done) {
				if (totalsize >= MAX_TOTAL_SIZE) {
					file.status = Dropzone.CANCELED;
					this._errorProcessing([ file ],"최대 30MB 첨부 가능", null);
				} else {
					done();
				}
			},
			init : function() {
				this.on("addedfile",function(file) {
					totalsize += parseFloat((file.size / (1024 * 1024)).toFixed(2));
				});
	
				this.on('removedfile',function(file) {
					$("input[role=attachSaveFileName][data-uuid='"+ file.upload.uuid+ "']").remove();
					$("input[role=attachOriFileName][data-uuid='"+ file.upload.uuid+ "']").remove();
					$("input[role=attachFileSize][data-uuid='"+ file.upload.uuid+ "']").remove();
	
					if (file.upload.progress != 0) {
						totalsize -= parseFloat((file.size / (1024 * 1024)).toFixed(2));
					}
				});
	
				this.on("error",function(file) {
					totalsize -= parseFloat((file.size / (1024 * 1024)).toFixed(2));
				});
			}
		});
	}
	
	
	//필수 입력값 체크
	//폼아이디 변경
	//필수 입력값 name 지정
	$('#form').validate({
		rules:{
			projectName:{required:true},
			csSeq:{required:true}
		}
	});
	
	//필수 입력 항목에 별 표시
	//폼 아이디 변경
	$.each($('#form').validate().settings.rules, function(key, value){
	    $('#' + key).parent().prev().html(function(idx, oldHtml){
		    if(oldHtml.indexOf('*') < 0)
			    return '* ' + oldHtml;
	    })
    });
}

function initEvent() {
	
	//목록 수정버튼 클릭시 이벤트
	$(document).on('click', 'a[role=dataEdit]', function(){
		
		//모달창 아이디 변경
    	$('#modalSave').data('seq', $(this).data('seq'));
		$('#modalSave').modal();
    });  
	
	$(document).on('click','button[role=deletefilebtn]',function(){
		if(confirm("파일을 삭제하시겠습니까??")) {
			var seq=$(this).data('seq');
			var _this=$(this)
			
			postAjax('/admin/deleteProjectAttachAjax.do', {seq:seq}, function(data, status){
				if(data.isSuccess === '1')
				{
					_this.parent().remove();
				}
			});
		}
	})
    
    $(document).on('click', 'a[role=dataRemove]', function(){
    	var seq = $(this).data('seq');
    	    	
    	//안내 문구 변경
         swalInit.fire({
             title: '프로젝트를 삭제하시겠습니까?',
             text: '',
             showCancelButton: true,
             confirmButtonText: '예',
             cancelButtonText: '아니요',
             confirmButtonClass: 'btn btn-success',
             cancelButtonClass: 'btn btn-danger',
             buttonsStyling: false
         }).then(function(result) {
        	 
             if(result.value) {
            	//예
            	//삭제 Url 변경
           	  	postAjax('/admin/deleteProjectAjax.do', {seq:seq}, function(data, status){
        			showAjaxMessage(data);
        			
        			if(data.isSuccess === '1')
        			{
	        			$('#list').DataTable().ajax.reload();
        			}
        		});
             }
             else if(result.dismiss === swal.DismissReason.cancel) {
           		//아니요
             }
         });
    });
    
    

    $('#btnDataEdit').click(function(){
    	$('#modalSave').data('seq', $('#modalView').data('seq'));
    	$('#modalSave').modal();
    });
    
    //수정화면 상세데이터 바인딩
    $('#modalSave').on('show.bs.modal', function(e) {
        if ($('#modalSave').data('seq'))
    	{
        	$("#attachdiv").css({"display":"table-row"});
            postAjax('/admin/selectProjectAjax.do', {seq:$(this).data('seq')}, function(data, status){
                var formInput = $('#form input[type!=radio],#form textarea');
        		
        	    $(formInput).each(function(i, input){
                    var inputValue = data.data[$(input).attr('name')];
        		    $(input).val(htmlDecode(inputValue));
                });
        	    $("#csSeq").val(data.data.csSeq).trigger("change.select2");
        	    
        	    var FileHtml =""
        	    $(data.data.projectattachlist).each(function(key, value){
        	    	FileHtml += "<div>"
        	    	FileHtml += "<a href='/admin/downloadprojectfile.do?seq="+value.seq+"'>"+value.oriFilename+"</a>"
        	    	FileHtml += "<button type='button' class='btn btn-sm text-white bg-warning removeaddfile' role='deletefilebtn' data-seq='"+value.seq+"'>삭제</button>"		
        	    	FileHtml += "</div>"
        	    })
        	    $("#attachdivlist").html(FileHtml);
        	    
            });
        }
    });

    $('#modalSave').on('hidden.bs.modal', function(e) {    	
    	initForm('form');
        $('#modalSave').data('seq', "");
        $("#attachdiv").css({"display":"none"});
        
    });
    
	//저장 이벤트
	 $('#btnDataSave').click(function(){
		 if ($('#form').valid())
		 {     
	            var formData = $('#form').serializeObject();
	            
	            ajax(null, '/admin/mergeProjectAjax.do', formData, function(data, status){
	                showAjaxMessage(data);
	                if (data.isSuccess === '1')
	                {
	                	//목록 새로고침
					    $('#list').DataTable().ajax.reload(null, false);
	                	
					    //모달창 닫기
					    $('#modalSave').modal('hide');
					    
	                }
	            });
		 }
	    });
	
}

</script>


<!-- 목록 -->
<div class='card'>
	<div class='card-header header-elements-inline'>
		<h5 class='card-title font-weight-bold'><i class='icon-chevron-right mr-1'></i>프로젝트관리</h5>
        <div class='header-elements'>
			<div class='list-icons ml-3'>
          		<!-- <a class='list-icons-item' data-action='collapse'></a> -->
          		<a class='list-icons-item' data-action='reload'></a>
          		<!-- <a class='list-icons-item' data-action='remove></a> -->
          	</div>
       	</div>
	</div>
	<div class='card-body'>
		<table id='list' class='table table-hover' style='text-align: center;'>
			<colgroup>
				<col style=''>
				<col style='width: 20%;'>
			</colgroup>
			<thead>
				<tr>
					<th>seq</th>
					<th>프로젝트명</th>
					<th>고객사</th>
					<th>프로젝트 시작일~종료일</th>
					<th>프로젝트 설명</th>
					<th>기능</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
</div>	

<div id='modalSave' class='modal fade'>
	<div class='modal-dialog modal-xl'>
		<div class='modal-content'>
			<div class='modal-header bg-primary text-white'>
				<h5 class='modal-title'>프로젝트 등록</h5>
				<button type='button' class='close' data-dismiss='modal'>&times;</button>
			</div>

			<form id='form' name='form' class='form-horizontal'>
                <input id='seq' name='seq' type='hidden' />
                <div class='modal-body'>
				
                    <div class='datatable-scroll'>
	                    <table class='detailtable mb-3'>
	                    	<colgroup>
	                    		<col style='width:20%'/>
	                    		<col style=''/>
	                    	</colgroup>
	                    	<tbody>

                            <tr>
                                <th>프로젝트명</th>
                                <td><input id='projectName' name='projectName' maxlength='20' class='form-control' type='text' placeholder='프로젝트명'></td>
                           </tr>
                           <tr>
                                <th>고객사</th>
                                <td><select id="csSeq" name='csSeq' class="from-control">
									<option selected value="" hidden="">고객사 선택</option>
										<c:forEach items="${getCsList}" var="cs">
										<option value="${cs.seq}"><c:out value="${cs.customerName}"/></option>
										</c:forEach>
									</select></td>
                           </tr>
                           <tr>
                                <th>프로젝트 시작일~종료일</th>
                                <td>시작일<input id='projectStart' name='projectStart' maxlength='20' class='form-control' type='text' placeholder='프로젝트 시작일'>종료일 
                                <input id='projectEnd' name='projectEnd' maxlength='20' class='form-control' type='text' placeholder='프로젝트 종료일'></td>                             
                           </tr>
                           <tr>
                                <th>프로젝트 설명</th>
                                <td><textarea style="height: 200px;" id='projectExp' name='projectExp' maxlength='200' class='form-control' placeholder='프로젝트 설명'></textarea></td>
                           </tr>
                           <tr>
                            <th>첨부파일</th>
                            <td><div class='dropzone' id='divAttachedFile'></div></td>
                           </tr>
                           <tr  id="attachdiv">
	                           	<th>첨부파일목록</th>
	                           	<td id='attachdivlist'></td>
                           </tr>
                           
                        </tbody>
                    </table>
                </div>
                </div>
			</form>
            <div class='modal-footer border-top'>
				<button type='button' class='btn bg-primary text-white' id='btnDataSave'>저장</button>
				<button type='button' class='btn bg-primary text-white' data-dismiss='modal'>닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 상세보기 창 -->
<div id='modalView' class='modal fade'>
	<div class='modal-dialog modal-xl'>
		<div class='modal-content'>
			<div class='modal-header bg-primary text-white'>
				<h5 class='modal-title'>프로젝트 상세</h5>
				<button type='button' class='close' data-dismiss='modal'>&times;</button>
			</div>
			<div class='modal-body'>
				<div class='datatable-scroll'>
					<table class='detailtable mb-3'>
						<colgroup>
							<col style='width: 20%' />
							<col style='' />
						</colgroup>
						<tbody>
							<tr>
								<th>프로젝트명</th>
								<td><label id='lblprojectName'></label></td>
							</tr>
							<tr>
								<th>고객사</th>
								<td><label id='lblcsName'></label></td>
							</tr>
							<tr>
								<th>프로젝트 시작일~종료일</th>
								<td><label id='lblprojectStart'></label>
								~ <label id='lblprojectEnd'></label></td>
							</tr>
							<tr>
								<th>프로젝트 설명</th>
								<td><label id='lblprojectExp'></label></td>
							</tr>
							<tr id='trAttchedFile'>
								<th>첨부파일</th>
								<td id='lblprojectattachlist'></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class='modal-footer border-top'>
				<button type='button' class='btn bg-primary text-white' data-dismiss='modal' id='btnDataEdit'>수정</button>
                <button type='button' class='btn bg-primary text-white' data-dismiss='modal'>닫기</button>
			</div>
		</div>
	</div>
</div>