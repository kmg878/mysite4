<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
            <div id="board" class="board-form">
               <form method="post" action="/mysite/board">
               <input type='hidden' name="no" value="${param.no}">
              
               
               <table class="tbl-ex">
                  <tr>
                     <th colspan="2">글보기</th>
                  </tr>
                  <tr>
                     <td class="label">제목</td>
                     <td>${BoardVo.title}</td>
                  </tr>
                  <tr>
                     <td class="label">내용</td>
                     <td>
                        <div class="view-content">${BoardVo.content}</div>
                     </td>
                  </tr>
               </table>
              
               <div class="bottom">
                  <a href="/mysite/board?a=commentform&no=${param.no}">답글</a>
                  <a href="/mysite/board?a=list">글목록</a>
                <c:if test = '${authUser.no ==BoardVo.userNo}'>
                  <a href="/mysite/board?a=modifyform&no=${param.no}">글수정</a>
               </c:if>
               </div>
               </form>
            </div>
      </div>
      <c:import url='/WEB-INF/views/include/navi.jsp'/>
      <c:import url='/WEB-INF/views/include/footer.jsp'/>
   </div>
</body>
</html>