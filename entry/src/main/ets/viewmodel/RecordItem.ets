export default class RecordItem{
  habitId : number = 0;
  date : Date = new Date();

  constructor(habitId : number,
              date : Date){
    this.habitId = habitId
    this.date = date
  }

}