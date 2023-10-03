<%@ page import="com.wifi.wifiproject.dao.BookmarkGroupDatabaseService" %>
<%@ page import="com.wifi.wifiproject.dto.Bookmark" %>
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

    if (BookmarkGroupDatabaseService.getInstance().bookmarkGroupList.size() > 0) {

        // 북마크 그룹 이름을 가진 북마크 전부 삭제
        BookmarkDataService.getInstance().dbDeleteBookmark("BOOKMARK_NAME", request.getParameter("group_name"));
        BookmarkDataService.getInstance().updateTable();

        BookmarkGroupDatabaseService.getInstance().dbDeleteBookmarkgroup(request.getParameter("id"));

        BookmarkGroupDatabaseService.getInstance().updateTable();
    }

    %>

    alert("데이터가 삭제되었습니다.");
    location.href = "../mark-group.jsp";
</script>

</body>
</html>
