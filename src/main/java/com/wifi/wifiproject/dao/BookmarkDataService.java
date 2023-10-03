package com.wifi.wifiproject.dao;

import com.wifi.wifiproject.dto.Bookmark;
import com.wifi.wifiproject.dto.History;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BookmarkDataService {

    private String url = "jdbc:mariadb://localhost:3306/wifi_database";
    private String username = "wifiUser";
    private String password = "zerobase";
    private String tableName = "bookmark_table";

    private static BookmarkDataService bookmarkDataService = new BookmarkDataService();
    public List<Bookmark> bookmarkList = null;

    private BookmarkDataService() {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        // 테이블이 무조건 존재하도록 설정
        createTable();

        // List<History>에 데이터 저장 시도
        // 기존에 db에 데이터가 존재하면 size가 0 초과, 존재하지 않으면 0
        bookmarkList = getAllBookmarksFromDb();

    }

    public static BookmarkDataService getInstance() {
        return bookmarkDataService;
    }

    private void createTable() {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {
                System.out.println("Connected to the database!");

                // 테이블 생성 SQL
                String createTableSql = "CREATE TABLE IF NOT EXISTS " + tableName + "(" +
                        "ID INT AUTO_INCREMENT PRIMARY KEY," +
                        "BOOKMARK_NAME VARCHAR(255)," +
                        "WIFI_NAME VARCHAR(255)," +
                        "REGISTER_DATE VARCHAR(255)" +
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

    public void dbInsertBookmark(String name, String wifi_name, String date) {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {

                // SQL INSERT 문을 실행하여 데이터 삽입
                String insertSql = "INSERT INTO " + tableName +
                        "(BOOKMARK_NAME, WIFI_NAME, " +
                        "REGISTER_DATE) " +
                        "VALUES (?, ?, ?)";
                PreparedStatement preparedStatement = connection.prepareStatement(insertSql);

                // 데이터 추출 및 바인딩

                preparedStatement.setString(1, name);
                preparedStatement.setString(2, wifi_name);
                preparedStatement.setString(3, date);


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

    public void dbUpdateBookmark(String before_name, String name) {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {

                // SQL UPDATE 문을 실행하여 데이터 삽입
                String updateSql = "UPDATE " + tableName + " SET " +
                        "BOOKMARK_NAME = ? " +
                        "WHERE BOOKMARK_NAME = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(updateSql);

                // 데이터 추출 및 바인딩

                preparedStatement.setString(1, name);
                preparedStatement.setString(2, before_name);


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

    public List<Bookmark> getAllBookmarksFromDb() {
        List<Bookmark> bookmarkList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {

                // SQL select 문을 실행하여 데이터 삽입
                String selectSql = "SELECT * FROM " + tableName;
                PreparedStatement preparedStatement = connection.prepareStatement(selectSql);

                ResultSet rs = preparedStatement.executeQuery();

                while (rs.next()) {
                    Bookmark b = new Bookmark();

                    b.setID(rs.getString("ID"));
                    b.setBOOKMARK_NAME(rs.getString("BOOKMARK_NAME"));
                    b.setWIFI_NAME(rs.getString("WIFI_NAME"));
                    b.setREGISTER_DATE(rs.getString("REGISTER_DATE"));


                    bookmarkList.add(b);
                }

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return bookmarkList;
    }

    public void updateTable() {
        bookmarkList = getAllBookmarksFromDb();
    }

    public void dbDeleteBookmark(String id) {

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

    public void dbDeleteBookmark(String attribute, String data) {

        try (Connection connection = DriverManager.getConnection(url, username, password)) {

            if (connection != null) {

                // SQL DELETE 문을 실행하여 데이터 삽입
                String deleteSql = "DELETE FROM " + tableName +
                        " WHERE " + attribute + " = " + "?";

                PreparedStatement preparedStatement = connection.prepareStatement(deleteSql);
                preparedStatement.setString(1, data);


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
