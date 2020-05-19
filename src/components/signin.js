//Sign in Page for user and doctors
import React, {Component} from 'react';
import {
  Text,
  View,
  StyleSheet,
  Button,
  TouchableOpacity,
  state,
  Image,
  TextInput,
} from 'react-native';
import {Actions} from 'react-native-router-flux';
import {Field, reduxForm} from 'redux-form';
import {compose} from 'redux';
import {connect} from 'react-redux';
import firebase from 'firebase';
import NetInfo from '@react-native-community/netinfo';
import Spinner from 'react-native-loading-spinner-overlay';
import Logo from './icons/Logo2.png';
import placeholderemail from './icons/envelope.png';
import placeholderPassword from './icons/padlock.png';


class SignIn extends Component {
  state = {loading: false}; //Initalize loader to false
  check = values => {
    firebase.auth().onAuthStateChanged(user => {
      if (user === undefined) {
        alert('No user found');
      } else {
        //alert('HHH');
        firebase
          .database()
          .ref('Users/' + user.uid)
          .once('value')
          .then(snapshot => {
            if (snapshot.val() != null) {
              //alert(user)
              //navigate to user phone authentication
              //this.setState({ loading: false });
              Actions.newPage();
            } else {
              //    var phone =  ((snapshot.val() && snapshot.val().phone) || 'Anonymous')
              //     alert(phone)
              firebase
                .database()
                .ref('doctor/' + user.uid)
                .once('value')
                .then(snapshot => {
                  if (snapshot.val() != null) {
                    // alert(snapshot.val().experiance);
                    //navigate to doctor phone authentication
                    if (snapshot.val().experiance === undefined) {
                      //	alert('heeje');
                      values.email = '';
                      values.password = '';
                      Actions.createDoctor();
                    } else {
                      values.email = '';
                      values.password = '';
                      Actions.EditDoctor();
                    }
                  } else {
                    alert('No record Found');
                    this.setState({loading: false});
                  }
                });
            }
          });
      }
    });
  };
  onSubmit = values => {
    this.setState({loading: true});
    // setInterval(() => {
    //     this.setState({
    //       //change the state of the laoding in every 3 second
    //       loading: !this.state.loading,
    //     });
    //   }, 30);

    //
    console.log(values.email, values.password);
    firebase
      .auth()
      .signInWithEmailAndPassword(values.email, values.password)
      .then(this.check)
      .catch(() => {
        this.setState({loading: false});
        alert('record not found');
        // NetInfo.isConnected.fetch().then(isConnected => {
        // 	if (!isConnected) {
        // 		alert('Internet is not connected');
        // 	}
        // 	else {
        // 		alert('Login falied!');
        // 	}
        // });
        // eslint-disable-next-line no-param-reassign
        // const newError = new ErrorUtils(error, '');
        // newError.showAlert();

        //alert('sign up first');
        //alert('cool');
      });
    if (Actions.newPage) {
      //console.log(firebase.auth().currentUser.uid);
      console.log(values.email);
      values.email = '';
      values.password = '';
      setTimeout(() => {
        this.setState({loading: false});
      }, 2000);
    }

    // else {
    //     this.setState({ loading: true });
    // }
  };

