package mrfu.yawa;

import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

import mrfu.yawa.Models.RealWeather;
import mrfu.yawa.utils.WeatherUtils;

public class MainActivity extends AppCompatActivity {
    private final int OVERLAY_PERMISSION_REQ_CODE = 1;  // Choose any value

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (!Settings.canDrawOverlays(this)) {
                Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                        Uri.parse("package:" + getPackageName()));
                startActivityForResult(intent, OVERLAY_PERMISSION_REQ_CODE);
            }
        }

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == OVERLAY_PERMISSION_REQ_CODE) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                if (!Settings.canDrawOverlays(this)) {
                    // SYSTEM_ALERT_WINDOW permission not granted
                    Toast.makeText(MainActivity.this, "Cannot show debug window", Toast.LENGTH_SHORT).show();
                }
            }
        }
    }

    public void onListClick(View view) {
        WeatherUtils.requestWeather(this, "Auckland,NZ", new WeatherUtils.WeatherCallback() {
            @Override
            public void onWeatherCallback(ArrayList<RealWeather> weathers, String errorStr) {
                Intent intent = new Intent(MainActivity.this, WeatherActivity.class);
                intent.putExtra("PageName", "FlatListBasics");
                intent.putExtra("Bundle", RealWeather.listToBundle(weathers, MainActivity.this));
                startActivity(intent);
            }
        });
    }

    public void onDetailClick(View view) {
        WeatherUtils.requestTodayWeather(this, "Auckland,NZ", new WeatherUtils.TodayWeatherCallback() {
            @Override
            public void onTodayWeatherCallback(RealWeather weather, String errorStr) {
                Intent intent = new Intent(MainActivity.this, WeatherActivity.class);
                intent.putExtra("PageName", "RNWeatherDetail");
                intent.putExtra("Bundle", weather.toBundle(MainActivity.this));
                startActivity(intent);
            }
        });
    }


}
