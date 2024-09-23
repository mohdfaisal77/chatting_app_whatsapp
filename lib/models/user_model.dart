class UserModel {

  String? id;
  String? name;
  String? age;
  String? address;
  String? bio;
  String? gender;
  String? maritalStatus;
  String? profileImage;
  String? lastOnlineStatus;
  String? status;
  String? email;

  UserModel({
     this.id,
     this.name,
     this.age,
     this.address,
     this.bio,
     this.gender,
     this.maritalStatus,
     this.profileImage,
    this.lastOnlineStatus,
    this.status,
    this.email

  });

  // Factory method to create a UserModel from JSON
   UserModel.fromJson(Map<String, dynamic> json) {
   id =json["id"];
   name =json["name"];
   age =json["age"];
   address =json["address"];
   bio =json["bio"];
   gender =json["gender"];
   maritalStatus =json["maritalStatus"];
   profileImage =json["profileImage"];
   lastOnlineStatus=json["lastOnlineStatus"];
   status=json["status"];
   email=json["email"];
  }
  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
     final Map<String, dynamic> data= <String,dynamic>{};
    data["id"]=id;
     data["name"]=name;
     data["age"]=age;
     data["address"]=address;
     data["bio"]=bio;
     data["gender"]=gender;
     data["maritalStatus"]=maritalStatus;
     data["profileImage"]=profileImage;
     data["lastOnlineStatus"]=lastOnlineStatus;
     data["status"]=status;
     data["email"]=email;
    return data;
  }
}
