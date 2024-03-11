@Observed
export default class RecordItem{
  /**
   * 记录id
   */
  id: number = 0;

  /**
   * 创建时间
   */
  createTime : Date = new Date();

  /**
   * 关联习惯的id
   */
  habitId : number = 0;

  constructor(id: number,
              createTime : Date,
              habitId : number){
    this.id = id;
    this.createTime = createTime;
    this.habitId = habitId;
  }

}