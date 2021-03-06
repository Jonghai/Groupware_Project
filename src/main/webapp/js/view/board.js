var boardModalHtml2 = "<div id='modalBoardSave' class='modal fade'>";
boardModalHtml2 += "	<div class='modal-dialog modal-xl'>";
boardModalHtml2 += "		<div class='modal-content'>";
boardModalHtml2 += "			<div class='modal-header bg-primary text-white'>";
boardModalHtml2 += "				<h5 class='modal-title font-weight-bold'>게시글 저장</h5>";
boardModalHtml2 += "				<button type='button' class='close font-weight-bold' data-dismiss='modal'>&times;</button>";
boardModalHtml2 += "			</div>";
boardModalHtml2 += "            <div class='modal-body'>";
boardModalHtml2 += "	           	<form id='boardForm' name='boardForm' class='form-horizontal'>";
boardModalHtml2 += "               		<input id='seq' name='seq' type='hidden' />";
boardModalHtml2 += "					<div class='datatable-scroll'>";
boardModalHtml2 += "						<table class='detailtable mb-3'>";
boardModalHtml2 += "							<colgroup>";
boardModalHtml2 += "								<col style='width:20%'/>";
boardModalHtml2 += "								<col style=''/>";
boardModalHtml2 += "							</colgroup>";
boardModalHtml2 += "							<tbody>";
boardModalHtml2 += "								<tr>";
boardModalHtml2 += "									<th>제목</th>";
boardModalHtml2 += "									<td><input type='text' class='form-control' placeholder='제목' id='boardTitle' name='boardTitle'></td>";
boardModalHtml2 += "								</tr>";
boardModalHtml2 += "								<tr>";
boardModalHtml2 += "									<th>작성일</th>";
boardModalHtml2 += "									<td><input type='text' class='form-control' placeholder='작성일' id='regDate' name='regDate'></td>";
boardModalHtml2 += "								</tr>";
//boardModalHtml2 += "                				<tr>";
//boardModalHtml2 += "									<th>제목링크</th>";
//boardModalHtml2 += "									<td><input type='text' class='form-control' placeholder='http://www.givet.or.kr' id='link' name='link'>";
//boardModalHtml2 += "									<label class='text-primary font-weight-semibold'>* 게시글 제목 클릭시 링크시킬 곳이 있다면 입력해 주세요.(사용자 화면에 적용됨)</label>";
//boardModalHtml2 += "									</td>";
//boardModalHtml2 += "								</tr>";
boardModalHtml2 += "                				<tr>";
boardModalHtml2 += "									<th>내용</th>";
boardModalHtml2 += "									<td><textarea id='boardContent' name='boardContent' class='form-control'></textarea></td>";
boardModalHtml2 += "								</tr>";
boardModalHtml2 += "                				<tr>";
boardModalHtml2 += "									<th>파일첨부</th>";
boardModalHtml2 += "									<td><div class='dropzone' id='divAttachedFile'></div></td>";
boardModalHtml2 += "								</tr>";
boardModalHtml2 += "                				<tr id='trAttchedFile'>";
boardModalHtml2 += "									<th>첨부파일</th>";
boardModalHtml2 += "									<td id='lblattachedFileView'></td>";
boardModalHtml2 += "								</tr>";
boardModalHtml2 += "							</tbody>";
boardModalHtml2 += "						</table>";
boardModalHtml2 += "            		</div>";
boardModalHtml2 += "				</form>";
boardModalHtml2 += "            </div>";
boardModalHtml2 += "            <div class='modal-footer border-top'>";
boardModalHtml2 += "				<button type='button' class='btn bg-primary text-white' id='btnBoardDataSave'>저장</button>";
boardModalHtml2 += "				<button type='button' class='btn bg-primary text-white' data-dismiss='modal'>닫기</button>";
boardModalHtml2 += "			</div>";
boardModalHtml2 += "		</div>";
boardModalHtml2 += "	</div>";
boardModalHtml2 += "</div>";

