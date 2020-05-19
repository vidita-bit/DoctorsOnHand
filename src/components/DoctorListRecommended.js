/* eslint-disable react-native/no-inline-styles */
//This file will show all recommended doctors and nearby doctors
import _ from 'lodash';
import React, {Component} from 'react';
import {connect} from 'react-redux';
import Geolocation from '@react-native-community/geolocation';
import {
  View,
  TouchableOpacity,
  Text,
  FlatList,
  ActivityIndicator,
} from 'react-native';
import Spinner from 'react-native-loading-spinner-overlay';
import DoctorsCard from './common/DoctorsCard';
import DistanceDoctorList from './DistanceDoctorList';
import {DOCTORSLIST} from '../actions';

let myLat = 0;
let myLon = 0;
let array1 = [];
let List1 = [];

class ListItem extends Component {
  state = {
    AllDoctors: true,
    NearbyDoctors: false,
    activeColor: 'blue',
    bottomBorderAD: 2,
    activeColorND: 'gray',
    bottomBorderND: 0,
    lat: '',
    lon: '',
    loading: true,
  };

  componentDidMount() {
    const {navigation} = this.props;
    const item = navigation.getParam('item'); //get specilaity that user have selected
    this.props.DOCTORSLIST(item); //get all the data from of that specilaity
  }
  componentWillReceiveProps(nextprops) {
    this.setState({
      AllDoctors: true,
      NearbyDoctors: false,
      activeColor: 'blue',
      bottomBorderAD: 2,
      activeColorND: 'gray',
      bottomBorderND: 0,
      lat: '',
      lon: '',
      loading: false,
    });
    const newp = nextprops.navigation.getParam('item');
    const oldp = this.props.navigation.getParam('item');
    if (newp !== oldp) {
      this.props.DOCTORSLIST(newp); // if user want to get different specilaity and click on different specility it will get new data of that specialaity
    }
  }
  //diplay all the doctor.Top tab naviagtion
  toggleAllDoctors() {
    this.setState({
      AllDoctors: true,
      NearbyDoctors: false,
      activeColor: 'blue',
      bottomBorderAD: 2,
      activeColorND: 'gray',
      bottomBorderND: 0,
    });
  }
  //display nearby doctor. Top naviagation
  toogleNearByDoctor() {
    this.setState({
      AllDoctors: false,
      NearbyDoctors: true,
      activeColor: 'gray',
      bottomBorderAD: 0,
      activeColorND: 'blue',
      bottomBorderND: 2,
    });
  }
  //show activity indicator to show that new data is loading
  renderFooter = () => {
    return this.state.loading ? (
      <View
        style={{
          alignItems: 'center',
          marginTop: 10,
          paddingBottom: 100,
        }}>
        <ActivityIndicator size="large" />
      </View>
    ) : null;
  };
  //if all data is dispaly set to false
  handleLoadMore = () => {
    this.setState({loading: false});
  };
  render() {
    Geolocation.getCurrentPosition(info => {
      myLat = info.coords.latitude;
      myLon = info.coords.longitude;
    });
    List1 = this.props.DoctorsList;
    array1 = [...List1];
    //sort all the doctor list according to system rating
    const array2 = array1.sort((a, b) => {
      return b['System Rating'] - a['System Rating'];
    });
    return (
      <View>
        <Spinner
          //visibility of Overlay Loading Spinner
          visible={this.state.loading}
          //Text with the Spinner
          textContent={'Loading...'}
        />
        <View style={{flexDirection: 'row', height: 50}}>
          <TouchableOpacity
            //show all recommended doctors when pressed
            onPress={() => {
              this.toggleAllDoctors();
            }}
            style={{
              width: '50%',
              alignContent: 'center',
              borderBottomWidth: this.state.bottomBorderAD,
              borderBottomColor: this.state.activeColor,
              paddingLeft: 60,
              paddingTop: 15,
            }}>
            <Text style={{color: this.state.activeColor}}>Top Rated</Text>
          </TouchableOpacity>
          <TouchableOpacity
            //show all nearby doctor when pressed
            onPress={() => {
              this.toogleNearByDoctor();
            }}
            style={{
              width: '50%',
              paddingLeft: 40,
              paddingTop: 15,
              borderBottomWidth: this.state.bottomBorderND,
              borderBottomColor: this.state.activeColorND,
            }}>
            <Text style={{color: this.state.activeColorND}}>
              Nearby Doctors
            </Text>
          </TouchableOpacity>
        </View>

        <View style={{marginBottom: 100}}>
          {this.state.AllDoctors ? (
            <FlatList
              //flat list will render all the data
              data={array2}
              keyExtractor={(item, index) => item.key}
              onEndReached={this.handleLoadMore}
              onEndReachedThreshold={0}
              initialNumToRender={4}
              renderItem={({item, index}) => (
                <DoctorsCard
                  //for ever doctor display doctor card
                  index={item.id}
                  Data={item}
                  navigation={this.props.navigation}
                  Speciality={item.Speciality}
                  Name={item.Doctor}
                  Rating={item.Rating}
                  Lati={item.Latitude}
                  Long={item.Longitude}
                  NoUsersRated={item['No of Users']}
                  UserRating={item.UserRating}
                  SystemRating={item['System Rating']}
                />
              )}
              //style={{paddingBottom:400}}
              // keyExtractor={item => item.id}
            />
          ) : null}

          {this.state.NearbyDoctors ? (
            <View>
              <DistanceDoctorList
                //display distance list
                navigation={this.props.navigation}
                List={array1}
                Late={myLat}
                Longe={myLon}
                Filter={1000}
              />
              <View style={{height: 60}} />
            </View>
          ) : null}
        </View>
      </View>
    );
  }
}

const mapStateToProps = state => {
  //get doctor list from redux
  const DoctorsList = _.map(state.doctorReducer);
  //console.log('DoctorsList', DoctorsList);
  return {DoctorsList};
};

export default connect(
  mapStateToProps,
  {DOCTORSLIST},
)(ListItem);
