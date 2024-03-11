/**
 * 数据库建表语句
 */
const SQL_CREATE_TABLE: string = `
  CREATE TABLE IF NOT EXISTS
    ID          INTEGER   PRIMARY KEY   AUTOINCREMENT,
    CREATE_TIME INTEGER   NOT NULL,
    HABIT_ID    INTEGER   NOT NULL
    )
`

class RecordModel {
  getCreateTableSql(): string{
    return SQL_CREATE_TABLE;
  }
}

let recordModel = new RecordModel()

export default recordModel as RecordModel