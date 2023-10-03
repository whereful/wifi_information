package com.wifi.wifiproject;

import com.wifi.wifiproject.dto.Row;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Getter
@Setter
public class DistanceStrategy {

    private double myLAT;
    private double myLNT;
    private int size;

    private static DistanceStrategy distanceStrategy = new DistanceStrategy(0.0, 0.0, 0);

    public List<Row> sortedRowList = new ArrayList<Row>();

    private DistanceStrategy(double myLAT, double myLNT, int size) {
        this.myLAT = myLAT;
        this.myLNT = myLNT;
        this.size = size;
    }

    public static DistanceStrategy getInstance() {
        return distanceStrategy;
    }

    public List<Row> changeStandard(double a, double b, int size, List<Row> rowList) {
        distanceStrategy.setMyLAT(a);
        distanceStrategy.setMyLNT(b);
        distanceStrategy.setSize(size);

        sortedRowList = new ArrayList<Row>();

        if (rowList.size() > 0) {
            Collections.sort(rowList, Comparator.comparingDouble(row -> row.getDistance(myLAT, myLNT)));

            for (int i = 0; i < size; i += 1) {
                sortedRowList.add(rowList.get(i));
            }

        }

        return sortedRowList;
    }

    public List<Row> makeSortedDistanceRow(List<Row> rowList) {

        if (rowList.size() > 0) {
            Collections.sort(rowList, Comparator.comparingDouble(row -> row.getDistance(myLAT, myLNT)));

            List<Row> sortedRow = new ArrayList<Row>();

            for (int i = 0; i < size; i += 1) {
                sortedRow.add(rowList.get(i));
            }

            return sortedRow;
        }

        return null;
    }


}
