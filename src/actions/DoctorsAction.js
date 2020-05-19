//this file have actions
import firebase from 'firebase';
import {Actions} from 'react-native-router-flux';
import {
  DOCTORS_FETCH_SUCCESS,
  REVIEW_ADDED,
  REVIEWS_FETCH_SUCCESS,
  RATING_FETCH_SCCCESS,
  SPECIALITY_FETCH_SUCCESS,
  GET_ALL_DATA,
  ADD_RATING,
  USER_RATING_ADDED,
} from './types';

//get all the reacord from firebase in speciality list
export const SpecialityList = () =>
  dispatch => {
    firebase
      .database()
      .ref('/Speciality/')
      .on('value', snapshot => {
        dispatch({type: SPECIALITY_FETCH_SUCCESS, payload: snapshot.val()});
      });
  };

//get all the record from database   
export const GetData = () =>
  dispatch => {
    firebase
      .database()
      .ref('/')
      .on('value', snapshot => {
        dispatch({type: GET_ALL_DATA, payload: snapshot.val()});
      });
  };

// get all the doctor on one specific specilaity  
export const DOCTORSLIST = SpecialityName =>
  dispatch => {
    firebase
      .database()
      .ref(`/${SpecialityName}/`)
      .on('value', snapshot => {
        dispatch({type: DOCTORS_FETCH_SUCCESS, payload: snapshot.val()});
      });
  };

// get specilaity for search  
export const Search = () =>
  dispatch => {
    firebase
      .database()
      .ref('/SpecialityList/')
      .on('value', snapshot => {
        dispatch({type: DOCTORS_FETCH_SUCCESS, payload: snapshot.val()});
      });
  };

// add user rating in firebase
export const AddRating = ({
  rating,
  Speciality,
  index,
  uid,
  NoUsersRated,
  DoctorsRating,
  data,
}) => {
  console.log(rating, Speciality, index, uid, NoUsersRated);
  const newUsers = NoUsersRated + 1;

  const newRating = (DoctorsRating * NoUsersRated + rating) / newUsers;
  console.log(newRating);
  //const newRating =
  return dispatch => {
    firebase
      .database()
      .ref(`/${Speciality}/${index}/UserRating`)
      .update({[uid]: rating})
      .then(() => {
        dispatch({type: ADD_RATING, payload: rating, data: data});
        //Actions.employeeList({ type: 'reset' });
      });
    firebase
      .database()
      .ref(`/${Speciality}/${index}/`)
      .update({
        'No of Users': newUsers,
        Rating: newRating,
      })
      .then(() => {
        //console.log('dataaaaa',data);
        dispatch({type: USER_RATING_ADDED, payload: newRating});
      });
  };
};

//if user want to update rating
export const UpdateRating = ({
  rating,
  Speciality,
  index,
  uid,
  NoUsersRated,
  DoctorsRating,
  oldrating,
  data,
}) => {
  //console.log('hekeejjejejejej');
  // console.log(rating, Speciality, index, uid, NoUsersRated, oldrating);
  //const newUsers = NoUsersRated + 1;

  const newRating =
    (DoctorsRating * NoUsersRated - oldrating + rating) / NoUsersRated;
  // console.log(newRating);
  //const newRating =
  return dispatch => {
    // firebase.database().ref(`/${Speciality}/${index}/UserRating/${uid}`)
    //   .push(rating)
    //   .then(() => {
    //     dispatch({ type: ADD_RATING });
    //     //Actions.employeeList({ type: 'reset' });
    //   });
    firebase
      .database()
      .ref(`/${Speciality}/${index}/UserRating/`)
      .update({
        [uid]: rating,
      })
      .then(() => {
        dispatch({type: USER_RATING_ADDED});
      });

    firebase
      .database()
      .ref(`/${Speciality}/${index}/`)
      .update({
        Rating: newRating,
      })
      .then(() => {
        dispatch({type: USER_RATING_ADDED});
      });
  };
};
// add review to user
export const AddReviews = ({review, Speciality, index, uid}) => {
  // const { currentUser } = firebase.auth();
  const key = 'Comment_' + uid;
  const LabelKey = 'Label_'+uid;
  //console.log('HELLO', review, Speciality, index);
  return dispatch => {
    firebase
      .database()
      .ref(`/${Speciality}/${index}`)
      .update({
        [key]: review, 
        [LabelKey] : 'Flag_y',
      })
      .then(() => {
        dispatch({type: REVIEW_ADDED});
        //Actions.employeeList({ type: 'reset' });
      });
  };
};

// get all the review of specific data
export const GetReviews = ({abc, DoctorsID}) =>
  //  const { currentUser } = firebase.auth();
  // console.log(abc, DoctorsID);
  dispatch => {
    firebase
      .database()
      .ref(`/SpecialityList/${abc}/Doctors/${DoctorsID}/Reviews/`)
      .on('value', snapshot => {
        dispatch({type: REVIEWS_FETCH_SUCCESS, payload: snapshot.val()});
      });
  };
// get rating of a doctor
export const GetRating = ({abc, DoctorsID}) =>
  //  const { currentUser } = firebase.auth();
  // console.log(abc, DoctorsID);
  dispatch => {
    firebase
      .database()
      .ref(`/SpecialityList/${abc}/Doctors/${DoctorsID}/Rating/`)
      .on('value', snapshot => {
        dispatch({type: RATING_FETCH_SCCCESS, payload: snapshot.val()});
      });
  };
