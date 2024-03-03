
import ReminderService from '../model/ReminderService';

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


}