import { auth } from "./firebase"

//Log in state
export const user = auth.currentUser;

//Sign Up
export const createUser = async (email, password) => {
  try {
    await auth.createUserWithEmailAndPassword(email,password)
    console.log("signed up!")
  } catch (error) {
    console.error(error)
  }
}

//Log In
export const logIn = async (email, password) => {
  try {
    await auth.signInWithEmailAndPassword(email,password)
    console.log('Logged in!')
  } catch (error) {
    console.error(error)
  }
}

//Sign Out
export const signOut = async () => {
 try {
  await auth.signOut()
  console.log('logged out!')

 } catch (error) {
   console.error(error)
 }
}

