<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='spring' uri='http://www.springframework.org/tags'%>

<script src="/js/plugins/fancytree/fancytree_all.min.js"></script>
<script src="/js/plugins/datatables/extensions/row_reorder.min.js"></script>

<script type='text/javascript'>

function initControl()
{
	
}

function initEvent() {
	

	var fancytree = $('.tree-ajax').fancytree({
    	//checkbox: true,
        //selectMode: 3,
        source: {
        	url: '/admin/getCommonCodeTreeAjax.do'
        },
        init: function(event, data) {
        	$.ui.fancytree.getTree('.tree-ajax').activateKey("0");
        },
        activate: function(event, data){
            $('#list').DataTable().ajax.reload();
        },
    });
	
	var table = $('#list').DataTable( {
		serverSide:true
		, processing:true
		, rowReorder: {selector: 'span.reorder'}
        , ajax: {
            url: '/admin/getCommonCodeListAjax.do',
            type: 'POST',
            data:function(d){
            	var selectedTreeValue = getSelectTreeItem();
            	
            	if(selectedTreeValue)
            		d.parentSeq = selectedTreeValue.key;
            	
            }
        }
		, order: [[ 2, 'asc' ]]
        , columns: [
            { 'data': 'seq', visible:false },
			{ 'data': 'codeDesc'},
			{ 'data': function(rowObject){
				return "<span class='reorder'>"+rowObject.sort+"</span>";
			}, 'name':"sort"},
			{ 'data': 'isUsedDesc' },
			{ 'data': 'isEditDesc' },
            {
	            className:      'text-center',
	            orderable:      false,
	            data:           function(rowObject, f, u, table)
	            {
	            	var actionButtonHtml = "";
		            var actionButtonItem = "";
		
		            if(rowObject.isEdit === "1" ){
			            actionButtonItem += "<a href='#' class='dropdown-item' data-seq='"+rowObject.seq+"' data-parentseq='"+rowObject.parentSeq+"' role='dataEdit'><i class='icon-pencil5'></i>??????</a>";
			            actionButtonItem += "<a href='#' class='dropdown-item' data-seq='"+rowObject.seq+"' data-parentseq='"+rowObject.parentSeq+"' role='dataRemove'><i class='icon-x'></i>??????</a>";	
		            }
		            
		            if(actionButtonItem){
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
		            }
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
                    text: '?????? ??????',
                    attr:{
                    	'data-toggle':'modal',
                    	'data-target':'#modalCommonCodeSave'
                    },
                    action: function(e, dt, node, config) {
                    }
                }
            ],
        }
    } );
	
	table.on('row-reorder', function (e, diff, edit) {
		var commonCodeSortArray = [];
       	$("#list > tbody > tr").each(function(i, tr){
       		var seq = table.row(tr).data().seq
       		var sort = i + 1;
       		
       		commonCodeSortArray.push({seq:seq, sort:sort});
       	});
       	
       	postAjax("/admin/reorderCommonCodeAjax.do", {commonCodeSortArray :JSON.stringify(commonCodeSortArray)}, function(){
       		
       	}, false);
       	
    });
	
	//validate add method
	//jQuery.validator.addMethod('addCheck', function(value, element) {
	//        return (value.length > 0);
	//    }, 'This field is required.'
	//);
	
	$('#commoncodeForm').validate({
		rules:{
			codeDesc:{required:true},
		}
	});

	$.each($('#commoncodeForm').validate().settings.rules, function(key, value){
	    $('#' + key).parent().prev().html(function(idx, oldHtml){
		    if(oldHtml.indexOf('*') < 0)
			    return '* ' + oldHtml;
	    })
    });

	$(document).on('click', 'a[role=dataEdit]', function(){
				
    	$('#modalCommonCodeSave').data('seq', $(this).data('seq'));
		$('#modalCommonCodeSave').modal();
    });  
    
    $(document).on('click', 'a[role=dataRemove]', function(){
    	var seq = $(this).data('seq');
    	var parentSeq = $(this).data('parentseq');
    	
    	sweetConfirm(
    			'?????? ????????? ?????????????????????????'
    			,  '???????????? ????????? ?????? ????????? ????????? ???????????? ????????? ????????? ??? ????????????. ?????? ??? ?????? ?????? ?????? ??? ?????????.'
    			, function(){
		    		postAjax('/admin/deleteCommonCodeAjax.do', {seq:seq}, function(data, status){
		    			showAjaxMessage(data);
		    			
		    			if(data.isSuccess === '1')
		    			{
		    				if(parentSeq === 0)
		    					$('.tree-ajax').fancytree();
		    				
		        			$('#list').DataTable().ajax.reload();
		    			}
		    		});
    			})
    });

    $('#btnCommonCodeDataEdit').click(function(){
    	$('#modalCommonCodeSave').data('seq', $('#modalCommonCodeView').data('seq'));
    	$('#modalCommonCodeSave').modal();
    });
    
    $('#modalCommonCodeSave').on('show.bs.modal', function(e) {
        if ($('#modalCommonCodeSave').data('seq'))
    	{
            postAjax('/admin/selectCommonCodeAjax.do', {seq:$(this).data('seq')}, function(data, status){
                var formInput = $('#commoncodeForm input[type!=radio],#commoncodeForm textarea');
        		
        	    $(formInput).each(function(i, input){
                    var inputValue = data.data[$(input).attr('name')];
        		    $(input).val(inputValue);
                });
				
        	    $("input[name=isUsed][value="+data.data.isUsed+"]").prop("checked",true);
        	    
                //CKEDITOR.instances.elementId.setData(htmlDecode(data));
            });
        }
    });

    $('#modalCommonCodeSave').on('hidden.bs.modal', function(e) {
    	initForm('commoncodeForm');
        $('#modalCommonCodeSave').data('seq', "");
        //CKEDITOR.instances.elementId.setData("");
    });
    
    $('#btnCommonCodeDataSave').click(function(){
        if ($('#commoncodeForm').valid())
		{
        	if(getSelectTreeItem() == null)
			{
        		toastr.warning("??????????????? ????????? ?????????.");
        		return;
			}   
        	
        	var formData = $('#commoncodeForm').serializeObject();
        	formData.parentSeq = getSelectTreeItem().key;
            ajax($('#modalCommonCodeSave div.modal-content'), '/admin/mergeCommonCodeAjax.do', formData, function(data, status){
                showAjaxMessage(data);
                if (data.isSuccess === '1')
                {
				    $('#list').DataTable().ajax.reload(null, false);
				    
				    if(formData.parentSeq === "0")
				    	$('.tree-ajax').fancytree();
				    
				    $('#modalCommonCodeSave').modal('hide');
                }
            });
        }
    });    
}

