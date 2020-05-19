import React, { Component } from 'react';
import { Text, Button, View, StyleSheet, Picker, TouchableOpacity, Label, Image, ImageBackground
 } from 'react-native';
import { Actions } from 'react-native-router-flux';
import { Field, reduxForm } from 'redux-form';
import { compose } from 'redux';
import { connect } from 'react-redux';
import ImagePicker from 'react-native-image-picker';
import * as firebase from 'react-native-firebase';
import firebase1 from 'firebase';
import NetInfo from '@react-native-community/netinfo';
import InputText from './InputText';
import { bool } from 'prop-types';
import camera from '../Images/camera.png';
import DoctorImage from './icons/doctorA.png';
import GoogleMap from './icons/google-maps.jpg';
import Geolocation from '@react-native-community/geolocation';


console.disableYellowBox = true;


const styles = StyleSheet.create(
    {
        container: {
            width: '97%',
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
            alignItems:'center',
            alignSelf:'center',
           // marginLeft: 30,


        },
        avatar: {
            width: 130,
            height: 130,
            borderRadius: 63,
            marginBottom:10,
            alignSelf:'center',
           // position: 'absolute',
           // marginTop:130,
            borderColor:'red',
            borderWidth:4,
            
          },
        input: {
            width: '90%',
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
    let myLat = 0;
    let myLon = 0;
    
class doctorSignup extends Component {
    constructor(props) {
        super(props);
        //const { lat } = this.props;
this.state = { loading: true, enabled: true, experiance: '', field: '', PMDC: '', qualification: '', description: '', check: false, avatarSource: Image.resolveAssetSource(require('./icons/doctorA.png')).uri };
    }

    // remove listener on unmount

  componentWillMount() {
//     NetInfo.isConnected.fetch().then(isConnected => {
//         if (!isConnected) {
//             this.setState({ loading: false });
//             alert(' Please check your Internet connection'); 
// }
//         });
//alert('hhe');
  }
  componentWillReceiveProps(){
   // alert('goof');  
  }
  componentDidMount(){
    //alert('props');  
  }
    onSubmit = (values) => {
        // const errors = {};
       // NetInfo.isConnected.fetch().then(isConnected => {
       //     if (!isConnected) {
       ///         this.setState({ loading: false });
       //         alert('Internet is not connected');
        //    } else
       // let value = 0;
        // firebase
        // .database()
        // .ref('/Speciality/')
        // .on('value', snapshot => {
        //      value = snapShot.numChildren();
        // }); 
        // alert(value);
                    const user = firebase1.auth().currentUser;
                    var ref = firebase.database().ref(`doctor/${user.uid}`);
                    ref.update({
                        experiance: values.experiance,
                         qualification: values.qualification,
                         PMDC: values.PMDC,
                         Specilaity: values.field,
                         description: values.description,
                         avatarSource: this.state.avatarSource.uri,
                        Longitude: myLon,
                        Latitude: myLat,
                       }); 
                
                       Actions.EditDoctor();
             //   }
      //  });
    }


    goBack() {
        Actions.pop();
    }
    choosePhoto = () => {
        const options = {
          storageOptions: {
            skipBackup: true,
            path: 'images',
          },
        };
    
        ImagePicker.showImagePicker(options, response => {
          console.log('Response = ', response);
    
          if (response.didCancel) {
            
          } else if (response.error) {
            alert('ImagePicker Error: ', response.error);
          } else {
            const source = { uri: response.uri };
    
    
            this.setState({
              avatarSource: source,
            });
           }
        });
      };

//#9E9E9E
     renderPicker = ({ meta: { touched, error }, input: { onChange, onChangeValue, value, ...inputProps }, children, ...pickerProps }) => (
         <View>
             
         <View placeholder='yeah' placeholderTextColor="black" style={{ width: 320, height: 45, marginTop: 20, marginLeft: 15, borderRadius: 5, borderWidth: 0.7, borderColor: 'gray', fontSize: 18, color: 'gray' }}>
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

            <View >


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
          const { avatarSource } = this.state;
        const { handleSubmit } = this.props;
        //alert(this.props.Longitude);
        Geolocation.getCurrentPosition(info => {
            myLat = info.coords.latitude;
            myLon = info.coords.longitude;
          });
        return (

                <View style={{padding:10}}>
                    <Text style={{color:'green',fontSize:19,padding:10,borderWidth:1,borderRadius:10,backgroundColor:'#cacaca',width:'100%',textAlign:'center'}}>Create Profile</Text>
                    <TouchableOpacity onPress={this.choosePhoto} style={{  alignSelf:'center',marginTop:10}}>
                        <View style={styles.avatar}>
                        <ImageBackground style={{ width: 122,
                    height: 122,}}  imageStyle={{ borderRadius: 63 ,borderWidth: 0,
                    borderColor: "red",
                    }} source={{uri: this.state.avatarSource}}
                            />

                        </View>
                        <View style={{width:35,height:35,padding:10,backgroundColor:'#fafafa',borderRadius: 63 ,borderWidth: 1,position:'absolute',marginLeft:90,marginTop:90,
                    borderColor: "red",alignItems:'center',justifyContent:'center'}}>
                        <Image source={camera} style={{width:18,height:18}} />
                    </View>
                
                    </TouchableOpacity>
                    <Field name='experiance' component={this.renderPicker} mode="dropdown">
                    <Picker.Item label=" Experiance" value={null} color="#9E9E9E" enabled={false} />
                        <Picker.Item label="1 year" value="1" />
                        <Picker.Item label="2 years" value="2" />
                        <Picker.Item label="3 years" value="3" />
                        <Picker.Item label="4 years" value="4" />
                        <Picker.Item label="5 years" value="5" />
                    </Field>

                    <Field name='field' mode="dropdown" component={this.renderPicker}>
                        <Picker.Item label="Speciality" value={null} color="#9E9E9E" enabled={false} />
                        <Picker.Item label='Allergy & Immunology' value='Allergy & Immunology' />
                        <Picker.Item label='Cardiology' value='Cardiology' />
                        <Picker.Item label='Dentistry' value='Dentistry' />
                        <Picker.Item label='Dermatology' value='Dermatology' />
                        <Picker.Item label='Family Medicine' value='Family Medicine' />
                        <Picker.Item label='Gastroenterology' value='Gastroenterology' />
                        <Picker.Item label='General Medical Practice' value='General Medical Practice' />
                        <Picker.Item label='General Surgery' value='General Surgery' />
                        <Picker.Item label='Neurology' value='Neurology' />
                        <Picker.Item label='Obstetrics & Gynecology' value='Obstetrics & Gynecology' />
                        <Picker.Item label='Oncology' value='Oncology' />
                        <Picker.Item label='Orthoptics' value='Orthoptics' />
                        
                    </Field>

                    <Field name='PMDC' placeholder="PMDC ID" component={this.renderTextInput} keyboardType={'phone-pad'} />
                      <Field name="qualification" label="qualification: " placeholder="Qualification" component={this.renderTextInput} />
                      <Field name="description" label="description: " placeholder="Description" component={this.renderTextInput} />
                      <View style={{ justifyContent: 'center', alignItems: 'center', marginTop: 10 }}>
                          {/* <Button title="choose photo" onPress={this.choosePhoto} /> */}
                      {/* <TouchableOpacity style={{ width: '94%',flexDirection:'row',borderWidth:1,borderRadius:10,padding:8,alignSelf:'center',marginLeft:10,borderColor:'gray',alignItems:'center',marginTop:10 }} onPress={Actions.Map}>
                          <Text style={{ color: 'gray',fontSize:16,width:'90%' }}>
                          Choose Location</Text>
                            <Image source={GoogleMap} style={{width:30,height:30}}/>                          
                          </TouchableOpacity> */}
                               <Text style={{ color: 'purple' }}>{this.props.place}</Text>
        </View>
                    
                    <View style={[{ position: 'relative', width: '50%', overflow: 'hidden', marginTop: 20, marginBottom: 10, marginHorizontal: 85, color: '#ffffff', borderRadius: 40, borderWidth: 0 }]}>
                        <Button
                            onPress={handleSubmit(this.onSubmit)}

                            title="Create Profile"
                            color="#004D40"

                        />
                         {/* <Button
style={{ marginTop: 50 }}
                            onPress={handleSubmit(this.onSubmit)}

                            title="signout"
                            color="#004D40"
                         /> */}


                    </View>
               
             
            </View>


        );
    }
}


const validate = (values) => {
    const errors = {};

    if (!values.PMDC) {
        errors.PMDC = 'PMDC ID is required!';
    }
    if (!values.experiance) {
        errors.experiance = 'Experiance no is required!';
    }
   
    if (!values.description) {
        errors.description = 'Description is required!';
     }
     if (!values.qualification) {
        errors.qualification = 'Qualification is required!';
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
