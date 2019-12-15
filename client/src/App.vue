<template>
  <div id="app">
    <div class="nav">
      <h1>
        <router-link to="/">
         {{title}} 
        </router-link>
         
        </h1>
      <router-link class="my-icon-link" to="/account">
        <i class="fa fa-user" style="color: white;font-size: 25px;"></i>
      </router-link>
    </div>
    <router-view/>
  </div>
</template>

<script>
export default {
  computed: {
    title(){
      return this.$store.getters.title
    }
  }
}
</script>

<style>
  *{
    margin: 0;
    padding: 0;
  font-family: Roboto;
  }
  .router-link-active{
    text-decoration: none;
    color: inherit;
  }
  a{
    text-decoration: none;
    color: inherit;
  }
</style>

<style scoped>

.nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-left: 15px;
  box-sizing: border-box;
  height: 50px;
  width: 100%;
  background: #00985F;
  box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
}

h1{
  font-style: normal;
  font-weight: 300;
  font-size: 22px;
  line-height: 26px;
  color: #FFFFFF;

}

.my-icon-link{
  display: flex;
  height: 100%;
}

.my-icon-link::before{
  display: inline-block;
  width: 1px;
  border-left: 1px solid #fff;
  opacity: 0.40;
  height: 100%;
  content: ""
}

.my-icon-link i{
  margin: auto;
  padding-left: 20px;
  padding-right: 20px;
}

</style>
