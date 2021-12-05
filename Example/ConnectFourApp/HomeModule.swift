//
//  HomeModule.swift
//  ConnectFourApp_Example
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class HomeModule {
  static func build() -> UIViewController {
    
    let presenter = HomePresenterImpl()
    let router = HomeRouterImpl()
    // TODO: Implement DI Container
    let interactor = HomeInteractorImpl(networkManager: NetworkManager.shared)
    let view = HomeViewImpl(presenter: presenter)
    
    presenter.homeRouter = router
    presenter.homeInteractor = interactor
    router.viewController = view
    
    return view
  }
}
