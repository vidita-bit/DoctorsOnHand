import React from 'react';
import { Scene, Router } from 'react-native-router-flux';
import LoginForm from './components/LoginForm';
import SpecialityList from './components/SpecialityList';
import DoctorsList from './components/DoctorsList';
import DoctorsDetails from './components/DoctorsDetails';

const RouterComponent = () => {
  return (
    <Router sceneStyle={{ paddingTop: 10 }}>
      <Scene key="home">
      <Scene key="auth">
        <Scene key="login" component={LoginForm} title="Please Login" />
      </Scene>

      <Scene key="main">
        <Scene
          key="SpecialityList"
          component={SpecialityList}
          title="SpecialityList"
          initial
        />
        
      </Scene>
      <Scene key="mainDoctor">
      <Scene key="doctorList" component={DoctorsList} title="Doctors List" />
      </Scene>
      <Scene key="doctorDetails" component={DoctorsDetails} title="Doctors Profile" />
      </Scene>
    </Router>
  );
};

export default RouterComponent;