boardModalHtml2 += "<div id='modalBoardView' class='modal fade'>";
boardModalHtml2 += "	<div class='modal-dialog modal-xl'>";
boardModalHtml2 += "		<div class='modal-content'>";
boardModalHtml2 += "			<div class='modal-header bg-primary text-white'>";
boardModalHtml2 += "				<h5 class='modal-title'>게시글 상세</h5>";
boardModalHtml2 += "				<button type='button' class='close' data-dismiss='modal'>&times;</button>";
boardModalHtml2 += "			</div>";
boardModalHtml2 += "            <div class='modal-body'>";
boardModalHtml2 += "				<div class='datatable-scroll'>";
boardModalHtml2 += "					<table class='detailtable mb-3'>";
boardModalHtml2 += "						<colgroup>";
boardModalHtml2 += "							<col style='width:20%'/>";
boardModalHtml2 += "							<col style=''/>";
boardModalHtml2 += "						</colgroup>";
boardModalHtml2 += "						<tbody>";
boardModalHtml2 += "							<tr>";
boardModalHtml2 += "								<th>제목</th>";
boardModalHtml2 += "								<td><label id='lblboardTitle'></td>";
boardModalHtml2 += "							</tr>";
//boardModalHtml2 += "							<tr>";
//boardModalHtml2 += "								<th>제목링크</th>";
//boardModalHtml2 += "								<td><label id='lbllink'></label></td>";
//boardModalHtml2 += "							</tr>";
boardModalHtml2 += "							<tr>";
boardModalHtml2 += "								<th>내용</th>";
boardModalHtml2 += "								<td><label id='lblboardContent'></label></td>";
boardModalHtml2 += "							</tr>";
boardModalHtml2 += "							<tr>";
boardModalHtml2 += "								<th>첨부파일</th>";
boardModalHtml2 += "								<td><label id='lblattachedFile'></label></td>";
boardModalHtml2 += "							</tr>";
boardModalHtml2 += "						</tbody>";
boardModalHtml2 += "					</table>";
boardModalHtml2 += "				</div>";
boardModalHtml2 += "			</div>";
boardModalHtml2 += "			<div class='modal-footer'>";
boardModalHtml2 += "				<button type='button' class='btn bg-primary text-white' data-dismiss='modal' id='btnBoardDataEdit'>수정</button>";
boardModalHtml2 += "				<button type='button' class='btn bg-primary text-white' data-dismiss='modal'>닫기</button>";
boardModalHtml2 += "			</div>";
boardModalHtml2 += "		</div>";
boardModalHtml2 += "	</div>";
boardModalHtml2 += "</div>";

var boardModalHtml3 = "<div id='modalBoardSave' class='modal fade'>";
boardModalHtml3 += "	<div class='modal-dialog modal-xl'>";
boardModalHtml3 += "		<div class='modal-content'>";
boardModalHtml3 += "			<div class='modal-header bg-primary text-white'>";
boardModalHtml3 += "				<h5 class='modal-title font-weight-bold'>게시글 저장</h5>";
boardModalHtml3 += "				<button type='button' class='close font-weight-bold' data-dismiss='modal'>&times;</button>";
boardModalHtml3 += "			</div>";
boardModalHtml3 += "            <div class='modal-body'>";
boardModalHtml3 += "	           	<form id='boardForm' name='boardForm' class='form-horizontal'>";
boardModalHtml3 += "               		<input id='seq' name='seq' type='hidden' />";
boardModalHtml3 += "					<div class='datatable-scroll'>";
boardModalHtml3 += "						<table class='detailtable mb-3'>";
boardModalHtml3 += "							<colgroup>";
boardModalHtml3 += "								<col style='width:20%'/>";
boardModalHtml3 += "								<col style=''/>";
boardModalHtml3 += "							</colgroup>";
boardModalHtml3 += "							<tbody>";
boardModalHtml3 += "								<tr>";
boardModalHtml3 += "									<th>제목</th>";
boardModalHtml3 += "									<td><input type='text' class='form-control' placeholder='제목' id='boardTitle' name='boardTitle'></td>";
boardModalHtml3 += "								</tr>";
boardModalHtml3 += "                				<tr>";
boardModalHtml3 += "									<th>내용</th>";
boardModalHtml3 += "									<td>";
boardModalHtml3 += "										<textarea id='boardContent' name='boardContent' class='form-control'></textarea>";
boardModalHtml3 += "										<label class='text-primary font-weight-semibold'>* 이미지를 드레그 하여 에디터 영역에 끌어 놓으면 이미지가 저장됩니다.</label>";
boardModalHtml3 += "									</td>";
boardModalHtml3 += "								</tr>";
boardModalHtml3 += "                				<tr id='trAttchedFile'>";
boardModalHtml3 += "									<th>첨부파일</th>";
boardModalHtml3 += "									<td id='lblattachedFileView'></td>";
boardModalHtml3 += "								</tr>";
boardModalHtml3 += "							</tbody>";
boardModalHtml3 += "						</table>";
boardModalHtml3 += "            		</div>";
boardModalHtml3 += "				</form>";
boardModalHtml3 += "            </div>";
boardModalHtml3 += "            <div class='modal-footer border-top'>";
boardModalHtml3 += "				<button type='button' class='btn bg-primary text-white' id='btnBoardDataSave'>저장</button>";
boardModalHtml3 += "				<button type='button' class='btn bg-primary text-white' data-dismiss='modal'>닫기</button>";
boardModalHtml3 += "			</div>";
boardModalHtml3 += "		</div>";
boardModalHtml3 += "	</div>";
boardModalHtml3 += "</div>";

