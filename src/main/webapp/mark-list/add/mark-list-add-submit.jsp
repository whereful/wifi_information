<%@ page import="com.wifi.wifiproject.dao.BookmarkGroupDatabaseService" %>
<%@ page import="com.wifi.wifiproject.dao.HistoryDatabaseService" %>
<%@ page import="java.time.LocalDateTime" %>
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
    <style>
        #wifi {
            font-family: Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        #wifi td, #wifi th {
            border: 1px solid #ddd;
            padding: 8px;

            text-align: center; /* 텍스트를 가운데 정렬 */
            vertical-align: middle; /* 텍스트를 수직 가운데 정렬 (옵션) */
        }

        #wifi tr:nth-child(odd){background-color: #f2f2f2;}

        #wifi tr:hover {background-color: #ddd;}

        #wifi th {
            padding-top: 12px;
            padding-bottom: 12px;
            background-color: #04AA6D;
            color: white;

            text-align: center; /* 텍스트를 가운데 정렬 */
            vertical-align: middle; /* 텍스트를 수직 가운데 정렬 (옵션) */
        }

    </style>

</head>
<body>
<script type="text/javascript">

    <%

        BookmarkDataService.getInstance().dbInsertBookmark(request.getParameter("bookmark_name"),
        request.getParameter("wifi_name"), LocalDateTime.now().withNano(0).toString());

        BookmarkDataService.getInstance().updateTable();


    %>

    alert("데이터가 추가되었습니다.");
    location.href = "../mark-list.jsp";
</script>

</body>
</html>
