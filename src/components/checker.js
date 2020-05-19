import React, {Component} from 'react';
import {
  View,
  Text,
  TextInput,
  StyleSheet,
  Button,
  TouchableHighlightBase,
} from 'react-native';
import firebase from 'firebase';

export default class checker extends Component {
  constructor(props) {
    super(props);
    this.state = {
      email: '',
      password: '',
    };
  }
  
  Signin() {
    firebase
      .auth()
      .signInWithEmailAndPassword(this.state.email, this.state.password)
      .then(this.check)
      .catch(error => {
        //alert(error.message);
      });
  }
  render() {
    return (
      <View style={styles.container}>
        <TextInput
          name="email"
          style={styles.input}
          onChangeText={email => this.setState({email})}
        />
        <TextInput
          name="password"
          style={styles.input}
          onChangeText={password => this.setState({password})}
        />
        <View style={{marginTop: 30}}>
          <Button onPress={this.Signin.bind(this)} title="click me" />
        </View>
      </View>
    );
  }
}
const styles = StyleSheet.create({
  container: {
    justifyContent: 'center',
    alignItems: 'center',
    flex: 1,
  },
  input: {
    marginTop: 30,
    height: 50,
    width: 300,
    borderColor: 'red',
    borderWidth: 3,
  },
});