function getSelectTreeItem(){
	var selectedNode = $(".tree-ajax").fancytree("getTree").getActiveNode();
	return selectedNode;
}


</script>
<div class='row m-0 h-100'>
	<div class='col-lg-2 p-0'>
		<div class='card h-100'>
			<div class='card-header header-elements-inline'>
				<h5 class='card-title font-weight-bold'>
					<i class='icon-chevron-right mr-1'></i> ??????????????????
				</h5>
			</div>
			<div class='card-body'>
				<div class="tree-ajax p-1"></div>
			</div>
		</div>
	</div>
	<div class='col-lg-10 p-0'>
		<div class='card h-100'>
			<div class='card-header header-elements-inline'>
				<h5 class='card-title font-weight-bold'><i class='icon-chevron-right mr-1'></i>?????? ??????
				<label class='text-primary font-weight-semibold' style='font-size:0.75em;'>* ??????????????? ???????????? ????????????????????? ????????? ??? ????????????.</label></h5>
		        <div class='header-elements'>
					<div class='list-icons ml-3'>
		          		<a class='list-icons-item' data-action='reload'></a>
		          	</div>
		       	</div>
			</div>
		    <div class='card-body'>
				<table id='list' class='table table-hover'>
					<colgroup>
						<col style=''>
						<col style='width: 10%;'>
						<col style='width: 10%;'>
						<col style='width: 15%;'>
						<col style='width: 80px;'>
					</colgroup>
					<thead>
						<tr>
							<th>seq</th>
							<th>?????????</th>
							<th>??????</th>
							<th>????????????</th>
							<th>??????????????????</th>
							<th>??????</th>
						</tr>
					</thead>
					<tbody>
		
					</tbody>
				</table>
			</div>
		</div>	
	</div>
</div>



<div id='modalCommonCodeSave' class='modal fade'>
	<div class='modal-dialog modal-xl'>
		<div class='modal-content'>
			<div class='modal-header bg-primary text-white'>
				<h5 class='modal-title'>?????? ??????</h5>
				<button type='button' class='close' data-dismiss='modal'>&times;</button>
			</div>

			<form id='commoncodeForm' name='commoncodeForm' class='form-horizontal'>
                <input id='seq' name='seq' type='hidden' />
                <div class='modal-body'>
				
                    <div class='datatable-scroll'>
						<table class='detailtable mb-3'>
							<colgroup>
								<col style='width: 20%' />
								<col style='' />
							</colgroup>
							<tbody>

								<tr>
									<th>?????????</th>
									<td><input id='codeDesc' name='codeDesc' maxlength='60' class='form-control' type='text' placeholder='?????????'></td>									
								</tr>
								<tr>
									<th>??????</th>
									<td>
										<input id='sort' name='sort' maxlength='3' class='form-control' type='text' placeholder='??????' data-inputtype='onlynumber'>
										<label class='text-primary font-weight-semibold'>* ???????????? ???????????? ????????? ?????? ???????????? ???????????? ????????? ???????????????.</label>
									</td>									
								</tr>
								<tr>
									<th>????????????</th>
									<td class="text-left">
										<label class="custom-control custom-radio custom-control-inline">
											<input type="radio" class="custom-control-input" name="isUsed" value='1' checked>
											<span class="custom-control-label">???</span>
										</label>
				
										<label class="custom-control custom-radio custom-control-inline">
											<input type="radio" class="custom-control-input" name="isUsed" value='0'>
											<span class="custom-control-label">?????????</span>
										</label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
                </div>
			</form>
            <div class='modal-footer border-top'>
				<button type='button' class='btn bg-primary text-white' id='btnCommonCodeDataSave'>??????</button>
				<button type='button' class='btn bg-primary text-white' data-dismiss='modal'>??????</button>
			</div>
		</div>
	</div>
</div>

