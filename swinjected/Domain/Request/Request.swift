import Foundation

typealias Success<T> = (_ t: T) -> ()
typealias Error = (_ error: Swift.Error) -> ()
