/* eslint-disable react-native/no-inline-styles */
// the file will show all doctors on one specilaity
import _ from 'lodash';
import React, {Component} from 'react';
import {connect} from 'react-redux';
import {
  View,
  TouchableOpacity,
  Text,
  FlatList,
  ActivityIndicator,
} from 'react-native';
import Spinner from 'react-native-loading-spinner-overlay';
import DoctorsCard from './common/DoctorsCard';
import {DOCTORSLIST} from '../actions';

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
  handleLoadMore = () => {
    this.setState({loading: false});
    //console.log('llllllllllllllllllll',this.state);
  };
  render() {
    //console.log(this.props.DoctorsList)
    // Geolocation.getCurrentPosition(info => {
    //   myLat = info.coords.latitude;
    //   myLon = info.coords.longitude;
    // });
    List1 = this.props.DoctorsList;
    array1 = [...List1];
    //array2 = Object.keys(array1);
    //let a = 0;
    //console.log(array2);
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
            //display all doctor list
            onPress={() => {
              this.toggleAllDoctors();
            }}
            style={{
              width: '100%',
              alignContent: 'center',
              borderBottomWidth: this.state.bottomBorderAD,
              borderBottomColor: this.state.activeColor,
              paddingTop: 15,
              justifyContent: 'center',
            }}>
            <Text style={{color: this.state.activeColor, textAlign: 'center'}}>
              All Doctors
            </Text>
          </TouchableOpacity>
        </View>

        <View style={{marginBottom: 100}}>
          {this.state.AllDoctors ? (
            <FlatList
              //flat list will render all the data
              data={array1}
              keyExtractor={(item, index) => item.key}
              //windowSize={7}
              onEndReached={this.handleLoadMore}
              onEndReachedThreshold={0}
              initialNumToRender={4}
              //maxToRenderPerBatch={15}
              // onEndReachedThreshold={0.5}
              // ListFooterComponent={this.renderFooter}
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
                  UserRating={item.UserRating}
                  NoUsersRated={item['No of Users']}
                />
              )}

              //style={{paddingBottom:400}}
              // keyExtractor={item => item.id}
            />
          ) : null}
        </View>
      </View>
    );
  }
}

const mapStateToProps = state => {
  //get doctor list from redux
  const DoctorsList = _.map(state.doctorReducer);
  return {DoctorsList};
};

export default connect(
  mapStateToProps,
  {DOCTORSLIST},
)(ListItem);
