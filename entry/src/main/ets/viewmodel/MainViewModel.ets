import ReminderService from '../model/ReminderService';
import DateUtils from  '../common/utils/DateUtils'
import Logger from '../common/utils/Logger'
import List from '@ohos.util.List';

/**
 * 主页逻辑功能类
 */
export default class MainViewModel {
  static instant: MainViewModel =new MainViewModel();
  private reminderService: ReminderService;
  // private alarms: Array<AlarmItem>;

  // 构造 函数
  private constructor() {
    // this.alarms = new Array();
    this.reminderService = new ReminderService();
    this.reminderService.openNotificationPermission();
  }

  public InitDayItems( year:number, month:number, day:number ) : void{
    let firstDay = DateUtils.getFirstDayOfMonthInWeek(year,month);
    Logger.debug(year+'年'+month+'月的第一天是周'+firstDay);

    let lengthMonth = DateUtils.getDaysOfMonth(year,month);
    let days = new List();

    let dayIndex = 1;
    for (let i = 0; i < firstDay + lengthMonth; i++) {
      if (i < firstDay){
        days.add('');
        continue;
      }
      days.add(dayIndex++);
    }
    // days = days.convertToArray();
    // Logger.debug(this.days.length.toString());
  }

}