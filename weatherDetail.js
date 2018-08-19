import React from 'react';
import {AppRegistry, StyleSheet, Text, View, ImageBackground} from 'react-native';

export default class RNWeatherDetail extends React.Component {
  render() {
    return (
        <View style={styles.container}>
          <Text style={styles.highScoresTitle}>{ this.props["locality"] } </Text>
          <Text style={styles.normalText}>{ this.props["date"] } </Text>
          <Text style={[styles.highScoresTitle, styles.weatherIcon]}>{ this.props["icon"] } </Text>
          <Text style={[styles.normalText, styles.weatherDesc]}>{ this.props["desc"] } </Text>
          <Text style={[styles.normalText, styles.weatherDesc]}>{ this.props["temp"] } </Text>
          <View style={{ flex: 1, justifyContent: 'flex-end', alignItems: 'center' }}>
            <Text style={styles.normalText}>Pressure: { this.props["pressure"] }hPa      Sunrise: { this.props["sunrise"] }</Text>
            <Text style={styles.normalText}>Humidity: { this.props["humidity"] }%      Sunset: { this.props["sunset"] }</Text>
            <Text style={[styles.normalText, styles.weatherDesc, styles.smallText]}>Issued: { this.props["time"] } </Text>
          </View>
        </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },
  highScoresTitle: {
    marginTop: 100,
    fontSize: 40,
    textAlign: 'center',
    margin: 10,
  },
  normalText: {
    fontSize: 20,

  },
  scores: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  weatherIcon: {
    fontFamily: "Weather Icons",
    fontSize: 50,
    marginTop: 20
  },
  weatherDesc: {
    marginTop: 10
  },
  smallText: {
    fontSize: 15
  }
});
