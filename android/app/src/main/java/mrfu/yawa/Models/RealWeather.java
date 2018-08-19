package mrfu.yawa.Models;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import com.facebook.react.bridge.Arguments;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;

import mrfu.yawa.utils.WeatherUtils;

/**
 * Created by Yuan Fu on 19/08/18
 * Copyright © 2018 Yuan Fu. All rights reserved.
 */
public class RealWeather implements Serializable {
    public String temp;
    public String icon;
    public String desc;
    public long date;

    //Other info
    public String  pressure;
    public String  humidity;
    public long  sunrise;
    public long  sunset;
    public String  locality;

    public Bundle toBundle(Context context) {
        Bundle bundle = new Bundle();
        bundle.putString("temp", temp + "℃");
        bundle.putString("icon", WeatherUtils.weatherMatch(context, icon));
        bundle.putString("desc", desc);
        bundle.putString("date", getDate(date, "EEEE, dd MMM"));
        bundle.putString("pressure", pressure);
        bundle.putString("humidity", humidity);
        bundle.putString("sunrise", getDate(sunrise, "HH:mm"));
        bundle.putString("sunset", getDate(sunset, "HH:mm"));
        bundle.putString("locality", locality);
        bundle.putString("time", getDate(date, "HH:mm"));
        return bundle;
    }

    private static String getDate(long milliSeconds, String dateFormat)
    {
        // Create a DateFormatter object for displaying date in specified format.
//        Date date = new Date(milliSeconds * 1000);
        DateFormat formatter = new SimpleDateFormat(dateFormat);

        // Create a calendar object that will convert the date and time value in milliseconds to date.
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(milliSeconds * 1000);
        return formatter.format(calendar.getTime());
    }

    public static Bundle listToBundle(ArrayList<RealWeather> list, Context context) {
        List<Long> dates = new ArrayList<>();
        for (RealWeather realWeather : list) {
            dates.add(realWeather.date);
        }
        List<Long> uniqueDates = new ArrayList<>();
        for (long date : dates) {
            SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
            String date1 = fmt.format(date * 1000);
            boolean isEqual = false;
            for (long uniqueDate : uniqueDates) {
                SimpleDateFormat fmt2 = new SimpleDateFormat("yyyyMMdd");
                String uniqueDate2 = fmt2.format(uniqueDate * 1000);
                isEqual = uniqueDate2.equals(date1);
            }
            if (!isEqual) {
                uniqueDates.add(date);
            }
        }

        List<List<RealWeather>> arrayWeathers = new ArrayList<>();

        for (long date: uniqueDates) {
            SimpleDateFormat fmt2 = new SimpleDateFormat("yyyyMMdd");
            String uniqueDate2 = fmt2.format(date * 1000);
            List<RealWeather> realWeatherList = new ArrayList<>();

            for (RealWeather realWeather: list) {
                SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
                String dateWeatherStr = fmt.format(realWeather.date * 1000);
                if (dateWeatherStr.equals(uniqueDate2)) {
                    realWeatherList.add(realWeather);
                }
            }
            arrayWeathers.add(realWeatherList);
        }

        ArrayList<ArrayList<Bundle>> neededWeathers = new ArrayList<>();
        for (List<RealWeather> weatherList : arrayWeathers) {
            ArrayList<Bundle> list1 = new ArrayList<>();
            for (RealWeather realWeather : weatherList) {
                String dateStr = getDate(realWeather.date, "HH:mm");
                if (dateStr.equals("03:00") || dateStr.equals("09:00") || dateStr.equals("15:00") || dateStr.equals("21:00")) {
                    list1.add(realWeather.toBundle(context));
                }
            }
            neededWeathers.add(list1);
        }

        Bundle bundle = new Bundle();
        bundle.putSerializable("AllWeather", neededWeathers);
        return bundle;
    }
}
