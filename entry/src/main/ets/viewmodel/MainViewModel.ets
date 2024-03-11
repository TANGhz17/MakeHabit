import Logger from '../common/utils/Logger'
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

}