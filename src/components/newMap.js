import React, { Component } from 'react';
 import { Dimensions, Text, View, PermissionsAndroid, Button } from 'react-native';
 import Geolocation from '@react-native-community/geolocation';
 import MapView, { Marker } from 'react-native-maps';
 const { width, height } = Dimensions.get('window');
 import { SearchBar } from 'react-native-elements';
 import NetInfo from '@react-native-community/netinfo';
 import Geocoder from 'react-native-geocoder';
//import DoctorSignup from './components/doctorSignup';
import { Actions } from 'react-native-router-flux';
//import doctorSignup from './components/doctorSignup';

 const ASPECT_RATIO = width / height;
const LATITUDE = 0;
const LONGITUDE = 0;
const LATITUDE_DELTA = 0.0922;
const LONGITUDE_DELTA = LATITUDE_DELTA * ASPECT_RATIO;
 export default class newMap2 extends Component {
 	constructor(props) {
 		super(props);
 		this.state = {
 			region: {
				latitude: LATITUDE,
				longitude: LONGITUDE,
				latitudeDelta: LATITUDE_DELTA,
				longitudeDelta: LONGITUDE_DELTA,

 			},
 			placeName: ''
 		};
	 }
	 componentWillMount = async () => {
		NetInfo.isConnected.fetch().then(isConnected => {
			if (!isConnected) {
				alert(' Please check your Internet connection');}
			});
	
		 try {
			 const granted = await PermissionsAndroid.request(PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION);
			 if (granted == PermissionsAndroid.RESULTS.GRANTED) {
				Geolocation.getCurrentPosition(
					position => {
					  this.setState({
						region: {
						  latitude: position.coords.latitude,
						  longitude: position.coords.longitude,
						  latitudeDelta: LATITUDE_DELTA,
						  longitudeDelta: LONGITUDE_DELTA,
						}
					  });
					},
				  (error) => console.log(error.message),
				  { enableHighAccuracy: true, timeout: 20000, maximumAge: 1000 },
				  );
				  this.watchID = Geolocation.watchPosition(
					position => {
					  this.setState({
						region: {
						  latitude: position.coords.latitude,
						  longitude: position.coords.longitude,
						  latitudeDelta: LATITUDE_DELTA,
						  longitudeDelta: LONGITUDE_DELTA,
						}
					  });
					}

				  );
			 } else {
				 alert('permission denied');
			 }
		 } catch (err) {
			 alert('something went wrong');
		 }
	  }
	  onRegionChange(region) {
		this.setState({ region });
	  }
	 
	goback = () => {
	//	Actions.popTo(sceneKey: 'createDoctor', props: {abc:'hello'});
		//Actions.pop({ Longitude: this.state.region.longitude, Latitude: this.state.region.latitude })
	}	  
 selected=async () => {
	NetInfo.isConnected.fetch().then(isConnected => {
		if (!isConnected) {
			alert(' Please check your Internet connection');}
		});
	const NY = {
		lat: this.state.region.latitude,
		lng: this.state.region.longitude
	};
	console.log(this.state.region.latitude);
	console.log(this.state.region.longitude);
	alert(this.state.region.latitude);
	
	 const nameLocation = await Geocoder.geocodePosition(NY);
	 const result = Object.entries(nameLocation).map(([key, val]) => ({
		[key]: val
	}));
	this.setState({ placeName: result[0][0].formattedAddress });
	alert(result[0][0].formattedAddress);
	 Actions.doctorSignup({ lat: this.state.region.latitude, lng: this.state.region.longitude, place: result[0][0].formattedAddress });
	
	
	
	//console.log(nameLocation.Promise)
	// for(let num of nameLocation){
	// 	alert(num)
	// }

	// nameLocation.map((item)=>{
	// 	return(
	// 		<Text>{item}</Text>
	// 	)
	// })
	
	
	//alert('kkkk')
		

	// )
	// Actions.doctorSignup();}
 }
 updateSearchh = search => {
	this.setState({ search });
}
	  
 	
async updateSearch() {
	//console.log('search', this.state.search);
	
	try {
	const res = await Geocoder.geocodeAddress(this.state.search);
	console.log(res);
		// res is an Array of geocoding object (see below)
		console.log('yeah', res[0].position.lat);

	
		this.setState({
			region: {
			  latitude: res[0].position.lat,
			  longitude: res[0].position.lng,
			  latitudeDelta: LATITUDE_DELTA,
			  longitudeDelta: LONGITUDE_DELTA,
			}
		  });
		// do something with data
	 
	
	return (
		<MapView
			 
 			style={{ height: '100%', width: '100%' }}
			 showsUserLocation
			 region={this.state.region}
			// onRegionChange={ region => this.setState({region}) }
			 onRegionChangeComplete={region => this.setState({ region })}
			 
    
  >
  <Marker
		  coordinate={this.state.region}
  />
	 <Text>{this.state.region.latitude}</Text>
	 <Text>{this.state.region.longitude}</Text>
      </MapView>
	);
	} catch (err) {
	alert('something went wrong '); 
}
  }
 
 	render() {
		const { search } = this.state;

 		return (
			 <View>
				
			
				 <View style={{ position: 'absolute', width: '100%', height: '100%', justifyContent: 'flex-end', alignItems: 'center' }}>
				   <Button
	  
	  title="Done"
	  onPress={this.selected}
				   />
	  </View>
 <SearchBar
        placeholder="Type Here..."
        onChangeText={this.updateSearchh}
		value={search}
		onEndEditing={() => this.updateSearch(this.state.search)}
 />
 			<MapView
			
 			style={{ height: '80%', width: '100%' }}
			 showsUserLocation
			 region={this.state.region}
			// onRegionChange={ region => this.setState({region}) }
			 onRegionChangeComplete={region => this.setState({ region })}
 			>
  <Marker
		  coordinate={this.state.region}
  />
	 <Text style={{ marginTop: 30 }}>{this.state.region.latitude}</Text>
	 <Text style={{ marginTop: 30 }}>{this.state.region.longitude}</Text>
	

      </MapView>
	
	 
	  </View>


		 );
 }
}