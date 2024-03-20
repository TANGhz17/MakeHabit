@Observed
export default class Record{
  /**
   * 记录id
   */
  id: number = 0;

  /**
   * 创建时间
   */
  createTime : number = 0;

  /**
   * 关联习惯的id
   */
  habitId : number = 0;

  constructor(id?: number,
              createTime?: number,
              habitId?: number){
    this.id = id;
    this.createTime = createTime;
    this.habitId = habitId;
  }

}