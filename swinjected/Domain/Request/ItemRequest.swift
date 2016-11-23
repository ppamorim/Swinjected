import Foundation
import Alamofire
import AlamofireObjectMapper

/**
 Request the server data, using Alamofire and mapping 
 this JSON to Array of Items.
 */
func requestItems(successHandler: @escaping Success<Array<Item>>, errorHandler: @escaping Error) {
  Alamofire
    .request(ITEM_REQUEST_URL)
    .validate()
    .responseArray { (dataResponse: DataResponse<Array<Item>>) in
      switch dataResponse.result {
      case .success(let value):
        successHandler(value)
        break
      case .failure(let error):
        errorHandler(error)
        break
      }
  }
}
