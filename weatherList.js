import React from 'react';
import {AppRegistry, FlatList, StyleSheet, Text, View} from 'react-native';

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
          )}
          keyExtractor={(item, index) => index.toString()}
        />
      </View>
    );
  }
}

const stylesFlatList = StyleSheet.create({
  container: {
   flex: 1,
   paddingTop: 64
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
// AppRegistry.registerComponent('FlatListBasics', () => FlatListBasics);
