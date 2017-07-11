<template>
  <div id="menu_drawer" class="drawer-content">
    <nav class="mdc-permanent-drawer">
      <div class="mdc-list-group">
        <nav id="icon-with-text-demo" class="mdc-list">
          <a :class="{'mdc-permanent-drawer--selected': isSelected('cameras')}" class="mdc-list-item" href="/cameras" data-mdc-tabindex-handled="true" tabindex="-1">
            <i class="material-icons mdc-list-item__start-detail" aria-hidden="true">photo_camera</i>監視カメラ
          </a>
          <a :class="{'mdc-permanent-drawer--selected': isSelected('sales')}" class="mdc-list-item" href="/sales" data-mdc-tabindex-handled="true" tabindex="-1">
            <i class="material-icons mdc-list-item__start-detail" aria-hidden="true">trending_up</i>統計情報
          </a>
          <a :class="{'mdc-permanent-drawer--selected': isSelected('sales_files')}"  class="mdc-list-item" href="/sales_files" data-mdc-tabindex-handled="true" tabindex="-1">
            <i class="material-icons mdc-list-item__start-detail" aria-hidden="true">file_upload</i>データインポート
          </a>
        </nav>
      </div>
    </nav>
  </div>
</template>

<script>
export default {
  props: {
    title: String
  },
  data () {
    return {
      drawer: null
    }
  },
  methods: {
    isSelected(pathname) {
      return window.location.pathname == `/${pathname}`
    },
    toggle() {
      if (!this.drawer) {
        let MDCPersistentDrawer = mdc.drawer.MDCPersistentDrawer
        this.drawer = new MDCPersistentDrawer(document.getElementById('menu_drawer'));
      }
      this.drawer.open = !this.drawer.open
    }
  }
}
</script>
