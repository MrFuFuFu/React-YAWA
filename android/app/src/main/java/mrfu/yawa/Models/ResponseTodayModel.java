package mrfu.yawa.Models;

import java.util.List;

/**
 * Created by Yuan Fu on 19/08/18
 * Copyright © 2018 Yuan Fu. All rights reserved.
 */
public class ResponseTodayModel {
    public ResponseModel.CoordEntity coord;
    public String country;
    public int cod;
    public List<ResponseModel.WeatherEntity> weather;
    public ResponseModel.MainEntity main;
    public long dt;
    public SysEntity sys;

    public class SysEntity {
        public long sunrise;
        public long sunset;
    }
}