boardModalHtml3 += "<div id='modalBoardView' class='modal fade'>";
boardModalHtml3 += "	<div class='modal-dialog modal-xl'>";
boardModalHtml3 += "		<div class='modal-content'>";
boardModalHtml3 += "			<div class='modal-header bg-primary text-white'>";
boardModalHtml3 += "				<h5 class='modal-title'>게시글 상세</h5>";
boardModalHtml3 += "				<button type='button' class='close' data-dismiss='modal'>&times;</button>";
boardModalHtml3 += "			</div>";
boardModalHtml3 += "            <div class='modal-body'>";
boardModalHtml3 += "				<div class='datatable-scroll'>";
boardModalHtml3 += "					<table class='detailtable mb-3'>";
boardModalHtml3 += "						<colgroup>";
boardModalHtml3 += "							<col style='width:20%'/>";
boardModalHtml3 += "							<col style=''/>";
boardModalHtml3 += "						</colgroup>";
boardModalHtml3 += "						<tbody>";
boardModalHtml3 += "							<tr>";
boardModalHtml3 += "								<th>제목</th>";
boardModalHtml3 += "								<td><label id='lblboardTitle'></td>";
boardModalHtml3 += "							</tr>";
boardModalHtml3 += "							<tr>";
boardModalHtml3 += "								<th>내용</th>";
boardModalHtml3 += "								<td><label id='lblboardContent'></label></td>";
boardModalHtml3 += "							</tr>";
boardModalHtml3 += "						</tbody>";
boardModalHtml3 += "					</table>";
boardModalHtml3 += "				</div>";
boardModalHtml3 += "			</div>";
boardModalHtml3 += "			<div class='modal-footer'>";
boardModalHtml3 += "				<button type='button' class='btn bg-primary text-white' data-dismiss='modal' id='btnBoardDataEdit'>수정</button>";
boardModalHtml3 += "				<button type='button' class='btn bg-primary text-white' data-dismiss='modal'>닫기</button>";
boardModalHtml3 += "			</div>";
boardModalHtml3 += "		</div>";
boardModalHtml3 += "	</div>";
boardModalHtml3 += "</div>";


var boardModalHtml4 = "<div id='modalBoardSave' class='modal fade'>";
boardModalHtml4 += "	<div class='modal-dialog modal-xl'>";
boardModalHtml4 += "		<div class='modal-content'>";
boardModalHtml4 += "			<div class='modal-header bg-primary text-white'>";
boardModalHtml4 += "				<h5 class='modal-title font-weight-bold'>게시글 저장</h5>";
boardModalHtml4 += "				<button type='button' class='close font-weight-bold' data-dismiss='modal'>&times;</button>";
boardModalHtml4 += "			</div>";
boardModalHtml4 += "			<div class='modal-body'>";
boardModalHtml4 += "				<form id='boardForm' name='boardForm' class='form-horizontal'>";
boardModalHtml4 += "				<input id='seq' name='seq' type='hidden' />";
boardModalHtml4 += "				<div class='datatable-scroll'>";
boardModalHtml4 += "					<table class='detailtable mb-3'>";
boardModalHtml4 += "						<colgroup>";
boardModalHtml4 += "							<col style='width:20%'/>";
boardModalHtml4 += "							<col style=''/>";
boardModalHtml4 += "						</colgroup>";
boardModalHtml4 += "						<tbody>";
boardModalHtml4 += "                			<tr>";
boardModalHtml4 += "								<th>제목</th>";
boardModalHtml4 += "								<td><input type='text' class='form-control' placeholder='제목' id='boardTitle' name='boardTitle'></td>";
boardModalHtml4 += "							</tr>";
boardModalHtml4 += "							<tr>";
boardModalHtml4 += "								<th>PDF 첨부</th>";
boardModalHtml4 += "								<td>";
boardModalHtml4 += "									<div class='input-group'>";
boardModalHtml4 += "										<input type='text' class='form-control selectedfilename' placeholder='파일명' readonly>";
boardModalHtml4 += "										<input type='file' style='display:none;' name='pdfFile' id='pdfFile' accept='.pdf'>";
boardModalHtml4 += "										<span class='input-group-append'>";
boardModalHtml4 += "											<button class='btn btn-light selectfile' type='button'>파일 선택</button>";
boardModalHtml4 += "										</span>";
boardModalHtml4 += "									</div>";
boardModalHtml4 += "									<label class='text-primary font-weight-semibold'>* PDF를 첨부하면 이전에 등록된 파일은 삭제 됩니다.</label>";
boardModalHtml4 += "								</td>";
boardModalHtml4 += "							</tr>";
boardModalHtml4 += "						</tbody>";
boardModalHtml4 += "					</table>";
boardModalHtml4 += "				</div>";
boardModalHtml4 += "				</form>";
boardModalHtml4 += "			</div>";
boardModalHtml4 += "			<div class='modal-footer border-top'>";
boardModalHtml4 += "				<button type='button' class='btn bg-primary text-white' id='btnBoardDataSave'>저장</button>";
boardModalHtml4 += "				<button type='button' class='btn bg-primary text-white' data-dismiss='modal'>닫기</button>";
boardModalHtml4 += "			</div>";
boardModalHtml4 += "		</div>";
boardModalHtml4 += "	</div>";
boardModalHtml4 += "</div>";

