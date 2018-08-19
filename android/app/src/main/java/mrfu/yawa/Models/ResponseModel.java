package mrfu.yawa.Models;

import java.util.List;

/**
 * Created by Yuan Fu on 19/08/18
 * Copyright © 2018 Yuan Fu. All rights reserved.
 */
public class ResponseModel {

    public CityEntity city;
    public CoordEntity coord;
    public String country;
    public int cod;
    public List<ListEntity> list;


    public class CityEntity {
        public int id;
        public String name;
    }

    public class CoordEntity {
        public double lon;
        public double lat;
    }

    public class ListEntity {
        public long dt;
        public MainEntity main;
        public List<WeatherEntity> weather;
    }

    public class MainEntity {
        public double temp;
        public double pressure;
        public double humidity;
    }

    public class WeatherEntity {
        public int id;
        public String main;
        public String description;
        public String icon;
    }
}
