<%@ page import="java.util.Comparator" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.wifi.wifiproject.DistanceStrategy" %>
<%@ page import="com.wifi.wifiproject.*" %>
<%@ page import="com.wifi.wifiproject.dto.BookmarkGroup" %>
<%@ page import="com.wifi.wifiproject.dao.BookmarkGroupDatabaseService" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
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

<h1>북마크 그룹</h1>

<p>
    <a href="../index.jsp">홈</a> |
    <a href="../history/history.jsp">위치 히스토리 목록</a> |
    <a href="../load-wifi.jsp">Open API 와이파이 정보 가져오기</a> |
    <a href="../mark-list/mark-list.jsp">북마크 보기</a> |
    <a href="mark-group.jsp">북마크 그룹 관리</a> |

</p>

<br>

<button onclick="location.href='add/mark-group-add.jsp'">북마크 그룹 이름 추가</button>

<br>
<br>

<table id="wifi">
    <tr>
        <th>ID</th>
        <th>북마크 이름</th>
        <th>순서</th>
        <th>등록일자</th>
        <th>수정일자</th>
        <th>비고</th>
    </tr>

    <%

        List<BookmarkGroup> bookmarkGroupList = BookmarkGroupDatabaseService.getInstance().bookmarkGroupList;

        if (bookmarkGroupList.size() > 0) {
            for (BookmarkGroup b : bookmarkGroupList) {
                out.write("<tr>");

                out.write("<td>" + b.getID() + "</td>");
                out.write("<td>" + b.getBOOKMARKGROUP_NAME() + "</td>");
                out.write("<td>" + b.getBOOKMARKGROUP_ORDER() + "</td>");
                out.write("<td>" + b.getREGISTER_DATE() + "</td>");
                out.write("<td>" + b.getUPDATE_DATE() + "</td>");


                out.write("<td>");
                out.write(String.format("<a href='./edit/mark-group-edit.jsp?id=%s'>수정</a>" + " | ", b.getID()));
                out.write(String.format("<a href='./delete/mark-group-delete.jsp?id=%s'>삭제</a>", b.getID()));
                out.write("</td>");

                out.write("</tr>");
            }
        }
        else {
            out.write("<tr>");

            out.write("<td colspan=\"6\">" + "없음" + "</td>");

            out.write("</tr>");
        }

    %>


</table>


</body>
</html>


