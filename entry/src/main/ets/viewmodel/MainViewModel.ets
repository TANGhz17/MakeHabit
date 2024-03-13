import Logger from '../common/utils/Logger'
import habitModel from '../model/HabitModel';
import RecordModel from '../model/RecordModel';
import { CJDateItem } from '../view/Components/Calendar/CJCalendar';
import HabitItem from './HabitItem'
import RecordItem from './RecordItem'

/**
 * 主页逻辑功能类
 */
export default class MainViewModel {
  static instant: MainViewModel =new MainViewModel();
  private habits: Array<HabitItem>;
  private records: Array<RecordItem>;

  // 构造 函数
  constructor() {
    this.habits = new Array();
    this.records = new Array();
  }

  addHabitsToDB(){
    let habits: HabitItem[] = [
      {id: 0, name: '锻炼', msg: '', intervalTime: NaN},
      {id: 1, name: '学习', msg: '', intervalTime: NaN},
      {id: 2, name: '练字', msg: '', intervalTime: NaN}
    ]
    habits.forEach(habit =>{
      habitModel.insert(habit)
    })
  }

  addRecordsToDB(){
    let records: RecordItem[] = [
      {id: 0, habitId: 1, createTime: new Date(2024,2-1,29).getTime()},
      {id: 1, habitId: 0, createTime: new Date(2024,3-1,4).getTime()},
      {id: 2, habitId: 1, createTime: new Date(2024,3-1,29).getTime()},
      {id: 3, habitId: 2, createTime: new Date(2024,3-1,29).getTime()}
    ]
    records.forEach(record => {
      RecordModel.insert(record)
    })
  }

  // 设置当前日期的记录
  setCurrentRecords(date: CJDateItem){

  }

}