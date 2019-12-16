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
    },
    updateMemberLocal(state, {id, status}){
      const members = state.conference.members.map(member => {
        if(members.id == id){
          return {...member, status}
        }else{
          return member
        }
      })
      state.conference = {...state.conference, members}
    },
    updateConferenceLocal(state, {id, status}){
      if(state.conference.id == id){
        state.conference = {...state.conference, status}
      }
      state.conferences = state.conferences.map(conference => {
        if( conference.id == id){
          return {...state.conference, status}
        }else{
          return conference
        }
      })
    }
  },
  actions: {
    updateConferenceLocal({commit}, {id, status}){
      commit('updateConferenceLocal', {id, status})
    },
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