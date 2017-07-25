<template>
  <div>
    <form :id="id" enctype="multipart/form-data" :action="url" accept-charset="UTF-8" method="post">
      <input name="utf8" type="hidden" value="✓">
      <input type="hidden" name="authenticity_token" :value="getCsrfToken()">
      <input type="file" :name="paramName" style="display: none;">
    </form>

    <div class="mdc-layout-grid" style="margin: 0; padding: 0">
      <div class="mdc-layout-grid__inner" style="margin: 0; padding: 0">
        <div class="mdc-layout-grid__cell mdc-layout-grid__cell--span-4" style="margin: 0; padding: 0">
          <button @click="upload" class="mdc-button mdc-button--raised mdc-button--primary" data-demo-no-js="">
            {{ buttonTitle }}
          </button>
        </div>
        <div class="mdc-layout-grid__cell mdc-layout-grid__cell--span-8" style="margin: 0; padding: 0">
          <div v-if="existsError" class="error-theme">
            <i class="material-icons" aria-hidden="true">error</i>
            {{ errorMessages[0] }}
            <span v-if="errorMessagesMore">...</span>
          </div>
        </div>
      </div>
    </div>

    <aside :id="id + '_dialog'"
      class="mdc-dialog"
      role="alertdialog"
      >
      <div class="mdc-dialog__surface">
        <section class="mdc-dialog__body">
          <ul class="mdc-list">
            <li v-for="msg in errorMessages" class="mdc-list-item">{{ msg }}</li>
          </ul>
        </section>
        <footer class="mdc-dialog__footer">
          <button type="button" class="mdc-button mdc-dialog__footer__button mdc-dialog__footer__button--accept">閉じる</button>
        </footer>
      </div>
      <div class="mdc-dialog__backdrop"></div>
    </aside>
  </div>
</template>

<script>
export default {
  props: {
    buttonTitle: String,
    url: String,
    paramName: String
  },
  data () {
    return {
      id: -1,
      errorMessages: []
    }
  },
  created() {
    this.id = this._uid
  },
  computed: {
    existsError() {
      return this.errorMessages.length > 0
    },
    errorMessagesMore() {
      return this.errorMessages.length > 1
    }
  },
  mounted() {
    let elem = document.getElementsByName(this.paramName)[0]
    elem.addEventListener('change', () => {
      let fd = new FormData(document.getElementById(this.id))
      fd.append('utf8', "✓")
      fd.append('authenticity_token', getCsrfToken())
      vbus.$emit('show-spinner')
      $.ajax({
          url: this.url,
          type: "POST",
          data: fd,
          processData: false,
          contentType: false,
          dataType: 'json'
      })
      .done(( data ) => {
        //vbus.$emit('show-message-bar', 'アップロードしました')
        this.errorMessages = []
        window.location.reload()
      })
      .fail(( data ) => {
        vbus.$emit('show-message-bar', 'アップロードに失敗しました')
        const json = data.responseJSON
        if (json && json.error && json.error.messages) {
          this.errorMessages = json.error.messages
        }
      })
      .always(( data ) => {
        vbus.$emit('hide-spinner')
        document.getElementById(this.id).reset()
      })
      return false
    }, false)
  },
  methods: {
    getCsrfToken() {
      return window.getCsrfToken()
    },
    upload() {
      let elem = document.getElementsByName(this.paramName)[0]
      elem.click()
    }
  }
}
</script>
