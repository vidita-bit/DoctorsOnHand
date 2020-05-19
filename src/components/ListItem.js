import React, { Component } from 'react';
import { View, Text, TouchableOpacity, ScrollView, Image } from 'react-native';
import heart from './icons/heart.png';

class ListItem extends Component {
    onButtonPress = (item, title, id) => {   
    console.log('Buttttooonnn', item);
      this.props.navigation.navigate('Third', {
        item
      });   

  }
  render() {
 
    return (
         <ScrollView>
        {this.props.items.map((item, index) => {
            return (
               <TouchableOpacity style={{width:'40%'}} onPress={() => this.onButtonPress(item)}>
                <View style={styles.listStyle} key={index}>
                <View style={{borderWidth:2,borderColor:'#a6e5ff', width:73,height:73, borderRadius:74/2}}>
                <View style={{borderWidth:2,borderColor:'#78bbd6', width:69,height:69, borderRadius:70/2}}>
                <View style={{borderWidth:1,borderColor:'white', width:65,height:65, borderRadius:65/2,paddingLeft:16,paddingTop:13,backgroundColor:'#78bbd6'}}>
                <Image style={{width:30, height:35}} source={heart}/>
                </View>               
                </View>  
                </View>

                    <Text key={index} style={styles.titleStyle}>{item}</Text>
                    </View>
               </TouchableOpacity>
            );
        })}
      </ScrollView>
    );
  }
}

const styles = {
  listStyle: {
    backgroundColor: '#F8F8F8',
    height: 120,
    paddingTop: 15,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    elevation: 2,
    position: 'relative'
  },
  titleStyle: {
    fontSize: 18,
    paddingLeft: 15
  }
};

export default ListItem;
