@Observed
export default class HabitItem {
  /**
   * 习惯id
   */
  id: number = 0;

  /**
   * 习惯名称
   */
  name: string = '';

  /**
   * 备注信息
   */
  msg: string = '';

  /**
   * 间隔提醒的时间
   */
  intervalTime: number = 0;

  constructor(id: number,
              name: string,
              msg?: string,
              intervalTime?: number) {
    this.id = id;
    this.name = name;
    this.msg = msg;
    this.intervalTime = intervalTime;
  }
}