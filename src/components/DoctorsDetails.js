import _ from 'lodash';
import React, { Component } from 'react';
import StarRating from 'react-native-star-rating';
import MapView from 'react-native-maps';
import firebase from 'firebase';
import OpenMap from 'react-native-open-map';
import {
  StyleSheet,
  Text,
  View,
  Image,
  Button,
  TextInput,
  ScrollView,
  KeyboardAvoidingView,
  TouchableOpacity,
  Alert
} from 'react-native';
import { connect } from 'react-redux';
import { AddReviews, AddRating, UpdateRating } from '../actions';
import DoctorImage from './icons/doctorA.png';
import GoogleMap from './icons/google-maps.jpg';


class DoxtorsDetails extends Component {

  state = {
    firstInput: '',
    starCount: this.props.navigation.getParam('Rating'),
    Latitude: this.props.navigation.getParam('Lati') || 0,
    Longitude: this.props.navigation.getParam('Long') || 0,
    SystemCount: this.props.navigation.getParam('SystemRating'),
    userRate: 0,
    userid: firebase.auth().currentUser.uid,
  }
  componentDidMount(){
   // console.log('hello',this.props.navigation.getParam('index'));
   console.log('hello',this.props.navigation.getParam('index'));
    const userratings  = this.props.navigation.getParam('UserRating');
    console.log(userratings);
    if(userratings !== undefined){
        if(userratings[this.state.userid]!== undefined){
          this.setState({userRate: userratings[this.state.userid]})
        }
    }

  }
  onButtonPress = (index,Data) => {
    //console.log('Buttttooonnn', SpecialityID);
    this.props.navigation.navigate('Seventh', {
      index,
      Data
    });
  }

  onStarRatingPress = (rating, Speciality, index,data) => {

    const uid = firebase.auth().currentUser.uid;
    const DoctorsRating = this.props.navigation.getParam('Rating');
    const abc = this.props.navigation.getParam('UserRating');
    const NoUsersRated = this.props.navigation.getParam('NoUsersRated');
   //alert(abc[uid]);
    if (abc === undefined) {
      if (abc === undefined) {
        this.props.AddRating({ rating, Speciality, index, uid, NoUsersRated, DoctorsRating,data });
      }
    }else if(abc[uid]===undefined){
      this.props.AddRating({ rating, Speciality, index, uid, NoUsersRated, DoctorsRating,data });
    
    }
     else {
      const oldrating = abc[uid];
      console.log(rating, Speciality, index, uid, NoUsersRated, DoctorsRating, oldrating);

      this.props.UpdateRating({ rating, Speciality, index, uid, NoUsersRated, DoctorsRating, oldrating,data });
    }
    this.setState({userRate:rating})
  }

  OnAddReview = (review, Speciality, index) => {
    const uid = firebase.auth().currentUser.uid;
    console.log('Index', index, Speciality, review);
    if (review !== '') {
      this.props.AddReviews({ review, Speciality, index,uid });
      Alert.alert('Review Added');
      this.setState({firstInput:''});
    }
  }
  _goToYosemite(lat, lon) {
    OpenMap.show({
      latitude: lat,
      longitude: lon,
      latitudeDelta: 0.01,
      longitudeDelta: 0.03,
    });
  }

