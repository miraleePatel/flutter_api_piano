// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

// class CheckWalletBalanceModel {
//   int? status;
//   String? message;
//   List<ConcertWallet>? concertWallet;
//   List<StudioWallet>? studioWallet;

//   CheckWalletBalanceModel(
//       {this.status, this.message, this.concertWallet, this.studioWallet});

//   CheckWalletBalanceModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['concertWallet'] != null) {
//       concertWallet = <ConcertWallet>[];
//       json['concertWallet'].forEach((v) {
//         concertWallet!.add(new ConcertWallet.fromJson(v));
//       });
//     }
//     if (json['studioWallet'] != null) {
//       studioWallet = <StudioWallet>[];
//       json['studioWallet'].forEach((v) {
//         studioWallet!.add(new StudioWallet.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.concertWallet != null) {
//       data['concertWallet'] =
//           this.concertWallet!.map((v) => v.toJson()).toList();
//     }
//     if (this.studioWallet != null) {
//       data['studioWallet'] = this.studioWallet!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ConcertWallet {
//   ConcertHall? concertHall;
//   int? walletHour;

//   ConcertWallet({this.concertHall, this.walletHour});

//   ConcertWallet.fromJson(Map<String, dynamic> json) {
//     concertHall = json['concertHall'] != null
//         ? new ConcertHall.fromJson(json['concertHall'])
//         : null;
//     walletHour = json['wallet_hour'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.concertHall != null) {
//       data['concertHall'] = this.concertHall!.toJson();
//     }
//     data['wallet_hour'] = this.walletHour;
//     return data;
//   }
// }

// class ConcertHall {
//   String? name;

//   ConcertHall({this.name});

//   ConcertHall.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     return data;
//   }
// }

// class StudioWallet {
//   String? walletName;
//   int? walletHour;

//   StudioWallet({this.walletName, this.walletHour});

//   StudioWallet.fromJson(Map<String, dynamic> json) {
//     walletName = json['wallet_name'];
//     walletHour = json['wallet_hour'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['wallet_name'] = this.walletName;
//     data['wallet_hour'] = this.walletHour;
//     return data;
//   }
// }




class CheckWalletBalanceModel {
  int? status;
  String? message;
  List<ConcertWallet>? concertWallet;
  List<StudioWallet>? studioWallet;

  CheckWalletBalanceModel(
      {this.status, this.message, this.concertWallet, this.studioWallet});

  CheckWalletBalanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['concertWallet'] != null) {
      concertWallet = <ConcertWallet>[];
      json['concertWallet'].forEach((v) {
        concertWallet!.add(new ConcertWallet.fromJson(v));
      });
    }
    if (json['studioWallet'] != null) {
      studioWallet = <StudioWallet>[];
      json['studioWallet'].forEach((v) {
        studioWallet!.add(new StudioWallet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.concertWallet != null) {
      data['concertWallet'] =
          this.concertWallet!.map((v) => v.toJson()).toList();
    }
    if (this.studioWallet != null) {
      data['studioWallet'] = this.studioWallet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConcertWallet {
  String? concertHall;
  int? walletHour;

  ConcertWallet({this.concertHall, this.walletHour});

  ConcertWallet.fromJson(Map<String, dynamic> json) {
    concertHall = json['concertHall'];
    walletHour = json['wallet_hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['concertHall'] = this.concertHall;
    data['wallet_hour'] = this.walletHour;
    return data;
  }
}

class StudioWallet {
  String? walletName;
  int? walletHour;

  StudioWallet({this.walletName, this.walletHour});

  StudioWallet.fromJson(Map<String, dynamic> json) {
    walletName = json['wallet_name'];
    walletHour = json['wallet_hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_name'] = this.walletName;
    data['wallet_hour'] = this.walletHour;
    return data;
  }
}