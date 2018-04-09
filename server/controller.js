var Model = require('./model')
async function getAllComments(ctx) {
  ctx.body = await Model.Comments.query('*', ctx.request.body.page)
}
module.exports.getAllComments = getAllComments