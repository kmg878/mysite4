<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>  
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>mysite</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="/mysite/assets/css/board.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="container">
			<c:import url='/WEB-INF/views/include/header.jsp'/>
		<div id="content">
			<div id="board">
				<form id="search_form" action="" method="post">
					<input type="text" id="kwd" name="kwd" value="">
					<input type="submit" value="찾기">
				</form>
				<table class="tbl-ex">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>&nbsp;</th>
					</tr>	
	<c:set var="countList" value="${fn:length(list2)}"/>
               <c:forEach var='vo' items='${list2}' varStatus='s'>
					<tr>
						<td>[${countList-s.index}]</td>
						<td style="text-align:left;padding-left:${(vo.depth)*10}px">
						<c:if test='${vo.depth>1 }'>
							<img src="">
						</c:if>
						<a href="/mysite/board?a=view&no=${ vo.no}">${vo.title}</a></td>
						<td>${vo.name}</td>
						<td>${vo.viewCount}</td>
						<td>${vo.regDate}</td>
						<c:if test='${authUser.no==vo.userNo }'>
						<td><a href="/mysite/board?a=delete&no=${vo.no }" class="del">삭제</a></td>
						</c:if>
					</tr>
					  </c:forEach>
					
				</table>
				
				<!-- begin:paging -->
				<div class="pager">
					<ul>
						<li><a href="/mysite/board?a=list&page=${beginPage-1 }">◀</a></li>
						
						<c:forEach begin='${beginPage }' end='${endPage }' step='1' var='i'>
						<c:choose>
						<c:when test='${currentPage == i }'>
						<li class="selected">${i }</li>
						</c:when>
						<c:otherwise>
						<li><a href="/mysite/board?a=list&page=${i }">${i }</a></li>
						</c:otherwise>
						</c:choose>
						</c:forEach>
						
						<c:if test='${endPage <total }'>
						<li><a href="/mysite/board?a=list&page=${endPage+1 }">▶</a></li>
						</c:if>
					</ul>
				</div>
				<!-- end:paging -->
				<c:if test = '${not empty sessionScope.authUser}'>
				<div class="bottom">
					<a href="/mysite/board?a=writeform" id="new-book">글쓰기</a>
				</div>
				</c:if>
								
			</div>
		</div>
		<c:import url='/WEB-INF/views/include/navi.jsp'/>
		<c:import url='/WEB-INF/views/include/footer.jsp'/>
	</div>
</body>
</html>