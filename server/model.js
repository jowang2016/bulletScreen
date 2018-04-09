var connection = require('./db')
class Model {
  constructor(table){
    this.table = table
    connection.connect()
  }
  query (sql, limit=0) {
    let start = Number(limit)*4%16
    return new Promise((resolve, reject) => {
      connection.query(`select ${sql} from ${this.table} limit ${start}, 4`, function (err, results, fields) {
        if (err) throw err
        resolve(results)
      })
    })
  }
}
class Comments extends Model {
  constructor(table){
    super(table)
  }
}
module.exports.Comments=new Comments('comments')