<template>
  <div id="menu_drawer" class="drawer-content">
    <nav class="mdc-permanent-drawer">
      <div class="mdc-list-group">
        <nav id="icon-with-text-demo" class="mdc-list">
          <a class="mdc-list-item" href="#" data-mdc-tabindex-handled="true" tabindex="-1">
            <i class="material-icons mdc-list-item__start-detail" aria-hidden="true">photo_camera</i>監視カメラ
          </a>
          <a class="mdc-list-item" href="#" data-mdc-tabindex-handled="true" tabindex="-1">
            <i class="material-icons mdc-list-item__start-detail" aria-hidden="true">trending_up</i>統計情報
          </a>
          <a class="mdc-list-item" href="#" data-mdc-tabindex-handled="true" tabindex="-1">
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
    toggle() {
      if (!this.drawer) {
        let MDCTemporaryDrawer = mdc.drawer.MDCTemporaryDrawer
        this.drawer = new MDCTemporaryDrawer(document.getElementById('menu_drawer'));
      }
      this.drawer.open = true
    }
  }
}
</script>

<style scoped>
.drawer-content {
  display: flex;
  flex: 1 1 auto;
  height: 100%;
  box-sizing: border-box;
}
</style>
