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
    updateMemberLocal(state, member){
      const members = state.conference.members.map(imember => {
        if(imember.id == member.id){
          return {...imember, ...member}
        }else{
          return imember
        }
      })
      state.conference = {...state.conference, members}
    },
    createMemberLocal(state, member){
      const members = state.conference.members
      state.conference = {...state.conference, members: members.push(member)}
    },
    deleteMemberLocal(state, member){
      const members = state.conference.members.filter(imember => imember.id != member.id)
      state.conference = {...state.conference, members}
    },
    updateConferenceLocal(state, conference){
      if(state.conference.id == conference.id){
        state.conference = {...state.conference, ...conference}
      }
      state.conferences = state.conferences.map(i_conference => {
        if( i_conference.id == conference.id){
          return {...state.conference, status}
        }else{
          return conference
        }
      })
    }
  },
  actions: {
    updateMemberLocal({commit}, member){
      commit('updateMemberLocal', member)
    },
    createMemberLocal({commit}, member){
      commit('createMemberLocal', member)
    },
    deleteMemberLocal({commit}, member){
      commit('deleteMemberLocal', member)
    },
    updateConferenceLocal({commit}, conference){
      commit('updateConferenceLocal', conference)
    },
    async loadConferences({commit}){
      const fetch_result = await fetch('http://localhost:3000/conferences')
      const data = await fetch_result.json()
      commit('setConferences', data)
    },
    async muteMember({commit}, {id}){
      commit
      const fetch_result = await fetch('http://localhost:3000/member_actions', {
        method: 'POST',
        headers: {
          'Content-type': 'application/json'
        },
        body: JSON.stringify({
          member_id: id,
          name: 'mute'
        })
      })
      const data = await fetch_result.json()
      return data
    },
    async unmuteMember({commit}, {id}){
      commit
      const fetch_result = await fetch('http://localhost:3000/member_actions', {
        method: 'POST',
        headers: {
          'Content-type': 'application/json'
        },
        body: JSON.stringify({
          member_id: id,
          name: 'unmute'
        })
      })
      const data = await fetch_result.json()
      return data
    },
    async disconnectMember({commit}, {id}){
      commit
      const fetch_result = await fetch('http://localhost:3000/member_actions', {
        method: 'POST',
        headers: {
          'Content-type': 'application/json'
        },
        body: JSON.stringify({
          member_id: id,
          name: 'disconnect'
        })
      })
      const data = await fetch_result.json()
      return data
    },
    async deleteMember({commit}, {id}){
      commit
      const fetch_result = await fetch('http://localhost:3000/members/' + id, {
        method: 'DELETE',
      })
      const data = await fetch_result.json()
      return data
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
          name: 'start'
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