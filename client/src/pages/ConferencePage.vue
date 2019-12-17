<template>
  <div v-if="conference">
    <div class="" >
      <div class="top-part">
        <h2 class="conference-name">{{ conference.name }}</h2>
        <a href="#">
          <i class="fa fa-gear" style="color: #AAAAAA; font-size: 20px"></i>
        </a>
      </div>
      <div  class="centred-part">
        <a v-if="conference.status != 'active'" href="#" :class="{'button' : true, 'disabled' : conference.status == 'pending'}" @click="startConference">
          Начать
        </a>
        <a v-if="conference.status == 'active'" href="#" class="button" @click="stopConference">
          Закончить
        </a>
        <div class="sub-centred-part">
          <span class="sub-message">Состояние:</span>
          <span class="message">{{ conference.status }}</span>
        </div>
      </div>
    </div>
    <div class="member-block">
      <h2 class="member-list">Список участников</h2>
      <a href="#" @click="showModal = true" class="button"> + Добавить</a>
    </div>
    <div>
      <ul>
        <li class="member" v-for="member in conference.members" :key="member.id">
          <i class="fa fa-user" style="color: #aaa; font-size:30px"></i>
          <div class="member-content">
            <h3 class="member-name"> {{ member.name }} </h3>
            <span class="member-status"> {{ member.status }} </span>
          </div>
        </li>
      </ul>
    </div>
    <modal v-if="showModal" @close="showModal = false">
      <h3 slot="header" style="font-style: normal; font-weight: normal;">Добавить участника</h3>
      <div slot="body">
        <input v-model="numberField" type="text" class="my-custom-input">
        <ul>
          <li v-for="(errors, fieldName) in errors" :key="fieldName">
            <span class="error" v-for="(error, index) in errors" :key="index">
              {{ fieldName }} {{ error }} 
            </span>
          </li>
        </ul>
      </div>
      <div slot="footer" style="width: 100%; display: flex; justify-content: space-between">
        <a class="button" href="#" @click="addMember"> Добавить </a>
        <a class="button" href="#" @click="close"> Отменить </a>
      </div>
    </modal>
  </div>
</template>

<script>

import Modal from '@/components/Modal'
export default {
  components: {
    Modal
  },
  channels: {
    ConferenceChannel: {
      connected() {
        console.log('connected')
      },
      rejected() {
        console.log('rejected')
      },
      received(data) {
        if(data.content.type == 'member'){
          this.$store.dispatch('updateMemberLocal', {id: data.content.id, status: data.content.status})
        }else if(data.content.type == 'conference'){
          this.$store.dispatch('updateConferenceLocal', {status: data.content.status, id: data.content.id})
        } else {
          this.$store.dispatch('updateConferenceLocal', data.content)
        }
      },
      disconnected() {
        console.log('disconnected')
      }
    }
  },
  data: () => {
    return {
      showModal: false,
      numberField: '',
      errors: {}
    }
  },
  computed: {
    conference(){
      return this.$store.getters.conference
    }
  },
  mounted(){
    this.$store.dispatch('setTitle', 'Управление конференцией')
    this.$store.dispatch('loadConference', {id: this.$route.params.id})
    .then( () => {
      this.$cable.subscribe({
        channel: 'ConferenceChannel',
        room: this.conference.id
      });
    })

  },
  methods: {
    startConference(){
      this.$store.dispatch('startConference', { id: this.conference.id })
    },
    stopConference(){
      this.$store.dispatch('stopConference', { id: this.conference.id })
    },
    close(){
      this.errors = {}
      this.numberField = ''
      this.showModal = false
    },
    addMember(){
      this.errors = {}
      this.$store.dispatch('addMember', {
        phone: this.numberField,
        conferenceId: this.conference.id
      })
      .then(result => {
        if(result.errors){
          this.errors = result.errors
        }else{
          this.showModal = false
          this.numberField = ''
        }
      })
      .catch(error => {
        throw error
      })
    }
  }
}
</script>

<style scoped>
a.disabled {
  pointer-events: none;
  cursor: default;
  opacity: 0.3;
}
  .member{
    display: flex;
    padding-left: 15px;
    padding-right: 15px;
    width: 100%;
    box-sizing: border-box;
    padding-top: 10px;
    padding-bottom: 10px;
    align-items: center;
    border-bottom: 1px solid #ccc;
  }
  .member-content{
    padding-left: 15px;
  }
  .member-name{
    font-style: normal;
    font-weight: normal;
    font-size: 12px;
    line-height: 14px;
  }
  .member-status{
    font-style: normal;
    font-weight: normal;
    font-size: 10px;
    line-height: 12px;
    color: #1A6822;
  }
  ul{
    list-style-type: none;
  }
  .error{
    font-size: 13px;
    color: red;
  }
  .member-block{
    display: flex;
    border-bottom: 1px #ccc solid;
    align-items: center;
    justify-content: space-between;
    padding-top: 10px;
    padding-left: 15px;
    padding-right: 15px;
    padding-bottom: 10px;
  } 
  .top-part{
    display: flex;
    width: 100%;
    box-sizing: border-box;
    padding-left: 15px;
    padding-right: 15px;
    padding-top: 15px;
    padding-bottom: 15px;
    justify-content: space-between;
    align-items: center;
  }
  .sub-centred-part{
    display: flex;
    flex-direction: column;
    padding-left: 15px;
    padding-bottom: 5px;
    justify-content: space-between;
  }
  .centred-part{
    display: flex;
    width: 100%;
    box-sizing: border-box;
    padding-left: 15px;
    padding-right: 15px;
    padding-bottom: 20px;
    border-bottom: 1px #ccc solid;
  }
  .conference-name{
    font-style: normal;
    font-weight: 300;
    font-size: 20px;
    line-height: 23px;
  }
  .member-list{
    font-style: normal;
    font-weight: 300;
    font-size: 18px;
    line-height: 21px;
    color: #888888;
  }
  .my-custom-input{
    font-style: normal;
    font-weight: normal;
    font-size: 12px;
    line-height: 14px;
    width: 289px;
    color: #00985F;
    border: 1px solid #00985F;
    padding: 9px;
    box-sizing: border-box;
    width: 100%;
  }
  .button{
    font-style: normal;
    font-weight: normal;
    font-size: 12px;
    line-height: 14px;
    color: #00985F;
    border: 1px solid #00985F;
    padding: 9px 40px 9px 40px;
  }
  .sub-message{
    font-style: normal;
    font-weight: normal;
    font-size: 12px;
    line-height: 14px;
    color: #333333;
  }
  .message{
    font-style: normal;
    font-weight: normal;
    font-size: 12px;
    line-height: 14px;
    color: #00985F;
  }
</style>