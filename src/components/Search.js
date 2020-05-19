/* eslint-disable no-sparse-arrays */
//Search doctor for selected filters 
import _ from 'lodash';
import React, {Component} from 'react';
import {connect} from 'react-redux';
import {
  StyleSheet,
  Text,
  View,
  ScrollView,
  TouchableOpacity,
  Button,
  Image,
  TextInput,
} from 'react-native';
import SearchInput, {createFilter} from 'react-native-search-filter';
import Geolocation from '@react-native-community/geolocation';
import {GetData} from '../actions';
import Listitem from './ListItem';
import DoctorsCard from './common/DoctorsCard';
import {isTSMappedType} from '@babel/types';
import DistanceDoctorList from './DistanceDoctorList';
import RadioForm, {
  RadioButton,
  RadioButtonInput,
  RadioButtonLabel,
} from 'react-native-simple-radio-button';
import {Dropdown} from 'react-native-material-dropdown';

const Image1 = require('../Images/filter-results-button.png');

//import emails from './emails';

const KEYS_TO_FILTERS = []; //add speciality
const SpecialityList = [
  'Allergy & Immunology',
  'Cardiology',
  'Dentistry',
  'Dermatology',
  'Family Madicine',
  'Gastroenterology',
  'General Medical Practice',
  'General Surgery',
  'Neurology',
  'Obstetrics & Gynecology',
  'Oncology',
  'Orthoptics',
];
//array that display specillity to select in filter
const SpecialityDropDown = [
  {
    value: 'Allergy & Immunology',
  },
  {
    value: 'Cardiology',
  },
  {
    value: 'Dentistry',
  },
  {
    value: 'Dermatology',
  },

  {
    value: 'Family Madicine',
  },

  {
    value: 'Gastroenterology',
  },
  {
    value: 'General Medical Practice',
  },

  {
    value: 'General Surgery',
  },

  {
    value: 'Neurology',
  },

  {
    value: 'Obstetrics & Gynecology',
  },

  {
    value: 'Oncology',
  },

  {
    value: 'Orthoptics',
  },
];

let myLat = 0;
let myLon = 0;
//Display all the disctance filter options

let radio_props1 = [
  {label: '10 km  ', value: 10},
  {label: '5 km  ', value: 5},
  {label: '2 km  ', value: 2},
  {label: 'Any', value: 1000},
  ,
];
class search extends Component {
  constructor(props) {
    super(props);
    this.state = {
      data: [],
      searchTerm: '',
      distance: 1000,
      filter: false,
    };
  }
  componentDidMount() {
    this.props.GetData(); //get data for action 
  }

  onChangeText = term => {
    this.setState({
      searchTerm: term,
      data: [],
    });
  };
  hello(item, title) {
    //navigate to doctors list
    this.props.navigation.navigate('Third', {
      items: item,
      title,
    });
  }

  searchUpdated() {
    this.setState({data: SpecialityList});
  }
  toggleFilter() {
    this.setState({filter: !this.state.filter});
  }
  render() {
    Geolocation.getCurrentPosition(info => {
      myLat = info.coords.latitude;
      myLon = info.coords.longitude;
    });

    let filteredEmails = [];
    if (this.state.data !== undefined) {
      // console.log(this.state.searchTerm);
      filteredEmails = this.state.data.filter(
        createFilter(this.state.searchTerm),
      );
      //console.log(filteredEmails);
    }

    return (
      <View style={styles.container}>
        <TextInput
          onChangeText={term => this.onChangeText(term)}
          style={styles.searchInput}
          placeholder="Type a message to search"
          value={this.state.searchTerm}
        />
        <Button title="Search" onPress={() => this.searchUpdated()} />

        <TouchableOpacity
          style={{
            flexDirection: 'row',
            position: 'absolute',
            justifyContent: 'flex-end',
            width: '20%',
            top: 15,
            right: 20,
            alignSelf: 'flex-end',
          }}
          onPress={() => this.toggleFilter()}>
          <Image
            source={Image1}
            style={{width: 20, height: 20, marginTop: 10}}
          />
          {/* <Text style={{ fontSize: 17, padding: 10 }}>Filter</Text> */}
        </TouchableOpacity>

        {this.state.filter ? (
          <View style={{padding: 10}}>
            <Dropdown
              label="Speciality List"
              data={SpecialityDropDown}
              onChangeText={value => this.onChangeText(value)}
            />
            <Text style={{marginBottom: 10}}>Distance</Text>
            <RadioForm
              radio_props={radio_props1}
              initial={3}
              formHorizontal
              labelHorizontal
              buttonColor={'#2196f3'}
              animation
              onPress={value => {
                this.setState({distance: value});
              }}
            />
          </View>
        ) : null}

        <ScrollView>
          {filteredEmails !== undefined
            ? filteredEmails.map(Items => {
                const List1 = this.props.specialityList[
                  SpecialityList.indexOf(Items)
                ];
                return (
                  <DistanceDoctorList
                    navigation={this.props.navigation}
                    List={List1}
                    Late={myLat}
                    Longe={myLon}
                    Filter={this.state.distance}
                  />
                );
              })
            : null}
        </ScrollView>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    //flex: 1,
    backgroundColor: '#fff',
    justifyContent: 'flex-start',
    padding: 10,
  },
  Items: {
    borderBottomWidth: 0.5,
    borderColor: 'rgba(0,0,0,0.3)',
    padding: 10,
  },
  searchInput: {
    padding: 10,
    borderColor: '#CCC',
    borderWidth: 1,
    marginBottom: 10,
  },
  TextContainer: {
    borderColor: '#CCC',
    borderWidth: 2,
  },
});

const mapStateToProps = state => {
  const specialityList = _.map(state.doctorReducer);
  // specialityList = specialityList;
  return {specialityList};
};

export default connect(
  mapStateToProps,
  {GetData},
)(search);
