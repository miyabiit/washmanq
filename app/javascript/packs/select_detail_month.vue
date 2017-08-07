<template>
  <month-picker :year="year" :month="month" @changeYear="onChangeYear" @changeMonth="onChangeMonth"></month-picker>
</template>

<script>
export default {
  props: {
    year: Number,
    month: Number,
    placeId: Number
  },
  methods: {
    onChangeYear(year) {
      location.href = `/sales/${year}/${this.month}/places/${this.placeId}`
    },
    onChangeMonth(month) {
      location.href = `/sales/${this.year}/${month}/places/${this.placeId}`
    }
  }
}
</script>
