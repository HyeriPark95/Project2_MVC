<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${host }님의 홈페이지</title>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<link rel="stylesheet" href="./resources/css/header_nav.css"> 
<link rel="stylesheet" href="./resources/css/visit.css">
<script>
	
	$(document).ready(function() {
		$('.page-item.active').removeClass('active');
		const host = $("#host").val();
		const sessionId = $("#sessionId").val();

		if (host == sessionId) {
			$(".guest_reg").hide();
		    $(".comment_list").css("height", "700px");
		    $('input[name="hOr"]').val(sessionId);
		} else {
		    $('input[name="hOr"]').val(host);
		}
		
		$(".geust_box").each(function() {
			const guestId = $(this).find("#guest_id").val();

		    if (guestId != sessionId && host != sessionId) {
		    	$(this).find("#edit, #delete, #line").hide();
		    } else if (host == sessionId) {
		    	$(this).find("#edit, #line").hide();
		    }
		});

		$(".geust_box").on("click", "#edit", function() {
			
			const $comment_update = $(this).closest(".geust_box").find(".comment_update");
		    const $comment = $(this).closest(".geust_box").find(".comment");
		    const $commentText = $comment.children("p").text();

		    $comment_update.show();
		    $comment_update.children("textarea").val($commentText);
		    $comment.hide();

		    $(this).hide();
		    $(this).closest(".geust_box").find("#edit2").show();
			
		});
		
		$(".geust_box").on("click", "#edit2", function() {
			
			const $comment_update = $(this).closest(".geust_box").find(".comment_update");
		    const $comment = $(this).closest(".geust_box").find(".comment");
		    const text = $(this).closest(".geust_box").find(".comment_update").children("textarea").val();
		 
			const v_num = $(this).closest("form[name='frmUpdate']").find("input[name='v_num']").val();
			const v_text = text;
			const v_time = $(this).closest("form[name='frmUpdate']").find("input[name='v_time']").val();
			const v_hostId = $(this).closest("form[name='frmUpdate']").find("input[name='v_hostId']").val();
			const v_guestId = $(this).closest("form[name='frmUpdate']").find("input[name='v_guestId']").val();
			
			const edit = $(this).closest(".geust_box").find("#edit");
			const edit2 = $(this);
		    
		    
			$.ajax({
				url: "visit/commentUpdate", // 요청을 보낼 URL
				method: "POST",
				dataType: "text",
				data: { 
					"v_num" : v_num,
					"v_text" : v_text,
					"v_time" : v_time,
					"v_hostId" : v_hostId,
					"v_guestId" : v_guestId
				},
				success: function(response) {
					$comment_update.hide();
					$comment.show();
					$comment.children("p").text(text);
					
				    edit2.hide();
				   	edit.show();
				    
				    console.log(response);
				},
				error: function(xhr, status, error) {
					console.log(error);
				}
			});
			
		  });	
	});	

</script>
</head>
<body>
    <header>
        <div class="icon">
            <img src="resources/images/racon.png" alt="">
        </div>
        <div class="header_info">
            <i class="fa-regular fa-bell"></i>
            <img class="header_profile" src="resources/images/p.png" alt="">
            <span>너굴</span>
            <i class="fa-sharp fa-solid fa-chevron-down"></i>
        </div>
    </header>
    <div class="nav_section">
        <nav>
            <div class="nav_wrap">
                <div class="music_player">
                    <div class="music_name">
                        <span>I AM - IVE</span>
                        <i class="fa-solid fa-music"></i>
                    </div>
                    <div class="music_icon">
                        <i class="fa-solid fa-backward-step"></i>
                        <i class="fa-solid fa-play"></i>
                        <i class="fa-solid fa-forward-step"></i>
                    </div>
                </div>

                <div class="search">
                    <span><b>아이디검색</b></span>
                    <div class="search_bar">
                        <input type="text" name="" id="">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </div>
                </div>
                <div class="menu">
                    <a href=""><div class="menu_box">홈</div></a>
                    <a href=""><div class="menu_box">프로필</div></a>
                    <a href=""><div class="menu_box">주크박스</div></a>
                    <a href=""><div class="menu_box">다이어리</div></a>
                    <a href=""><div>갤러리</div></a>
                    <a href=""><div>방명록</div></a>
                </div>
            </div>
        </nav>
        <section>
            <div class="section_wrap">
                <div class="guest_title">
                    <h1>방명록</h1>
                </div>
                <form name="frm" action="./visit/Reg" method="post">
	                <div class="guest_reg">
	                	<div class="pic_nickname">
	                		<img src="${member.h_pic}">
	                   		<p>${member.m_nick}</p>
	                	</div>
	                    <textarea name="v_text"></textarea>
	                   	<input id="host" type="hidden" name="v_hostId" value="${host}">
						<input id="sessionId" type="hidden" name="v_guestId" value="${sessionId}">
	                    <div class="reg_btn">
	                        <button>등록</button>
	                    </div>
	                </div>
                </form>
                <div class="comment_list">
	                <c:forEach var="list" items="${list }">
	                	<div class="geust_box">
	                		<div class="guest_pic_nick">
	                			<img src="${list.h_pic }">
	                    		<p>${list.m_nick }</p>
	                		</div>
	                		<form name="frmUpdate" action="visit/commentUpdate" method="post">
		                        <div class="guest_comment">
		                        	<input type="hidden" name="v_num" value="${list.v_num }">
									<input type="hidden" name="v_time" value="${list.v_time }">
		                        	<input id="host_id" type="hidden" name="v_hostId" value="${list.v_hostId }">
		                        	<input id="guest_id" type="hidden" name="v_guestId" value="${list.v_guestId }">
		                            <span>${list.v_time}</span>
		                            <div class="comment">
		                                <p>${list.v_text}</p>
		                            </div>
		                            <div class="comment_update">
		                            	<textarea name="v_text"></textarea>
		                            </div>
		                            <div>
		                            	<button id="edit" type="button">수정</button>
		                            	<button id="edit2" type="button">수정</button>
		                            </div>
		                        </div>
	                       	</form>
	                       	<span id="line">|</span>
	                       	<form name="frmDelete" action="visit/delete" method="post">
	                       		<input type="hidden" name="v_num" value="${list.v_num }">
	                       		<input type="hidden" name="hOr" value="">
	                       		<button id="delete">삭제</button>
	                       	</form>
	                    </div>
	                </c:forEach>
	                
					<div aria-label="Page navigation example">
						<ul class="pagination justify-content-center">
					    	<li class="page-item"><a class="page-link" href="./visit?id=${host}&page=1"><</a></li>
					    	<c:forEach var="pageNumber" begin="${startPage}" end="${endPage}">
					    		<li class="page-item"><a class="page-link" href="./visit?id=${host }&page=${pageNumber}">${pageNumber}</a></li>
					 		</c:forEach>
					    	<li class="page-item"><a class="page-link" href="./visit?id=${host}&page=${totalPages}">></a></li>
					  	</ul>
					</div>
                </div>
            </div>
        </section>
    </div>
</body>
</html>