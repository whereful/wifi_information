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

<h1>위치 히스토리 삭제</h1>


<p>
    <a href="../index.jsp">홈</a> |
    <a href="./history.jsp">위치 히스토리 목록</a> |
    <a href="../load-wifi.jsp">Open API 와이파이 정보 가져오기</a> |
    <a href="../mark-list/mark-list.jsp">북마크 보기</a> |
    <a href="../mark-group/mark-group.jsp">북마크 그룹 관리</a> |

</p>

<br>

<p>위치 히스토리 정보를 삭제하시겠습니까?</p>

<table id="wifi">

    <%
        // out.write(request.getParameter("mgrNo"));

        for (History h : HistoryDatabaseService.getInstance().historyList) {
            if (h.getID().equals(request.getParameter("id"))) {


                out.write("<tr>");
                out.write("<th>ID</th>"); out.write("<td>" + h.getID() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>X좌표</th>"); out.write("<td>" + h.getX() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>X좌표</th>"); out.write("<td>" + h.getY() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>조회일자</th>"); out.write("<td>" + h.getSEARCH_DATE() + "</td>");
                out.write("</tr>");

                out.write("<tr>");

                out.write("<td colspan=\"2\">");
                out.write("<a href='./history.jsp'> 돌아가기</a>" + " | ");
                out.write(String.format("<button type='button' " +
                        "onClick=location.href='../history/history-delete-submit.jsp?id=%s'>삭제</button>", h.getID()));

                out.write("</td>");
                out.write("</tr>");

                break;
            }
        }
    %>



</table>


</body>
</html>
