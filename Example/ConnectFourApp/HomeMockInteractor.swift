//
//  HomeMockInteractor.swift
//  ConnectFourApp_Example
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

class HomeMockInteractor: HomeInteractorInterface {
  var networkManager: NetworkManagerInterface
  
  init(networkManager: NetworkManagerInterface) {
    self.networkManager = networkManager
  }
  
  let playersMock = [PlayerDAO(color: .init(hexString: "#FF0000"), name: "Sue"),
                     PlayerDAO(color: .init(hexString: "#0000FF"), name: "Henry"),
  ]
  
  func getDefaultPlayersInfo(completionHandler: @escaping closureResult) {
    completionHandler(.success(playersMock))
  }
  
  func parseIntoDao(defaultInfo: [DefaultInfo]) -> [PlayerDAO]? {
    return nil
  }
  
  
  
}
