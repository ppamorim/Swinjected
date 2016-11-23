import Foundation

extension String {
  /**
   * Load the string based on the actual location
   * or language of the device.
   */
  var localized: String {
    return NSLocalizedString(self, value: "", comment: "")
  }
  
  var lastEightCharacters: String {
    return String(self.characters.suffix(8))
  }
  
  var trim: String {
    return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
  }
  
}
