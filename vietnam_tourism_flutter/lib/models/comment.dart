class Comment {
  int accountId=0;
  String content="";
  DateTime time =DateTime.now();

  //Save accountId liked, disliked comment 
  List<int> likeds = [];   
  List<int> dislikeds = [];

}