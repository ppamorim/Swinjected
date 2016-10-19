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
  
  func sync() {
    homeInteractor?.callback = self
    homeInteractor?.requestData()
  }
  
}

extension HomePresenterImpl: HomeCallback {
  
  func onSuccess() {
    view?.onSuccess()
  }
  
  func onError() {
    view?.onError()
  }
  
}
