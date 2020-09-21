import 'package:trymerenters/Globals.dart';

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

  static Product getProduct(Map result) {
    Product product = Product();
    product.id = result['id'];
    product.name = result['name'];
    product.brand = result['brand'];
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
    product.description = result['description'];
    product.specifications = result['product_specifications'];
    if (result['picture'] != null) {
      product.pictures = List();
      product.pictures.add(result['picture']['url']);
    }
    return (product);
  }

  static Product getProductMin(Map result) {
    Product product = Product();
    product.id = result['id'];
    product.name = result['name'];
    product.pricePerDay = result['price_per_day'] != null
        ? result['price_per_day'].toDouble()
        : null;
    product.pricePerWeek = result['price_per_week'] != null
        ? result['price_per_week'].toDouble()
        : null;
    product.pricePerMonth = result['price_per_month'] != null
        ? result['price_per_month'].toDouble()
        : null;
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
      products.add(getProductMin(element['product']));
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
    }
  }
  ''';

  static String products(String sort) => '''
  query {
    product($sort) {
      name
      id
      price_per_week
      price_per_month
      price_per_day
      picture {
        url
      }
    }
  }
  ''';

  static String productsCompany(int id, String sort) => '''
  query {
    company(where: {id: {_eq: $id}}) {
      products($sort) {
        name
        id
        price_per_week
        price_per_month
        price_per_day
        picture {
          url
        }
      }
    }
  }
  ''';

  static String orders(int id) => '''
  query MyQuery {
    order(where: {order_items: {product: {company_id: {_eq: $id}}}}, order_by: {created_at: desc}) {
      order_items(where: {product: {company_id: {_eq: $id}}}) {
        product {
          id
          name
          price_per_month
          picture {
            url
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
