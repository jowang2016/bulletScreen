<template>
  <div>
    <div class="a-w">
      <div class="b-w">
        <div class="b-c" v-for="(item, index) in items" :key="index" :ref="index" :data-ref="index" v-if="item" :style="{top: index % 4 * 30 + 'px'}">
          <span :style="{color: _item.color, fontSize: _item.fontSize + 'px'}" v-for="(_item, _index) in item" :key="_index" @mouseenter="moCtrl(index)" @mouseleave="msCtrl(index)">{{_item.content}}</span>
        </div>
      </div>
      <video src="../assets/bg.mp4" id="vd"></video>
      <div class="video-ctr" @click="play">
        <img src="../assets/play.png" alt="" v-show="!playStatus">
        <img src="../assets/pause.png" alt="" v-show="playStatus">
      </div>
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
      speeds: [],
      idx: 0,
      params: [],
      playStatus: '',
      timerStopIndex: ''
    }
  },
  methods: {
    async getComments () {
      let res = await Http.post('http://localhost:3000/comments', {idx: this.idx})
      if (res.data && JSON.stringify(res.data) !== '{}') {
        let items = []
        let lens = []
        for (let k in res.data) {
          items.push(res.data[k])
          lens.push(res.data[k].length)
        }
        this.params.push(...lens)
        this.items.push(...items)
      } else {
        console.log('no data')
      }
    },
    clearCtrl (index) {
      clearInterval(this.timers[index])
      this.items[index] = null
      this.speeds[index] = undefined
      this.timers[index] = null
      this.params[index] = undefined
    },
    moCtrl (index) {
      clearInterval(this.timers[index])
      this.timerStopIndex = index
    },
    msCtrl (index) {
      if (this.playStatus) {
        this.restoreTimer(index)
      }
    },
    restoreTimer (index) {
      clearInterval(this.timers[index])
      const freq = Math.round(50 / this.params[index]) > 25 ? Math.round(50 / this.params[index]) : 25
      this.timers[index] = setInterval(() => {
        this.speeds[index]++
        if (this.speeds[index] >= 200) {
          this.clearCtrl(index, index)
          return
        }
        var left = 100 - this.speeds[index]
        if (this.$refs[index] && this.$refs[index][0]) {
          this.$refs[index][0].style.left = left + '%'
        }
      }, freq)
    },
    play () {
      let vd = document.getElementById('vd')
      if (vd.paused) {
        vd.play()
        this.playStatus = true
      } else {
        vd.pause()
        this.playStatus = false
      }
    },
    bulletCtrl () {
      let vd = document.getElementById('vd')
      vd.onplay = () => {
        this.apiTimer = setInterval(() => {
          this.items.map((item, index) => {
            if (item) {
              if (!this.speeds[index]) {
                this.speeds[index] = 0
                this.restoreTimer(index)
              } else if (this.speeds[index] > 0 && this.speeds[index] < 200) {
                if (this.timerStopIndex !== index) {
                  this.restoreTimer(index)
                }
              } else if (this.speeds[index] >= 200) {
                this.clearCtrl(index)
              }
            }
          })
          this.idx++
          this.getComments()
        }, 500)
      }
      vd.onpause = () => {
        clearInterval(this.apiTimer)
        this.timers.map(item => {
          clearInterval(item)
        })
      }
      vd.onend = () => {
        clearInterval(this.apiTimer)
        this.timers.map(item => {
          clearInterval(item)
        })
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
.b-w{position: absolute;width: 100%;height: 100%;z-index: 10;}
.b-c{position: absolute;left: 100%;min-width: 500px;}
.b-c span{margin-right: 15px;}
.video-ctr{position: absolute;width: 100%;height: 50px;bottom: 0;left: 0;background: black;color: white;z-index: 20;line-height: 50px;}
.video-ctr img{width: 40px;vertical-align: middle;}
</style>
