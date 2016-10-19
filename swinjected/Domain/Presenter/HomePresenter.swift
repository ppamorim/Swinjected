
protocol HomePresenter {
  var view: HomeView? { get set }
  func sync()
}

protocol HomeView {
  func onSuccess()
  func onError()
}
