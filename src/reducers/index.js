import { combineReducers } from 'redux';
import AuthReducer from './AuthReducer';
import EmployeeFormReducer from './EmployeeFormReducer';
import SpecialityListReducer from './SpecialityListReducer';
import DoctorReducer from './DoctorReducer';
import { reducer as formReducer } from 'redux-form';
import authReducer from './auth.reducer.js';


export default combineReducers({
  authReducer,
  form: formReducer,
  employeeForm: EmployeeFormReducer,
  specialityList: SpecialityListReducer,
  doctorReducer: DoctorReducer
});
