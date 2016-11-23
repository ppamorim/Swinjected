//
//  ItemRequest.swift
//  swinjected
//
//  Created by Pedro Paulo de Amorim on 20/10/2016.
//  Copyright © 2016 Pedro Paulo de Amorim. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

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
