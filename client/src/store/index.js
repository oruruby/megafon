import Vue from 'vue'
import Vuex from 'vuex'

import Conference from './conference'
import App from './app'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    Conference,
    App
  }
})
