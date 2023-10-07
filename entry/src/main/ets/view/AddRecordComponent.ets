import AppContext from '@ohos.app.ability.common';
import relationalStore from '@ohos.data.relationalStore';
import { STORE_CONFIG, SQL_CREATE_RECORDS, testRecord } from '../common/RelationalStoreUtil';

@Preview
@Component
export default struct AddRecordComponent {

  build() {
    Column() {
      Image($r("app.media.add"))
        .width("40vp")
        .height("40vp")
        .onClick(()=>{
          let handler = getContext(this) as AppContext.UIAbilityContext;
          relationalStore.getRdbStore(handler, STORE_CONFIG, (err, store) => {
            if (err) {
              console.error(`Failed to get RdbStore. Code:${err.code}, message:${err.message}`);
              return;
            }

            // 插入数据
            testRecord.date = Date.now();
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
          })
        })
    }    
    .width("100%")
    .alignItems(HorizontalAlign.End)
    .justifyContent(FlexAlign.End)
  }
}