  render() {
    const { navigation } = this.props;
    let lati = this.state.Latitude;
    let lon = this.state.Longitude;


    if (lati === NaN && lati === null) {
      lati = 0;
      lon = 0;
    }
    const doctorsindex = this.props.navigation.getParam('index');
    let data = this.props.specialityList[doctorsindex];
   // console.log(data.Doctor);
   if(data==undefined){
    data=this.props.navigation.getParam('Data');

   }
    else if(data.Doctor == undefined){
      data=this.props.navigation.getParam('Data');
      console.log(data);
    }
    //console.log(data);
    const commentid = 'Comment_'+this.state.userid;
    const usercomment = data[commentid];

    return (
      <ScrollView style={{backgroundColor:'#cacaca'}}>
        <KeyboardAvoidingView>
          <View style={styles.container}>
            <View style={styles.topContainer}>
              <View style={styles.imageContainer}>
                <Image source={DoctorImage} style={styles.image} />
              </View>
              <View style={styles.InfoConatiner}>
                <Text style={{ fontSize: 20, marginTop: 10 }}>{data.Doctor}</Text>
                <Text style={{ marginTop: 5 }}>{data.Speciality}</Text>

                
                <View style={{ height: 20, width: 100, marginTop: 5 }}>
                  <StarRating
                    starSize={15}
                    emptyStar={'ios-star-outline'}
                    fullStar={'ios-star'}
                    halfStar={'ios-star-half'}
                    iconSet={'Ionicons'}
                    disabled
                    maxStars={5}
                    rating={this.state.starCount}
                    fullStarColor={'#fcba03'}
                  />
                </View>

              </View>
            </View>
          </View>
          <View style={{backgroundColor:'white',marginTop: 10}}>
             <Text style={{ borderWidth: 0, borderBottomWidth: 0, borderColor: 'gray', margin: 0, padding: 5, fontSize: 18, fontWeight: 'bold', marginBottom: 0, color:'blue' }}> Introduction </Text>
              <Text style={{ borderWidth: 0, borderColor: 'gray', padding: 8, fontSize: 16, marginHorizontal: 0 }}>{data.Description}</Text>
             <View style={{borderWidth:0.5,borderColor:'gray',marginHorizontal:10}}/>
          </View>
          <View style={{backgroundColor:'white',marginTop: 0}}>
             <Text style={{ borderWidth: 0, borderBottomWidth: 0, borderColor: 'gray', margin: 0, padding: 5, fontSize: 18, fontWeight: 'bold', marginBottom: 0, color:'blue' }}> Specializations </Text>
             <Text style={{ borderWidth: 0, borderColor: 'gray', padding: 8, fontSize: 16, marginHorizontal: 0 }}>{data.Speciality}</Text>
             <View style={{borderWidth:0.5,borderColor:'gray',marginHorizontal:10}}/>
          </View>
          <View style={{backgroundColor:'white',marginTop: 0}}>
             <Text style={{ borderWidth: 0, borderBottomWidth: 0, borderColor: 'gray', margin: 0, padding: 5, fontSize: 18, fontWeight: 'bold', marginBottom: 0, color:'blue' }}> Qualification </Text>
             <Text style={{ borderWidth: 0, borderColor: 'gray', padding: 8, fontSize: 16, marginHorizontal: 0 }}>{data.Qualification}</Text>
             <View style={{borderWidth:0.5,borderColor:'gray',marginHorizontal:10}}/>
          </View>
          <View style={{backgroundColor:'white',paddingBottom: 5}}>
             <Text style={{ borderWidth: 0, borderBottomWidth: 0, borderColor: 'gray', margin: 0, padding: 5, fontSize: 18, fontWeight: 'bold', marginBottom: 0, color:'blue' }}> Experience </Text>
             <Text style={{ borderWidth: 0, borderColor: 'gray', padding: 8, fontSize: 16, marginHorizontal: 0 }}>{data.Experience} yrs</Text>
             <View style={{borderWidth:0.5,borderColor:'gray',marginHorizontal:10}}/>
          </View>

      {usercomment==undefined ? 
       <View style={{backgroundColor:'white',marginTop:10}}>
       <Text style={{ borderWidth: 0, borderBottomWidth: 0, borderColor: 'gray', margin: 0, padding: 5, fontSize: 18, fontWeight: 'bold', marginBottom: 0, color:'blue' }}> Review </Text>
        

<View style={{ padding: 0, paddingTop: 0,flexDirection:'row',height:35 }}>
         <TextInput
           style={{ width: '80%', borderColor: 'gray', borderWidth: 1,padding:5 }}
           onChangeText={text => this.setState({ firstInput: text })}
           // value={this.state.firstInput}
           placeholder='Enter your review'
         />

         <View style={{width:'20%'}}>
         <Button
           title="Add"
           color="#CF123D"
           onPress={() => this.OnAddReview(this.state.firstInput, data.Speciality, navigation.getParam('index'))}
         />
         </View>
         
       </View>
       <View style={{marginHorizontal:100,marginVertical:10}}>
       <Button
           title="All Reviews"
           color="#f194ff"
           onPress={() => this.onButtonPress(navigation.getParam('index'),navigation.getParam('Data'))}
         />
       </View>
       
    </View>


      : 
      <View style={{backgroundColor:'white',marginTop:10}}>
      <Text style={{ borderWidth: 0, borderBottomWidth: 0, borderColor: 'gray', margin: 0, padding: 5, fontSize: 18, fontWeight: 'bold', marginBottom: 0, color:'blue' }}> Review </Text>
      <View style={{marginHorizontal:100,marginVertical:10}}>
       <Button
           title="All Reviews"
           color="#f194ff"
           onPress={() => this.onButtonPress(navigation.getParam('index'),navigation.getParam('Data'))}
         />
       </View>
      </View>
    }
         
       <View style={{backgroundColor:'white',marginTop:10,paddingVertical:10}}>
          <Text style={{ borderWidth: 0, borderBottomWidth: 0, borderColor: 'gray', margin: 0, padding: 5, fontSize: 18, fontWeight: 'bold', marginBottom: 0, color:'blue' }}> Rate this Doctor </Text>
          <View style={{width:'100%',alignItems:'center'}}>
          <View style={{width:'50%'}}>
          <StarRating
          starSize={35}
              disabled={false}
              maxStars={5}
              emptyStar={'ios-star-outline'}
                    fullStar={'ios-star'}
                    halfStar={'ios-star-half'}
                    iconSet={'Ionicons'}
              fullStarColor={'green'}
              rating={this.state.userRate}
              selectedStar={(rating) => this.onStarRatingPress(rating, data.Speciality, navigation.getParam('index'),data)}
            />
          </View>
         
          </View>
          
        </View>
         
          <View style={{backgroundColor:'white',marginTop:10}}>
          <Text style={{ borderWidth: 0, borderBottomWidth: 0, borderColor: 'gray', margin: 0, padding: 5, fontSize: 18, fontWeight: 'bold', marginBottom: 0, color:'blue' }}> Location </Text>
            <View style={[styles.container1]}>

              <MapView
                style={styles.map}
                onPress={() => this._goToYosemite(data.Latitude, data.Longitude)}
                initialRegion={{
                  latitude: this.state.Latitude,
                  longitude: this.state.Longitude,
                  latitudeDelta: 0.0043,
                  longitudeDelta: 0.0034,
                }}
              >


                <MapView.Marker
                  coordinate={{
                    latitude: this.state.Latitude,
                    longitude: this.state.Longitude
                  }}
                  onPress={() => this._goToYosemite(data.Latitude, data.Longitude)}
                />


              </MapView>
           
            </View>

          </View>

        </KeyboardAvoidingView>
      </ScrollView>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#41cdfa',
    shadowOffset: { width: 0, height: 3 },
    shadowOpacity: 0.2,
    shadowRadius: 2,
    elevation: 1,
    marginLeft: 0,
    marginRight: 0,
    marginTop: 0,
    marginBottom: 5,
  },
  container1: {
    backgroundColor: '#cacaca',
    borderWidth: 1,
    borderColor: 'gray',
    shadowOffset: { width: 0, height: 3 },
    shadowOpacity: 0.2,
    shadowRadius: 2,
    elevation: 1,
    marginLeft: 15,
    marginRight: 15,
    // marginTop: 10,
    marginBottom: 5,
    // padding: 10,
    paddingTop: 0
  },
  image: {
    width: 90,
    height: 90
  },
  imageContainer: {
    alignItems: 'flex-start',
    borderWidth: 1,
    borderRadius: 70,
    padding: 2,
    borderColor: '#bababa'
  },
  topContainer: {
    flexDirection: 'row',
    marginTop: 10,
    marginBottom: 10,
    marginLeft: 10
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
    marginTop: 4
  },
  IconContainer: {
    padding: 5
  },
  name: {
    fontSize: 22,
    textAlign: 'center',
    fontWeight: 'bold',
  },
  body: {
    marginTop: 0,
  },
  bodyContent: {
    //flex: 1,
    // alignItems: 'center',
    padding: 30,
  },
  info: {
    fontSize: 16,
    color: '#00BFFF',
    marginTop: 10
  },
  description: {
    fontSize: 16,
    color: '#696969',
    marginTop: 10,
    textAlign: 'center'
  },
  map: {
    height: 150,
    width: '100%'
  }
});


const mapStateToProps = state => {
  const specialityList = _.map(state.doctorReducer);
  return { specialityList };
};

//export default connect(mapStateToProps, { GetData })(search);

export default connect(mapStateToProps, { AddReviews, AddRating, UpdateRating })(DoxtorsDetails);

