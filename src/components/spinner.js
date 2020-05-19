//This file show the spinner on screen
import React from 'react';
import { View, ActivityIndicator } from 'react-native';

const Spinner = ({ size }) => {
return (
    <View style={styles.spinnerStyle}>
        {/* ActivityIndicator is a spinner in react native */}
        <ActivityIndicator size={size || 'large'} />

    </View>
)
}
//styles use in this file
const styles = {
    spinnerStyle: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center'


    }


};
export { Spinner };
