//Display all the recommended speciality on screen

import React, {Component} from 'react';
import {
  View,
  TouchableOpacity,
  Image,
  Text,
  Dimensions,
  TextInput,
  Button,
  ScrollView,
} from 'react-native';
import heart from './icons/heart.png';
import Aleargy from './icons/allergy-shots.png';
import Dentist from './icons/tooth.png';
import Creativity from './icons/creativity.png';
import Dermatology from './icons/dermatology.png';
import ENT from './icons/ENT.png';
import Family from './icons/family.png';
import Gastroenterology from './icons/stomach.png';
import gm from './icons/gm1.png';
import eye from './icons/eye.png';
import GS from './icons/GS.png';
import Gynecology from './icons/gynecology.png';
import Neurology from './icons/neurology.png';
import Oncology from './icons/Oncology.png';
import Pt from './icons/PT.png';
import Search from './SearchRecommend';
import SpecialityIcons from './common/SpecialityIcons';
import search from './icons/search.png';

const Image1 = require('../Images/filter-results-button.png');

const screenWidth = Math.round(Dimensions.get('window').width);

const Speciality = [
  'Allergy & Immunology',
  'Cardiology',
  'Clinical Psychology',
  'Dentistry',
  'Dermatology',
  'Ear, Nose, and Throat',
  'Family Medicine',
  'Gastroenterology',
  'General Medical Practice',
  'General Surgery',
  'Neurology',
  'Obstetrics & Gynecology',
  'Oncology',
  'Orthoptics',
  'Physical Therapy',
];
//array of speciality to show on screen

class DoctorsList extends Component {
  onButtonPress = item => {
    //console.log('recommmmmm', item);
    this.props.navigation.navigate('Eighth', {
      item,
    });//Naviagate to doctors List
  };

