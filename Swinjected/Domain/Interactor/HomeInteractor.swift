protocol HomeInteractor {
  var callback: HomeCallback? { get set }
  func requestData()
}

protocol HomeCallback {
  func onSuccess(_ items: Array<Item>)
  func onError(_ error: Swift.Error)
}
