import PropTypes from 'prop-types';
import React, { Component } from 'react';
import { TextInput, Text, View, StyleSheet } from 'react-native';

const propTypes = {
    mapElement: PropTypes.func,
    onSubmitEditing: PropTypes.func,
    onChangeText: PropTypes.func,
    value: PropTypes.string,
    placeholder: PropTypes.string,
    maxLength: PropTypes.number,
    keyboardType: PropTypes.string,
    secureTextEntry: PropTypes.bool,
    label: PropTypes.string
};

const defaultProps = {
    mapElement: (n) => { },
    onSubmitEditing: () => { },
    onChangeText: () => { },
    value: '',
    placeholder: '',
    maxLength: 200,
    keyboardType: 'default',
    secureTextEntry: false,
    label: ''
};

const styles = StyleSheet.create({
    inputBox: {
        width: 320,
        height: 45,
        marginTop: 20,
        marginLeft: 15,
        borderRadius: 5,
        borderWidth: 0.7,
        borderColor: '#c2c2c2',
        fontSize: 18,
        paddingLeft: 10,
        color: 'black'
    }

});

class InputText extends Component {

    // eslint-disable-next-line no-undef
    state = {
        value: ''
    }

    componentDidMount() {
        this.setState({
            value: this.props.value
        });
    }

    // eslint-disable-next-line no-undef
    onChangeText = (value) => {
        this.setState({
            value
        }, () => {
            this.props.onChangeText(value);
        })
    }

    render() {
        const { placeholder, secureTextEntry, keyboardType, maxLength, value, onChangeText, onSubmitEditing } = this.props;
        return (
            <View>
                <TextInput
                    style={styles.inputBox}
                    underlineColorAndroid="rgba(0,0,0,0)"
                    placeholder={placeholder}
                    placeholderTextColor="#9E9E9E"
                    selectionColor="#999999"
                    secureTextEntry={secureTextEntry}
                    keyboardType={keyboardType}
                    maxLength={maxLength} S
                    returnKeyType="next"
                    value={this.state.value}
                    onSubmitEditing={onSubmitEditing}
                    onChangeText={this.onChangeText} />
            </View>
        );
    }
}

InputText.defaultProps = defaultProps;

InputText.propTypes = propTypes;

export default InputText;