  render() {
    return (
      <ScrollView>
         {/* Navigate to search screen */}
        <TouchableOpacity
          onPress={() => this.props.navigation.navigate('Tenth')}
          style={{
            flexDirection: 'row',
            borderWidth: 1,
            margin: 10,
            height: 50,
          }}>
            {/* Display search and placeholder when user click it navigate to search screen */}
          
          <View style={{width: '87%', justifyContent: 'center'}}>
            <Text style={{color: 'gray', fontSize: 17}}> Search...</Text>
          </View>
          <View style={{width: '10%', justifyContent: 'center'}}>
            <Image source={search} style={{width: 30, height: 30}} />
          </View>


        </TouchableOpacity>
   {/* Display Header of Specialiaty list */}
     
        <Text
          style={{
            textAlign: 'center',
            fontSize: 18,
            backgroundColor: '#cacaca',
            padding: 10,
          }}>
          Speciality List
        </Text>
        <View style={{flexDirection: 'row', justifyContent: 'center'}}>
           {/* Display and naviagte to doctor list of Allergy & Immunology Specialiaty list */}
         
          <TouchableOpacity
            style={{width: '33%'}}
            onPress={() => this.onButtonPress(Speciality[0])}>
            <View style={styles.listStyle}>
              <View style={styles.iconborder1}>
                <View style={styles.iconborder2}>
                  <View style={styles.iconborder3}>
                    <Image style={{width: 25, height: 25}} source={Aleargy} />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>Allergy & Immunology</Text>
            </View>
          </TouchableOpacity>
           {/* Display and naviagte to doctor list of Cardialogy Specialiaty list */}
         
          <TouchableOpacity
            style={{
              width: '33%',
            }}
            onPress={() => this.onButtonPress(Speciality[1])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 14,
                      paddingTop: 13,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image style={{width: 25, height: 25}} source={heart} />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>Cardiology</Text>
            </View>
          </TouchableOpacity>
          {/* Display and naviagte to doctor list of Dentistry Specialiaty list */}

          <TouchableOpacity
            style={{
              width: '33%',
            }}
            onPress={() => this.onButtonPress(Speciality[2])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 14,
                      paddingTop: 13,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image
                      style={{width: 25, height: 25, resizeMode: 'contain'}}
                      source={Dentist}
                    />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>Dentistry</Text>
            </View>
          </TouchableOpacity>
        </View>
        <View style={{flexDirection: 'row', justifyContent: 'center'}}>
          {/* Display and naviagte to doctor list of Clinical Psychology Specialiaty list */}

          <TouchableOpacity
            style={{
              width: '33%',
            }}
            onPress={() => this.onButtonPress(Speciality[3])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 14,
                      paddingTop: 13,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image
                      style={{width: 25, height: 25, resizeMode: 'contain'}}
                      source={Creativity}
                    />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>Clinical Psychology</Text>
            </View>
          </TouchableOpacity>
           {/* Display and naviagte to doctor list of Dermatology Specialiaty list */}

          <TouchableOpacity
            style={{
              width: '33%',
            }}
            onPress={() => this.onButtonPress(Speciality[4])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 15,
                      paddingTop: 13,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image
                      style={{width: 25, height: 25, resizeMode: 'contain'}}
                      source={Dermatology}
                    />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>Dermatology</Text>
            </View>
          </TouchableOpacity>
                    {/* Display and naviagte to doctor list of Ear, Nose & Throat Specialiaty list */}

          <TouchableOpacity
            style={{
              width: '33%',
            }}
            onPress={() => this.onButtonPress(Speciality[5])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 16,
                      paddingTop: 10,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image style={{width: 20, height: 31}} source={ENT} />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>Ear, Nose & Throat</Text>
            </View>
          </TouchableOpacity>
        </View>
        <View style={{flexDirection: 'row', justifyContent: 'center'}}>
           {/* Display and naviagte to doctor list of Family Madicine Specialiaty list */}

          <TouchableOpacity
            style={{width: '33%'}}
            onPress={() => this.onButtonPress(Speciality[6])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 12,
                      paddingTop: 13,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image
                      style={{width: 30, height: 30, resizeMode: 'contain'}}
                      source={Family}
                    />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>Family Madicine</Text>
            </View>
          </TouchableOpacity>
           {/* Display and naviagte to doctor list of Gastroenterology Specialiaty list */}

          <TouchableOpacity
            style={{width: '33%'}}
            onPress={() => this.onButtonPress(Speciality[7])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 14,
                      paddingTop: 13,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image
                      style={{width: 25, height: 25}}
                      source={Gastroenterology}
                    />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>Gastroenterology</Text>
            </View>
          </TouchableOpacity>
           {/* Display and naviagte to doctor list of General Medical Practice Specialiaty list */}

          <TouchableOpacity
            style={{width: '33%'}}
            onPress={() => this.onButtonPress(Speciality[8])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 14,
                      paddingTop: 13,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image style={{width: 25, height: 25}} source={gm} />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>General Medical Practice</Text>
            </View>
          </TouchableOpacity>
        </View>
        <View style={{flexDirection: 'row', justifyContent: 'center'}}>
           {/* Display and naviagte to doctor list of General Surgery Specialiaty list */}

          <TouchableOpacity
            style={{width: '33%'}}
            onPress={() => this.onButtonPress(Speciality[9])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 13,
                      paddingTop: 10,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image style={{width: 25, height: 30}} source={GS} />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>General Surgery</Text>
            </View>
          </TouchableOpacity>
          {/* Display and naviagte to doctor list of Neurology Specialiaty list */}

          <TouchableOpacity
            style={{width: '33%'}}
            onPress={() => this.onButtonPress(Speciality[10])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 13,
                      paddingTop: 13,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image style={{width: 25, height: 25}} source={Neurology} />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>Neurology</Text>
            </View>
          </TouchableOpacity>
          {/* Display and naviagte to doctor list of Obstetrics & Gynecology Specialiaty list */}

          <TouchableOpacity
            style={{width: '33%'}}
            onPress={() => this.onButtonPress(Speciality[11])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 14,
                      paddingTop: 13,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image
                      style={{width: 25, height: 25}}
                      source={Gynecology}
                    />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>Obstetrics & Gynecology</Text>
            </View>
          </TouchableOpacity>
        </View>

        <View style={{flexDirection: 'row', justifyContent: 'center'}}>
          {/* Display and naviagte to doctor list of Oncology Specialiaty list */}

          <TouchableOpacity
            style={{width: '33%'}}
            onPress={() => this.onButtonPress(Speciality[12])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 8,
                      paddingTop: 8,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image style={{width: 40, height: 40}} source={Oncology} />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>Oncology</Text>
            </View>
          </TouchableOpacity>
          {/* Display and naviagte to doctor list of Orthoptics Specialiaty list */}

          <TouchableOpacity
            style={{width: '33%'}}
            onPress={() => this.onButtonPress(Speciality[13])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 14,
                      paddingTop: 13,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image style={{width: 25, height: 25}} source={eye} />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>Orthoptics</Text>
            </View>
          </TouchableOpacity>
            {/* Display and naviagte to doctor list of Physical Therapy Specialiaty list */}

          <TouchableOpacity
            style={{width: '33%'}}
            onPress={() => this.onButtonPress(Speciality[14])}>
            <View style={styles.listStyle}>
              <View
                style={{
                  borderWidth: 2,
                  borderColor: '#a6e5ff',
                  width: 63,
                  height: 63,
                  borderRadius: 74 / 2,
                }}>
                <View
                  style={{
                    borderWidth: 2,
                    borderColor: '#78bbd6',
                    width: 59,
                    height: 59,
                    borderRadius: 70 / 2,
                  }}>
                  <View
                    style={{
                      borderWidth: 1,
                      borderColor: 'white',
                      width: 55,
                      height: 55,
                      borderRadius: 65 / 2,
                      paddingLeft: 16,
                      paddingTop: 13,
                      backgroundColor: '#78bbd6',
                    }}>
                    <Image style={{width: 20, height: 25}} source={Pt} />
                  </View>
                </View>
              </View>

              <Text style={styles.titleStyle}>Physical Therapy</Text>
            </View>
          </TouchableOpacity>
        </View>
      </ScrollView>
    );
  }
}
//styles that apply in this files

const styles = {
  listStyle: {
    paddingTop: 15,
    justifyContent: 'center',
    alignItems: 'center',
  },
  titleStyle: {
    fontSize: 13,
    paddingLeft: 0,
    paddingTop: 5,
    textAlign: 'center',
  },
  searchInput: {
    padding: 10,
    borderColor: '#CCC',
    borderWidth: 1,
    marginBottom: 5,
    margin: 5,,
  },
  iconborder1: {
    borderWidth: 2,
    borderColor: '#a6e5ff',
    width: 63,
    height: 63,
    borderRadius: 74 / 2,,
  },
  iconborder2: {
    borderWidth: 2,
    borderColor: '#78bbd6',
    width: 59,
    height: 59,
    borderRadius: 70 / 2,
  },
  iconborder3: {
    borderWidth: 1,
    borderColor: 'white',
    width: 55,
    height: 55,
    borderRadius: 65 / 2,
    paddingLeft: 14,
    paddingTop: 13,
    backgroundColor: '#78bbd6',
  },
};

export default DoctorsList;
