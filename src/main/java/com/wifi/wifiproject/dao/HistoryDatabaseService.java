package com.wifi.wifiproject.dao;

import com.wifi.wifiproject.dto.History;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HistoryDatabaseService {

    private String url = "jdbc:mariadb://localhost:3306/wifi_database";
    private String username = "wifiUser";
    private String password = "zerobase";
    private String tableName = "history_table";

    private static HistoryDatabaseService historyDatabaseService = new HistoryDatabaseService();
    public List<History> historyList = null;

    private HistoryDatabaseService() {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        // 테이블이 무조건 존재하도록 설정
        createTable();

        // List<History>에 데이터 저장 시도
        // 기존에 db에 데이터가 존재하면 size가 0 초과, 존재하지 않으면 0
        historyList = getAllHistorysFromDb();

    }

    public static HistoryDatabaseService getInstance() {
        return historyDatabaseService;
    }

    private void createTable() {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {
                System.out.println("Connected to the database!");

                // 테이블 생성 SQL
                String createTableSql = "CREATE TABLE IF NOT EXISTS " + tableName + "(" +
                        "ID INT AUTO_INCREMENT PRIMARY KEY," +
                        "X VARCHAR(255)," +
                        "Y VARCHAR(255)," +
                        "SEARCH_DATE VARCHAR(255)" +
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

    public void dbInsertHistory(String x, String y, String date) {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {

                // SQL INSERT 문을 실행하여 데이터 삽입
                String insertSql = "INSERT INTO " + tableName +
                        "(X, Y, " +
                        "SEARCH_DATE) " +
                        "VALUES (?, ?, ?)";
                PreparedStatement preparedStatement = connection.prepareStatement(insertSql);

                // 데이터 추출 및 바인딩

                preparedStatement.setString(1, x);
                preparedStatement.setString(2, y);
                preparedStatement.setString(3, date);


                    // 쿼리 실행
                preparedStatement.executeUpdate();

                    // 밑의 두 문장 작성 시 오류 발생
                    // preparedStatement.close();
                    // connection.close();

                }

                System.out.println("Data inserted successfully.");
                // System.out.println(seoulWifiInfo.getTbPublicWifiInfo().getRow().get(0).getX_SWIFI_MGR_NO());

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public List<History> getAllHistorysFromDb() {
        List<History> historyList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {

                // SQL select 문을 실행하여 데이터 삽입
                String selectSql = "SELECT * FROM " + tableName;
                PreparedStatement preparedStatement = connection.prepareStatement(selectSql);

                ResultSet rs = preparedStatement.executeQuery();

                while (rs.next()) {
                    History h = new History();

                    h.setID(rs.getString("ID"));
                    h.setX(rs.getString("X"));
                    h.setY(rs.getString("Y"));
                    h.setSEARCH_DATE(rs.getString("SEARCH_DATE"));


                    historyList.add(h);
                }

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return historyList;
    }

    public void updateTable() {
        historyList = getAllHistorysFromDb();
    }

    public void dbDeleteHistory(String id) {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {

                // SQL DELETE 문을 실행하여 데이터 삽입
                String deleteSql = "DELETE FROM " + tableName +
                        " WHERE ID = " + "?";

                PreparedStatement preparedStatement = connection.prepareStatement(deleteSql);
                preparedStatement.setString(1, id);


                // 쿼리 실행
                preparedStatement.executeUpdate();

                // 밑의 두 문장 작성 시 오류 발생
                // preparedStatement.close();
                // connection.close();

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

}
