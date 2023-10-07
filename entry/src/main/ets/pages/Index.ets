import common from '@ohos.app.ability.common';
import relationalStore from '@ohos.data.relationalStore';
import { STORE_CONFIG, SQL_CREATE_RECORDS, testRecord } from '../common/RelationalStoreUtil';
import AddRecordComponent from '../view/AddRecordComponent'
import TitleComponent from '../view/TitleComponent'

@Entry
@Preview
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Column() {
      TitleComponent()

      AddRecordComponent()
    }
    .width('100%')
    .height('100%')
  }

  @Builder RecordList(){
    Column() {
      List() {

      }
    }
  }
}