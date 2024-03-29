import relationalStore from '@ohos.data.relationalStore';
import { ColumnInfo, ColumnType } from '../common/bean/ColumnInfo';
import DbUtil from '../common/utils/DbUtil';
import Habit from '../viewmodel/Habit';

const TABLE_NAME = 'HABIT'

/**
 * 数据库建表语句
 */
const SQL_CREATE_TABLE: string = `
  CREATE TABLE IF NOT HABIT (
    ID              INTEGER   PRIMARY KEY   AUTOINCREMENT,
    NAME            TEXT      NOT NULL,
    MSG             TEXT,
    INTERVAL_TIME   INTEGER
    )
`

const COLUMNS: ColumnInfo[] = [
  {name: 'id', columnName: 'ID', type: ColumnType.LONG},
  {name: 'name', columnName: 'NAME', type: ColumnType.STRING},
  {name: 'msg', columnName: 'MSG', type: ColumnType.STRING},
  {name: 'intervalTime', columnName: 'INTERVAL_TIME', type: ColumnType.LONG},
]

class HabitModel {

  getCreateTableSql(): string{
    // return SQL_CREATE_TABLE;
    return 'CREATE TABLE IF NOT EXISTS ' + TABLE_NAME +
    ' ( ' +
    COLUMNS[0].columnName + ' INTEGER  PRIMARY KEY  AUTOINCREMENT, ' +
    COLUMNS[1].columnName + ' TEXT     NOT NULL, ' +
    COLUMNS[2].columnName + ' TEXT, ' +
    COLUMNS[3].columnName + ' INTEGER ' +
    ')'
  }

  insert(habit: Habit){
    return DbUtil.insert(TABLE_NAME, habit, COLUMNS)
  }

  deleteById(id: number){
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo(COLUMNS[0].columnName,id)
    return DbUtil.delete(predicates)
  }

  async queryByHabitName(ids: number[]): Promise<Habit[]>{
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    for (let i = 0; i < ids.length; i++) {
      predicates.equalTo(COLUMNS[0].columnName, ids[i])
    }
    return DbUtil.queryForList<Habit>(predicates, COLUMNS)
  }

  async queryAllHabits(): Promise<Habit[]>{
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates
      .isNotNull(COLUMNS[1].columnName)
      .orderByAsc(COLUMNS[0].columnName)
    return DbUtil.queryForList<Habit>(predicates, COLUMNS)
  }

}

let habitModel = new HabitModel()

export default habitModel as HabitModel
