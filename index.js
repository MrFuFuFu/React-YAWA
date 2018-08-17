import React from 'react';
import {AppRegistry, FlatList, StyleSheet, Text, View} from 'react-native';

class RNHighScores extends React.Component {
  render() {
    var contents = this.props['scores'].map((score) => (
      <Text key={score.name}>
        {score.name}:{score.value}
        {'\n'}
      </Text>
    ));
    return (
      <View style={styles.container}>
        <Text style={styles.highScoresTitle}>2048 High Scores!</Text>
        <Text style={styles.scores}>{contents}</Text>
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
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  scores: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

// Module name
AppRegistry.registerComponent('RNHighScores', () => RNHighScores);



export default class FlatListBasics extends React.Component {
  render() {
    const bgColors= ['#FF6565', '#A065FF', '#FF659E', '#86E99E', '#6D65FF', '#6C6C6C'];
    return (
      <View style={stylesFlatList.container}>
        <FlatList

          data={this.props['AllWeather']}


          

          renderItem={ ({ item, index}) => (
            <View style={ [stylesFlatList.itemStyle, {backgroundColor: bgColors[index]}] }>
              <Text style={stylesFlatList.itemDate}>{ item[0]["date"] }</Text>

              <View style={{flexDirection: 'row'}}>

              {item.map((weather, i) => (
              	<View key={i} style={stylesFlatList.itemWeather}>
					<Text style={stylesFlatList.itemWeatherText}>{ item[i]["time"] }</Text>
					<Text style={[stylesFlatList.itemWeatherText, stylesFlatList.weatherIcon]}>{ item[i]["icon"] }</Text>
					<Text style={stylesFlatList.itemWeatherText}>{ item[i]["temp"] }</Text>
					<Text style={stylesFlatList.itemWeatherText}>{ item[i]["desc"] }</Text>
				</View>
              ))}

              </View>
            </View>
          ) }

        />
      </View>
    );
  }
}

const stylesFlatList = StyleSheet.create({
  container: {
   flex: 1,
   paddingTop: 22
  },

  itemStyle: {
  	margin: 10,
    padding: 10,
    height: 160,
    borderRadius: 10,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 0 },
    shadowOpacity: 0.4,
    shadowRadius: 5
  },

  itemDate: {
  	padding: 5,
  	fontSize: 17,
  	color: 'white',
  	textAlign: 'center'
  },

  itemWeather: {
  	flex:1,
  	alignItems: 'center'
  },

  itemWeatherText: {
  	padding: 5,
  	color: 'white',
  	fontSize: 14
  },

  weatherIcon: {
  	fontFamily: "Weather Icons",
  	fontSize: 17
  }

})

// skip this line if using Create React Native App
AppRegistry.registerComponent('FlatListBasics', () => FlatListBasics);
