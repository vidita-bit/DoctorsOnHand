/* eslint-disable import/no-unresolved */
import React, { Component } from 'react';
import { Text, Button, View, TextInput, StyleSheet, TouchableOpacity, Alert, Image, ScrollView } from 'react-native';
import { Actions } from 'react-native-router-flux';
import { Field, reduxForm } from 'redux-form';
import { compose } from 'redux';
import { connect } from 'react-redux';
import firebase from 'firebase';
import NetInfo from '@react-native-community/netinfo';
import Spinner from 'react-native-loading-spinner-overlay';
//import {createNewUser } from '../actions/auth.actions';
import { ErrorUtils } from '../actions/auth.utils';
import RadioForm, {
    RadioButton,
    RadioButtonInput,
    RadioButtonLabel,
  } from 'react-native-simple-radio-button';
  
import InputText from './InputText';
//import { breakStatement } from '@babel/types';
import Logo from './icons/Logo2.png';
import placeholderemail from './icons/envelope.png';
import placeholderPassword from './icons/padlock.png';
import placeholderPhone from './icons/phone-contact.png';
import placeholderAddress from './icons/address.png';
const radio_props = [{label: 'Users', value: 0}, {label: 'Doctor', value: 1}];

// const styles = StyleSheet.create(
//     {
//         container: {
//             width: 350,
//             height: 'auto',
//             shadowColor: '#000',
//             shadowOffset: {
//                 width: 0,
//                 height: 2,

//             },
//             shadowOpacity: 0.23,
//             shadowRadius: 2,
//             elevation: 2,
//             borderWidth: 0,
//             marginTop: 100,
//             marginLeft: 30,


//         },
//         input: {
//             width: 320,
//             height: 45,
//             marginTop: 20,
//             marginLeft: 15,
//             borderRadius: 5,
//             borderWidth: 0.7,
//             borderColor: '#c2c2c2',
//             color: 'red',
//             fontSize: 15,
//             paddingLeft: 10,

//         },
//         errorText: {
//             color: 'red',
//             fontSize: 15,
//             paddingLeft: 20


//         }


//     });

const styles = StyleSheet.create({
    button: {
      alignItems: 'center',
      backgroundColor: 'red',
      padding: 17,
      marginBottom:10,
      borderRadius:25,
      marginTop: 8
    },
    button1: {
      alignItems: 'center',
      backgroundColor: 'white',
      padding: 17,
      marginBottom:10,
      borderRadius:25,
      borderWidth:1,
      borderColor:'red'
    },
    backgroundImage: { 
        flex: 1,
        alignSelf: 'stretch',
        width: null
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
        margin:5,
        marginBottom:10
      },
     
      ImageStyle: {
        padding: 10,
        margin: 5,
        marginRight:20,
        height: 25,
        width: 25,
        resizeMode: 'stretch',
        alignItems: 'center',
      },
      errorText: {
                    color: 'red',
                    fontSize: 15,
                    paddingLeft: 20      
                }
  })

class SignUp extends Component {
    state = { loading: false,value:0 }

    selected=async(name, email, password, confirmpassword )=> {
       const  user=await firebase.auth().currentUser.uid
    //alert(user);
    
          if (user) {
            if (this.state.value === 1) {
              //var user  = firebase.auth().currentUser;
              const ref = firebase.database().ref(`doctor/${user}`);
              ref.update({
                name: name,
                email: email,
                password: password,
              });
              Actions.phoneA({value: this.state.value,userid: user});
            } else {
              const ref = firebase.database().ref(`Users/${user}`);
              ref.update({
                name: name,
    
                email: email,
                password: password,
              });
              Actions.phoneA({value: this.state.value,userid: user});
            }
          }
        
        if (Actions.newPage) {
          setTimeout(() => {
            this.setState({loading: false});
          }, 2000);
        }
      }
     
    onSubmit = (values) => {
        // NetInfo.isConnected.fetch().then(state => {
        //     if(!state.isConnected)
        //     {
        //         this.setState({loading:false })
        //         alert('Internet is not connected');
              
             
        //     } });
       
      
        if (values.password === values.confirmpassword) {
            this.setState({loading: true });
        
            firebase.auth().createUserWithEmailAndPassword(values.email, values.password)
            .then((user)=> {
                //alert(user.uid);
                this.selected(
                    values.name,
                    values.email,
                    values.password,
                    values.confirmpassword,
                  )
            }   
              ).catch(error => {
                const reg = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
                if (reg.test(values.email) === false) {
                    console.log('Email is Not Correct');
                  }
                    
  
                    switch (error.code) {
                        case 'auth/email-already-in-use':
                            alert('Email address already in use.');
                            break;
                        case 'auth/invalid-email':
                            alert(`Email address is invalid.`);
                            break;
                        case 'auth/operation-not-allowed':
                        alert(`Error during sign up.`);
                            break;
                        // case 'auth/weak-password':
                        //     alert('Password is not strong enough. Add additional characters including special characters and numbers.');
                        //     break;
                        default:
                            console.log(error.message);
                    }
                });
           
                //  alert(values);
                // this.createNewUser(values);
            } else {
            alert('passwords are not matching');
        }
        if (Actions.newPage) {
            setTimeout(() => {
                this.setState({ loading: false });
            }, 2000);

        }


        //alert(values.InputText);
    }


