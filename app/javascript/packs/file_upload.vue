<template>
  <div>
    <form :id="id" enctype="multipart/form-data" :action="url" accept-charset="UTF-8" method="post">
      <input name="utf8" type="hidden" value="✓">
      <input type="hidden" name="authenticity_token" :value="getCsrfToken()">
      <input type="file" :name="paramName" style="display: none;">
    </form>

    <button @click="upload" class="mdc-button mdc-button--raised mdc-button--primary" data-demo-no-js="">
      {{ buttonTitle }}
    </button>
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
      id: -1
    }
  },
  created() {
    this.id = this._uid
  },
  mounted() {
    let elem = document.getElementsByName(this.paramName)[0]
    elem.addEventListener('change', () => {
      let fd = new FormData(document.getElementById(this.id))
      fd.append('utf8', "✓")
      fd.append('authenticity_token', getCsrfToken())
      $.ajax({
          url: this.url,
          type: "POST",
          data: fd,
          processData: false,
          contentType: false,
          dataType: 'json'
      })
      .done(( data ) => {
        vbus.$emit('show-message-bar', 'アップロードしました')
      })
      .fail(( data ) => {
        vbus.$emit('show-message-bar', 'アップロードに失敗しました')
      })
      .always(( data ) => {
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
