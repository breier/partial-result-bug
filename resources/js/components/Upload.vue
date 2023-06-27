<template>
  <div class="upload">
    <pre v-if="response" class="response">{{ response }}</pre>
    <div v-if="imagePreview" class="preview">
      <img :src="imagePreview" alt="Preview" />
    </div>
    <div class="input">
      <input type="file" accept="image/*, application/pdf" @change="imageSelected" />
      <input type="button" value="Upload!" @click="uploadFile">
    </div>
  </div>
</template>

<style lang="scss" scoped>
.upload {
  max-width: 400px;
  margin: 0 auto;
  .response {
    border: solid 1px #555;
    background-color: #333;
    color: #EEE;
    padding: 5px;
  }
  .preview {
    padding: 20px;
    img {
      border: solid 1px #555;
      border-radius: 10px;
      max-width: 360px;
    }
  }
  .input input[type=file] {
    max-width: 330px;
  }
}
</style>

<script>
import axios from 'axios'

export default {
  name: 'Upload',
  data: () => ({
    response: null,
    imagePreview: null,
    imageFile: null,
  }),
  methods: {
    imageSelected(e) {
      if (e.target.files.length != 0) {
        this.imageFile = e.target.files[0]
        var blob = this.imageFile.type.match(/\/pdf$/)
          ? new Blob([this.imageFile], {type: 'application/pdf'})
          : this.imageFile

        this.imagePreview = URL.createObjectURL(blob)
      }
    },
    uploadFile() {
      let formData = new FormData()
      formData.append('image', this.imageFile)
      axios.post('/api/upload', formData)
        .then(response => {
          if (response.data.error) {
            this.response = response.data.error
          } else {
            this.response = response.data
          }
        }).catch(error => {
          this.response = error.message
        })
    },
  }
}
</script>
