<%--
  Created by IntelliJ IDEA.
  User: wheregod
  Date: 10/1/AD2023
  Time: 3:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.wifi.wifiproject.dao.WifiDatabaseService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <style>
        h1, div {
            text-align: center;
        }
    </style>
</head>

<%
    // db 테이블에 데이터가 존재하지 않는 경우에만 테이블 초기화 및 데이터 설정
    if (WifiDatabaseService.getInstance().wifiRowList.size() == 0) {
        WifiDatabaseService.getInstance().renewTable();
    }

%>
<body>

<h1>
    <%
        out.write(String.format("%d개의 WIFI 정보를 정상적으로 저장하였습니다.",
                WifiDatabaseService.getInstance().wifiRowList.size()));
    %>
</h1>

<br>
<br>

<div>
    <a href="index.jsp">홈으로 가기</a>
</div>

</body>
</html>

