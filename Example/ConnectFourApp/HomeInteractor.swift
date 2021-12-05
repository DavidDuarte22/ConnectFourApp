//
//  HomeInteractor.swift
//  ConnectFourApp_Example
//
//  Created by David Duarte on 29/11/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import ConnectFourApp

protocol HomeInteractorInterface: class {
  func getDefaultPlayersInfo(completionHandler: @escaping closureResult)
  func parseIntoDao(defaultInfo: [DefaultInfo]) -> [PlayerDAO]?
  var networkManager: NetworkManagerInterface { get set }
  
  typealias closureResult = (Result<[PlayerDAO], NetworkError>) -> Void
}

class HomeInteractorImpl: HomeInteractorInterface {
  
  // TODO: set, at least, like a UserDefault
  static let defaultURL = "https://private-75c7a5-blinkist.apiary-mock.com/connectFour/configuration"
  var networkManager: NetworkManagerInterface
  
  init(networkManager: NetworkManagerInterface) {
    self.networkManager = networkManager
  }
  
  func getDefaultPlayersInfo(completionHandler: @escaping closureResult) {
    self.networkManager.fetchInfoByUrl(from: HomeInteractorImpl.defaultURL) { result in
      switch result {
      case .success(let defaultInfo):
        guard let players = self.parseIntoDao(defaultInfo: defaultInfo) else {
          completionHandler(.failure(NetworkError.parseError))
          return
        }
        completionHandler(.success(players))
      case .failure(let error):
        completionHandler(.failure(error))
      }
    }
  }
  
  func parseIntoDao(defaultInfo: [DefaultInfo]) -> [PlayerDAO]? {
    guard let name1 = defaultInfo[0].name1,
          let color1 = defaultInfo[0].color1,
          let name2 = defaultInfo[0].name2,
          let color2 = defaultInfo[0].color2 else { return nil }
    return  [
      PlayerDAO(color: UIColor(hexString: color1), name: name1),
      PlayerDAO(color: UIColor(hexString: color2), name: name2) ]
    
  }
}
