import React, { Component } from 'react';
import { Button, View, StyleSheet } from 'react-native';
// import openMap from 'react-native-open-maps';
import MapView from 'react-native-maps';
import OpenMap from 'react-native-open-map';
// import LaunchNavigator from 'react-native-launch-navigator';
//import { NavigationApps,actions,googleMapsTravelModes } from 'react-native-navigation-apps';

const latitude = 31.4790;
const longitude = 74.2662;
export default class Map extends Component {
  _goToYosemite() {
    OpenMap.show({
      latitude: 31.4790,
      longitude: 74.2662,
      latitudeDelta: 0.01,
      longitudeDelta: 0.03,
      // sourceLatitude: -8.0870631, 
      // sourceLongitude: -34.8941619

    });
  }

  render() {
    return (
      <View style={styles.container}>
        <MapView
          style={styles.map}
          onPress={this._goToYosemite}
          initialRegion={{
            latitude,
            longitude,
            latitudeDelta: 0.0043,
            longitudeDelta: 0.0034,
          }}
        >
          <MapView.Marker
            coordinate={{
              latitude,
              longitude
            }}

            onPress={this._goToYosemite}
          >

          </MapView.Marker>



        </MapView>
        {/* <Button
        color={'#bdc3c7'}
        onPress={this._goToYosemite}
        title="Click To Open Maps 🗺"
            />  */}
      </View>

    );
  }
}

const styles = StyleSheet.create({

  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  map: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
  }
});