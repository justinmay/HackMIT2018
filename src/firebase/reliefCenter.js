import firebase from 'firebase'
import {createUser, logIn} from './auth'
import { auth, firestore } from "./firebase"



export const addReliefCenter = async (reliefCenter) => {
  await createUser(reliefCenter.email, reliefCenter.password)
  auth.setPersistence(firebase.auth.Auth.Persistence.LOCAL)
  await logIn(reliefCenter.email, reliefCenter.password)
  firestore.collection("reliefCenter").add({
      email: reliefCenter.email,
      password: reliefCenter.password,
      contactName: reliefCenter.contactName,
      institutionName: reliefCenter.institutionName,
      institutionLatLong: reliefCenter.institutionLatLong,
      institutionPhoneNumber: reliefCenter.institutionPhoneNumber
  })
}