//ModelClass:1) Define Variable to capture data
class GetUsers {
  int id;
  String name;
  String email;
  String phoneNumber;
 
 //2)init var in const
  GetUsers({
    this.id=0,
    this.name="",
    this.email="",
    this.phoneNumber=""
  });
 
 //3)Using Initilized Vars,  its NamedConstrutor(fromJson) which init 'var'  required Map as Parameter, We Pass Json data here
  factory GetUsers.fromJson(Map<String, dynamic> json) {
    return GetUsers(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone']
    );
  }
}