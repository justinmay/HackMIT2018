
import {firestore} from "../firebase/firebase"

const initialState = {}

const GET_RELIEF_CENTER = "GET_RELIEF_CENTER"

//Action Creators
const getCenter = (centerInfo) => {
  return {
    type: GET_RELIEF_CENTER,
    payload: centerInfo
  }
}

//Thunk Creator
export const getCenterThunk = (email) => async dispatch => {
  try {
    console.log("THUNK HIT")
    const reference = await firestore.collection('reliefCenter').where("email", "==", email.toString()).get()
    dispatch(getCenter(reference))
  } catch (error) {
    console.error(error)
  }
}


// export const getUserProfileInfo = () => async dispatch => {
//   try {
    
//     const user = firebase.auth().currentUser
//     const userEmail = user.email;
//     const userRef = await firestore
//       .collection("user")
//       .where("email", "==", userEmail.toString())
//       .get();
//     const docRefId = await userRef.docs[0].id;
//     const dataAPI = await firestore
//       .collection("user")
//       .doc("" + docRefId + "")
//       .get()
//       .then(user => user.data());
//     const output = { 
//       created: user.metadata.creationTime,
//       access: user.metadata.lastSignInTime,
//       name: dataAPI.name,
//       email: dataAPI.email
//     }
//     dispatch(getUser(output))
//   } catch (error) {
//     console.error(error)
//   }
// }

const reducer = (state = initialState, action) => {
  switch(action.type) {
    default: 
      return state
    case GET_RELIEF_CENTER:
      return action.payload
  }
}

export default reducer