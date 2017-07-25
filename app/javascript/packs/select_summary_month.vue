<template>
  <month-picker :year="year" :month="month" @changeYear="onChangeYear" @changeMonth="onChangeMonth"></month-picker>
</template>

<script>
export default {
  props: {
    year: Number,
    month: Number
  },
  methods: {
    onChangeYear(year) {
      location.href = `/sales/${year}/${this.month}`
    },
    onChangeMonth(month) {
      location.href = `/sales/${this.year}/${month}`
    }
  }
}
</script>
