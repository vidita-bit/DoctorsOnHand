import React, { Component } from 'react';
import { TextInput, StyleSheet, View, Text, Button, Image, TouchableOpacity, ImageBackground } from 'react-native';
import firebase from 'react-native-firebase';
import firebase1 from 'firebase';
import NetInfo from '@react-native-community/netinfo';
import camera from '../Images/camera.png';
import GoogleMap from './icons/google-maps.jpg';
import { Actions } from 'react-native-router-flux';

export default class FinalFuckingDoctor extends Component {
    constructor(props) {
        super(props);
        this.state = {
            experiance: '',
            description: '',
            qualification: '',
            img: '',
            name: '',

        };
    }
    // eslint-disable-next-line no-undef
    componentWillMount (){
        // NetInfo.isConnected.fetch().then(isConnected => {
        //     if (!isConnected) {
        //         this.setState({ loading: false });
        //         alert('Internet is not connected');
        //     } else {
                const user = firebase1.auth().currentUser;
                //alert(user);
                return firebase.database().ref(`doctor/${user.uid}`).once('value').then((snapshot) => {
                    var name = (snapshot.val() && snapshot.val().name) || 'Anonymous';
                    var experiance = (snapshot.val() && snapshot.val().experiance) || 'Anonymous';
                    var description = (snapshot.val() && snapshot.val().description) || 'Anonymous';
                    var qualification = ((snapshot.val() && snapshot.val().qualification) || 'Anonymous')
                    var img = ((snapshot.val() && snapshot.val().avatarSource) || 'Anonymous')
                    this.setState({ name:name, experiance: experiance, qualification: qualification, description: description, img: img });
                })
           // }
  //      });
    }

    done() {
                var user = firebase1.auth().currentUser;
                var ref = firebase.database().ref(`doctor/${user.uid}`);
                ref.update({
                    name: this.state.name,
                    experiance: this.state.experiance,
                    qualification: this.state.qualification,
                    description: this.state.description,

                });
                alert('values updated')
         
    }
    render() {
        return (

            <View style={{ padding: 10 }}>
                <Text style={{ color: 'green', fontSize: 19, padding: 10, borderWidth: 1, borderRadius: 10, backgroundColor: '#cacaca', width: '100%', textAlign: 'center' }}>Edit Profile</Text>
                <TouchableOpacity onPress={this.choosePhoto} style={{ alignSelf: 'center', marginTop: 10 }}>
                    <View style={styles.avatar}>
                        <ImageBackground style={{
                            width: 122,
                            height: 122,
                        }} imageStyle={{
                            borderRadius: 63, borderWidth: 0,
                            borderColor: "red",
                        }} source={{ uri: this.state.img }}
                        />

                    </View>
                    <View style={{
                        width: 35, height: 35, padding: 10, backgroundColor: '#fafafa', borderRadius: 63, borderWidth: 1, position: 'absolute', marginLeft: 90, marginTop: 90,
                        borderColor: "red", alignItems: 'center', justifyContent: 'center'
                    }}>
                        <Image source={camera} style={{ width: 18, height: 18 }} />
                    </View>

                </TouchableOpacity>
                <Text style={{ color: 'green', fontSize: 16, marginLeft: 5 }}>Name</Text>
                <TextInput style={styles.input} placeholderTextColor='red' onChangeText={text => this.setState({ name: text })} value={this.state.name} />
                <Text style={{ color: 'green', fontSize: 16, marginLeft: 5 }}>Experiance</Text>
                <TextInput style={styles.input} placeholderTextColor='red' onChangeText={text => this.setState({ experiance: text })} value={this.state.experiance} />
                <Text style={{ color: 'green', fontSize: 16, marginLeft: 5 }}>Qualification</Text>
                <TextInput style={styles.input} placeholderTextColor='red' onChangeText={text => this.setState({ qualification: text })} value={this.state.qualification} />

                <Text style={{ color: 'green', fontSize: 16, marginLeft: 5 }}>Description</Text>
                <TextInput style={[styles.input,{marginBottom:30}]} placeholderTextColor='red' onChangeText={text => this.setState({ description: text })} value={this.state.description} />
                {/* <Text style={{ color: 'green', fontSize: 16, marginLeft: 5 }}>Location</Text>

                <TouchableOpacity style={[styles.input, { flexDirection: 'row', alignItems: 'center', marginBottom: 10 }]} onPress={Actions.map}>
                    <Text style={{ color: 'gray', fontSize: 16, width: '90%', marginLeft: 10 }}>
                        Choose Location</Text>
                    <Image source={GoogleMap} style={{ width: 30, height: 30 }} />
                </TouchableOpacity> */}

                <Button
                    title="Edit"
                    //style={{ height:40 }}
                    onPress={this.done.bind(this)}
                />

            </View>


        );
    }
}

const styles = StyleSheet.create({
    container: {
        justifyContent: 'center',
        alignItems: 'center',
        flex: 1

    },
    input: {
        height: 45,
        borderRadius: 10,
        borderColor: 'gray',
        borderWidth: 1,
        marginTop: 5

    },
    avatar: {
        width: 130,
        height: 130,
        borderRadius: 63,
        marginBottom: 10,
        alignSelf: 'center',
        // position: 'absolute',
        // marginTop:130,
        borderColor: 'red',
        borderWidth: 4,

    },


});

