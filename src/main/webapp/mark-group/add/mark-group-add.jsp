<%@ page import="com.wifi.wifiproject.dao.HistoryDatabaseService" %>
<%@ page import="com.wifi.wifiproject.dto.History" %><%--
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

        #wifi tr:nth-child(odd) {
            background-color: #f2f2f2;
        }

        #wifi tr:hover {
            background-color: #ddd;
        }

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

<h1>북마크 그룹 추가</h1>

<p>
    <a href="../../index.jsp">홈</a> |
    <a href="../../history/history.jsp">위치 히스토리 목록</a> |
    <a href="../../load-wifi.jsp">Open API 와이파이 정보 가져오기</a> |
    <a href="../../mark-list/mark-list.jsp">북마크 보기</a> |
    <a href="../mark-group.jsp">북마크 그룹 관리</a> |

</p>

<br>


<table id="wifi">

    <%

        out.write("<tr>");
        out.write("<th>북마크 이름</th>");
        out.write("<td>");
        out.write("<input type='text' id='name'>");
        out.write("</td>");
        out.write("</tr>");

        out.write("<tr>");
        out.write("<th>순서</th>");
        out.write("<td>");
        out.write("<input type='number' step='1' id='order'>");
        out.write("</td>");
        out.write("</tr>");

    %>

    <%
        out.write("<tr>");
        out.write("<td colspan=\"2\">");

        out.write("<button type='button' onClick='goToAddSubmit()'>추가</button>");
        out.write("</td>");

        out.write("</tr>");

    %>


</table>

<script>
    function goToAddSubmit() {
        var name = document.getElementById("name").value
        var order = document.getElementById("order").value

        location.href='./mark-group-add-submit.jsp?name=' + name + "&order=" + order
    }


</script>

</body>
</html>
