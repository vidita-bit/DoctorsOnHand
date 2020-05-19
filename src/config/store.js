import { createStore, applyMiddleware } from 'redux';
import { AsyncStorage } from 'react-native';
import { persistStore, persistReducer } from 'redux-persist';
import thunk from 'redux-thunk';

import reducers from '../reducers/indexx';


//console.log(reducers);

const persistConfig = {
    key: 'root',
    storage: AsyncStorage,
    whitelist: []
  };

const persistedReducer = persistReducer(persistConfig, reducers);
  
export default () => {
  let store = createStore(persistedReducer, {}, applyMiddleware(thunk));
  let persistor = persistStore(store);
// alert(persistor);
  return { store, persistor };
};
//uski hi sargam

