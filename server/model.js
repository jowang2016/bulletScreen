var connection = require('./db')
class Model {
  constructor(table){
    this.table = table
    connection.connect()
  }
  query (sql, idx=0) {
    return new Promise((resolve, reject) => {
      const idx1 = Number(idx)*2%16
      const idx2 = idx1 + 2
      connection.query(`select ${sql} from ${this.table} where idx>=${idx1} and idx<${idx2}`, function (err, results, fields) {
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