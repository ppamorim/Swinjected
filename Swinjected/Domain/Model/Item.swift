import Foundation
import ObjectMapper

class Item: Mappable {
  
  var title: String?
  var description: String?
  var image: String?
  
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
    image <- map["image"]
  }
  
}
