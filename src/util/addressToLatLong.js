const axios = require('axios')

const key = 'AIzaSyAoI3CYKQTIfXRW_dtzgFN0uF3SM6uhEKI'

export const addToLat = async (address) => {
  var parsedAddress = address.replace(/,/g , "").replace(/ /g,"+");
  try {
    const res = await axios.get(`https://maps.googleapis.com/maps/api/geocode/json?address=${parsedAddress}&key=${key}`)
    return res.data.results[0].geometry.location
  } catch (error) {
    console.error(error)
  } 
}

