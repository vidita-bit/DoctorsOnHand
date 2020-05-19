import Swiper from 'react-native-swiper';
import React from 'react';
//import styles from './styles';
import {AppRegistry, StyleSheet, Text, View, Image,Dimensions,ImageBackground} from 'react-native';
import I1 from '../icons/DoctorImage2.jpg';
import I2 from '../icons/DoctorImage12.jpg';
//import Swiper from 'react-native-swiper';
//import React from 'react';
//import styles from './styles';
//import {AppRegistry, StyleSheet, Text, View} from 'react-native';

//import ImageCard from '../ImageCard';
const Swipper = props => {
  return (
    <Swiper
      autoplay={true}
      autoplayTimeout={4}
      style={{
        height: 180,
        marginLeft: 0,
        alignSelf: 'center',
        justifyContent: 'center',
        alignItems:'center'
      }}
      
      dotColor="#808080"
      activeDotColor="#fff"
      >
      <Image source={I1} resizeMode='stretch' style={{width:'97%',height:180,borderRadius:10,alignSelf:'center',marginTop:10}}/>
      <Image source={I2} resizeMode='stretch' style={{width:'97%',height:180,borderRadius:5,alignSelf:'center',marginTop:10}}/>
     </Swiper>
  );
};
export default Swipper;