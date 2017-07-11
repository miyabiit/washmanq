<template>
  <div :id="id" class="mdc-snackbar" aria-live="assertive" aria-atomic="true" aria-hidden="true">
    <div class="mdc-snackbar__text">
    </div>
    <div class="mdc-snackbar__action-wrapper">
      <button type="button" class="mdc-button mdc-snackbar__action-button">
      </button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      id: -1,
      message: '',
      snackbar: null
    }
  },
  created() {
    this.id = this._uid
  },
  mounted() {
    let MDCSnackbar = global.mdc.snackbar.MDCSnackbar
    this.snackbar = new MDCSnackbar(document.getElementById(this.id))
    vbus.$on('show-message-bar', (msg) => {this.show(msg)})
  },
  methods: {
    show(msg) {
      this.message = msg
      this.snackbar.show({
        dismissesOnAction: true,
        message: this.message,
        multiline: true,
        actionText: '閉じる',
        actionHandler: () => { console.log('message close') },
        timeout: 2750
      })
    }
  }
}
</script>
