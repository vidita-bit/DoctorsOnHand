// show all the doctor using the user current location
import React, { Component } from 'react';
import { ScrollView, View, TouchableOpacity, Text } from 'react-native';
import DoctorsCard from './common/DoctorsCard';

const haversine = require('haversine');
let myLat = 0;
let myLon = 0;
let List1 = [];
class DistanceDoctorList extends Component {
    
  state = {
    AllDoctors: true,
    NearbyDoctors: false,
    activeColor: 'blue',
    bottomBorderAD: 2,
    activeColorND: 'gray',
    bottomBorderND: 0,
    lat: '',
    lon: ''
    }
  render() {

const start = {
    
  latitude: this.props.Late, longitude: this.props.Longe
};
 let loni = 0;
 let lati = 0;
    List1 = this.props.List;
   // console.log('List............', List1);
   Object.keys(List1).map((key) => {
      lati = List1[key].Latitude;
      loni = List1[key].Longitude;
     // console.log(start, lati, loni);
      List1[key].distance = haversine(start, { latitude: lati, longitude: loni });
     // console.log(List1[key].distance);
   });
   
     // eslint-disable-next-line no-unused-expressions
     List1.sort !== undefined ?
     List1 = List1.sort((a, b) => 
     a.distance - b.distance
     )
     : null;
    return (
      <View>
      
<ScrollView>
  {console.log(Object.keys(List1))}
{

          Object.keys(List1).map( (key) => {
            if(List1[key].distance <= this.props.Filter){
             // console.log('key',key);
              return (
                
                <DoctorsCard 
                index={List1[key].id}
                Data={List1[key]}
                navigation={this.props.navigation}
                Speciality={List1[key].Speciality} 
                Name={List1[key].Doctor} 
                Rating={List1[key].Rating}
                Distance={List1[key].distance}
                Lati={List1[key].Latitude}
                Long={List1[key].Longitude}
                SystemRating={List1[key]['System Rating']}
                NoUsersRated={List1[key]['No of Users']}
                UserRating={List1[key].UserRating}
                />
              )
            }
          })
        }  
      </ScrollView>
      </View>
    );
  }
}

export default DistanceDoctorList;

