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
import Datepicker from 'vue-datepicker'
import NavDrawer from './nav_drawer.vue'
import FileUpload from './file_upload.vue'
import FileTable from './file_table.vue'
import MessageBar from './message_bar.vue'
import Spinner from './spinner.vue'
import Monthpicker from './month_picker.vue'
import SalesSummaryTable from './sales_summary_table.vue'
import SelectSummaryMonth from './select_summary_month.vue'

Vue.component("vuetable", Vuetable)
Vue.component("file-table", FileTable)
Vue.component('nav-drawer', NavDrawer)
Vue.component('file-upload', FileUpload)
Vue.component('message-bar', MessageBar)
Vue.component('spinner', Spinner)
Vue.component('date-picker', Datepicker)
Vue.component('month-picker', Monthpicker)
Vue.component('sales-summary-table', SalesSummaryTable)
Vue.component('select-summary-month', SelectSummaryMonth)

window.vbus = new Vue()

document.addEventListener('DOMContentLoaded', () => {
  new Vue({ el: '#vue_root' })
  mdc.autoInit()
})
