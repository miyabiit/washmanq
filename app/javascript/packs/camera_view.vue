<template>
  <li class="mdc-grid-tile">
    <div class="mdc-grid-tile__primary">
      <img class="mdc-grid-tile__primary-content" :src="imageUrl" />
    </div>
    <div class="mdc-grid-tile__footer">
      <span class="mdc-grid-tile__title" v-if="camera.displayName">{{ camera.displayName }}</span>
      <span class="mdc-grid-tile__support-text" v-if="shootedAt">{{ shootedAtText }}</span>
    </div>
  </li>
</template>

<script>
export default {
  props: {
    camera: Object,
    realtime: {
      type: Boolean,
      default: true
    },
    imageHeight: {
      type: String,
      default: '220px'
    }
  },
  computed: {
    shootedAtText() { return moment(this.shootedAt).format('YYYY/MM/DD HH:mm') }
  },
  data() {
    return { imageUrl: this.camera.imageUrl, shootedAt: this.camera.shootedAt }
  },
  beforeDestroy() {
    if (this.cameraStream) {
      App.cable.subscriptions.remove(this.cameraStream)
    }
  },
  mounted() {
    let _this = this
    if (this.realtime) {
      this.cameraStream = App.cable.subscriptions.create({channel: "CameraChannel", id: this.camera.id}, {
        received(data) {
          console.log('receive data ====')
          console.log(data)
          console.log('====')
          _this.imageUrl = data.imageUrl
          _this.shootedAt = data.shootedAt
        }
      })
    }
  },
  methods: {
  }
}
</script>

<style scoped>
</style>
