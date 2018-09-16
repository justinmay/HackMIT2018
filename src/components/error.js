import React from 'react';
import { Link} from "react-router-dom";
import {Button, ButtonToolbar} from "react-bootstrap"
import e1 from '../imgs/e1.png'; 
import HomePage from '../components/HomePage'
class App extends React.Component {
   render() {
      return (
         <div>
            <Header/>
            <Content/>
         </div>
      );
   }
}
class Header extends React.Component {
   render() {
      return (
         <div>
            <h1 style={style}>Oops</h1>
         </div>
      );
   }
}
class Content extends React.Component {
   render() {
      return (
         <div className="Image"style={style} >
            <h2 style={style}>Something Went Wrong</h2>
            <p id="taco"style={style}>We're sorry for the inconvenience, please try again!</p>
            <img id="img" src={e1}style={shift}></img>
            <br></br>
            <Link to="/login">
            <ButtonToolbar>
     <Button className="B1"bsSize="large" type="button">
          Back
     </Button>
     </ButtonToolbar>
 </Link>
         </div>
         
      );
   }

}


  const shift={

  };
const style = {
   
    color: 'white',
    textAlign: 'center',
   

  };
export default App;