import relationalStore from '@ohos.data.relationalStore';
import { ColumnInfo, ColumnType } from '../common/bean/ColumnInfo';
import DbUtil from '../common/utils/DbUtil';
import RecordItem from '../viewmodel/RecordItem';

const TABLE_NAME = 'RECORD'

/**
 * 数据库建表语句
 */
const SQL_CREATE_TABLE: string = `
  CREATE TABLE IF NOT EXISTS RECORD
    ID          INTEGER   PRIMARY KEY   AUTOINCREMENT,
    CREATE_TIME INTEGER   NOT NULL,
    HABIT_ID    INTEGER   NOT NULL
    )
`

const COLUMNS: ColumnInfo[] = [
  {name: 'id', columnName: 'ID', type: ColumnType.LONG},
  {name: 'createTime', columnName: 'CREATE_TIME', type: ColumnType.LONG},
  {name: 'habitId', columnName: 'HABIT_ID', type: ColumnType.LONG}
]

class RecordModel {
  getCreateTableSql(): string{
    // return SQL_CREATE_TABLE;
    return 'CREATE TABLE IF NOT EXISTS ' + TABLE_NAME +
    ' ( ' +
    COLUMNS[0].columnName + ' INTEGER  PRIMARY KEY  AUTOINCREMENT, ' +
    COLUMNS[1].columnName + ' INTEGER  NOT NULL, ' +
    COLUMNS[2].columnName + ' INTEGER  NOT NULL ' +
    ')'
  }

  insert(record: RecordItem){
    return DbUtil.insert(TABLE_NAME, record, COLUMNS)
  }

  deleteById(id: number){
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo(COLUMNS[0].columnName,id)
    return DbUtil.delete(predicates)
  }

  async queryByDate(date: number): Promise<RecordItem[]>{
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo(COLUMNS[1].columnName,date)
    return DbUtil.queryForList<RecordItem>(predicates, COLUMNS)
  }

}

let recordModel = new RecordModel()

export default recordModel as RecordModel