<%@ page import="com.wifi.wifiproject.dao.WifiDatabaseService" %>
<%@ page import="com.wifi.wifiproject.dto.Row" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.wifi.wifiproject.DistanceStrategy" %>
<%@ page import="com.wifi.wifiproject.dao.HistoryDatabaseService" %>
<%@ page import="com.wifi.wifiproject.DistanceStrategy" %>
<%@ page import="java.time.LocalDateTime" %>

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

<h1>와이파이 정보 구하기</h1>

<p>
    <a href="index.jsp">홈</a> |
    <a href="history/history.jsp">위치 히스토리 목록</a> |
    <a href="javascript:void(0);" onclick="load()">Open API 와이파이 정보 가져오기</a> |
    <a href="mark-list/mark-list.jsp">북마크 보기</a> |
    <a href="mark-group/mark-group.jsp">북마크 그룹 관리</a> |

</p>

<br>

<!-- 폼 시작 -->
<form method="GET">
    <label>LAT:</label>
    <input type="number" step = "0.000000001" id="LAT" name="LAT" required>,  <!-- 아이디 입력 필드 -->

    <label>LNT:</label>
    <input type="number" step = "0.000000001" id="LNT" name="LNT" required> <!-- 비밀번호 입력 필드 -->

    <input type="button" onclick="getLocation()" value="내 위치 가져오기"> <!-- 제출 버튼 -->
    <input type="submit" value="근처 WIFI 정보 가져오기"> <!-- 제출 버튼 -->

</form>
<!-- 폼 종료 -->

<br>
<br>

<table id="wifi">
    <tr>
        <th>거리(Km)</th><th>관리번호</th><th>자치구</th><th>와이파이명</th><th>도로명주소</th><th>상세주소</th><th>설치위치(층)</th>
        <th>설치유형</th><th>설치기관</th><th>서비스구분</th><th>망종류</th><th>설치년도</th><th>실내외구분</th><th>WIFI접속환경</th>
        <th>x좌표</th><th>Y좌표</th><th>작업일자</th>
    </tr>

    <%
        // GET 호출 결과를 저장
        String strLAT = request.getParameter("LAT");
        String strLNT = request.getParameter("LNT");

        if (strLAT != null && strLNT != null) {

            double myLAT = Double.parseDouble(strLAT);
            double myLNT = Double.parseDouble(strLNT);

//            org.apache.jasper.JasperException: Unable to compile class for JSP:
//
//            An error occurred at line: [114] in the jsp file: [/index.jsp]
//            References to interface static methods are allowed only at source level 1.8 or above

            // tomcat java compile version : 1.7
            // Collections.sort(rowList, Comparator.comparingDouble(row -> row.getDistance(myLAT, myLNT)));

            // DistanceStrategy distanceStrategy = new DistanceStrategy(myLAT, myLNT, 20);
            // List<Row> sortedRowList = distanceStrategy.makeSortedDistanceRow(WifiDatabaseService.getInstance().wifiRowList);

            List<Row> sortedRowList = DistanceStrategy.getInstance().changeStandard(myLAT, myLNT, 20,
                    WifiDatabaseService.getInstance().wifiRowList);

            if (sortedRowList.size() > 0) {

                for (Row r : sortedRowList) {
                    out.write("<tr>");

                    out.write("<td>" + String.format("%.4f", r.getDistance(myLAT, myLNT)) + "</td>");

                    out.write("<td>" + r.getX_SWIFI_MGR_NO() + "</td>");
                    out.write("<td>" + r.getX_SWIFI_WRDOFC() + "</td>");

                    out.write(String.format("<td>" + "<a href='./mark-list/detail.jsp?mgrNo=%s'>"
                            + r.getX_SWIFI_MAIN_NM() + "</a>" + "</td>", r.getX_SWIFI_MGR_NO()));

                    out.write("<td>" + r.getX_SWIFI_ADRES1() + "</td>");
                    out.write("<td>" + r.getX_SWIFI_ADRES2() + "</td>");
                    out.write("<td>" + r.getX_SWIFI_INSTL_FLOOR() + "</td>");
                    out.write("<td>" + r.getX_SWIFI_INSTL_TY() + "</td>");
                    out.write("<td>" + r.getX_SWIFI_INSTL_MBY() + "</td>");
                    out.write("<td>" + r.getX_SWIFI_SVC_SE() + "</td>");
                    out.write("<td>" + r.getX_SWIFI_CMCWR() + "</td>");
                    out.write("<td>" + r.getX_SWIFI_CNSTC_YEAR() + "</td>");
                    out.write("<td>" + r.getX_SWIFI_INOUT_DOOR() + "</td>");
                    out.write("<td>" + r.getX_SWIFI_REMARS3() + "</td>");
                    out.write("<td>" + r.getLNT() + "</td>");
                    out.write("<td>" + r.getLAT() + "</td>");
                    out.write("<td>" + r.getWORK_DTTM() + "</td>");

                    out.write("</tr>");

                }

                HistoryDatabaseService.getInstance().dbInsertHistory(strLAT, strLNT,
                        LocalDateTime.now().withNano(0).toString());
                HistoryDatabaseService.getInstance().updateTable();

            }

            else {
                out.write("<tr>");

                out.write("<td colspan=\"17\">" + "OPEN API 정보를 가져온 후에 조회해 주세요." + "</td>");

                out.write("</tr>");
            }

        }
        else {
            out.write("<tr>");

            out.write("<td colspan=\"17\">" + "위치 정보를 가져온 후에 조회해 주세요." + "</td>");

            out.write("</tr>");
        }
    %>

</table>

<script>
    // 위치 정보를 가져오는 함수
    function getLocation() {
        if ("geolocation" in navigator) {
            // Geolocation API를 지원하는 경우

            // 위치 정보를 가져오기
            navigator.geolocation.getCurrentPosition(function (position) {
                // 위치 정보를 성공적으로 가져왔을 때의 처리
                var latitude = position.coords.latitude;   // 위도
                var longitude = position.coords.longitude; // 경도

                document.getElementById("LAT").value = latitude;
                document.getElementById("LNT").value = longitude;

            }, function (error) {
                // 위치 정보를 가져오지 못했을 때의 처리
                switch (error.code) {
                    case error.PERMISSION_DENIED:
                        console.error("User denied the request for Geolocation.");
                        break;
                    case error.POSITION_UNAVAILABLE:
                        console.error("Location information is unavailable.");
                        break;
                    case error.TIMEOUT:
                        console.error("The request to get user location timed out.");
                        break;

                }
            });
        } else {
            // Geolocation API를 지원하지 않는 경우
            console.error("Geolocation is not supported by your browser.");
        }
    }

    // 데이터 로드 함수
    function load() {
        alert("데이터를 가져오겠습니까?");
        location.href="./load-wifi.jsp"
    }

</script>


</body>
</html>


