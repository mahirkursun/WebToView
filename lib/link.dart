class Link {
  int id;
  String link;

  Link({this.id, this.link});

  Map<String, dynamic> toMap() {
    return {'id': id, 'link': link};
  }
}
