<template>
  <div>
    <div class="a-w">
      <div class="b-w">
        <div class="b-c" v-for="(item, index) in items" :key="index"><span :style="{color: item.color, fontSize: item.fontSize + 'px'}">{{item.content}}</span></div>
      </div>
      <video src="../assets/bg.mp4" controls id="vd"></video>
    </div>
  </div>
</template>

<script>
import Http from '@/http'
export default {
  data () {
    return {
      items: [],
      timers: [],
      page: 0
    }
  },
  methods: {
    async getComments () {
      let res = await Http.post('http://localhost:3000/comments', {page: this.page})
      if (res.data) {
        let items = [...res.data]
        this.items.push(...items)
        if (this.items.length > 10) {
          this.items = this.items.slice(items.length, this.items.length)
        }
      } else {
        console.log('no data')
      }
    },
    bulletCtrl () {
      let vd = document.getElementById('vd')
      vd.onplay = () => {
        this.apiTimer = setInterval(() => {
          this.page++
          this.getComments()
        }, 5000)
      }
      vd.onpause = () => {
        this.timers.map(item => {
          clearInterval(item)
        })
        clearInterval(this.apiTimer)
      }
      vd.onend = () => {
        this.timers.map(item => {
          clearInterval(item)
        })
        clearInterval(this.apiTimer)
      }
    }
  },
  created () {
    this.getComments()
  },
  updated () {
    this.bulletCtrl()
  },
  beforeDestroy () {
    clearInterval(this.apiTimer)
    this.timers.map(item => {
      clearInterval(item)
    })
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.a-w{position: relative;float: left;overflow: hidden;}
.b-w{position: absolute;width: 100%;height: 50%;}
.b-c{animation: move 5s infinite;}
@keyframes move {
  from {transform: translateX(50%);}
  to {transform: translateX(-100%);opacity: 0.5;}
}
</style>
