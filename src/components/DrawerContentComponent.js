import React, { Component } from 'react';
import { NavigationActions } from 'react-navigation';
import { Text, View, StyleSheet, ImageBackground, Image, TouchableOpacity, TouchableHighlight, ScrollView } from 'react-native'
//import { white } from 'ansi-colors';
//import Iconics from 'react-native-ionicons';
//import MyView from './HideView';

export default class drawerContentComponents extends Component {

    navigateToScreen = (route) => (
        () => {
            const navigateAction = NavigationActions.navigate({
                routeName: route
            });
            this.props.navigation.dispatch(navigateAction);
        });



    toggleCancel() {
        console.log('toggle');
        this.setState({
            showCancel: !this.state.showCancel
        });
    }




    render() {
        return (
            <ScrollView >
                <View style={styles.headerContainer}>
                    <View style={{ flex: 1, flexDirection: 'row', width: 220, justifyContent: 'center', marginTop: 40, marginBottom: 30 }} >
                        <Image source={{ uri: 'https://reactnativecode.com/wp-content/uploads/2018/01/2_img.png' }}
                            style={{ width: 60, height: 60, borderRadius: 150 / 2 }} />
                        <View style={{ marginTop: 10 }}>
                            <Text style={styles.headerText1}>Username</Text>
                            <Text style={styles.headerText1}>Example@gmail.com</Text>
                        </View>

                    </View>


                </View>

                <View style={styles.textContainer}>
                    <View
                        style={{
                            borderBottomColor: 'black',
                            borderBottomWidth: 1,
                            marginBottom: 40,
                            marginTop: 10
                        }}
                    />
                </View>
                <ScrollView style={styles.screenContainer}>
                    <TouchableOpacity style={[styles.screenStyle, (this.props.activeItemKey == 'Screen5') ? styles.activeBackgroundColor : null]} onPress={this.navigateToScreen('Screen5')}>
                        <Text style={[styles.screenTextStyle, (this.props.activeItemKey == 'Screen5') ? styles.selectedTextStyle : null]} >Home</Text>

                    </TouchableOpacity>
                    <View
                        style={{
                            borderBottomColor: '#cccccc',
                            borderBottomWidth: 1
                        }}
                    />
                    <TouchableOpacity style={[styles.screenStyle, (this.props.activeItemKey == 'Screen3') ? styles.activeBackgroundColor : null]} onPress={this.navigateToScreen('Screen3')}>
                        <Text style={[styles.screenTextStyle, (this.props.activeItemKey == 'Screen3') ? styles.selectedTextStyle : null]} >Speciality List</Text>

                    </TouchableOpacity>
                    <View
                        style={{
                            borderBottomColor: '#cccccc',
                            borderBottomWidth: 1
                        }}
                    />

                </ScrollView>
            </ScrollView>
        )
    }
}

const styles = StyleSheet.create({
    container: {
        alignItems: 'center',
    },
    headerContainer: {
        height: 120,
    },
    headerText: {
        marginLeft: 5,
        marginTop: 5,
        fontWeight: 'bold'
    },
    headerText1: {
        marginLeft: 10
    },
    screenContainer: {
        width: '100%',
        paddingBottom: 20
    },
    screenStyle: {
        height: 50,
        marginTop: 2,
        flexDirection: 'row',
        alignItems: 'center',
        width: '100%'
    },
    screenTextStyle: {
        fontSize: 16,
        marginLeft: 20,
        textAlign: 'center'
    },
    selectedTextStyle: {
        fontWeight: 'bold',
        // color: '#00adff'
    },
    activeBackgroundColor: {
        //  backgroundColor: '#c2bcbc',
        // alignItems: 'flex-start'
    },
    textContainer: {
        marginTop: 2,
        paddingTop: 2,
        width: '100%'
    },
    headingContainer: {
        width: '100%',
        fontSize: 20,
        paddingTop: 5,
        paddingLeft: 5,
        alignItems: 'center',
        height: 40,
        borderWidth: 1,
    }
});