<template>
  <div>
    <div class="mdc-layout-grid no-margin-grid">
      <div class="mdc-layout-grid__inner">
        <div class="mdc-layout-grid__cell mdc-layout-grid__cell--span-3">
          <month-picker :year="year" :month="month" @changeYear="onChangeYear" @changeMonth="onChangeMonth"></month-picker>
        </div>
        <div class="mdc-layout-grid__cell mdc-layout-grid__cell--span-3">
          <div class="mdc-select select-place" role="listbox" tabindex="0">
            <span class="mdc-select__selected-text">{{ place.name }}</span>
            <div class="mdc-simple-menu mdc-select__menu">
              <ul class="mdc-list mdc-simple-menu__items">
                <li v-for="place in places" @click="selectPlace(place.id)" class="mdc-list-item" role="option" tabindex="0">
                  {{ place.name }}
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
    <table class="ui blue celled structured table">
      <thead>
        <tr>
          <th rowspan="2">種別</th>
          <th rowspan="2">売上台数</th>
          <th colspan="2">売上金額</th>
          <th rowspan="2">操作</th>
        </tr>
        <tr>
          <th>現金</th>
          <th>プリペイド</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(sale, index) in washSales">
          <td>{{ sale.equipment_num }}号機</td>
          <td class="number">
            <div class="ui input">
              <input type="text" v-model="sale.sales_count">
            </div>
          </td>
          <td class="number">
            <div class="ui input">
              <input type="text" v-model="sale.cash_sales_amount">
            </div>
          </td>
          <td class="number">
            <div class="ui input">
              <input type="text" v-model="sale.prepaid_sales_amount">
            </div>
          </td>
          <td>
            <a v-if="index == (washSales.length - 1)" @click="removeWashSale()" href="javascript:void(0)" class="pull-right"><i style="font-size: 1rem" class="material-icons mdc-button__icon">delete</i>&nbsp;削除</a>
          </td>
        </tr>
        <tr style="min-height: 60px">
          <td colspan="5">
            <a href="javascript:void(0)" class="pull-right" @click="addWashSale()"><i style="font-size: 1rem" class="material-icons mdc-button__icon">add</i>&nbsp;洗車売上追加</a>
          </td>
        </tr>
        <tr v-for="(sale, index) in spraySales">
          <td>スプレー{{ sale.equipment_num }}</td>
          <td class="number">
            <div class="ui input">
              <input type="text" v-model="sale.sales_count">
            </div>
          </td>
          <td class="number">
            <div class="ui input">
              <input type="text" v-model="sale.cash_sales_amount">
            </div>
          </td>
          <td class="number">
            <div class="ui input">
              <input type="text" v-model="sale.prepaid_sales_amount">
            </div>
          </td>
          <td>
            <a v-if="index == (spraySales.length - 1)" @click="removeSpraySale()" href="javascript:void(0)" class="pull-right"><i style="font-size: 1rem" class="material-icons mdc-button__icon">delete</i>&nbsp;削除</a>
          </td>
          </td>
        </tr>
        <tr style="min-height: 60px">
          <td colspan="5">
            <a href="javascript:void(0)" class="pull-right" @click="addSpraySale()"><i style="font-size: 1rem" class="material-icons mdc-button__icon">add</i>&nbsp;スプレー売上追加</a>
          </td>
        </tr>
      </tbody>
    </table>
    <div>
      <button type="button" @click="updateSales()" class="pull-right mdc-button mdc-button--raised mdc-button--primary">更新</button>
    </div>
  </div>
</template>

<script>
const MDCSelect = mdc.select.MDCSelect
const MDCSimpleMenu = mdc.menu.MDCSimpleMenu
const menuFactory = (menuEl) => {
  const menu = new MDCSimpleMenu(menuEl)
  return menu
}

export default {
  props: {
    year: Number,
    month: Number,
    place: Object,
    places: Array,
    rootPath: {
      default: '/input_sales',
      type: String
    }
  },
  data() {
    return {
      spraySales: [],
      washSales: []
    }
  },
  mounted() {
    var _this = this
    this.selects = []
    $('.select-place').each(function() {
      const select = new MDCSelect(this, undefined, menuFactory)
      select.selectedIndex = _this.places.map((p) => p.id).indexOf(_this.place.id)
      $(this).css('width', '100px')
    })
    this.fetchSales()
  },
  methods: {
    fetchSales() {
      let _this = this
      vbus.$emit('show-spinner')
      $.ajax({
          url: `/sales/${this.year}/${this.month}/places/${this.place.id}`,
          type: "GET",
          dataType: 'json'
      })
      .done(( data ) => {
        _this.washSales = data.wash_sales
        _this.spraySales = data.spray_sales
      })
      .fail(( data ) => {
        vbus.$emit('show-message-bar', 'エラーが発生しました')
      })
      .always(( data ) => {
        vbus.$emit('hide-spinner')
      })
    },
    updateSales() {
      vbus.$emit('show-spinner')
      $.ajax({
          url: `/sales/${this.year}/${this.month}/places/${this.place.id}`,
          type: "PUT",
          data: JSON.stringify({
            wash_sales: this.washSales,
            spray_sales: this.spraySales
          }),
          contentType: 'application/json',
          dataType: 'json'
      })
      .done(( data ) => {
        vbus.$emit('show-message-bar', '更新しました')
      })
      .fail(( data ) => {
        vbus.$emit('show-message-bar', 'エラーが発生しました')
      })
      .always(( data ) => {
        vbus.$emit('hide-spinner')
      })
    },
    addWashSale() {
      this.washSales.push({equipment_num: this.washSales.length+1, sales_count: 0, cash_sales_amount: 0, prepaid_sales_amount: 0})
    },
    removeWashSale() {
      this.washSales.pop()
    },
    addSpraySale() {
      this.spraySales.push({equipment_num: this.spraySales.length+1, sales_count: 0, cash_sales_amount: 0, prepaid_sales_amount: 0})
    },
    removeSpraySale() {
      this.spraySales.pop()
    },
    onChangeYear(year) {
      location.href = `${this.rootPath}/${year}/${this.month}/places/${this.place.id}/edit`
    },
    onChangeMonth(month) {
      location.href = `${this.rootPath}/${this.year}/${month}/places/${this.place.id}/edit`
    },
    selectPlace(placeId) {
      location.href = `${this.rootPath}/${this.year}/${this.month}/places/${placeId}/edit`
    }
  }
}
</script>
