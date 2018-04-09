const Koa = require('koa')
const router = require('koa-router')()
const bodyParser = require('koa-body-parser')
const app = new Koa()
const cors = require('koa2-cors');
let Controller = require('./controller')
router.post('/comments', Controller.getAllComments)
app.use(cors())
app.use(bodyParser())
app.use(router.routes())
app.listen(3000);