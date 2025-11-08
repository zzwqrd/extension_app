import 'package:dartz/dartz.dart';
import 'package:extension_app/core/services/helper_respons.dart';

import '../../../../../core/services/api_client.dart';
import '../models/categories.dart';

class CategoryRemoteDataSource with ApiClient {
  /// 🟣 Get Categories with products & children
  Future<Either<HelperResponse, ModelsCategories>> getCategories() async {
    const String query = '''
    query {
      categories {
        items {
          name
          products {
            items {
              name
              small_image {
                url
              }
            }
          }
          children {
            name
            image
          }
        }
      }
    }
    ''';

    return await graphQLQuery(
      query,
      fromJson: (json) => ModelsCategories.fromJson(json),
      dataKey: 'categories',
    );
  }
}
