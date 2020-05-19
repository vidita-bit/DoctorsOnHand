/* eslint-disable react-native/no-inline-styles */
//Display information of single doctor
import React, {Component} from 'react';
import {
  View,
  Text,
  Image,
  Button,
  TouchableOpacity,
  StyleSheet,
} from 'react-native';
import OpenMap from 'react-native-open-map';
import StarRating from 'react-native-star-rating';
import GoogleMap from '../icons/google-maps.jpg';
import DoctorImage from '../icons/doctorA.png';

class DoctorsCard extends Component {
  //naviagte to detail doctors list
  onButtonPress = (
    Name,
    Speciality,
    Rating,
    Data,
    index,
    Lati,
    Long,
    SystemRating,
    UserRating,
    NoUsersRated,
  ) => {
    this.props.navigation.navigate('Fourth', {
      Name,
      Speciality,
      Rating,
      Data,
      index,
      Lati,
      Long,
      SystemRating,
      UserRating,
      NoUsersRated,
    });
  };
  //open google map or uber app if installed
  _goToYosemite(lat, lon) {
    OpenMap.show({
      latitude: lat,
      longitude: lon,
      latitudeDelta: 0.01,
      longitudeDelta: 0.03,
    });
  }

  render() {
    return (
      <View style={styles.container}>
        <View style={styles.topContainer}>
          <View style={styles.imageContainer}>
            <Image source={DoctorImage} style={styles.image} />
          </View>
          <View style={styles.InfoConatiner}>
            {this.props.Name !== 0 &&
            // eslint-disable-next-line use-isnan
            this.props.Name !== NaN &&
            this.props.Name !== undefined ? (
              <Text style={{fontSize: 20}}>
                {this.props.Name.split(',')[0]}
              </Text>
            ) : null}
            <Text>{this.props.Speciality}</Text>
            {this.props.Distance !== 0 &&
            // eslint-disable-next-line use-isnan
            this.props.Distance !== NaN &&
            this.props.Distance !== undefined ? (
              <Text>{Math.round(this.props.Distance)} km</Text>
            ) : null}

            {this.props.SystemRating !== 0 &&
            // eslint-disable-next-line use-isnan
            this.props.SystemRating !== NaN &&
            this.props.SystemRating !== undefined ? (
              <View style={{flexDirection: 'row'}}>
                <Text style={{color: 'green', marginRight: 5}}>
                  {this.props.SystemRating}
                </Text>
                <View style={{height: 20, width: 100}}>
                  <StarRating
                    starSize={15}
                    emptyStar={'ios-star-outline'}
                    fullStar={'ios-star'}
                    halfStar={'ios-star-half'}
                    iconSet={'Ionicons'}
                    disabled
                    maxStars={5}
                    rating={this.props.SystemRating}
                    fullStarColor={'green'}
                  />
                </View>
              </View>
            ) : null}
            <View style={{flexDirection: 'row'}}>
              <Text style={{color: '#fcba03', marginRight: 5}}>
                {this.props.Rating}
              </Text>
              <View style={{height: 20, width: 100}}>
                <StarRating
                  starSize={15}
                  emptyStar={'ios-star-outline'}
                  fullStar={'ios-star'}
                  halfStar={'ios-star-half'}
                  iconSet={'Ionicons'}
                  disabled
                  maxStars={5}
                  rating={this.props.Rating}
                  fullStarColor={'#fcba03'}
                />
              </View>
            </View>
          </View>
        </View>
        <View style={styles.buttonContainer}>
          <View style={styles.btn}>
            <Button
              //button that naviagte to doctor details page
              title="View Profile"
              onPress={() =>
                this.onButtonPress(
                  this.props.Name,
                  this.props.Speciality,
                  this.props.Rating,
                  this.props.Data,
                  this.props.index,
                  this.props.Lati,
                  this.props.Long,
                  this.props.SystemRating,
                  this.props.UserRating,
                  this.props.NoUsersRated,
                )
              }
            />
          </View>
          <TouchableOpacity
            //open google map
            onPress={() =>
              this._goToYosemite(this.props.Lati, this.props.Long)
            }>
            <Image source={GoogleMap} style={{width: 40, height: 40}} />
          </TouchableOpacity>
        </View>
      </View>
    );
  }
}
// styles for this page
const styles = StyleSheet.create({
  container: {
    backgroundColor: '#fff',
    borderColor: '#ddd',
    borderWidth: 1,
    borderRadius: 2,
    borderBottomWidth: 0,
    shadowColor: '#000',
    shadowOffset: {width: 0, height: 3},
    shadowOpacity: 0.2,
    shadowRadius: 2,
    elevation: 1,
    marginLeft: 5,
    marginRight: 5,
    marginTop: 10,
    marginBottom: 5,
    padding: 5,
  },
  image: {
    width: 60,
    height: 60,
  },
  imageContainer: {
    alignItems: 'flex-start',
    borderWidth: 2,
    borderRadius: 120,
    padding: 10,
    borderColor: 'orange',
  },
  topContainer: {
    flexDirection: 'row',
    marginTop: 10,
    marginBottom: 10,
    marginLeft: 10,
  },
  InfoConatiner: {
    flexDirection: 'column',
    marginLeft: 20,
  },
  buttonContainer: {
    flexDirection: 'row',
  },
  btn: {
    width: '85%',
    marginRight: 13,
    marginTop: 4,
  },
  IconContainer: {
    padding: 5,
  },
});

export default DoctorsCard;
