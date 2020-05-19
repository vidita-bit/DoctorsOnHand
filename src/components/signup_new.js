/* eslint-disable no-alert */
/* eslint-disable react-native/no-inline-styles */
import React, {Component} from 'react';
import {Text, Button, View, StyleSheet, TouchableOpacity} from 'react-native';
import {Actions} from 'react-native-router-flux';
import {Field, reduxForm} from 'redux-form';
import {compose} from 'redux';
import {connect} from 'react-redux';
import firebase from 'react-native-firebase';
import NetInfo from '@react-native-community/netinfo';
import RadioForm, {
  RadioButton,
  RadioButtonInput,
  RadioButtonLabel,
} from 'react-native-simple-radio-button';
import Spinner from 'react-native-loading-spinner-overlay';
import InputText from './InputText';

const radio_props = [{label: 'Patient', value: 0}, {label: 'Doctor', value: 1}];

const styles = StyleSheet.create({
  container: {
    width: 350,
    height: 'auto',
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.23,
    shadowRadius: 2,
    elevation: 2,
    borderWidth: 0,
    marginTop: 100,
    marginLeft: 30,
  },
  input: {
    width: 320,
    height: 45,

    marginTop: 20,
    marginLeft: 15,
    borderRadius: 5,
    borderWidth: 0.7,
    borderColor: '#c2c2c2',
    color: 'red',
    fontSize: 15,
    paddingLeft: 10,
  },
  errorText: {
    color: 'red',
    fontSize: 15,
    paddingLeft: 20,
  },
});

class SignUp extends Component {
  state = {loading: false, value: 0};
componentWillMount(){
  console.log('Sign In');
}
  selected(name, email, password, confirmpassword) {
    firebase.auth().onAuthStateChanged(user => {
      if (user) {
        if (this.state.value === 1) {
          //var user  = firebase.auth().currentUser;
          const ref = firebase.database().ref(`doctor/${user.uid}`);
          ref.update({
            name: name,
            email: email,
            password: password,
          });
          Actions.phoneA({value: this.state.value});
        } else {
          const ref = firebase.database().ref(`patient/${user.uid}`);
          ref.update({
            name: name,

            email: email,
            password: password,
          });
          Actions.phoneA({value: this.state.value});
        }
      }
    });
    if (Actions.newPage) {
      setTimeout(() => {
        this.setState({loading: false});
      }, 2000);
    }
  }
  onSubmit = values => {
    NetInfo.fetch().then(state => {
      //console.log("Connection type", state.type);
      //console.log("Is connected?", state.isConnected);
      if (!state.isConnected) {
        alert('Internet is not connected');
        InternetConnectionFail(dispatch);
      } else {
        alert('Login falied!');
      }
      //   }
      // NetInfo.isConnected.fetch().then(isConnected => {
      //     if (!isConnected) {
      //         this.setState({ loading: false });
      //         alert('Internet is not connected');
      //     }
    });
    if (values.password !== values.confirmpassword) {
      alert('passwords are not matching');
    } else {
     // console.log(firebase.auth());

      firebase
        .auth()
        .createUserWithEmailAndPassword(values.email, values.password)
        .then(
          this.selected(
            values.name,
            values.email,
            values.password,
            values.confirmpassword,
          ),
        )
        .catch(error => {
          alert(error.message);

          // const reg = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
          if (reg.test(values.email) === false) {
            console.log('Email is Not Correct');
          }

          switch (error.code) {
            case 'auth/email-already-in-use':
              alert('Email address already in use.');
              break;
            case 'auth/invalid-email':
              alert('Email address is invalid.');
              break;
            case 'auth/operation-not-allowed':
              alert('Error during sign up.');
              break;
            // case 'auth/weak-password':
            //     alert('Password is not strong enough. Add additional characters including special characters and numbers.');
            //     break;
            default:
              console.log(error.message);
          }
        });
    }

    //  alert(values);
    // this.createNewUser(values);

    //alert(values.InputText);
  };

  goBack() {
    Actions.pop();
  }

  renderTextInput = field => {
    const {
      meta: {touched, error},
      label,
      secureTextEntry,
      maxLength,
      keyboardType,
      placeholder,
      input: {onChange, ...restInput},
    } = field;
    return (
      <View>
        <InputText
          onChangeText={onChange}
          maxLength={maxLength}
          placeholder={placeholder}
          keyboardType={keyboardType}
          secureTextEntry={secureTextEntry}
          label={label}
          {...restInput}
        />
        {touched && error && <Text style={styles.errorText}>{error}</Text>}
      </View>
    );
  };
  render() {
    const {handleSubmit} = this.props;
    return (
      <View>
        <Spinner
          //visibility of Overlay Loading Spinner
          visible={this.state.loading}
          //Text with the Spinner
          textContent={'Loading...'}
          //Text style of the Spinner Text
          textStyle={styles.spinnerTextStyle}
        />

        <View style={styles.container}>
          <Field
            name="name"
            placeholder="Name"
            component={this.renderTextInput}
          />
          <Field
            name="email"
            keyboardType="email-address"
            label="Email: "
            placeholder="Email"
            component={this.renderTextInput}
          />
          <Field
            secureTextEntry
            name="password"
            placeholder="Password"
            component={this.renderTextInput}
          />
          <Field
            secureTextEntry
            name="confirmpassword"
            placeholder="Confirm Password"
            component={this.renderTextInput}
          />
          <RadioForm
            radio_props={radio_props}
            initial={0}
            labelStyle={{marginLeft: 0, marginRight: 100}}
            style={{marginLeft: 50, marginTop: 20}}
            formHorizontal
            labelHorizontal
            onPress={value => {
              this.setState({value});
            }}
          />
          <View
            style={[
              {
                position: 'relative',
                width: '50%',
                overflow: 'hidden',
                marginTop: 20,
                marginBottom: 10,
                marginHorizontal: 85,
                color: '#ffffff',
                borderRadius: 40,
                borderWidth: 0,
              },
            ]}>
            <Button
              onPress={handleSubmit(this.onSubmit)}
              title="Sign Up"
              color="#004D40"
            />
          </View>
        </View>
        <View style={{flexDirection: 'row', marginVertical: 60}}>
          <View
            style={{
              flex: 1,
              justifyContent: 'center',
              alignItems: 'center',
              flexDirection: 'row',
              fontWeight: '500',
            }}>
            <Text style={{color: 'rgba(0,0,0,0.4)', fontSize: 18}}>
              Already have an account?{' '}
            </Text>
            <TouchableOpacity onPress={this.goBack}>
              <Text style={{fontSize: 18, color: 'blue'}}>Signin</Text>
            </TouchableOpacity>
          </View>
        </View>
      </View>
    );
  }
}


const validate = values => {
  const errors = {};
  if (!values.name) {
    errors.name = 'Name is required';
  }
  if (!values.email) {
    errors.email = 'Email is required';
  }
  if (!values.password) {
    errors.password = 'Password is required';
  }
  if (!values.confirmpassword) {
    errors.confirmpassword = 'Confirm Password is required';
  }
  return errors;
};

export default compose(
  connect(
    null,
    null,
  ),
  reduxForm({
    form: 'Register',
    validate,
  }),
)(SignUp);
