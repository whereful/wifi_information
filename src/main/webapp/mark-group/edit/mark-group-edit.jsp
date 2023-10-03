<%@ page import="com.wifi.wifiproject.dao.HistoryDatabaseService" %>
<%@ page import="com.wifi.wifiproject.dto.History" %>
<%@ page import="com.wifi.wifiproject.dao.BookmarkGroupDatabaseService" %>
<%@ page import="com.wifi.wifiproject.dto.BookmarkGroup" %><%--
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

<h1>북마크 그룹 수정</h1>


<p>
    <a href="../../index.jsp">홈</a> |
    <a href="../../history.jsp">위치 히스토리 목록</a> |
    <a href="../../load-wifi.jsp">Open API 와이파이 정보 가져오기</a> |
    <a href="../../mark-list/mark-list.jsp">북마크 보기</a> |
    <a href="../../mark-group/mark-group.jsp">북마크 그룹 관리</a> |

</p>

<br>

<p>북마크 그룹 정보를 수정하시겠습니까?</p>

<table id="wifi">

    <%

        for (BookmarkGroup b : BookmarkGroupDatabaseService.getInstance().bookmarkGroupList) {
            if (b.getID().equals(request.getParameter("id"))) {

                out.write("<tr>");
                out.write("<th>북마크 이름</th>");
                out.write("<td>");
                out.write("<input type='text' id='name' value=" + b.getBOOKMARKGROUP_NAME() + ">");
                out.write("</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>순서</th>");
                out.write("<td>");
                out.write("<input type='text' step='1' id='order' value=" +
                        b.getBOOKMARKGROUP_ORDER() + ">");
                out.write("</td>");
                out.write("</tr>");

                out.write("<td colspan=\"2\">");
                out.write("<a href='../mark-group.jsp'> 돌아가기</a>" + " | ");
                out.write(String.format("<button type='button' onClick=\"goToEditSubmit(%s, \'%s\')\">수정</button>", b.getID(),
                        b.getBOOKMARKGROUP_NAME()));
                out.write("</td>");
                out.write("</tr>");

                break;
            }
        }
    %>



</table>

<script>
    function goToEditSubmit(id, before_name) {
        var name = document.getElementById("name").value
        var order = document.getElementById("order").value

        var url = './mark-group-edit-submit.jsp?id=' + id + '&before_name=' + before_name + '&name=' + name + '&order=' + order;
        location.href=url;
    }


</script>

</body>
</html>
