export default {
  state: {
    conferences: [

    ],
    conference: null
  },
  mutations: {
    setConferences(state, payload){
      state.conferences = payload
    },
    setConference(state, payload){
      state.conference = payload
    }
  },
  actions: {
    async loadConferences({commit}){
      const fetch_result = await fetch('http://localhost:3000/conferences')
      const data = await fetch_result.json()
      commit('setConferences', data)
    },
    async startConference({commit}, {id}){
      commit
      const fetch_result = await fetch('http://localhost:3000/conference_actions', {
        method: 'POST',
        headers: {
          'Content-type': 'application/json'
        },
        body: JSON.stringify({
          conference_id: id,
          name: 'run'
        })
      })
      const data = await fetch_result.json()
      return data
    },
    async stopConference({commit}, {id}){
      commit
      const fetch_result = await fetch('http://localhost:3000/conference_actions', {
        method: 'POST',
        headers: {
          'Content-type' : 'application/json'
        },
        body: JSON.stringify({
          conference_id: id,
          name: 'stop'
        })
      })
      const data = await fetch_result.json()
      return data
    },
    async loadConference({commit}, {id}){
      const fetch_result = await fetch('http://localhost:3000/conferences/' + id)
      const data = await fetch_result.json()
      commit('setConference', data)
    },
    async addMember({commit}, {phone, conferenceId}){
      commit
      const fetch_result = await fetch('http://localhost:3000/members/', {
        method: 'POST',
        headers: {
          'Content-type': 'application/json'
        },
        body: JSON.stringify({
          phone: phone,
          conference_id: conferenceId
        })
      })
      const data = await fetch_result.json()
      return data

    }
  },
  getters: {
    conferences(state){
      return state.conferences
    },
    conference(state){
      return state.conference
    }
  }
}