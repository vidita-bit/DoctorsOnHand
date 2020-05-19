//First file that run first when app in opened

//import the compnents that are used in this file
import React, {Component} from 'react';
import {Provider} from 'react-redux';
import {createStore, applyMiddleware} from 'redux';
import firebase from 'firebase';
import ReduxThunk from 'redux-thunk';
import reducers from './reducers';
import Router from './components/routers';
import logger from 'redux-logger';

class App extends Component {
  componentDidMount() {
    console.disableYellowBox = true; //Disable warning to display on device

    const firebaseConfig = {
      apiKey: 'AIzaSyCb9x70Nongsqho1RDgABVwj-sVPsBDS4I',
      authDomain: 'doctorsonhand-b4ebe.firebaseapp.com',
      databaseURL: 'https://doctorsonhand-b4ebe.firebaseio.com',
      projectId: 'doctorsonhand-b4ebe',
      storageBucket: 'doctorsonhand-b4ebe.appspot.com',
      messagingSenderId: '696896498959',
      appId: '1:696896498959:web:12414797b68db4c92a627a',
      measurementId: 'G-CHNJEWQHH5',
    }; //Firebase authentication
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
  }

  render() {
    const store = createStore(
      reducers,
      {},
      applyMiddleware(ReduxThunk, logger),
    ); //initalize react redux

    return (
      // initialization of redux
      <Provider store={store}>
        <Router />
        {/*  goto router file */}
      </Provider>
    );
  }
}

export default App;
