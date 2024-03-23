import Logger from '../common/utils/Logger'
import habitModel from '../model/HabitModel';
import RecordModel from '../model/RecordModel';
import { CJDateItem } from '../view/CJCalendar';
import Habit from './Habit'
import Record from './Record'

/**
 * 主页逻辑功能类
 */
export default class MainViewModel {
  static instant: MainViewModel = new MainViewModel();

  // 构造 函数
  constructor() {
  }

  public addHabitsToDB() {
    let habits: Habit[] = [
      {
        id: 0, name: '锻炼', msg: '', intervalTime: NaN
      },
      {
        id: 1, name: '学习', msg: '', intervalTime: NaN
      },
      {
        id: 2, name: '练字', msg: '', intervalTime: NaN
      }
    ]
    habits.forEach(habit => {
      habitModel.insert(habit)
    })
  }

  public addRecordsToDB() {
    let records: Record[] = [
      {
        id: null, habitId: 1, createTime: new Date(2024, 2 - 1, 29).getTime()
      },
      {
        id: null, habitId: 0, createTime: new Date(2024, 3 - 1, 4).getTime()
      },
      {
        id: null, habitId: 1, createTime: new Date(2024, 3 - 1, 29, 10).getTime()
      },
      {
        id: null, habitId: 2, createTime: new Date(2024, 3 - 1, 29).getTime()
      },
      {
        id: null, habitId: 2, createTime: new Date(2024, 3 - 1, 29, 23, 59, 59).getTime()
      }
    ]
    records.forEach(record => {
      RecordModel.insert(record)
    })
  }
  
  getNoonContent(date: Date): string {
    // 在一天里的第几分钟
    let min = date.getHours() * 60 + date.getMinutes();
    if (min < 3 * 60)
      return '半夜'
    else if (min <= 5 * 60 )
      return '凌晨'
    else if (min <= 7 * 60 )
      return '早晨'
    else if (min <= 11 * 60)
      return '上午'
    else if (min <= 13 * 60 )
      return '中午'
    else if (min <= 17 * 60 )
      return '下午'
    else if (min <= 18 * 60 )
      return '傍晚'
    else if (min <= 24 * 60 )
      return '晚上'
  }

  // 设置当前日期的记录
  setCurrentRecords(date: CJDateItem) {

  }
}