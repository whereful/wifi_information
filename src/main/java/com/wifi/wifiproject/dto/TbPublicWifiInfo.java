package com.wifi.wifiproject.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class TbPublicWifiInfo {

    private int list_total_count;
    private RESULT RESULT;

    // 변수명을 바꾸면 오류 발생
    private List<Row> row;

}
