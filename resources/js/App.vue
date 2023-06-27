<template>
  <div id="app">
    <h2>Partial Result Bug</h2>
    <hr/>
    <div class="content">
      <upload />
    </div>
  </div>
</template>

<style lang="scss" scoped>
h2 {
    text-align: center;
}
.content {
  padding: 20px;
}
</style>

<script>
import Upload from './components/Upload.vue'

export default {
  name: 'App',
  components: {
    Upload
  }
}
</script>
