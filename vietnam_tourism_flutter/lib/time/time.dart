class SeeTime{
  SeeTime(this.time);
  DateTime time;

  String seeTime(){
    if(DateTime.now().year!=time.year){
      if(DateTime.now().year-time.year==1)
      {
        return (DateTime.now().month+12-time.month).toString()+" tháng trước";
      }
      return (DateTime.now().year-time.year-1).toString()+" năm trước";
    }
    else if(DateTime.now().month!=time.month){
      if(DateTime.now().month-time.month==1){
        return (DateTime.now().day+daysOfMonth(time.month, time.year)-time.day).toString()+" ngày trước";
      }
      return (DateTime.now().month-time.month-1).toString()+" tháng trước";
    }
    else if(DateTime.now().day!=time.day){
      if(DateTime.now().day-time.day==1){
        return (DateTime.now().hour+24-time.hour).toString()+" giờ trước";
      }
      return (DateTime.now().day-time.day-1).toString()+" ngày trước";
    }
    else if(DateTime.now().hour!=time.hour){
      if(DateTime.now().hour-time.hour==1){
        return (DateTime.now().minute+60-time.minute).toString()+" phút trước";
      }
      return (DateTime.now().hour-time.hour-1).toString()+" giờ trước";
    }
    else if(DateTime.now().minute!=time.minute){
      if(DateTime.now().minute-time.minute==1){
        return (DateTime.now().second+60-time.second).toString()+" giây trước";
      }
      
      return (DateTime.now().minute-time.minute-1).toString()+" phút trước";
    }
    else if(DateTime.now().second!=time.second){
      return (DateTime.now().second-time.second).toString()+" giây trước";
    }
    return "";
  }

  int daysOfMonth(int month, int year){
    if(year%4==0||(year%400==0&&year%100!=0)){
      switch(month){
        case 2: return 29;
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12: return 31;
        case 4:
        case 6:
        case 9:
        case 11: return 30;
      }
    }
    else{
      switch(month){
        case 2: return 28;
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12: return 31;
        case 4:
        case 6:
        case 9:
        case 11: return 30;
      }
    }
    return 0;
  }
}