boardModalHtml4 += "<div id='modalBoardView' class='modal fade'>";
boardModalHtml4 += "	<div class='modal-dialog modal-xl'>";
boardModalHtml4 += "		<div class='modal-content'>";
boardModalHtml4 += "			<div class='modal-header bg-primary text-white'>";
boardModalHtml4 += "				<h5 class='modal-title'>게시글 상세</h5>";
boardModalHtml4 += "				<button type='button' class='close' data-dismiss='modal'>&times;</button>";
boardModalHtml4 += "			</div>";
boardModalHtml4 += "            <div class='modal-body'>";
boardModalHtml4 += "				<div class='datatable-scroll'>";
boardModalHtml4 += "					<table class='detailtable mb-3'>";
boardModalHtml4 += "						<colgroup>";
boardModalHtml4 += "							<col style='width:20%'/>";
boardModalHtml4 += "							<col style=''/>";
boardModalHtml4 += "						</colgroup>";
boardModalHtml4 += "						<tbody>";
boardModalHtml4 += "                			<tr>";
boardModalHtml4 += "								<th>제목</th>";
boardModalHtml4 += "								<td><label id='lblboardTitle'></label></td>";
boardModalHtml4 += "							</tr>";
boardModalHtml4 += "                			<tr>";
boardModalHtml4 += "								<th>썸네일</th>";
boardModalHtml4 += "								<td><label id='lblthumnailImage'></label></td>";
boardModalHtml4 += "							</tr>";
boardModalHtml4 += "							<tr>";
boardModalHtml4 += "								<th>첨부파일</th>";
boardModalHtml4 += "								<td><label id='lblattachedFile'></label></td>";
boardModalHtml4 += "							</tr>";
boardModalHtml4 += "						</tbody>";
boardModalHtml4 += "					</table>";
boardModalHtml4 += "            	</div>";
boardModalHtml4 += "            </div>";
boardModalHtml4 += "            <div class='modal-footer'>";
boardModalHtml4 += "				<button type='button' class='btn bg-primary text-white' data-dismiss='modal' id='btnBoardDataEdit'>수정</button>";
boardModalHtml4 += "                <button type='button' class='btn bg-primary text-white' data-dismiss='modal'>닫기</button>";
boardModalHtml4 += "			</div>";
boardModalHtml4 += "		</div>";
boardModalHtml4 += "	</div>";
boardModalHtml4 += "</div>";

