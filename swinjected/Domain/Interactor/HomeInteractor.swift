
protocol HomeInteractor {
  var callback: HomeCallback? { get set }
  func requestData()
}

protocol HomeCallback {
  func onSuccess()
  func onError()
}
