class UserData {
  final String name;
  final String fatherName;
  final String motherName;
  final String phoneNo;
  final String cnic;
  final String address;
  final String email;
  final String gender;
  final String cast;
  final String religion;
  final String sect;
  final String maritalStatus;
  final String job;
  final String kids;
  final String qualification;
  final String height;
  final String weight;
  final String age;
  final String city;
  final String home;
  final String province;
  final String smoking;
  final String disability;
  final String skinColor;
  final String brother;
  final String sister;
  final String bio;
  final String interest;
  final String partnerPref;
  final String dateOfBirth;
  final String imageUrl;
  final String frontCnicUrl;
  final String backCnicUrl;
  final String imageSelfieUrl;
  final String paymentStatus;
  final String verifyByAdminStatus;
  final String cnicAddress;
  final String motherAlive;
  final String fatherAlive;
  final String jointFamily;
  final String uid;
  UserData({
    required this.cnicAddress,
    required this.motherAlive,
    required this.fatherAlive,
    required this.jointFamily,
    required this.home,
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.phoneNo,
    required this.cnic,
    required this.address,
    required this.email,
    required this.gender,
    required this.cast,
    required this.religion,
    required this.sect,
    required this.maritalStatus,
    required this.job,
    required this.kids,
    required this.qualification,
    required this.height,
    required this.weight,
    required this.age,
    required this.city,
    required this.province,
    required this.smoking,
    required this.disability,
    required this.skinColor,
    required this.brother,
    required this.sister,
    required this.bio,
    required this.interest,
    required this.partnerPref,
    required this.dateOfBirth,
    required this.imageUrl,
    required this.frontCnicUrl,
    required this.backCnicUrl,
    required this.imageSelfieUrl,
    required this.paymentStatus,
    required this.verifyByAdminStatus,
    required this.uid,
  });

  factory UserData.fromMap(Map<String, dynamic> data) {
    return UserData(
      home: data['home'] ?? '',
      name: data['name'] ?? '',
      fatherName: data['father_name'] ?? '',
      motherName: data['mother_name'] ?? '',
      phoneNo: data['phone_no'] ?? '',
      cnic: data['cnic'] ?? '',
      address: data['address'] ?? '',
      email: data['email'] ?? '',
      gender: data['gender'] ?? '',
      cast: data['cast'] ?? '',
      religion: data['religion'] ?? '',
      sect: data['sect'] ?? '',
      maritalStatus: data['marital_status'] ?? '',
      job: data['job'] ?? '',
      kids: data['kids'] ?? '',
      qualification: data['qualification'] ?? '',
      height: data['height'] ?? '',
      weight: data['weight'] ?? '',
      age: data['age'] ?? '',
      city: data['city'] ?? '',
      province: data['province'] ?? '',
      smoking: data['smoking'] ?? '',
      disability: data['disability'] ?? '',
      skinColor: data['skin_color'] ?? '',
      brother: data['brother'] ?? '',
      sister: data['sister'] ?? '',
      bio: data['bio'] ?? '',
      interest: data['interest'] ?? '',
      partnerPref: data['partner_preference'] ?? '',
      dateOfBirth: data['date_of_birth'] ?? '',
      imageUrl: data['image_url'] ?? '',
      frontCnicUrl: data['front_cnic_url'] ?? '',
      backCnicUrl: data['back_cnic_url'] ?? '',
      imageSelfieUrl: data['selfie_url'] ?? '',
      paymentStatus: data['payment_status'] ?? '',
      verifyByAdminStatus: data['verify_by_admin_status'] ?? '',
      cnicAddress: data['cnic_address'],
      motherAlive: data['mother_alive'],
      fatherAlive: data['father_alive'],
      jointFamily: data['joint_family'],
      uid : data['uid'],
    );
  }
}
