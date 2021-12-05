//
//  DashboardRouter.swift
//  ConnectFourApp_Example
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol DashboardRouterInterface {
  func navigateToResult()
}

class DashboardRouterImpl: DashboardRouterInterface {
  
  weak var viewController: UIViewController?
  
  func navigateToResult() {
    
  }
}
