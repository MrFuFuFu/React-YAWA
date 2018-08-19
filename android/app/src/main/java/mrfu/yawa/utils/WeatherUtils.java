package mrfu.yawa.utils;

import android.content.Context;
import android.util.Log;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.Volley;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import mrfu.yawa.Models.RealWeather;
import mrfu.yawa.Models.ResponseModel;
import mrfu.yawa.Models.ResponseTodayModel;
import mrfu.yawa.Network.GsonRequest;
import mrfu.yawa.R;

/**
 * Created by FuYuan on 8/05/18.
 */

public class WeatherUtils {

    public interface WeatherCallback {
        void onWeatherCallback(ArrayList<RealWeather> weather, String errorStr);
    }

    public interface TodayWeatherCallback {
        void onTodayWeatherCallback(RealWeather weather, String errorStr);
    }

    public static void requestWeather(Context context, final String cityName, final WeatherCallback callback) {
        RequestQueue queue = Volley.newRequestQueue(context);

        String cityName1 = "";
        try {
            cityName1 = URLEncoder.encode(cityName, "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String url = "http://api.openweathermap.org/data/2.5/forecast?mode=json&units=metric&APPID=399a5bbd96e27a24b8f8c656e8c30ff4&q=" + cityName1;

        GsonRequest<ResponseModel> gsonRequest = new GsonRequest<>(Request.Method.GET, url, ResponseModel.class, new Response.Listener<ResponseModel>() {
            @Override
            public void onResponse(ResponseModel dataModel) {
                if (dataModel != null) {
                    ArrayList<RealWeather> realWeathers = new ArrayList<>();

                    for (ResponseModel.ListEntity entity : dataModel.list) {
                        if (entity == null) continue;
                        RealWeather realWeather = new RealWeather();
                        if (entity.main != null) {
                            realWeather.temp = "" + (int)entity.main.temp;
                            realWeather.pressure = "" + (int)entity.main.pressure;
                            realWeather.humidity = "" + (int)entity.main.humidity;
                        }
                        if (entity.weather != null && entity.weather.size() > 0) {
                            realWeather.icon = entity.weather.get(0).icon;
                            realWeather.desc = entity.weather.get(0).description;
                            realWeather.date = entity.dt;
                        }
                        realWeather.locality = cityName;
                        realWeathers.add(realWeather);
                    }
                    
                    callback.onWeatherCallback(realWeathers, null);
                }

            }
        }, new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        Log.i("Error", error.getLocalizedMessage());
                        callback.onWeatherCallback(null, error.getMessage());
                    }
                });

        // Add the request to the RequestQueue.
        queue.add(gsonRequest);
    }

    public static void requestTodayWeather(Context context, final String cityName, final TodayWeatherCallback callback) {
        RequestQueue queue = Volley.newRequestQueue(context);

        String cityName1 = "";
        try {
            cityName1 = URLEncoder.encode(cityName, "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String url = "http://api.openweathermap.org/data/2.5/weather?mode=json&units=metric&APPID=399a5bbd96e27a24b8f8c656e8c30ff4&q=" + cityName1;

        GsonRequest<ResponseTodayModel> gsonRequest = new GsonRequest<>(Request.Method.GET, url, ResponseTodayModel.class, new Response.Listener<ResponseTodayModel>() {
            @Override
            public void onResponse(ResponseTodayModel dataModel) {
                if (dataModel != null) {
                    RealWeather realWeather = new RealWeather();
                    if (dataModel.main != null) {
                        realWeather.temp = "" + (int)dataModel.main.temp;
                        realWeather.pressure = "" + (int)dataModel.main.pressure;
                        realWeather.humidity = "" + (int)dataModel.main.humidity;
                    }
                    if (dataModel.weather != null && dataModel.weather.size() > 0) {
                        realWeather.icon = dataModel.weather.get(0).icon;
                        realWeather.desc = dataModel.weather.get(0).description;

                    }
                    realWeather.date = dataModel.dt;
                    realWeather.locality = cityName;
                    if ( dataModel.sys != null) {
                        realWeather.sunrise = dataModel.sys.sunrise;
                        realWeather.sunset = dataModel.sys.sunset;
                    }


                    callback.onTodayWeatherCallback(realWeather, null);
                }

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.i("Error", error.getLocalizedMessage());
                callback.onTodayWeatherCallback(null, error.getMessage());
            }
        });

        // Add the request to the RequestQueue.
        queue.add(gsonRequest);
    }

    public static String weatherMatch(Context context, String code) {
        if (code.equals("01d")) {
            return context.getString(R.string.ClearSkyDay);
        } else if (code.equals("01n")) {
            return context.getString(R.string.ClearSkyNight);// "\\u{f073}";
        } else if (code.equals("02d")) {
            return context.getString(R.string.FewCloudsDay);
        } else if (code.equals("02n")) {
            return context.getString(R.string.FewCloudsNight);// "\\u{f01e}";
        } else if (code.equals("03d")) {
            return context.getString(R.string.ScatteredCloudsDay);// "\\u{f01e}";
        } else if (code.equals("03n")) {
            return context.getString(R.string.ScatteredCloudsNight);// "\\u{f017}";
        } else if (code.equals("04d")) {
            return context.getString(R.string.BrokenCloudsDay);// "\\u{f017}";
        } else if (code.equals("04n")) {
            return context.getString(R.string.BrokenCloudsNight);// "\\u{f0b5}";
        } else if (code.equals("09d")) {
            return context.getString(R.string.ShowerRainDay);// "\\u{f019}";
        } else if (code.equals("09n")) {
            return context.getString(R.string.ShowerRainNight);// "\\u{f019}";
        } else if (code.equals("10d")) {
            return context.getString(R.string.RainDay);// "\\u{f017}";
        } else if (code.equals("10n")) {
            return context.getString(R.string.RainNight);// "\\u{f01a}";
        } else if (code.equals("11d")) {
            return context.getString(R.string.ThunderstormDay);// "\\u{f01a}";
        } else if (code.equals("11n")) {
            return context.getString(R.string.ThunderstormNight);// "\\u{f064}";
        } else if (code.equals("13d")) {
            return context.getString(R.string.SnowDay);// "\\u{f016}";
        } else if (code.equals("13n")) {
            return context.getString(R.string.SnowNight);// "\\u{f064}";
        } else if (code.equals("50d")) {
            return context.getString(R.string.MistDay);// "\\u{f01b}";
        } else if (code.equals("50n")) {
            return context.getString(R.string.MistNight);// "\\u{f015}";
        }
        return null;
    }
}
