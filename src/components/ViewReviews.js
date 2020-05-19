/* eslint-disable react-native/no-inline-styles */
//Display all the review of one doctor
import _ from 'lodash';
import React, {Component} from 'react';
import {connect} from 'react-redux';
import {View, Text, BackHandler, Button, ScrollView} from 'react-native';
import firebase from 'firebase';

class Reviews extends Component {
  state = {
    Data: [],
  };
  render() {
    const doctorsindex = this.props.navigation.getParam('index'); //get index of doctors record
    // const data = this.props.specialityList[doctorsindex];
    let data = this.props.specialityList[doctorsindex];
    if (data == undefined) {
      data = this.props.navigation.getParam('Data'); //get data of a single record
    }
    return (
      <ScrollView>
        {/* Display all the doctors comment from data */}

        {/* Loop that display only comment. The comment are store in data with comment_1 or comment_userid */}
        {Object.keys(data).map(key => {
          if (key.split('_')[0] === 'Comment') {
            //Split the key with _ and dislay the that key or value that start with comment
            return (
              /* Display comment on screen */
              <View
                style={{
                  padding: 10,
                  borderWidth: 1,
                  borderColor: 'gray',
                  margin: 5,
                  borderRadius: 10,
                }}>
                {/* Display You if user have comment on that doctor  */}
                {key.split('_')[1] === firebase.auth().currentUser.uid ? (
                  <Text style={{color: 'red'}}>You</Text>
                ) : (
                  <Text>username</Text>
                )}

                <Text style={{fontSize: 15, textAlign: 'center'}}>
                  {data[key]}
                </Text>
              </View>
            );
          }
        })}
      </ScrollView>
    );
  }
}
//get data form react redux
const mapStateToProps = state => {
  const specialityList = _.map(state.doctorReducer);
  return {specialityList};
};

export default connect(
  mapStateToProps,
  {},
)(Reviews);
