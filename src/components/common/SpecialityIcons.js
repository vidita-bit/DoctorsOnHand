import React, { Component } from 'react';
import { View, TouchableOpacity, Text, Image } from 'react-native';
import Aleargy from '../icons/allergy-shots.png';

const Speciality = ['Allergy & Immunology',
  'Cardiology', 'Clinical Psychology', 'Dentistry', 'Dermatology',
  'Ear, Nose, and Throat', 'Family Medicine', 'Gastroenterology',
  'General Medical Practice', 'General Surgery', 'Neurology',
  'Obstetrics & Gynecology', 'Oncology', 'Orthoptics', 'Physical Therapy'
];

class SpecilaityIcons extends Component {
  onButtonPress = (item) => {
    console.log('Buttttooonnn', item);
    this.props.navigation.navigate('Third', {
      item
    });
  }

  render() {
    return (
      <TouchableOpacity
        style={{ width: '33%' }}
        onPress={() => this.onButtonPress(Speciality[0])}
      >
        <View style={styles.listStyle}>
          <View style={styles.iconborder1}>
            <View style={styles.iconborder2} >
              <View style={styles.iconborder3}>
                <Image
                  style={{ width: 25, height: 25 }}
                  source={Aleargy}
                />
              </View>
            </View>
          </View>

          <Text style={styles.titleStyle}>Allergy & Immunology</Text>
        </View>
      </TouchableOpacity>
    )
  }
}
const styles = {
  listStyle: {
    paddingTop: 15,
    justifyContent: 'center',
    alignItems: 'center'
  },
  titleStyle: {
    fontSize: 13,
    paddingLeft: 0,
    paddingTop: 5,
    textAlign: 'center'
  },
  searchInput: {
    padding: 10,
    borderColor: '#CCC',
    borderWidth: 1,
    marginBottom: 5,
    margin: 5
  },
  iconborder1: {
    borderWidth: 2,
    borderColor: '#a6e5ff',
    width: 63,
    height: 63,
    borderRadius: 74 / 2

  },
  iconborder2: {
    borderWidth: 2,
    borderColor: '#78bbd6',
    width: 59,
    height: 59,
    borderRadius: 70 / 2
  },
  iconborder3: {
    borderWidth: 1,
    borderColor: 'white',
    width: 55,
    height: 55,
    borderRadius: 65 / 2,
    paddingLeft: 14,
    paddingTop: 13,
    backgroundColor: '#78bbd6'
  }
};


export default SpecilaityIcons;