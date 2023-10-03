package com.wifi.wifiproject.dto;

import lombok.Getter;
import lombok.Setter;
import org.jetbrains.annotations.NotNull;

@Getter
@Setter
public class Row {

    private String X_SWIFI_MGR_NO;
	private String X_SWIFI_WRDOFC;
    private String X_SWIFI_MAIN_NM;
	private String X_SWIFI_ADRES1;
    private	String X_SWIFI_ADRES2;
	private String X_SWIFI_INSTL_FLOOR;
    private	String X_SWIFI_INSTL_TY;
    private String X_SWIFI_INSTL_MBY;
	private String X_SWIFI_SVC_SE;
	private String X_SWIFI_CMCWR;
	private String X_SWIFI_CNSTC_YEAR;
	private String X_SWIFI_INOUT_DOOR;
	private String X_SWIFI_REMARS3;

	// 사이트 오류 : LAT에 y좌표가 입력됨
	private String LNT;
	private String LAT;

	private String WORK_DTTM;

	public double getDistance(double x, double y) {
		// 사이트 오류 : LAT에 y좌표가 입력됨

		// 거리 계산 다른 공식 필요?(위도, 경도?)
		return Math.pow((Double.parseDouble(this.LNT) - x), 2) + Math.pow((Double.parseDouble(this.LAT) - y), 2);
	}


}
