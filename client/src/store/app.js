export default {
  state: {
    title: ''
  },
  mutations: {
    setTitle(state, payload){
      state.title = payload
    }
  },
  actions: {
    setTitle({commit}, payload){
      commit('setTitle', payload)
    }
  },
  getters: {
    title(state){
      return state.title
    }
  }
}