<template>
  <div class="server-logs">
    <span>Server Logs:</span>
    <pre v-if="response" class="response">{{ response }}</pre>
  </div>
</template>

<style lang="scss" scoped>
.server-logs {
  max-width: 400px;
  margin: 0 auto;
  span {
    font: bold 10px monospace;
  }
  .response {
    overflow: scroll;
    padding: 5px 5px 10px 5px;
    border: solid 1px #555;
    background-color: #333;
    color: #EEE;
  }
}
</style>

<script>
import axios from 'axios'

export default {
  name: 'ServerLogs',
  data: () => ({
    response: null,
  }),
  methods: {
    getLogs() {
      const timestamp = new Date().getTime()

      axios.get(`/httpd-error.log?t=${timestamp}`)
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
  },
  mounted() {
    setInterval(this.getLogs, 2000)
  }
}
</script>
