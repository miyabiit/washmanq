<template>
  <div v-infinite-scroll="loadMore" infinite-scroll-disabled="busy" infinite-scroll-distance="20">
    <div class="mdc-grid-list mdc-grid-list--tile-aspect-4x3">
      <ul class="mdc-grid-list__tiles">
        <a href="javascript:void(0)" @click.prevent="showModal(image)" v-for="image in images">
          <camera-view :realtime="false" :camera="{imageUrl: image.url, shootedAt: image.shootedAt}"></camera-view>
        </a>
      </ul>
    </div>
    <div ref="modal" class="ui modal camera-modal" v-if="modalImage">
      <div class="header">
        {{ modalImage.shootedAt | formatDate }}
      </div>
      <i class="close icon"></i>
      <div class="image content">
        <img class="image" :src="modalImage.url">
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  props: {
    camera: Object,
    shootedAtFrom: String,
    shootedAtTo: String
  },
  data() {
    return {
      busy: false,
      last: false,
      page: 0,
      images: [],
      modalImage: null
    }
  },
  filters: {
    formatDate: function(date) {
      return moment(date).format('YYYY/MM/DD HH:mm')
    }
  },
  mounted() {
    this.resetItems()
  },
  watch: {
    shootedAtFrom() {
      this.resetItems()
    },
    shootedAtTo() {
      this.resetItems()
    }
  },
  methods: {
    resetItems() {
      this.images = []
      this.last = false
      this.page = 0;
      this.fetchItems()
    },
    fetchItems() {
      this.busy = true
      axios.get(`/cameras/${this.camera.id}/images.json`, {
        params: {
          page: this.page,
          from: this.shootedAtFrom,
          to: this.shootedAtTo
        }
      }).then(response => {
        if (response.data && response.data.length > 0) {
          for (const image of response.data) {
            this.images.push(image)
          }
          if (response.data.length < 20) {
            this.last = true
          }
        } else {
          this.last = true
        }
        this.busy = false
      })
    },
    showModal(image) {
      this.modalImage = image
      $(this.$refs.modal).modal('show')
    },
    loadMore() {
      if (!this.last) {
        this.page += 1;
        this.fetchItems()
      }
    }
  }
}
</script>

<style scoped>
.camera-modal {
  max-width: 682px;
}
</style>
