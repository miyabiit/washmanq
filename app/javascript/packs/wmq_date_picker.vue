<template>
  <date-picker :date="syncDate" :option="option"></date-picker>
</template>

<script>
import moment from 'moment'

export default {
  props: {
    date: String
  },
  data() {
    return { 
      syncDate: {time: this.date},
      option: {
        type: 'min',
        week: ['月', '火', '水', '木', '金', '土', '日'],
        month: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
        format: 'YYYY-MM-DD HH:mm',
        buttons: { },
        inputClass: {ui: true, input: true},
        inputStyle: {
          'display': 'inline-block',
          'padding': '6px',
          'line-height': '22px',
          'font-size': '16px',
          'border': '2px solid #fff',
          'box-shadow': '0 1px 3px 0 rgba(0, 0, 0, 0.2)',
          'border-radius': '2px',
          'color': '#5F5F5F',
          'max-width': '170px'
        },
        buttons: {
          ok: 'OK',
          cancel: 'キャンセル'
        },
      }
    }
  },
  watch: {
    'syncDate.time': function(val) {
      console.log('syncDate new value = ' + val)
      this.$emit('change-date', val)
    }
  }
}
</script>
