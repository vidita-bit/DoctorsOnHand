import React, { Component } from 'react';
import { Text, Button, View, StyleSheet, Picker, Item, WebView, Linking } from 'react-native';
import { Actions } from 'react-native-router-flux';
import { Field, reduxForm } from 'redux-form';
import { compose } from 'redux';
import { connect } from 'react-redux';
import * as firebase from 'firebase';
//import firestore from 'firebase/firestore';
import NetInfo from '@react-native-community/netinfo';
import InputText from './InputText';

//const captchaUrl = https://workers-ef768.firebaseapp.com/captcha.html?appurl=${Linking.makeUrl};

//zaheerkhalil2@gmail.com
//zaheer321

// import * as EmailValidator from 'email-validator';

// const phone = require('phone');


console.disableYellowBox = true;


const styles = StyleSheet.create(
    {
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
            paddingLeft: 20


        },
        dropdown: {
            width: 320,
            height: 45,
            //     marginTop: 10,
            //     marginBottom: 15,
            //     marginLeft: 15,
            //     borderRadius: 5,
            //     borderWidth: 0.7,
            //    // borderColor: '#c2c2c2',
            //     fontSize: 18,
            //     paddingLeft: 10,
            color: 'black'
        }


    });

class doctorSignup extends Component {
    state = { loading: false, enabled: true, phoneN: '', check: false }

   
    // remove listener on unmount


    onSubmit = (values) => {
        // const reg = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/i;
        // const pRegix='^((\92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$';
        // const escapedString = escapeStringRegexp(pRegix);

        // const errors = {};
        NetInfo.isConnected.fetch().then(isConnected => {
            if (!isConnected) {
                this.setState({ loading: false });
                alert('Internet is not connected');
            }
        });
        if (values.password.length < 6) {
            alert('password length must be 6 ');
        }
        // if (values.phone.match(pRegix)){
        // }


        if (values.password === values.confirmpassword) {
            this.setState({ loading: true });


        // const phoneReg = '/^((?:00|\+)92)?(0?3(?:[0-46]\d|55)\d{7})$/';

        //    errors.phone = 'fuck';
        //    alert(errors.phone);
      // alert('k');
//       try {
//         firebase.auth().createUserWithEmailAndPassword(values.email, values.password)

firebase.auth().createUserWithEmailAndPassword(values.email, values.password)
.then(Actions.editDoctor)
.catch(e => {
  alert(e.message);
});
// .catch(error => {
//                 switch (error.code) {
//                     case 'auth/email-already-in-use':
//                         alert('Email address already in use.');
//                         break;
//                     case 'auth/invalid-email':
//                         alert('Email address is invalid.');
//                         break;
//                     case 'auth/operation-not-allowed':
//                         alert('Error during sign up.');
//                         break;
//                     // case 'auth/weak-password':
//                     //     alert('Password is not strong enough. Add additional characters including special characters and numbers.');
//                     //     break;
//                     default:
//                         console.log(error.message);
//                 }


//             });
firebase.auth().onAuthStateChanged((user) => {
    //var user  = firebase.auth().currentUser;
    var ref=firebase.database().ref('doctors/'+user.uid);
    ref.update({
        name: values.name,
         phone: values.phone
       });
  });

        
             


        // if (values.phone.match(phoneReg)){
        //   alert('phone number is not corrrect');
        // }


            //  alert(values);
            // this.createNewUser(values);
        } else {
            alert('passwords are not matching');
        }
        // if (Actions.editDoctor) {
        //     setTimeout(() => {
        //         this.setState({ loading: false });
        //     }, 2000);
        // }


        //alert(values.InputText);
    }


    goBack() {
        Actions.pop();
    }


     renderPicker = ({ meta: { touched, error }, input: { onChange, onChangeValue, value, ...inputProps }, children, ...pickerProps }) => (
         <View>
         <View placeholder='yeah' placeholderTextColor="#9E9E9E" style={{ width: 320, height: 45, marginTop: 20, marginLeft: 15, borderRadius: 5, borderWidth: 0.7, borderColor: '#c2c2c2', fontSize: 18, color: '#9E9E9E' }}>
        <Picker

          selectedValue={value}
          onValueChange={value => onChange(value)}
          {...inputProps}
          {...pickerProps}
        >
          { children }


        </Picker>


        </View>
        {(touched && onChange && error) && <Text style={styles.errorText}>{error}</Text>}
        </View>

      );
    renderTextInput = (field) => {
        const { meta: { touched, error }, label, secureTextEntry, maxLength, keyboardType, placeholder, input: { onChange, ...restInput } } = field;
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
                {(touched && error) && <Text style={styles.errorText}>{error}</Text>}
            </View>
        );
    }
    render() {
        const { handleSubmit } = this.props;


        return (

            <View>
                <View style={styles.container}>

                    <Field name='name' placeholder="Name" component={this.renderTextInput} />
                    <Field name='field' mode="dropdown" component={this.renderPicker}>
                        <Picker.Item label=" please select a field" value={null} color="#9E9E9E" enabled={false} />
                        <Picker.Item label="Urologist" value="urologist" />
                        <Picker.Item label="Dentist" value="dentist" />
                        <Picker.Item label="Psychologist" value="psychologist" />
                    </Field>

                    <Field name='phone' placeholder="Phone" component={this.renderTextInput} keyboardType={'phone-pad'} />

                    <Field name="email" keyboardType="email-address" label="Email: " placeholder="Email" component={this.renderTextInput} />
                    <Field secureTextEntry name="password" placeholder="Password" component={this.renderTextInput} />
                    <Field secureTextEntry name="confirmpassword" placeholder="Confirm Password" component={this.renderTextInput} />

                    <View style={[{ position: 'relative', width: '50%', overflow: 'hidden', marginTop: 20, marginBottom: 10, marginHorizontal: 85, color: '#ffffff', borderRadius: 40, borderWidth: 0 }]}>
                        <Button
                            onPress={handleSubmit(this.onSubmit)}

                            title="Register"
                            color="#004D40"

                        />


                    </View>


                </View>
                {/* <View style={{ flexDirection: 'row', marginVertical: 60 }}>
                    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center', flexDirection: 'row', fontWeight: '500', }}>

                        <Text style={{ color: 'rgba(0,0,0,0.4)', fontSize: 18 }} >Already have an account? </Text>
                        <TouchableOpacity onPress={this.goBack}><Text style={{ fontSize: 18, color: 'blue' }}>Signin</Text></TouchableOpacity>
                    </View>
                </View> */}
            </View>


        );
    }
}


const validate = (values) => {
    const errors = {};

    if (!values.name) {
        errors.name = 'Name is required!';
    }
    if (!values.phone) {
        errors.phone = 'Phone no is required!';
    }
    // if(values.phone.maxLength>5){
    //     errors.phone = 'Password';

    // }
    if (!values.email) {
        errors.email = 'Email is required!';
    }
    if (!values.password) {
        errors.password = 'Password is required!';
    }
    if (!values.confirmpassword) {
        errors.confirmpassword = 'Confirm Password is required!';
    }

    if (!values.field) {
        errors.field = 'Field is required!';
    }


    return errors;
};


export default compose(
    connect(null, null),
    reduxForm({
        form: 'doctorSignup',
        // phoneValidate,
        validate,

    })
)(doctorSignup);