  signup() {
    Actions.signup();
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
      // <View>
      // 	<InputText
      // 		onChangeText={onChange}
      // 		maxLength={maxLength}
      // 		placeholder={placeholder}
      // 		keyboardType={keyboardType}
      // 		secureTextEntry={secureTextEntry}
      // 		label={label}
      // 		{...restInput}
      // 	/>
      // 	{(touched && error) && <Text style={styles.errorText}>{error}</Text>}
      // </View>
      <View>
        <View style={styles.SectionStyle}>
          <Image
            //We are showing the Image from online
            source={placeholderemail}
            style={styles.ImageStyle}
          />
          <TextInput
            onChangeText={onChange}
            maxLength={maxLength}
            placeholder={placeholder}
            keyboardType={keyboardType}
            secureTextEntry={secureTextEntry}
            label={label}
            {...restInput}
            style={{flex: 1}}
            // placeholder='Email'
            placeholderTextColor="#d1d1d1"
            underlineColorAndroid="transparent"
          />
        </View>
        {touched && error && <Text style={styles.errorText}>{error}</Text>}
      </View>
    );
  };

  renderTextInput1 = field => {
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
        <View style={styles.SectionStyle}>
          <Image source={placeholderPassword} style={styles.ImageStyle} />
          <TextInput
            onChangeText={onChange}
            maxLength={maxLength}
            placeholder={placeholder}
            keyboardType={keyboardType}
            secureTextEntry={secureTextEntry}
            label={label}
            {...restInput}
            style={{flex: 1}}
            // placeholder='Email'
            placeholderTextColor="#d1d1d1"
            underlineColorAndroid="transparent"
          />
        </View>
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
        <View style={{backgroundColor: 'rgb(255,0,0)'}}>
          <View
            style={{
              flexDirection: 'row',
              justifyContent: 'center',
              alignItems: 'center',
              marginBottom: 140,
              marginTop: 70,,
            }}>
            <Image
              source={Logo}
              style={{width: 250, height: 120, resizeMode: 'contain'}}
            />
          </View>
        </View>
        <View
          style={{
            position: 'absolute',
            top: 250,
            justifyContent: 'center',
            alignItems: 'center',
            width: '100%',
          }}>
          <View
            style={{
              backgroundColor: 'rgb(255,255,255)',
              borderColor: '#d1d1d1',
              borderWidth: 1,
              borderRadius: 20,
              padding: 30,
              width: '90%',,
            }}>
            <Field
              name="email"
              placeholder="Email"
              keyboardType="email-address"
              component={this.renderTextInput}
            />

            <Field
              name="password"
              placeholder="Password"
              secureTextEntry
              component={this.renderTextInput1}
            />

            <TouchableOpacity
              style={{flexDirection: 'row', marginTop: 10, marginBottom: 15}}
              onPress={Actions.fpassword}>
              <Text
                style={{
                  color: '#d1d1d1',
                  alignSelf: 'flex-start',
                  width: '50%',
                }}
              />
              <Text
                style={{color: 'red', alignSelf: 'flex-start', width: '50%'}}>
                Forgot Password?
              </Text>
            </TouchableOpacity>

            <TouchableOpacity
              style={styles.button}
              onPress={handleSubmit(this.onSubmit)}>
              <Text style={{color: 'white', fontWeight: 'bold', fontSize: 16}}>
                {' '}
                LOGIN{' '}
              </Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.button1} onPress={this.signup}>
              <Text style={{color: 'red', fontWeight: 'bold', fontSize: 16}}>
                {' '}
                CREATE ACCOUNT{' '}
              </Text>
            </TouchableOpacity>
          </View>
        </View>
      </View>

      // <View>

      // 	< View style={styles.container}>

      // 		<Field name="email" placeholder="Email" keyboardType="email-address" component={this.renderTextInput} />
      // 		<Field name="password" placeholder="Password" secureTextEntry component={this.renderTextInput} />

      // 		<View style={[{ width: '50%', overflow: 'hidden', marginTop: 30, marginHorizontal: 85, color: '#ffffff', borderRadius: 40, borderWidth: 0 }]}>

      // 			{/* <Spinner visible={this.state.loading} textContent={'Loading...'}>    */}
      // 			<Button
      // 				onPress={handleSubmit(this.onSubmit)}
      // 				title="Sign In"
      // 				color="#004D40"

      // 			/>

      // 		</View>

      // 		<View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      // 			<TouchableOpacity onPress={Actions.fpassword}><Text style={{ fontSize: 18, color: '#388E3C' }}> Forgot Password?</Text></TouchableOpacity></View>
      // 	</View>
      // 	<View style={{ flexDirection: 'row', marginVertical: 30 }}>
      // 		<View style={{ flex: 1, justifyContent: 'center', alignItems: 'center', flexDirection: 'row' }}>
      // 			<Text style={{ color: 'rgba(0,0,0,0.4)', fontSize: 18 }}>Don't have any account?</Text>
      // 			<TouchableOpacity onPress={this.signup}><Text style={{ fontSize: 18, color: 'blue' }}> Signup here</Text></TouchableOpacity>
      // 		</View>
      // 	</View>
      // </View>
    );
  }
}

// const styles = StyleSheet.create(
// 	{
// 		container: {
// 			width: 350,
// 			height: 280,
// 			shadowColor: '#000',
// 			shadowOffset: {
// 				width: 0,
// 				height: 2,
// 			},
// 			shadowOpacity: 0.23,
// 			shadowRadius: 2,
// 			elevation: 2,
// 			borderWidth: 0,
// 			marginTop: 100,
// 			marginLeft: 30

// 		},
// 		input: {
// 			width: 320,
// 			height: 45,
// 			marginTop: 20,
// 			marginLeft: 15,
// 			borderRadius: 5,
// 			borderWidth: 0.7,
// 			borderColor: '#c2c2c2',
// 			fontSize: 18,
// 			paddingLeft: 10
// 		},
// 		errorText: {
// 			color: 'red',
// 			fontSize: 15,
// 			paddingLeft: 20

// 		},
// 		errorText2: {
// 			color: 'blue',
// 			fontSize: 25,
// 			marginLeft: 90

// 		}
// 	});
const styles = StyleSheet.create({
  button: {
    alignItems: 'center',
    backgroundColor: 'red',
    padding: 17,
    marginBottom: 10,
    borderRadius: 25,,
  },
  button1: {
    alignItems: 'center',
    backgroundColor: 'white',
    padding: 17,
    marginBottom: 10,
    borderRadius: 25,
    borderWidth: 1,
    borderColor: 'red',,
  },
  backgroundImage: {
    flex: 1,
    alignSelf: 'stretch',
    width: null,,
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
    marginBottom: 10,,
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
  errorText: {
    color: 'red',
    fontSize: 15,
    paddingLeft: 20,,
  },,
});

const validate = values => {
  const errors = {};

  if (!values.email) {
    errors.email = 'Email is required';
  }
  if (!values.password) {
    errors.password = 'Password is required';
  }
  return errors;
};
export default compose(
  connect(
    null,
    null,
  ),
  reduxForm({
    form: 'Login',
    validate,,
  }),
)(SignIn);
