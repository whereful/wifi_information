package com.wifi.wifiproject.dao;

import com.google.gson.Gson;
import com.wifi.wifiproject.dto.Row;
import com.wifi.wifiproject.dto.SeoulWifiInfo;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class WifiDatabaseService {

    private String url = "jdbc:mariadb://localhost:3306/wifi_database";
    private String username = "wifiUser";
    private String password = "zerobase";
    private String tableName = "seoul_wifi_info";
    private static WifiDatabaseService wifiDatabaseService = new WifiDatabaseService();
    public List<Row> wifiRowList = null;


    private WifiDatabaseService() {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        // 테이블이 무조건 존재하도록 설정
        createTable();

        // List<Row>에 데이터 저장 시도
        // 기존에 db에 데이터가 존재하면 size가 0 초과, 존재하지 않으면 0
        wifiRowList = getAllRowsFromDb();

    }

    public static WifiDatabaseService getInstance() {
        return wifiDatabaseService;
    }


    // 테이블이 존재하면 삭제, 존재하지 않으면 삭제하지 않음
    private void deleteTable() {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {
                System.out.println("Connected to the database!");

                // 테이블 생성 SQL
                String deleteTableSql = "DROP TABLE IF EXISTS " + tableName;

                // SQL CREATE TABLE 문을 실행하여 테이블 생성
                Statement createTableStatement = connection.createStatement();
                createTableStatement.executeUpdate(deleteTableSql);

                createTableStatement.close();

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    // table이 없으면 생성, 있으면 생성하지 않음
    private void createTable() {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {
                System.out.println("Connected to the database!");

                // 테이블 생성 SQL
                String createTableSql = "CREATE TABLE IF NOT EXISTS " + tableName + "(" +
                        "X_SWIFI_MGR_NO VARCHAR(255) PRIMARY KEY," +
                        "X_SWIFI_WRDOFC VARCHAR(255)," +
                        "X_SWIFI_MAIN_NM VARCHAR(255)," +
                        "X_SWIFI_ADRES1 VARCHAR(255)," +
                        "X_SWIFI_ADRES2 VARCHAR(255)," +
                        "X_SWIFI_INSTL_FLOOR VARCHAR(255)," +
                        "X_SWIFI_INSTL_TY VARCHAR(255)," +
                        "X_SWIFI_INSTL_MBY VARCHAR(255)," +
                        "X_SWIFI_SVC_SE VARCHAR(255)," +
                        "X_SWIFI_CMCWR VARCHAR(255)," +
                        "X_SWIFI_CNSTC_YEAR VARCHAR(255)," +
                        "X_SWIFI_INOUT_DOOR VARCHAR(255)," +
                        "X_SWIFI_REMARS3 VARCHAR(255)," +
                        "LNT VARCHAR(255)," +
                        "LAT VARCHAR(255)," +
                        "WORK_DTTM VARCHAR(255)" +
                        ")";

                // SQL CREATE TABLE 문을 실행하여 테이블 생성
                Statement createTableStatement = connection.createStatement();
                createTableStatement.executeUpdate(createTableSql);

                createTableStatement.close();

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }


    // 테이블이 존재한다고 가정, 작은 단위의 데이터들을 db에 저장
    public void dbInsertSeoulWifi(SeoulWifiInfo seoulWifiInfo) {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {

                // SQL INSERT 문을 실행하여 데이터 삽입
                String insertSql = "INSERT INTO " + tableName +
                        "(X_SWIFI_MGR_NO, X_SWIFI_WRDOFC, " +
                        "X_SWIFI_MAIN_NM, X_SWIFI_ADRES1, " +
                        "X_SWIFI_ADRES2, X_SWIFI_INSTL_FLOOR, " +
                        "X_SWIFI_INSTL_TY, X_SWIFI_INSTL_MBY, " +
                        "X_SWIFI_SVC_SE, X_SWIFI_CMCWR, " +
                        "X_SWIFI_CNSTC_YEAR, X_SWIFI_INOUT_DOOR, " +
                        "X_SWIFI_REMARS3, LAT, " +
                        "LNT, WORK_DTTM) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement preparedStatement = connection.prepareStatement(insertSql);

                // 데이터 추출 및 바인딩
                for (Row row : seoulWifiInfo.getTbPublicWifiInfo().getRow()) {
                    preparedStatement.setString(1, row.getX_SWIFI_MGR_NO());
                    preparedStatement.setString(2, row.getX_SWIFI_WRDOFC());
                    preparedStatement.setString(3, row.getX_SWIFI_MAIN_NM());
                    preparedStatement.setString(4, row.getX_SWIFI_ADRES1());
                    preparedStatement.setString(5, row.getX_SWIFI_ADRES2());
                    preparedStatement.setString(6, row.getX_SWIFI_INSTL_FLOOR());
                    preparedStatement.setString(7, row.getX_SWIFI_INSTL_TY());
                    preparedStatement.setString(8, row.getX_SWIFI_INSTL_MBY());
                    preparedStatement.setString(9, row.getX_SWIFI_SVC_SE());
                    preparedStatement.setString(10, row.getX_SWIFI_CMCWR());
                    preparedStatement.setString(11, row.getX_SWIFI_CNSTC_YEAR());
                    preparedStatement.setString(12, row.getX_SWIFI_INOUT_DOOR());
                    preparedStatement.setString(13, row.getX_SWIFI_REMARS3());
                    preparedStatement.setString(14, row.getLAT());
                    preparedStatement.setString(15, row.getLNT());
                    preparedStatement.setString(16, row.getWORK_DTTM());

                    // 쿼리 실행
                    preparedStatement.executeUpdate();

                    // 밑의 두 문장 작성 시 오류 발생
                    // preparedStatement.close();
                    // connection.close();

                }

                System.out.println("Data inserted successfully.");
                // System.out.println(seoulWifiInfo.getTbPublicWifiInfo().getRow().get(0).getX_SWIFI_MGR_NO());

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    // 테이블이 존재한다고 가정, dbInsertSeoulWifi를 반복호출하여 모든 데이터 저장
    public void setAllRowsInDb() {

        OkHttpClient client = new OkHttpClient();
        Gson gson = new Gson();

        String key = "776c67665a77686538344a78686a70";

        int startNum = 1;
        int step = 1000;

        // endNum을 임의의 값으로 설정
        int endNum = 2000;

        SeoulWifiInfo seoulWifiInfo = null;
        WifiDatabaseService wifiDatabaseService = WifiDatabaseService.getInstance();

        // 9000번대의 json 데이터에서 class에서 정의한 type과 일치하지 않는 오류 발생
        // com.google.gson.JsonSyntaxException: java.lang.NumberFormatException: empty String
        while (true) {

            if (endNum < startNum) {
                break;
            }

            // 서울시 공공 api 데이터 링크
            // String apiUrl = "http://openapi.seoul.go.kr:8088/" + key + "/json/TbPublicWifiInfo/1/1000/";

            String apiUrl = String.format("http://openapi.seoul.go.kr:8088/" + key + "/json/TbPublicWifiInfo/%d/%d/"
                    , startNum, startNum + step - 1);

            // System.out.println(apiUrl);

            // HTTP GET 요청 생성
            Request req = new Request.Builder()
                    .url(apiUrl)
                    .build();

            try {
                // 요청 보내고 응답 받기
                Response res = client.newCall(req).execute();
                // System.out.println(response);

                // 응답에서 JSON 데이터 파싱
                String jsonResponse = res.body().string();


                seoulWifiInfo = gson.fromJson(jsonResponse, SeoulWifiInfo.class);

                // JSON 데이터를 데이터베이스에 저장
                wifiDatabaseService.dbInsertSeoulWifi(seoulWifiInfo);


            } catch (IOException e) {
                e.printStackTrace();
            }

            // 처음 실행한 후 endNum을 데이터 총 개수로 설정
            if (startNum == 1) {
                endNum = seoulWifiInfo.getTbPublicWifiInfo().getList_total_count();
            }

//        System.out.println(String.format("startNum = %d, endNum = %d, seoulWifiInfo = %s", startNum, endNum,
//                seoulWifiInfo.toString()));

            startNum += step;

            // Thread.sleep(100);

        }

    }

    // 테이블을 없는 상태로 만들기, 테이블 만들기, 모든 데이터를 테이블에 삽입, List<Row>에 새로운 데이터들을 저장
    public void renewTable() {
        deleteTable();
        createTable();
        setAllRowsInDb();

        wifiRowList = getAllRowsFromDb();
    }

    // 테이블이 존재한다고 가정, db에 저장된 모든 데이터들을 가져옴
    public List<Row> getAllRowsFromDb() {
        List<Row> rows = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {

                // SQL select 문을 실행하여 데이터 삽입
                String selectSql = "SELECT * FROM " + tableName;
                PreparedStatement preparedStatement = connection.prepareStatement(selectSql);

                ResultSet rs = preparedStatement.executeQuery();

                while (rs.next()) {
                    Row r = new Row();

                    r.setX_SWIFI_MGR_NO(rs.getString("X_SWIFI_MGR_NO"));
                    r.setX_SWIFI_WRDOFC(rs.getString("X_SWIFI_WRDOFC"));
                    r.setX_SWIFI_MAIN_NM(rs.getString("X_SWIFI_MAIN_NM"));
                    r.setX_SWIFI_ADRES1(rs.getString("X_SWIFI_ADRES1"));
                    r.setX_SWIFI_ADRES2(rs.getString("X_SWIFI_ADRES2"));
                    r.setX_SWIFI_INSTL_FLOOR(rs.getString("X_SWIFI_INSTL_FLOOR"));
                    r.setX_SWIFI_INSTL_TY(rs.getString("X_SWIFI_INSTL_TY"));
                    r.setX_SWIFI_INSTL_MBY(rs.getString("X_SWIFI_INSTL_MBY"));
                    r.setX_SWIFI_SVC_SE(rs.getString("X_SWIFI_SVC_SE"));
                    r.setX_SWIFI_CMCWR(rs.getString("X_SWIFI_CMCWR"));
                    r.setX_SWIFI_CNSTC_YEAR(rs.getString("X_SWIFI_CNSTC_YEAR"));
                    r.setX_SWIFI_INOUT_DOOR(rs.getString("X_SWIFI_INOUT_DOOR"));
                    r.setX_SWIFI_REMARS3(rs.getString("X_SWIFI_REMARS3"));
                    r.setLAT(rs.getString("LAT"));
                    r.setLNT(rs.getString("LNT"));
                    r.setWORK_DTTM(rs.getString("WORK_DTTM"));

                    rows.add(r);
                }

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return rows;
    }


}
