import Foundation

/**
 Implementation of the HomePresenter, used to start the data 
 syncronization and to handle the data used by the ViewController.
 This component is needed to separate the data structure and view
 structure. It acts like a repository of data and a controller that
 notifies the ViewController of any data change.
 */
class HomePresenterImpl: HomePresenter {
  
  //Protocol used to notify the view.
  var view: HomeView?
  
  //Interactor instance.
  var homeInteractor: HomeInteractor?
  
  //Data loaded by the interactor.
  var items: Array<Item> = []
  
  /**
   Start the data syncronization, configuring the callback of 
   interactor and invoking the method used to start the data 
   loading.
   */
  func sync() {
    homeInteractor?.callback = self
    homeInteractor?.requestData()
  }
  
}

/**
 Extension used to handle the interactor callback, if your
 presenter has multiple interactors, it would be better to
 create different extensions to maintain the clean structure.
 */
extension HomePresenterImpl: HomeCallback {
  
  //Notify success of data loading.
  func onSuccess(_ items: Array<Item>) {
    self.items = items
    view?.onSuccess()
  }
  
  //Notify error for the view.
  func onError(_ error: Swift.Error) {
    view?.onError(error)
  }
  
}
