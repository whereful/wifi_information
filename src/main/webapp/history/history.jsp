<%@ page import="com.wifi.wifiproject.dao.HistoryDatabaseService" %>
<%@ page import="com.wifi.wifiproject.dto.History" %>
<%@ page import="java.util.List" %>
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

<h1>위치 히스토리 구하기</h1>


<p>
    <a href="../index.jsp">홈</a> |
    <a href="../history/history.jsp">위치 히스토리 목록</a> |
    <a href="../load-wifi.jsp">Open API 와이파이 정보 가져오기</a> |
    <a href="../mark-list/mark-list.jsp">북마크 보기</a> |
    <a href="../mark-group/mark-group.jsp">북마크 그룹 관리</a> |

</p>

<br>


<table id="wifi">
    <tr>
        <th>ID</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>조회일자</th>
        <th>비고</th>
    </tr>

    <%

        List<History> historyList = HistoryDatabaseService.getInstance().historyList;

        if (historyList.size() > 0) {
            for (History h : historyList) {
                out.write("<tr>");

                out.write("<td>" + h.getID() + "</td>");
                out.write("<td>" + h.getX() + "</td>");
                out.write("<td>" + h.getY() + "</td>");
                out.write("<td>" + h.getSEARCH_DATE() + "</td>");


                out.write("<td>");
                out.write("<form action='history-delete.jsp' method='GET'>");
                out.write(String.format("<input type='hidden' name='id' value=%s>", h.getID()));
                out.write("<input type='submit' value='삭제'>");
                out.write("</form>");
                out.write("</td>");

                out.write("</tr>");
            }
        }
        else {
            out.write("<tr>");

            out.write("<td colspan=\"5\">" + "없음" + "</td>");

            out.write("</tr>");
        }

    %>

</table>

</body>
</html>


