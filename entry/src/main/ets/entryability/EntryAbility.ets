import relationalStore from '@ohos.data.relationalStore';
import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { STORE_CONFIG, SQL_CREATE_RECORDS, testRecord } from '../common/RelationalStoreUtil';

export default class EntryAbility extends UIAbility {

  createRdbStore(){
    relationalStore.getRdbStore(this.context, STORE_CONFIG, (err, store) => {
      if (err) {
        console.error(`Failed to get RdbStore. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info(`Succeeded in getting RdbStore.`);
      store.executeSql(SQL_CREATE_RECORDS); // 创建RECORDS数据表

      // 这里执行数据库的增、删、改、查等操作

      // 插入数据
      store.insert('RECORDS', testRecord, (err, rowId) => {
        if (err) {
          console.error(`Failed to insert data. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info(`Succeeded in inserting data. rowId:${rowId}`);
      })

      // 查询
      // 创建表 RECORDS 的 predicates
      let predicates = new relationalStore.RdbPredicates('RECORDS');
      predicates.equalTo('habitId', '0'); // 匹配表 RECORDS 中 habitId 为 0 的字段
      store.query(predicates, ['habitId', 'count', 'date', 'message'], (err, resultSet) => {
        if (err) {
          console.error(`Failed to query data. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info(`resultSet column: ${resultSet.rowCount}`);
        resultSet.close();
      })
    });
  }

  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    this.createRdbStore()

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
