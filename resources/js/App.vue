<template>
  <div id="app">
    <h2>Partial Result Bug</h2>
    <hr/>
    <div class="content">
      <upload />
    </div>
    <div class="server-logs">
      <server-logs />
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
import ServerLogs from './components/ServerLogs.vue'
import Upload from './components/Upload.vue'

export default {
  name: 'App',
  components: {
    Upload,
    ServerLogs,
  }
}
</script>
