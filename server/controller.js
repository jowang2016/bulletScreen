var Model = require('./model')
async function getAllComments(ctx) {
  const res = await Model.Comments.query('*', ctx.request.body.idx)
  let obj = {}
  res.map(item => {
    if (!Object.prototype.hasOwnProperty.call(obj, item.idx)) {
      obj[item.idx] = []
    }
    obj[item.idx].push(item)
  })
  ctx.body = obj
}
module.exports.getAllComments = getAllComments