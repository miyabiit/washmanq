<template>
  <div>
    <div class="mdc-select select-year" role="listbox" tabindex="0">
      <span class="mdc-select__selected-text">{{year}}</span>
      <div class="mdc-simple-menu mdc-select__menu">
        <ul class="mdc-list mdc-simple-menu__items">
          <li v-for="y in yearItems" @click="selectYear(y)" class="mdc-list-item" role="option" tabindex="0">
            {{ y }}
          </li>
        </ul>
      </div>
    </div>
    年
    &nbsp;
    <div class="mdc-select select-month" role="listbox" tabindex="0">
      <span class="mdc-select__selected-text">{{month}}</span>
      <div class="mdc-simple-menu mdc-select__menu">
        <ul class="mdc-list mdc-simple-menu__items">
          <li v-for="m in monthItems" @click="selectMonth(m)" class="mdc-list-item" role="option" tabindex="0">
            {{ m }}
          </li>
        </ul>
      </div>
    </div>
    月
  </div>
</template>

<script>
// import {MDCSelect} from '@material/select'
// import {MDCSimpleMenu} from '@material/menu'
const MDCSelect = mdc.select.MDCSelect
const MDCSimpleMenu = mdc.menu.MDCSimpleMenu

const menuFactory = (menuEl) => {
  const menu = new MDCSimpleMenu(menuEl)
  return menu
}

export default {
  props: {
    year: Number,
    month: Number
  },
  data() {
    const today = new Date()
    const month = today.getFullYear()
    return {
      yearItems: [month-1, month, month+1],
      monthItems: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    }
  },
  mounted() {
    var _this = this
    this.selects = []
    $('.select-year').each(function() {
      const select = new MDCSelect(this, undefined, menuFactory)
      select.selectedIndex = _this.yearItems.indexOf(_this.year)
      // no resize! (resized in MDCSelect...)
      $(this).css('width', '60px')
    })
    $('.select-month').each(function() {
      const select = new MDCSelect(this, undefined, menuFactory)
      select.selectedIndex = _this.monthItems.indexOf(_this.month)
      // no resize! (resized in MDCSelect...)
      $(this).css('width', '45px')
    })
  },
  methods: {
    selectYear(year) {
      this.$emit('changeYear', year) 
    },
    selectMonth(month) {
      this.$emit('changeMonth', month) 
    }
  }
}
</script>

<style scoped>
</style>
