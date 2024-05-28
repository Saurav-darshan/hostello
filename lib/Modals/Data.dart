class productdata {
  List<String> image = [
    "h1.jpeg",
    "h2.jpeg",
    "h3.webp",
    "h4.jpeg",
    "h5.jpeg",
    "h6.jpeg",
  ];
  List<String> rating = ["4.8", "4.3", "4.0", "4.6", "4.9", "5.0"];
  List<String> title = [
    "Zostel Patna",
    "Lichchavi Vihar Hostel",
    "Patna Youth Hostel",
    "Hotel City Home",
    "Rama Girls Hostel",
    "Taj Boys Hostel",
  ];
  List<String> address = [
    "Rajendra Nagar, Patna",
    "Frazer Road, Patna",
    "Phulwari Sharif, Patna",
    "Bailey Road, Patna",
    "Anisabad, Patna",
    "Boring Road, Patna",
  ];
  List<String> price = [
    "₹ 3000/ mo",
    "₹ 3500/ mo",
    "₹ 3900/ mo",
    "₹ 4000/ mo",
    "₹ 4700/ mo",
    "₹ 9000/ mo",
  ];

  Item getByID(int id) => Item(
      id,
      title[id % title.length],
      rating[id % rating.length],
      address[id % address.length],
      price[id % price.length],
      image[id % image.length]);

  Item getByPosition(int position) {
    return getByID(position);
  }
}

class Item {
  final int id;
  final String title;
  final String rating;
  final String address;
  final String price;
  final String image;

  const Item(
      this.id, this.title, this.rating, this.address, this.price, this.image);
  @override
  int get hashCode => id;
  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
