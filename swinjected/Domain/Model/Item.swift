//
//  Item.swift
//  swinjected
//
//  Created by Pedro Paulo de Amorim on 20/10/2016.
//  Copyright © 2016 Pedro Paulo de Amorim. All rights reserved.
//

import Foundation
import ObjectMapper

class Item: Mappable {
  
  var title: String?
  var description: String?
  
  /**
   Initializator of ObjectMapper.
   */
  required convenience init?(map: Map) {
    self.init()
  }
  
  /**
   This method will map every field to be used with
   the ObjectMapper.
   */
  func mapping(map: Map) {
    title <- map["title"]
    description <- map["description"]
  }
  
}
