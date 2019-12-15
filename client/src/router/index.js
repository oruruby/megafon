import Vue from 'vue'
import VueRouter from 'vue-router'
import ConferencesPage from '@/pages/ConferencesPage'
import AccountPage from '@/pages/AccountPage'
import ConferencePage from '@/pages/ConferencePage'
Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'conferences',
    component: ConferencesPage
  },
  {
    path: '/conferences/:id',
    name: 'conference',
    component: ConferencePage
  },
  {
    path: '/account',
    name: 'account',
    component: AccountPage
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