var boardModalHtml5 = "<div id='modalBoardSave' class='modal fade'>";
boardModalHtml5 += "	<div class='modal-dialog modal-xl'>";
boardModalHtml5 += "		<div class='modal-content'>";
boardModalHtml5 += "			<div class='modal-header bg-primary text-white'>";
boardModalHtml5 += "				<h5 class='modal-title font-weight-bold'>게시글 저장</h5>";
boardModalHtml5 += "				<button type='button' class='close font-weight-bold' data-dismiss='modal'>&times;</button>";
boardModalHtml5 += "			</div>";
boardModalHtml5 += "			<div class='modal-body'>";
boardModalHtml5 += "				<form id='boardForm' name='boardForm' class='form-horizontal'>";
boardModalHtml5 += "				<input id='seq' name='seq' type='hidden' />";
boardModalHtml5 += "				<div class='datatable-scroll'>";
boardModalHtml5 += "					<table class='detailtable mb-3'>";
boardModalHtml5 += "						<colgroup>";
boardModalHtml5 += "							<col style='width:20%'/>";
boardModalHtml5 += "							<col style=''/>";
boardModalHtml5 += "						</colgroup>";
boardModalHtml5 += "						<tbody>";
boardModalHtml5 += "                			<tr>";
boardModalHtml5 += "								<th>제목</th>";
boardModalHtml5 += "								<td><input type='text' class='form-control' placeholder='제목' id='boardTitle' name='boardTitle'></td>";
boardModalHtml5 += "							</tr>";
boardModalHtml5 += "							<tr>";
boardModalHtml5 += "								<th>유튜브 링크</th>";
boardModalHtml5 += "								<td><input type='text' class='form-control' placeholder='유튜브 링크' id='boardTitleLink' name='boardTitleLink'>";
boardModalHtml5 += "								<span class='text-primary font-weight-semibold'>* 유튜브 동영상화면 -> 마우스 오른쪽 버튼 -> 소스코드복사 -> 유튜브 링크에 붙여 넣기 </span>";
boardModalHtml5 += "								</td>";
boardModalHtml5 += "							</tr>";
boardModalHtml5 += "						</tbody>";
boardModalHtml5 += "					</table>";
boardModalHtml5 += "            	</div>";
boardModalHtml5 += "				</form>";
boardModalHtml5 += "            </div>";
boardModalHtml5 += "            <div class='modal-footer border-top'>";
boardModalHtml5 += "				<button type='button' class='btn bg-primary text-white' id='btnBoardDataSave'>저장</button>";
boardModalHtml5 += "				<button type='button' class='btn bg-primary text-white' data-dismiss='modal'>닫기</button>";
boardModalHtml5 += "			</div>";
boardModalHtml5 += "		</div>";
boardModalHtml5 += "	</div>";
boardModalHtml5 += "</div>";

boardModalHtml5 += "<div id='modalBoardView' class='modal fade'>";
boardModalHtml5 += "	<div class='modal-dialog modal-xl'>";
boardModalHtml5 += "		<div class='modal-content'>";
boardModalHtml5 += "			<div class='modal-header bg-primary text-white'>";
boardModalHtml5 += "				<h5 class='modal-title'>게시글 상세</h5>";
boardModalHtml5 += "				<button type='button' class='close' data-dismiss='modal'>&times;</button>";
boardModalHtml5 += "			</div>";
boardModalHtml5 += "            <div class='modal-body'>";
boardModalHtml5 += "				<div class='datatable-scroll'>";
boardModalHtml5 += "					<table class='detailtable mb-3'>";
boardModalHtml5 += "						<colgroup>";
boardModalHtml5 += "							<col style='width:20%'/>";
boardModalHtml5 += "							<col style=''/>";
boardModalHtml5 += "						</colgroup>";
boardModalHtml5 += "						<tbody>";
boardModalHtml5 += "                			<tr>";
boardModalHtml5 += "								<th>제목</th>";
boardModalHtml5 += "								<td><label id='lblboardTitle'></label></td>";
boardModalHtml5 += "							</tr>";
boardModalHtml5 += "							<tr>";
boardModalHtml5 += "								<th>유튜브</th>";
boardModalHtml5 += "								<td><label id='lblboardTitleLink'></label></td>";
boardModalHtml5 += "							</tr>";
boardModalHtml5 += "            			</tbody>";
boardModalHtml5 += "            		</table>";
boardModalHtml5 += "            	</div>";
boardModalHtml5 += "            </div>";
boardModalHtml5 += "            <div class='modal-footer'>";
boardModalHtml5 += "				<button type='button' class='btn bg-primary text-white' data-dismiss='modal' id='btnBoardDataEdit'>수정</button>";
boardModalHtml5 += "                <button type='button' class='btn bg-primary text-white' data-dismiss='modal'>닫기</button>";
boardModalHtml5 += "			</div>";
boardModalHtml5 += "		</div>";
boardModalHtml5 += "	</div>";
boardModalHtml5 += "</div>";

var boardModalList = {
		boardModal2:boardModalHtml2,
		boardModal3:boardModalHtml3,
		boardModal4:boardModalHtml4,
		boardModal5:boardModalHtml5
};
