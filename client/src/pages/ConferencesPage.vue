<template>
  <div>
    <a class="button" href="#" @click="newConference" style=" margin: auto; margin-top: 10px; width: 200px; display: block; text-align: center"> + Добавить конференцию </a>
    <ul class="conference-list">
      <router-link class="conference-link" :to="'conferences/' + conference.id"  v-for="conference in conferences" :key="conference.id">
        <li class="conference">
          <i class="fa fa-group conference-icon" style="font-size: 25px; color: #999"></i>
          <div class="confrerence-centre-part">
            <span class="conference-name">
              {{ conference.name }}
            </span>
            <span class="conference-status">
              {{ conference.status }}
            </span>
          </div>
          <div class="conference-rigth-part">
            <span class="confrence-mssage">
              {{ conference.message }}
            </span>
            <span class="conference-counter">
              {{ conference.counter }}
            </span>
          </div>
        </li>
      </router-link>
    </ul>
    <modal v-show="showModal" @close="showModal = false">
      <h3 slot="header" style="font-style: normal; font-weight: normal;">Добавить конференцию</h3>
      <div slot="body">
        <input v-model="textField" type="text" class="my-custom-input">
        <ul>
          <li v-for="(errors, fieldName) in errors" :key="fieldName">
            <span class="error" v-for="(error, index) in errors" :key="index">
              {{ fieldName }} {{ error }} 
            </span>
          </li>
        </ul>
      </div>
      <div slot="footer" style="width: 100%; display: flex; justify-content: space-between">
        <a class="button" href="#" @click="addConference"> Добавить </a>
        <a class="button" href="#" @click="close"> Отменить </a>
      </div>
    </modal>
  </div>
</template>

<script>
import Modal from '@/components/Modal'
export default {
  mounted(){
    this.$store.dispatch('setTitle','Конференции')
    this.$store.dispatch('loadConferences')
    .then(() => {
      this.$cable.subscribe({
        channel: 'UserChannel',
        room: "1"
      });
    })
  },
  channels: {
    UserChannel: {
       connected() {
        console.log('connected')
      },
      rejected() {
        console.log('rejected')
      },
      received(result) {
        const actions = {
          create_conference: conference => {
            this.$store.dispatch('createConferenceLocal', conference)
          },
          delete_conference: conference => {
            this.$store.dispatch('deleteConferenceLocal', conference)
          },
        }
        actions[result.content.type](result.content.data)
      },
      disconnected() {
        console.log('disconnected')
      }
    }
  },
  components: {
    Modal
  },
  computed: {
    conferences(){
     return this.$store.getters.conferences
    }
  },
  data: () => {
    return {
      showModal: false,
      textField: '',
      errors: {}
    }
  },
  methods: {
    newConference(){
      this.showModal = true
    },
    addConference(){
      this.errors = {}
      this.$store.dispatch('addConference', {
        name: this.textField
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
    },
    close(){
      this.errors = {}
      this.textField = ''
      this.showModal = false
    },
  }
}
</script>

<style scoped>

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

.conference-list{
  display: flex;
  flex-direction: column;
}

.confrerence-centre-part{
  display: flex;
  flex-direction: column;
}

.conference-rigth-part{
  display: flex;
  align-items: flex-end;
  flex-direction: column;
}

.error{
  font-size: 13px;
  color: red;
}

ul{
  list-style-type: none;
}

.conference-status{
  font-style: normal;
  font-weight: normal;
  font-size: 12px;
  line-height: 20px;

  color: #1A6822;
}

.conference-counter{
  font-style: normal;
font-weight: normal;
  line-height: 20px;


color: #752B90;
}
.confrence-mssage{
  font-style: normal;
font-weight: normal;
font-size: 11px;
line-height: 20px;

color: #999999;
}
.conference-icon{
}
.conference-name{
  font-style: normal;
font-weight: 300;
font-size: 16px;
line-height: 20px
}
  .conference{
    padding-left: 10px;
    padding-right: 10px;
    display: flex;
    justify-content: space-between;
    width: 100%;
    box-sizing: border-box;
    height: 60px;
    align-items: center;
    border-bottom: 1px solid #CCCCCC;
  }
  .router-link-active{
    background-color: #333;
  }
</style>