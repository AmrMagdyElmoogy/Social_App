class Like {
  bool like;
  Like({this.like});
  Like.fromJson(Map<String, dynamic> json) {
    like = json['Like'];
  } 
}
