<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar navbar-expand-lg navbar-dark navbar-static">
	<div class="d-flex flex-1 d-lg-none">
		<button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbar-mobile">
			<i class="icon-paragraph-justify3"></i>
		</button>
		<button type="button" class="navbar-toggler sidebar-mobile-main-toggle">
			<i class="icon-transmission"></i>
		</button>
	</div>
	<div class="navbar-brand text-center text-lg-left">
		<a href="/admin/board.do?code=data1" class="d-inline-block">
			<img src="/css/egovframework/img/bj_logo.png" alt='LOGO' class="d-none d-sm-block" style='width:220px;height:auto;' >
			<!-- <img src="../../../../global_assets/images/logo_icon_light.png" class="d-sm-none" alt=""> -->
		</a>
	</div>
	<div class="collapse navbar-collapse order-2 order-lg-1" id="navbar-mobile">
		<!-- <ul class="navbar-nav">
			<li class="nav-item">
				<a href="#" class="navbar-nav-link sidebar-control sidebar-main-toggle d-none d-lg-block">
					<i class="icon-transmission"></i>
				</a>
			</li>
		</ul> -->
	</div>
	<ul class="navbar-nav flex-row order-1 order-lg-2 flex-1 flex-lg-0 justify-content-end align-items-center">
		<li class="nav-item nav-item-dropdown-lg dropdown dropdown-user h-100">
			<a href="#" class="navbar-nav-link navbar-nav-link-toggler dropdown-toggle d-inline-flex align-items-center h-100" data-toggle="dropdown">
				<img src="../../../../global_assets/images/placeholders/placeholder.jpg" class="rounded-pill mr-lg-2" height="34" alt="">
				<span class="d-none d-lg-inline-block">관리자</span>
			</a>
			<div class="dropdown-menu dropdown-menu-right">
				<a href="/admin/logout.do" class="dropdown-item"><i class="icon-switch2"></i> 로그아웃</a>
			</div>
		</li>
	</ul>
</div>