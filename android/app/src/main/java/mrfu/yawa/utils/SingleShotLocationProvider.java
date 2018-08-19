package mrfu.yawa.utils;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.widget.Toast;

/**
 * Created by FuYuan on 8/05/18.
 */

public class SingleShotLocationProvider {

    public interface LocationCallback {
        void onNewLocationAvailable(GPSCoordinates location);
    }

    public interface PermissionLocationCallback {
        void premited(boolean isPremited);
    }

    // calls back to calling thread, note this is for low grain: if you want higher precision, swap the
    // contents of the else and if. Also be sure to check gps permission/settings are allowed.
    // call usually takes <10ms
    public static void requestSingleUpdate(final Context context, final LocationCallback callback) {
        final LocationManager locationManager = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);

        if (ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            Toast.makeText(context, "Please check the location permissions.", Toast.LENGTH_SHORT).show();
            return;
        }

//        boolean isNetworkEnabled = locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER);
        boolean isGPSEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);

        Criteria criteria = new Criteria();
        criteria.setAccuracy(isGPSEnabled ? Criteria.ACCURACY_FINE : Criteria.ACCURACY_COARSE);
        locationManager.requestSingleUpdate(criteria, new LocationListener() {
            @Override
            public void onLocationChanged(Location location) {
                callback.onNewLocationAvailable(new GPSCoordinates(location.getLatitude(), location.getLongitude()));
            }

            @Override public void onStatusChanged(String provider, int status, Bundle extras) { }
            @Override public void onProviderEnabled(String provider) { }
            @Override public void onProviderDisabled(String provider) { }
        }, null);
    }


    // consider returning Location instead of this dummy wrapper class
    public static class GPSCoordinates {
        public float longitude = -1;
        public float latitude = -1;

        public GPSCoordinates(float theLatitude, float theLongitude) {
            longitude = theLongitude;
            latitude = theLatitude;
        }

        public GPSCoordinates(double theLatitude, double theLongitude) {
            longitude = (float) theLongitude;
            latitude = (float) theLatitude;
        }

        @Override
        public String toString() {
            return "Longitude=" + longitude + " Latitude=" + latitude;
        }
    }

    public static void getLocationPermission(Activity activity){
        String[] permissions = {Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.ACCESS_COARSE_LOCATION};

        if(ContextCompat.checkSelfPermission(activity.getApplicationContext(),
                Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED){
            if (ContextCompat.checkSelfPermission(activity.getApplicationContext(),
                    Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED){
            }else{
                ActivityCompat.requestPermissions(activity, permissions, 1234);
            }
        }else{
            ActivityCompat.requestPermissions(activity, permissions, 1234);
        }
    }
}
