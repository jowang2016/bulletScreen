import Axios from 'axios'
import Qs from 'qs'
class Http {
  static get (url, param = {}) {
    return new Promise((resolve, reject) => {
      resolve(Axios.get(url, Qs.stringify(param)))
    })
  }
  static post (url, param = {}) {
    return new Promise((resolve, reject) => {
      resolve(Axios.post(url, Qs.stringify(param)))
    })
  }
}
export default Http
