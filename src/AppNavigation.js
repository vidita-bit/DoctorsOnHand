/* eslint-disable react-native/no-inline-styles */
//this file help us to naviagte between screens
import React, {Component} from 'react';
import {View, Image, TouchableOpacity} from 'react-native';
import {createAppContainer} from 'react-navigation';
import {createDrawerNavigator} from 'react-navigation-drawer';
import {createStackNavigator} from 'react-navigation-stack';
import Screen2 from './components/SpecialityList';
import Screen3 from './components/DoctorsList';
import Screen8 from './components/DoctorListRecommended';
import Screen4 from './components/DoctorsDetails';
import Screen5 from './components/Home';
import Screen6 from './components/Search';
import Screen7 from './components/ViewReviews';
import Screen9 from './components/SpecialityListeRecommend';
import Image1 from './Images/list.png';
import Screen10 from './components/SearchRecommend';

class NavigationDrawerStructure extends Component {
  toggleDrawer = () => {
    //open and close side drawer
    this.props.navigationProps.toggleDrawer();
  };
  back = () => {
    //to back to previous screen
    this.props.navigationProps.goBack();
  };

  render() {
    return (
      <View style={{flexDirection: 'row'}}>
        {/* button to open and close drawer */}
        <TouchableOpacity onPress={this.toggleDrawer.bind(this)}>
          <Image
            style={{width: 30, height: 30, marginLeft: 10}}
            source={Image1}
          />
        </TouchableOpacity>
      </View>
    );
  }
}
//this will help to move between screen
const Screen2StackNavigator = createStackNavigator({
  Second: {
    screen: Screen2,
    navigationOptions: ({navigation}) => ({
      title: 'Speciality List',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,

      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
  Third: {
    screen: Screen3,
    navigationOptions: ({navigation}) => ({
      title: 'Doctors List',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,
      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
  Eighth: {
    screen: Screen8,
    navigationOptions: ({navigation}) => ({
      title: 'Recommended Doctors',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,
      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
  Fourth: {
    screen: Screen4,
    navigationOptions: ({navigation}) => ({
      title: 'Doctors Details',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,
      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
  Seventh: {
    screen: Screen7,
    navigationOptions: ({navigation}) => ({
      title: 'Doctors Reviews',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,
      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
});

const Screen3StackNavigator = createStackNavigator({
  Ninth: {
    screen: Screen9,
    navigationOptions: ({navigation}) => ({
      title: 'Speciality List',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,

      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
  Third: {
    screen: Screen3,
    navigationOptions: ({navigation}) => ({
      title: 'Doctors List',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,
      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
  Eighth: {
    screen: Screen8,
    navigationOptions: ({navigation}) => ({
      title: 'Recommended Doctors',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,
      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
  Fourth: {
    screen: Screen4,
    navigationOptions: ({navigation}) => ({
      title: 'Doctors Details',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,
      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
  Seventh: {
    screen: Screen7,
    navigationOptions: ({navigation}) => ({
      title: 'Doctors Reviews',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,
      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
});

//the stack from home scrrens
const Screen5StackNavigator = createStackNavigator({
  Fifth: {
    screen: Screen5,
    navigationOptions: ({navigation}) => ({
      drawerLabel: () => null,
      title: 'Home',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,
      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
});
//stack for search page
const Screen6StackNavigator = createStackNavigator({
  Six: {
    screen: Screen6,
    navigationOptions: ({navigation}) => ({
      title: 'Search Bar',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,

      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
  Fourth: {
    screen: Screen4,
    navigationOptions: ({navigation}) => ({
      title: 'Doctors Details',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,
      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
  Seventh: {
    screen: Screen7,
    navigationOptions: ({navigation}) => ({
      title: 'Doctors Reviews',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,
      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
});

const Screen7StackNavigator = createStackNavigator({
  Tenth: {
    screen: Screen10,
    navigationOptions: ({navigation}) => ({
      title: 'Search Bar',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,

      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
  Fourth: {
    screen: Screen4,
    navigationOptions: ({navigation}) => ({
      title: 'Doctors Details',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,
      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
  Seventh: {
    screen: Screen7,
    navigationOptions: ({navigation}) => ({
      title: 'Doctors Reviews',
      headerLeft: <NavigationDrawerStructure navigationProps={navigation} />,
      headerStyle: {
        backgroundColor: '#FF9800',
      },
      headerTintColor: '#fff',
    }),
  },
});
// drawer navigation and open first scrren home
const DrawerNavigatorExample = createDrawerNavigator(
  {
    Screen5: {
      screen: Screen5StackNavigator,
      navigationOptions: {
        drawerLabel: 'Home',
      },
    },

    Screen2: {
      screen: Screen2StackNavigator,
      navigationOptions: {
        drawerLabel: () => null,
      },
    },

    Screen3: {
      screen: Screen3StackNavigator,
      navigationOptions: {
        drawerLabel: 'Speciality List',
      },
    },

    Screen6: {
      screen: Screen6StackNavigator,
      navigationOptions: {
        drawerLabel: () => null,
      },
    },

    Screen7: {
      screen: Screen7StackNavigator,
      navigationOptions: {
        drawerLabel: () => null,
      },
    },
  },
  {
    //drawer width set to 250
    drawerWidth: 250,
  },
);

export default createAppContainer(DrawerNavigatorExample);
