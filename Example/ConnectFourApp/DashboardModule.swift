//
//  DashboardModule.swift
//  ConnectFourApp_Example
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class DashboardModule {
  static func build(firstPlayer: PlayerDAO, secondPlayer: PlayerDAO) -> UIViewController {
    
    let presenter = DashboardPresenterImpl()
    let router = DashboardRouterImpl()
    let interactor = DashboardInteractorImpl(firstPlayer: firstPlayer, secondPlayer: secondPlayer)
    let view = DashboardViewImpl(presenter: presenter)
    
    presenter.dashboardRouter = router
    presenter.dashboardInteractor = interactor
    router.viewController = view
    
    return view
  }
}
