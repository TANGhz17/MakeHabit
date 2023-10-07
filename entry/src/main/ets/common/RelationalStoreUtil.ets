import relationalStore from '@ohos.data.relationalStore';

/**
 * 数据库信息
 */
export const STORE_CONFIG = {
  name: 'MakeHabit.db', // 数据库文件名
  securityLevel: relationalStore.SecurityLevel.S1 // 数据库安全级别
};

/**
 * 建表SQL语句
 */
export const SQL_CREATE_RECORDS =  "CREATE TABLE IF NOT EXISTS RECORDS (" +
                                  "'habitId' INTEGER NOT NULL, " +
                                  "'count' INTEGER NOT NULL, " +      // count 计数
                                  "'date' INTEGER PRIMARY KEY, " +    // date 从 1970-01-01 00:00:00 UTC 算起的秒数。
                                  "'message' VARCHAR(255) )";
/**
 * Record 测试用例
 */
export const testRecord = {
  'habitId' : 0,
  'count' : 1,
  'date' : Date.now(),  // date 从 1970-01-01 00:00:00 UTC 算起的秒数。
  'message' : ''
}