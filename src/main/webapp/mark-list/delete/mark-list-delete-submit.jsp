<%@ page import="com.wifi.wifiproject.dao.BookmarkGroupDatabaseService" %>
<%@ page import="com.wifi.wifiproject.dao.BookmarkDataService" %><%--
  Created by IntelliJ IDEA.
  User: wheregod
  Date: 10/2/AD2023
  Time: 5:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>와이파이 정보 구하기</title>

</head>
<body>
<script type="text/javascript">

  <%

  if (BookmarkDataService.getInstance().bookmarkList.size() > 0) {
      BookmarkDataService.getInstance().dbDeleteBookmark(request.getParameter("id"));

      BookmarkDataService.getInstance().updateTable();
  }

  %>

  alert("데이터가 삭제되었습니다.");
  location.href = "../mark-list.jsp";
</script>

</body>
</html>
