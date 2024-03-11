import relationalStore from '@ohos.data.relationalStore';
import common from '@ohos.app.ability.common';
import Logger from './Logger'
import { ColumnInfo, ColumnType } from '../bean/ColumnInfo';

const DB_FILENAME: string = 'MakeHabit.db'

class DbUtil {
  rdbStore: relationalStore.RdbStore

  initDB(context: common.UIAbilityContext) : Promise<void>{
    let config: relationalStore.StoreConfig ={
      name: DB_FILENAME,
      securityLevel: relationalStore.SecurityLevel.S1
    }
    return new Promise<void>((resolve, reject) => {
      relationalStore.getRdbStore(context, config)
        .then(rdbStore => {
          this.rdbStore = rdbStore
          Logger.info('rdbStore 初始化完成！')
          resolve()
        })
        .catch(reason => {
          Logger.error('rdbStore 初始化异常', JSON.stringify(reason))
          reject(reason)
        })
    })
  }

  createTable(createSQL: string): Promise<void> {
    return new Promise((resolve, reject) => {
      this.rdbStore.executeSql(createSQL)
        .then(() => {
          Logger.info('创建表成功', createSQL)
          resolve()
        })
        .catch(err => {
          Logger.error('创建表失败', err.message, JSON.stringify(err))
          reject(err)
        })
    })
  }

  insert(tableName: string, obj: any, columns: ColumnInfo[]){
    return new Promise((resolve, reject) => {
      // 1.构建sql新增数据
      let value = this.buildValueBucket(obj, columns)
      // 2.向数据表添加数据
      this.rdbStore.insert(tableName, value, (err, id) => {
        if (err) {
          Logger.error(tableName, '表新增数据失败！', JSON.stringify(err))
          reject(err)
        }
        Logger.info(tableName, '表新增数据成功！数据id：', id.toString())
        resolve(id)
      })
    })
  }

  delete(predicates: relationalStore.RdbPredicates){
    return new Promise((resolve, reject) => {
      this.rdbStore.delete(predicates, (err, rows) => {
        if (err) {
          Logger.error('表删除数据失败！', JSON.stringify(err))
          reject(err)
        }
        Logger.info('表删除数据成功！删除行数', rows.toString())
        resolve(rows)
      })
    })
  }

  queryForList<T>(predicates: relationalStore.RdbPredicates, columns: ColumnInfo[]): Promise<T[]>{
    return new Promise((resolve, reject) => {
      this.rdbStore.query(predicates, columns.map(info => info.columnName), (err, result) => {
        if (err) {
          Logger.error('查询数据失败！', JSON.stringify(err))
          reject(err)
        }
        Logger.info('查询数据成功！查询行数', result.rowCount.toString())
        resolve(this.parseResultSet(result,columns))
      })
    })
  }

  /**
   * 构建sql新增数据
   */
  buildValueBucket(obj: any, columns: ColumnInfo[]): relationalStore.ValuesBucket{
    let value = {}
    columns.forEach(info => {
      let val = obj[info.name]
      if (typeof val !== 'undefined'){
        value[info.columnName] = val
      }
    })
    return value;
  }

  /**
   * 解析SQL返回的数据集
   * @param result
   * @param columns
   * @returns
   */
  parseResultSet<T>(result: relationalStore.ResultSet, columns: ColumnInfo[]): T[]{
    let arr = []
    if (result.rowCount <= 0) {
      return arr
    }
    while(!result.isAtLastRow){
      result.goToNextRow()
      let obj = {}
      columns.forEach(info => {
        let val = null
        switch (info.type){
          case ColumnType.LONG:
            val = result.getLong(result.getColumnIndex(info.columnName))
            break
          case ColumnType.DOUBLE:
            val = result.getDouble(result.getColumnIndex(info.columnName))
            break
          case ColumnType.STRING:
            val = result.getString(result.getColumnIndex(info.columnName))
            break
          case ColumnType.BLOB:
            val = result.getBlob(result.getColumnIndex(info.columnName))
            break
        }
        obj[info.name] = val
      })
      arr.push(obj)
    }
    return arr
  }
}

let dbUtil: DbUtil = new DbUtil();

export default dbUtil as DbUtil