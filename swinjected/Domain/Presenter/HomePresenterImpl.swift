//
//  HomePresenterImpl.swift
//  swinjected
//
//  Created by Pedro Paulo de Amorim on 19/10/2016.
//  Copyright © 2016 Pedro Paulo de Amorim. All rights reserved.
//

import Foundation

class HomePresenterImpl: HomePresenter {
  
  var view: HomeView?
  var homeInteractor: HomeInteractor?
  var items: Array<Item> = []
  
  func sync() {
    homeInteractor?.callback = self
    homeInteractor?.requestData()
  }
  
}

extension HomePresenterImpl: HomeCallback {
  
  func onSuccess(_ items: Array<Item>) {
    self.items = items
    view?.onSuccess()
  }
  
  func onError(_ error: Swift.Error) {
    view?.onError(error)
  }
  
}
