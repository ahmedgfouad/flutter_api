

class Character {
  int? charId;
  String? name;
  String? nickname;
  String? image;
  late List<dynamic>jobs;
  String? statusIfDeadOrAlive;
  late List<dynamic>appearanceOfSeasons;
  String? actorName;
 String? categoryForTwoSeries;
  List<Null>? betterCallSaulAppearance;

  // Character(
  //     {this.charId,
  //       this.name,
  //       this.birthday,
  //       this.occupation,
  //       this.img,
  //       this.status,
  //       this.nickname,
  //       this.appearance,
  //       this.portrayed,
  //       this.category,
  //       this.betterCallSaulAppearance});

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    nickname = json['nickname'];
    image = json['img'];
    jobs =json['occupation'];
    statusIfDeadOrAlive=json['status'];
    appearanceOfSeasons=json['appearance'];
    actorName=json['portrayed'];
    categoryForTwoSeries=json['category'];
    betterCallSaulAppearance=json['better_call_saul_appearance'];


  }


}