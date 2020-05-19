import {
    GOTO_DOCTORSLIST,
    REVIEW_ADDED,
    REVIEWS_FETCH_SUCCESS,
    RATING_FETCH_SCCCESS,
    DOCTORS_FETCH_SUCCESS,
    GET_ALL_DATA,
    ADD_RATING,
    USER_RATING_ADDED,
  } from '../actions/types';
import { act } from 'react-test-renderer';
  
  const INITIAL_STATE = {};
  
  export default (state = INITIAL_STATE, action) => {
    switch (action.type) {
      case GOTO_DOCTORSLIST:
        return action.payload;
      case REVIEW_ADDED:
        return state;
      case ADD_RATING:
          return state;
      case USER_RATING_ADDED:
        console.log('stateeeeee',state);
          return state;
      case REVIEWS_FETCH_SUCCESS:
        return action.payload;
      case RATING_FETCH_SCCCESS:
          return action.payload;
      case DOCTORS_FETCH_SUCCESS:
          return action.payload;
      case GET_ALL_DATA:
        return action.payload;
      default:
        return state;
    } 
  };