import React, { Component } from 'react';
import { Text, Button, View, StyleSheet, Picker, Item, WebView,Linking,TextInput } from 'react-native';
import { Actions } from 'react-native-router-flux';
import { Field, reduxForm } from 'redux-form';
import { compose } from 'redux';
import { connect } from 'react-redux';
import * as firebase from 'firebase';
import firestore from 'firebase/firestore';
import NetInfo from '@react-native-community/netinfo';
import InputText from './InputText';
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
            color: 'black'
        }


    });
   
class editDoctor extends Component {
  
    constructor(props) {
        super(props);
        this.state = {
          name: '',
          loading: false,
           enabled: true, 
           phone: '', 
           check: false
        };
      }
      componentWillMount() {
       
            var userId = firebase.auth().currentUser.uid;
           return firebase.database().ref('doctors/' + userId).once('value').then((snapshot) => {
            var username = (snapshot.val() && snapshot.val().name) || 'Anonymous';
            this.setState({ name: username });
            console.log(this.state.name);
              });
         
       
       
       
      }
   
  


   

    // remove listener on unmount 

  
    onSubmit = (values) => {
        var user = firebase.auth().currentUser;
        var ref=firebase.database().ref('doctors/'+user.uid);
        ref.update({
            name: values.name,
            phone: values.phone


        })
        
        NetInfo.isConnected.fetch().then(isConnected => {
            if (!isConnected) {
                this.setState({ loading: false });
                alert('Internet is not connected');
            }
        });
      
       
   
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
        const { meta: { touched, error }, label, secureTextEntry, maxLength,value, keyboardType, placeholder, input: { defaultValue, onChange, ...restInput } } = field;
        return (

            <View>
   
               

                <InputText
              //  value={defaultValue}
                   // defaultValue={this.state.name}
                    onChangeText={onChange}
                    maxLength={maxLength}
                    placeholder={placeholder}
                    keyboardType={keyboardType}
                    secureTextEntry={secureTextEntry}
                    label={label}
                   
                

                    {...restInput}
        >{this.state.name}</InputText>
  
                {(touched && error) && <Text style={styles.errorText}>{error}</Text>}
            </View>
        );
    }
    render() {
        
        const { handleSubmit, value } = this.props;

   

        
        return (
            
            <View>
                <View style={styles.container}>
     <Text>{this.state.name}</Text> 

        <Field name="name"  component={this.renderTextInput}   />
                    <Field name='field' mode="dropdown" component={this.renderPicker}>
                        <Picker.Item label=" please select a field" value={null} color="#9E9E9E" enabled={false} />
                        <Picker.Item label="Urologist" value="urologist" />
                        <Picker.Item label="Dentist" value="dentist" />
                        <Picker.Item label="Psychologist" value="psychologist" />
                    </Field>

                    <Field name='phone'  component={this.renderTextInput} keyboardType={'phone-pad'}  />  
{/*                    
                    <Field name="email" keyboardType="email-address" label="Email: " placeholder="Email" component={this.renderTextInput} />
                    <Field secureTextEntry name="password" placeholder="Password" component={this.renderTextInput} />
                    <Field secureTextEntry name="confirmpassword" placeholder="Confirm Password" component={this.renderTextInput} /> */}

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
const mapStateToProps = (state, props) => ({
    initialValues: props.name, // retrieve name from redux store 
  });
export default connect(
    mapStateToProps
  )(reduxForm({
     form: 'editDoctor', // a unique identifier for this form
    enableReinitialize: true,
    validate
  })(editDoctor));