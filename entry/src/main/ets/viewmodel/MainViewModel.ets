import ReminderService from '../model/ReminderService';
import Logger from '../common/utils/Logger'

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

  public testDate( year:number, month:number, day:number ) : void{
    let that = this;

    var date = new Date();
    var test = new Date(year,month,day);

    Logger.debug(test.toString());
  }

}