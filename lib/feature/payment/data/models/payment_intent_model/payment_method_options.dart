import 'card.dart';
import 'link.dart';

class PaymentMethodOptions {
  Card? card;
  Link? link;

  PaymentMethodOptions({this.card, this.link});

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
    return PaymentMethodOptions(
      card: json['card'] == null
          ? null
          : Card.fromJson(json['card'] as Map<String, dynamic>),
      link: json['link'] == null
          ? null
          : Link.fromJson(json['link'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'card': card?.toJson(),
        'link': link?.toJson(),
      };
}
