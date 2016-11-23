
protocol HomePresenter {
  var view: HomeView? { get set }
  var items: Array<Item> { get }
  func sync()
}

protocol HomeView {
  func onSuccess()
  func onError(_ error: Swift.Error)
}
