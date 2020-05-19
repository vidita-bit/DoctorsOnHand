import React from 'react';
import firebase from 'firebase';
import { Actions } from 'react-native-router-flux';
//import { NavigationActions } from 'react-navigation';
//import { SwitchActions } from 'react-navigation';
import {NavigationActions} from 'react-navigation';
import AppNavigation from '../AppNavigation';
import {
  EMAIL_CHANGED,
  PASSWORD_CHANGED,
  LOGIN_USER_SUCCESS,
  LOGIN_USER_FAIL,
  LOGIN_USER
} from './types';

// navigateToScreen = (route) => () => {
//   const navigateAction = NavigationActions.navigate({
//     routeName: route
//   });
//   this.props.navigation.dispatch(navigateAction);
// };

export const emailChanged = (text) => {
  return {
    type: EMAIL_CHANGED,
    payload: text
  };
};

export const passwordChanged = (text) => {
  return {
    type: PASSWORD_CHANGED,
    payload: text
  };
};

export const loginUser = ({ email, password }) => {
  return (dispatch) => {
    dispatch({ type: LOGIN_USER });

    firebase.auth().signInWithEmailAndPassword(email, password)
      .then(user => loginUserSuccess(dispatch, user))
      .catch((error) => {
        console.log(error);

        firebase.auth().createUserWithEmailAndPassword(email, password)
          .then(user => loginUserSuccess(dispatch, user))
          .catch(() => loginUserFail(dispatch));
      });
  };
};

const loginUserFail = (dispatch) => {
  dispatch({ type: LOGIN_USER_FAIL });
};


const loginUserSuccess = (dispatch, user) => {
  dispatch({
    type: LOGIN_USER_SUCCESS,
    payload: user
  });
  console.log('Login');
  
  // this.navigateToScreen('Demo Screen 2');
};
