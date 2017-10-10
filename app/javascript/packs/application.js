/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue'
import {Vuetable} from 'vuetable-2'
import NavDrawer from './nav_drawer.vue'
import FileUpload from './file_upload.vue'
import FileTable from './file_table.vue'
import MessageBar from './message_bar.vue'
import Spinner from './spinner.vue'
import Monthpicker from './month_picker.vue'
import SalesSummaryTable from './sales_summary_table.vue'
import SelectSummaryMonth from './select_summary_month.vue'
import SelectDetailMonth from './select_detail_month.vue'
import CameraView from './camera_view.vue'
import CameraHistory from './camera_history.vue'
import AsyncComputed from 'vue-async-computed'
import axios from 'axios'
import Datepicker from 'vuejs-datepicker'
import VueDatepicker from 'vue-datepicker'
import WmqDatePicker from './wmq_date_picker'
import moment from 'moment'
import infiniteScroll from 'vue-infinite-scroll'
import InputSales from './input_sales.vue'

Vue.use(AsyncComputed)
Vue.use(infiniteScroll)

Vue.component("vuetable", Vuetable)
Vue.component("file-table", FileTable)
Vue.component('nav-drawer', NavDrawer)
Vue.component('file-upload', FileUpload)
Vue.component('message-bar', MessageBar)
Vue.component('spinner', Spinner)
Vue.component('month-picker', Monthpicker)
Vue.component('sales-summary-table', SalesSummaryTable)
Vue.component('select-summary-month', SelectSummaryMonth)
Vue.component('select-detail-month', SelectDetailMonth)
Vue.component('camera-view', CameraView)
Vue.component('camera-history', CameraHistory)
Vue.component('datepicker', Datepicker)
Vue.component('date-picker', VueDatepicker)
Vue.component('wmq-date-picker', WmqDatePicker)
Vue.component('input-sales', InputSales)

window.vbus = new Vue()
window.$vue_data = {}
window.Vue = Vue

// TODO: refactoring
Vue.set($vue_data, 'cameras', [])
Vue.set($vue_data, 'shootedAtFrom', moment().subtract(1, 'days').format('YYYY-MM-DD HH:mm'))
Vue.set($vue_data, 'shootedAtTo', moment().format('YYYY-MM-DD HH:mm'))


Vue.filter("formatDate", function(value, format) {
  if (value) {
    return moment(String(value)).format(format)
  }
})

document.addEventListener('DOMContentLoaded', () => {
  new Vue({ el: '#vue_root', data: window.$vue_data })
  mdc.autoInit()
})
