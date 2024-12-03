
class customer {

  final String CName;
  final String? CDName;
  final String? DOB;
  final String? Code;
  final String CMobile;
  final String Email;
  bool isclick;
  final String id;
  final List? clabel;
  customer({
    required this.CName,
    this.CDName,
    this.DOB,
    this.Code = '91',
    required this.CMobile,
    required this.Email,
    this.isclick = false,
    required this.id,
    this.clabel,
  });

  factory customer.fromJson(Map<String?, dynamic> json) {
    return customer(
                id: json['_id'] ?? '',
                CName: json['name'] ?? '',
                Email: json['email'] ?? '',
                CDName: json['display_name'],
                CMobile: json['contact_number'] ?? '',
                clabel: json['labels'] ?? '',
                DOB: json['dob'] ?? '',
              );
  }

}

