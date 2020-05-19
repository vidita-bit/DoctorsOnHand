/* eslint-disable react-native/no-inline-styles */
//Open forgot Password by getting email from user
import React, {Component} from 'react';
import firebase from 'firebase';
import Logo from './icons/Logo1.jpg';
import placeholderemail from './icons/envelope.png';
//import placeholderPassword from './icons/padlock.png';

import {
  View,
  StyleSheet,
  StatusBar,
  Text,
  TouchableOpacity,
  Button,
  Image,
  TextInput,
} from 'react-native';
import InputText from './InputText';

export default class FPassword extends Component {
  constructor(props) {
    super(props);
    this.state = {
      TextInputName: '',
      TextInputEmail: '',
    };
  }
  passw = yourEmail => {
    //firebase will send email to the user to change password
    firebase
      .auth()
      .sendPasswordResetEmail(yourEmail)
      .then(function(user) {
        // eslint-disable-next-line no-alert
        alert('Please check your email...'); //alert to tell user to check email
      })
      .catch(e => {
        console.log(e); //error to check
      });
  };
  render() {
    return (
      <View>
        <View style={{backgroundColor: 'rgb(255,0,0)'}}>
          <View
            style={{
              flexDirection: 'row',
              justifyContent: 'center',
              alignItems: 'center',
              marginBottom: 140,
              marginTop: 70,
            }}>
            <Image
              source={Logo}
              style={{width: 250, height: 120, resizeMode: 'contain'}}
            />
          </View>
        </View>
        <View
          style={{
            width: '100%',
            position: 'absolute',
            top: 250,
            justifyContent: 'center',
            alignItems: 'center',
          }}>
          <View
            style={{
              backgroundColor: 'rgb(255,255,255)',
              borderColor: '#d1d1d1',
              borderWidth: 1,
              borderRadius: 20,
              padding: 30,
              width: '90%',
              height: 200,
            }}>
            <View style={styles.SectionStyle}>
              <Image
                //email placeholder
                source={placeholderemail}
                style={styles.ImageStyle}
              />
              <TextInput
                style={{flex: 1}}
                placeholder="Email"
                placeholderTextColor="#d1d1d1"
                underlineColorAndroid="transparent"
                onChangeText={TextInputEmail => this.setState({TextInputEmail})}
              />
            </View>

            <TouchableOpacity
              //Confirm button when this button is pressed it will call the function
              style={styles.button}
              onPress={this.passw(this.state.TextInputEmail)}>
              <Text style={{color: 'white', fontWeight: 'bold', fontSize: 16}}>
                {' '}
                CONFIRM{' '}
              </Text>
            </TouchableOpacity>
          </View>
        </View>
      </View>
    );
  }
}
//styles apply on this page
const styles = StyleSheet.create({
  button: {
    alignItems: 'center',
    backgroundColor: 'red',
    padding: 17,
    marginBottom: 10,
    borderRadius: 25,
  },
  button1: {
    alignItems: 'center',
    backgroundColor: 'white',
    padding: 17,
    marginBottom: 10,
    borderRadius: 25,
    borderWidth: 1,
    borderColor: 'red',
  },
  backgroundImage: {
    flex: 1,
    alignSelf: 'stretch',
    width: null,
  },
  SectionStyle: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
    borderWidth: 1,
    borderColor: '#d1d1d1',
    height: 50,
    borderRadius: 15,
    margin: 5,
    marginBottom: 10,
  },

  ImageStyle: {
    padding: 10,
    margin: 5,
    marginRight: 20,
    height: 25,
    width: 25,
    resizeMode: 'stretch',
    alignItems: 'center',
  },
});
