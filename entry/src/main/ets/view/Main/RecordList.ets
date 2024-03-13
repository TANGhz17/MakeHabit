import RecordItem from '../../viewmodel/RecordItem';
import { CJDateItem } from '../Components/Calendar/CJCalendar';

@Component
export struct RecordList {
  @Link currDate: CJDateItem;

  build() {
    List(){
      ForEach(this.currDate.records, (record: RecordItem)=>{
        ListItem(){

        }
      })
    }
  }
}