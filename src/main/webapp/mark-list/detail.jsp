<%@ page import="com.wifi.wifiproject.DistanceStrategy" %>
<%@ page import="com.wifi.wifiproject.dto.Row" %>
<%@ page import="com.wifi.wifiproject.dto.BookmarkGroup" %>
<%@ page import="com.wifi.wifiproject.dao.BookmarkGroupDatabaseService" %>
<%@ page import="com.wifi.wifiproject.dao.WifiDatabaseService" %><%--
  Created by IntelliJ IDEA.
  User: wheregod
  Date: 10/2/AD2023
  Time: 5:59 PM
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

<h1>와이파이 정보 구하기</h1>

<p>
    <a href="../index.jsp">홈</a> |
    <a href="../history/history.jsp">위치 히스토리 목록</a> |
    <a href="../load-wifi.jsp">Open API 와이파이 정보 가져오기</a> |
    <a href="mark-list.jsp">북마크 보기</a> |
    <a href="../mark-group/mark-group.jsp">북마크 관리</a> |

</p>

<br>

<select id="selectBox" name="selectedValue">
    <option value="none">북마크 그룹 이름 선택</option>
    <% for (BookmarkGroup b : BookmarkGroupDatabaseService.getInstance().bookmarkGroupList) { %>
    <option value="<%= b.getBOOKMARKGROUP_NAME() %>"><%= b.getBOOKMARKGROUP_NAME() %></option>
    <% } %>
</select>

<button type='button' onClick='goToAddSubmit()'>북마크 추가하기</button>


<table id="wifi">

    <%
        // out.write(request.getParameter("mgrNo"));

        String wifi_name = "";
        for (Row r : WifiDatabaseService.getInstance().wifiRowList) {
            if (r.getX_SWIFI_MGR_NO().equals(request.getParameter("mgrNo")) ||
            r.getX_SWIFI_MAIN_NM().equals(request.getParameter("wifi_name"))) {

                out.write("<tr>");
                out.write("<th>거리(Km)</th>"); out.write("<td>" + String.format("%.4f", 0.0) + "</td>");

                // r.getDistance(DistanceStrategy.getInstance().getMyLAT(), DistanceStrategy.getInstance().getMyLNT())
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>관리번호</th>"); out.write("<td>" + r.getX_SWIFI_MGR_NO() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>자치구</th>"); out.write("<td>" + r.getX_SWIFI_WRDOFC() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>와이파이명</th>"); out.write("<td>" + "<a href='../index.jsp'>"
                        + r.getX_SWIFI_MAIN_NM() + "</a>" + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>도로명주소</th>"); out.write("<td>" + r.getX_SWIFI_ADRES1() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>상세주소</th>"); out.write("<td>" + r.getX_SWIFI_ADRES2() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>설치위치(층)</th>"); out.write("<td>" + r.getX_SWIFI_INSTL_FLOOR() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>설치유형</th>"); out.write("<td>" + r.getX_SWIFI_INSTL_TY() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>설치기관</th>"); out.write("<td>" + r.getX_SWIFI_INSTL_MBY() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>서비스구분</th>"); out.write("<td>" + r.getX_SWIFI_SVC_SE() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>망종류</th>"); out.write("<td>" + r.getX_SWIFI_CMCWR() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>설치년도</th>"); out.write("<td>" + r.getX_SWIFI_CNSTC_YEAR() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>실내외구분</th>"); out.write("<td>" + r.getX_SWIFI_INOUT_DOOR() + "</td>");
                out.write("</tr>");


                out.write("<tr>");
                out.write("<th>WIFI접속환경</th>"); out.write("<td>" + r.getX_SWIFI_REMARS3() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>x좌표</th>"); out.write("<td>" + r.getLNT() + "</td>");
                out.write("</tr>");


                out.write("<tr>");
                out.write("<th>Y좌표</th>"); out.write("<td>" + r.getLAT() + "</td>");
                out.write("</tr>");

                out.write("<tr>");
                out.write("<th>작업일자</th>"); out.write("<td>" + r.getWORK_DTTM() + "</td>");
                out.write("</tr>");

                wifi_name = r.getX_SWIFI_MAIN_NM();

                break;
            }
        }
    %>

</table>

<script>
    function goToAddSubmit() {
        var selectBox = document.getElementById("selectBox")
        var bookmark_name = selectBox.options[selectBox.selectedIndex].value

        location.href='./add/mark-list-add-submit.jsp?bookmark_name=' + bookmark_name + "&wifi_name=<%=wifi_name%>"
    }


</script>

</body>
</html>
