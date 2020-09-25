import 'package:trymerenters/Globals.dart';

enum productInfo_e { CARD }

class QueryParse {
  static void getUser(Map result) {
    user.companyId = result['company_id'];
  }

  static void getCompany(Map result) {
    company.id = result['id'];
    company.name = result['name'];
    company.address = result['address'];
    company.phoneNumber = result['phone'];
    company.email = result['email'];
    company.siret = result['siret'];
    company.siren = result['siren'];
    company.pathToAvatar = auth0User.picture;
  }

  static Product getProduct(Map result, [productInfo_e productInfo]) {
    Product product = Product();
    product.id = result['id'];
    product.name = result['name'];
    product.brand = result['brand'];
    product.stock = result['stock'];
    product.pricePerDay = result['price_per_day'] != null
        ? result['price_per_day'].toDouble()
        : null;
    product.pricePerWeek = result['price_per_week'] != null
        ? result['price_per_week'].toDouble()
        : null;
    product.pricePerMonth = result['price_per_month'] != null
        ? result['price_per_month'].toDouble()
        : null;
    product.stock = result['stock'];
    if (productInfo != productInfo_e.CARD) {
      product.description = result['description'];
      product.specifications = result['product_specifications'];
    }
    product.reviews = Reviews(reviews: List());
    (result['reviews'] as List).forEach((element) {
      product.reviews.reviews.add(productInfo != productInfo_e.CARD
          ? Review(
          score: element['score'].toDouble(),
          description: element['description'])
          : Review(score: element['score'].toDouble()));
    });
    product.reviews.computeAverageRating();
    if (result['picture'] != null) {
      product.pictures = List();
      product.pictures.add(result['picture']['url']);
    }
    return (product);
  }

  static Order getOrder(Map result) {
    Order order = Order();
    List<Product> products = List();
    double total = 0;

    order.id = result['id'];
    order.status = result['order_statuses'][0]['status'];

    (result['order_items'] as List).forEach((element) {
      products.add(getProduct(element['product']));
      total += products.last.pricePerMonth;
    });
    order.products = products;
    order.total = total;
    return (order);
  }
}

class Mutations {
  static String addProduct(int id) => '''
  mutation {
    createCartItem(product_id: $id) {
      id
    }
  }
  ''';

  static String modifyCompany(int id, String name, String address, String email,
          String phoneNumber, String siret, String siren) =>
      '''
  mutation {
    update_company(where: {id: {_eq: $id}}, _set: {address: "$address", email: "$email", name: "$name", phone: "$phoneNumber", siren: "$siren", siret: "$siret"}) {
      affected_rows
    }
  }
  ''';

  static String modifyProduct(
          int id,
          String title,
          String brand,
          double monthPrice,
          double weekPrice,
          double dayPrice,
          int stock,
          String description) =>
      '''
  mutation {
    update_product(_set: {name: "$title", brand: "$brand", price_per_month: "$monthPrice", price_per_week: "$weekPrice", price_per_day: "$dayPrice", stock: $stock, description: "$description"}, where: {id: {_eq: $id}}) {
      affected_rows
    }
  }
  ''';

  static String deleteProductSpecifications(int id) => '''
  mutation {
    delete_product_specifications(where: {product_id: {_eq: $id}}) {
      affected_rows
    }
  }
  ''';

  static String insertProductSpecification(int id, String spec) => '''
  mutation {
    insert_product_specifications(objects: {product_id: $id, name: "$spec"}) {
      affected_rows
    }
  }
  ''';
}

class Queries {
  static String product(int id) => '''
  query {
    product(where: {id: {_eq: $id}}) {
      id
      name
      brand
      price_per_day
      price_per_week
      price_per_month
      stock
      description
      product_specifications {
        name
      }
      picture {
        url
      }
      reviews {
        description
        score
      }
    }
  }
  ''';

  static String productsCompany(int id, String sort) => '''
  query {
    company(where: {id: {_eq: $id}}) {
      products($sort) {
        id
        name
        brand
        price_per_month
        stock
        picture {
          url
        }
        reviews {
          score
        }
      }
    }
  }
  ''';

  static String orders(int id, String status) => '''
  query {
    order(where: {order_items: {product: {company_id: {_eq: $id}}}'''+ (status.isEmpty ? "" : ''', order_statuses: {status: {_eq: "$status"}}''') + '''}, order_by: {created_at: desc}) {
      order_items(where: {product: {company_id: {_eq: $id}}}) {
        product {
          id
          name
          brand
          price_per_month
          stock
          picture {
            url
          }
          reviews {
            description
            score
          }
        }
      }
      id
      order_statuses {
        status
      }
      created_at
    }
  }
  ''';

  static String user(String uid) => '''
  query {
    user(where: {uid: {_eq: "$uid"}}) {
      company_id
    }
  }
  ''';

  static String company(int id) => '''
  query {
    company(where: {id: {_eq: $id}}) {
      address
      email
      id
      name
      phone
      siret
      siren
    }
  }
  ''';
}
