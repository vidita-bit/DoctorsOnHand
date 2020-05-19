//Search doctor for selected filters
import _ from 'lodash';
import React, {Component} from 'react';
import {View, FlatList, ListItem, Text} from 'react-native';
import {SearchBar} from 'react-native-elements';
import {connect} from 'react-redux';
import {SpecialityList} from '../actions';

class SearchDoctors extends Component {
  state = {
    data: [],
    backup: [],
  };

  componentDidMount() {
    this.props.SpecialityList(); //call action to get all the data of doctors
  }
  search = txt => {
    const text = txt.toLowerCase();
    const tracks = this.state.backup;
    const filterTracks = tracks.filter(item => {
      if (item.toLowerCase().match(text)) {
        return item;
      }
    });
    this.setState({data: filterTracks});
  };

  searchText = search => {
    console.log(search);
    this.setState({search});
    //this.props.Search();
    this.setState({
      data: this.props.specialityList,
    });
    console.log('Data', this.state.data);
    //this.setState({ search });

    const filteredData = this.state.data.filter(item => {
      // console.log(item.Doctors === undefined);
      // if (item.Doctors !== undefined) {
      //  console.log('aa', item.Doctors);
      // if (item.Doctors.Name !== undefined) {
      //   console.log('aa', item.Doctors.Name);
      return item.includes(search);
      //  }
      // }
      // return 'a';
    });
    console.log(filteredData);
    this.setState({filteredData});
  };
  render() {
    const {search} = this.state;
    return (
      <View>
        <SearchBar
          round={true}
          lightTheme={true}
          placeholder="Search..."
          autoCapitalize="none"
          autoCorrect={false}
          onChangeText={this.searchText}
          value={search}
        />

        <FlatList
          data={
            this.state.filteredData && this.state.filteredData.length > 0
              ? this.state.filteredData
              : this.state.data
          }
          keyExtractor={item => `item-${item}`}
          renderItem={
            ({item}) => <Text>{item}</Text>
          }
        />
      </View>
    );
  }
}

const mapStateToProps = state => {
  const specialityList = _.map(state.specialityList, (val, uid) => {
    return {...val, uid};
  });
  //console.log(specialityList);
  return {specialityList};
};

export default connect(
  mapStateToProps,
  {SpecialityList},
)(SearchDoctors);
