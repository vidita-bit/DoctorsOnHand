//To routes to login and signup of users and doctors

import React, {Component} from 'react';
import {Router, Stack, Scene} from 'react-native-router-flux';
import SignIn from './signin';
import SignUp from './signup';
import FPassword from './forgotPassword';
import doctorDetails from './doctorSignup1';
import PhoneA from './phoneAuth';
import nPage from './nPage';
import EditPage from './editSimpleField';

export default class Route extends Component {
  render() {
    return (
      <Router>
        <Stack key="root" hideNavBar>
          {/* Route to signin page and first screen will apear on device */}
          <Scene key="signin" component={SignIn} title="Login" />
          {/* Route to signup page */}
          <Scene key="signup" component={SignUp} title="Register" />
          {/* Route to Forget Password page */}
          <Scene key="fpassword" component={FPassword} title="fPassword" />
          {/* Route to Phone Authentication page */}
          <Scene key="phoneA" component={PhoneA} title="phoneA" />
          {/* Route to Login page */}
          <Scene key="newPage" component={nPage} title="npage" />
          {/* Route to doctors signup page */}
          <Scene
            key="createDoctor"
            component={doctorDetails}
            title="Create Doctor"
          />
          {/* Route to Edit doctor profile page */}
          <Scene key="EditDoctor" component={EditPage} title="Edit Profile" />
        </Stack>
      </Router>
    );
  }
}
