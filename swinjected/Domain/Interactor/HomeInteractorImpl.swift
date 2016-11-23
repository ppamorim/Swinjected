import Foundation

/**
 Interactors has a single propose, to load the data for the presenter, 
 using a very simple representation and implementing a concept of pure 
 function for this data loading.
 */
class HomeInteractorImpl: HomeInteractor {
  
  //Callback of this interactor.
  var callback: HomeCallback?
  
  /**
   Start the data loading, invoking the method to request the data for 
   the server.
   */
  func requestData() {
    requestItems(
      successHandler: { data in self.callback?.onSuccess(data) },
      errorHandler: { error in self.callback?.onError(error) })
  }
  
}
