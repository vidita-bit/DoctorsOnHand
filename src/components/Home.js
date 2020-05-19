/* eslint-disable react-native/no-inline-styles */
//Home screen that shows image slider and view and recommended doctors
import React, {Component} from 'react';
import {
  View,
  Image,
  StyleSheet,
  Text,
  TouchableOpacity,
} from 'react-native';
import {SliderBox} from 'react-native-image-slider-box';
const Image2 = require('../Images/viewProfile.png');
const Image3 = require('../Images/recc.png');
const Image4 = require('../Images/Coun_doctor.png');
const Image5 = require('../Images/appo.png');

class Home extends Component {
  render() {
    //console.log(firebase.auth().currentUser.uid);
    //images that show on image slider
    const images = [
      Image.resolveAssetSource(require('./icons/DoctorImage2.jpg')).uri,
      Image.resolveAssetSource(require('./icons/DoctorImage12.jpg')).uri,
    ];

    return (
      <View>
        <View
          style={{
            backgroundColor: '#fafafa',
            height: 220,
            paddingTop: 30,
            width: '100%',
            marginBottom: 15,
          }}>
          {/* image slider */}
          <SliderBox images={images} />
        </View>
         {/* button that navigate to specilatity list */}
        <TouchableOpacity
          style={{margin: 5}}
          onPress={() => this.props.navigation.navigate('Second')}>
          <View
            style={{
              flexDirection: 'row',
              padding: 15,
              borderWidth: 0,
              borderColor: '#fafafa',
              borderRadius: 15,
              shadowColor: '#000',
              shadowOffset: {
                width: 0,
                height: 3,
              },
              shadowOpacity: 0.2,
              shadowRadius: 4,

              elevation: 5,
              borderTopWidth: 0,
            }}>
            <View
              style={{
                width: 100,
                height: 60,
                justifyContent: 'center',
                alignItems: 'center',
                borderRadius: 100,
                borderWidth: 0,
              }}>
              <Image
                source={Image2}
                style={{
                  width: 70,
                  height: 70,
                  borderRadius: 200,
                  borderWidth: 0,
                }}
              />
            </View>
            <Text style={{fontSize: 20, marginLeft: 5, marginTop: 15}}>
              View Doctor's Profile
            </Text>
          </View>
        </TouchableOpacity>
        {/* button that will naviagate to recommended specilaity list */}
        <TouchableOpacity
          style={{margin: 5}}
          onPress={() => this.props.navigation.navigate('Ninth')}>
          <View
            style={{
              flexDirection: 'row',
              padding: 15,
              borderWidth: 0,
              borderColor: '#fafafa',
              borderRadius: 15,
              shadowColor: '#000',
              shadowOffset: {
                width: 0,
                height: 3,
              },
              shadowOpacity: 0.2,
              shadowRadius: 4,

              elevation: 5,
              borderTopWidth: 0,
            }}>
            <View
              style={{
                width: 70,
                height: 70,
                marginRight: 15,
                marginLeft: 15,
                justifyContent: 'center',
                borderRadius: 240,
                alignItems: 'center',
                alignSelf: 'center',
                borderWidth: 1,
                borderColor: '#bababa',
              }}>
              <Image
                source={Image3}
                style={{
                  width: 40,
                  resizeMode: 'contain',
                  borderRadius: 90,
                  borderWidth: 0,
                  borderColor: 'red',
                }}
              />
            </View>
            <Text style={{fontSize: 20, marginLeft: 5, marginTop: 15}}>
              Recommended Doctors
            </Text>
          </View>
        </TouchableOpacity>
        <TouchableOpacity style={{margin: 5}}>
          <View
            style={{
              flexDirection: 'row',
              padding: 15,
              borderWidth: 0,
              borderColor: '#fafafa',
              borderRadius: 15,
              shadowColor: '#000',
              shadowOffset: {
                width: 0,
                height: 3,
              },
              shadowOpacity: 0.2,
              shadowRadius: 4,

              elevation: 5,
              borderTopWidth: 0,
            }}>
            <View
              style={{
                width: 100,
                height: 60,
                justifyContent: 'center',
                alignItems: 'center',
                borderRadius: 100,
                borderWidth: 0,
              }}>
              <Image
                source={Image4}
                style={{
                  width: 70,
                  height: 70,
                  borderRadius: 200,
                  borderWidth: 0,
                }}
              />
            </View>
            <Text style={{fontSize: 20, marginLeft: 5, marginTop: 15}}>
              Consult Doctor Online
            </Text>
          </View>
        </TouchableOpacity>
        <TouchableOpacity style={{margin: 5}}>
          <View
            style={{
              flexDirection: 'row',
              padding: 15,
              borderWidth: 0,
              borderColor: '#fafafa',
              borderRadius: 15,
              shadowColor: '#000',
              shadowOffset: {
                width: 0,
                height: 3,
              },
              shadowOpacity: 0.2,
              shadowRadius: 4,

              elevation: 5,
              borderTopWidth: 0,
            }}>
            <View
              style={{
                width: 100,
                height: 60,
                justifyContent: 'center',
                alignItems: 'center',
                borderRadius: 100,
                borderWidth: 0,
              }}>
              <Image
                source={Image5}
                style={{
                  width: 110,
                  marginTop: 4,
                  resizeMode: 'contain',
                  borderWidth: 0,
                }}
              />
            </View>
            <Text style={{fontSize: 20, marginLeft: 5, marginTop: 15}}>
              Appointments
            </Text>
          </View>
        </TouchableOpacity>
      </View>
    );
  }
}
export default Home;
