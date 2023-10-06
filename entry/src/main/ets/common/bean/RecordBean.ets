// Record类
export class RecordBean{
  habitId : number;
  count : number;
  date : number;  // date 从 1970-01-01 00:00:00 UTC 算起的秒数。
  message : string;

  constructor(habitId : number,count : number, date : number, message : string) {
    this.habitId = habitId;
    this.count = count;
    this.date = date;
    this.message = message;
  }
}