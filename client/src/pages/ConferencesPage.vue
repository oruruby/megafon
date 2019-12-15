<template>
  <div>
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
  </div>
</template>

<script>
export default {
  mounted(){
    this.$store.dispatch('setTitle','Конференции')
    this.$store.dispatch('loadConferences')
  },
  computed: {
    conferences(){
     return this.$store.getters.conferences
    }
  }
}
</script>

<style scoped>

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