//
//  DashboardRouter.swift
//  ConnectFourApp_Example
//
//  Created by David Duarte on 29/11/2021.
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