    goBack() {
        Actions.pop();
    }

    renderTextInput = (field) => {
        const { meta: { touched, error }, label, secureTextEntry, maxLength,placeholderimage, keyboardType, placeholder, input: { onChange, ...restInput } } = field;
        return (
            <View>
                          {/* <TextInput
                    style={{flex:1 }}
                    placeholderTextColor="#d1d1d1" 
                    underlineColorAndroid="transparent"
                    onChangeText={onChange}
                    maxLength={maxLength}
                    placeholder={placeholder}
                    keyboardType={keyboardType}
                    secureTextEntry={secureTextEntry}
                    label={label}
                    {...restInput}
                 /> */}
     <View style={styles.SectionStyle}>
          <Image
            source={placeholderimage}
            style={styles.ImageStyle}
          />
          <TextInput
                    style={{flex:1 }}
                    placeholderTextColor="#d1d1d1" 
                    underlineColorAndroid="transparent"
                    onChangeText={onChange}
                    maxLength={maxLength}
                    placeholder={placeholder}
                    keyboardType={keyboardType}
                    secureTextEntry={secureTextEntry}
                    label={label}
                    {...restInput} />
          
        </View>
        {(touched && error) && <Text style={styles.errorText}>{error}</Text>}

        </View>
        );
    }

    render(){
        const { handleSubmit } = this.props;
        return(
          <View>
               <Spinner
                    //visibility of Overlay Loading Spinner
                    visible={this.state.loading}
                    //Text with the Spinner 
                    textContent={'Loading...'}
                    //Text style of the Spinner Text
                    textStyle={styles.spinnerTextStyle}
                />
                <View style={{backgroundColor:'rgb(255,0,0)'}}>
                <View style={{
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        marginBottom: 100,
        marginTop: 50
      }}>
<Image source={Logo}
              style={{width: 250, height: 120, resizeMode:'contain'}} />
      </View>
               
             
              </View>
              {/* kkk */}
                <View style={{width:'100%',justifyContent:'center',alignItems:'center',top:140}}>
                <View style={{backgroundColor:'rgb(255,255,255)',position: 'absolute',
   
     borderColor:'#d1d1d1', borderWidth:1, borderRadius:20, padding:30,width:'90%'}}>
         
          <Field name='name' placeholder="Name" placeholderimage={placeholderemail} component={this.renderTextInput} />

          
          <Field name="email" keyboardType="email-address" label="Email: " placeholderimage={placeholderemail} placeholder="Email" component={this.renderTextInput} />
                     <Field secureTextEntry name="password" placeholder="Password" component={this.renderTextInput}  placeholderimage={placeholderPassword} />
                     <Field secureTextEntry name="confirmpassword" placeholder="Confirm Password" component={this.renderTextInput}  placeholderimage={placeholderPassword}/>
                     <RadioForm
            radio_props={radio_props}
            initial={0}
            labelStyle={{marginLeft: 0, marginRight: 100}}
            style={{marginLeft: 0, marginTop: 20}}
            formHorizontal
            labelHorizontal
            onPress={value => {
              this.setState({value});
            }}
          />

       
               
                 <TouchableOpacity style={styles.button} onPress={handleSubmit(this.onSubmit)}>
                 <Text style={{color:'white', fontWeight:'bold',fontSize:16}}> SIGN UP </Text>
             </TouchableOpacity>
         </View>
    
                </View>
      
          </View>
                           
                    )
    }
    // render() {
    //     const { handleSubmit } = this.props;
    //     return (


    //         <View>
    //             <Spinner
    //                 //visibility of Overlay Loading Spinner
    //                 visible={this.state.loading}
    //                 //Text with the Spinner 
    //                 textContent={'Loading...'}
    //                 //Text style of the Spinner Text
    //                 textStyle={styles.spinnerTextStyle}
    //             />

    //             <View style={styles.container}>

    //                 <Field name='name' placeholder="Name" component={this.renderTextInput} />
    //                 <Field name="email" keyboardType="email-address" label="Email: " placeholder="Email" component={this.renderTextInput} />
    //                 <Field secureTextEntry name="password" placeholder="Password" component={this.renderTextInput} />
    //                 <Field secureTextEntry name="confirmpassword" placeholder="Confirm Password" component={this.renderTextInput} />

    //                 <View style={[{ position: 'relative', width: '50%', overflow: 'hidden', marginTop: 20, marginBottom: 10, marginHorizontal: 85, color: '#ffffff', borderRadius: 40, borderWidth: 0 }]}>
    //                     <Button
    //                         onPress={handleSubmit(this.onSubmit)}

    //                         title="Sign Up"
    //                         color="#004D40"


    //                     />


    //                 </View>


    //             </View>
    //             <View style={{ flexDirection: 'row', marginVertical: 60 }}>
    //                 <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center', flexDirection: 'row', fontWeight: '500', }}>

    //                     <Text style={{ color: 'rgba(0,0,0,0.4)', fontSize: 18 }} >Already have an account? </Text>
    //                     <TouchableOpacity onPress={this.goBack}><Text style={{ fontSize: 18, color: 'blue' }}>Signin</Text></TouchableOpacity>
    //                 </View>
    //             </View>
    //         </View>


    //     );
    // }


}


const validate = (values) => {
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
    connect(null, null),
    reduxForm({
        form: 'register',
        validate
    })
)(SignUp);
