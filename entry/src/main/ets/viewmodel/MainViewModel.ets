
import ReminderService from '../model/ReminderService';

export default class MainViewModel {
  static instant: MainViewModel =new MainViewModel();
  private reminderService: ReminderService;
  // private alarms: Array<AlarmItem>;

  private constructor() {
    // this.alarms = new Array();
    this.reminderService = new ReminderService();
    this.reminderService.openNotificationPermission();
  }


}