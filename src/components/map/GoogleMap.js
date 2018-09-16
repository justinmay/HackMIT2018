import React, {Component} from 'react'
import {Map, InfoWindow, Marker, GoogleApiWrapper} from 'google-maps-react';

const key = 'AIzaSyDyu-krxk2k2W6nW70MA0FPDyqXnaPZs34'

export class GoogleMap extends Component {
  render() {
    const style = {
      width: '100vw',
      height: '100vh'
    }
    return(
      <div style={style}>
        <Map google={this.props.google}></Map>
      </div>
    )
  }
}

export default GoogleApiWrapper({
  apiKey: key
})(GoogleMap)