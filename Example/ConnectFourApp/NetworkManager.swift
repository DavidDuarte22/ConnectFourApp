//
//  NetworkManager.swift
//  ConnectFourApp_Example
//
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

enum NetworkError: Error {
  case badURL
  case parseError
}

protocol NetworkManagerInterface {
  func fetchInfoByUrl(from urlString: String, completionHandler: @escaping (Result<[DefaultInfo], NetworkError>) -> Void)
}

class NetworkManager: NetworkManagerInterface {
  
  private init() { }
  
  static let shared = NetworkManager()
  
  let session = URLSession.shared
  
  func fetchInfoByUrl(from urlString: String, completionHandler: @escaping (Result<[DefaultInfo], NetworkError>) -> Void)  {
    guard let url = URL(string: urlString) else {
      completionHandler(.failure(.badURL))
      return
    }
    
    let task = session.dataTask(with: url, completionHandler: { data, response, error in
      if error != nil {
        // handle error
      }
      
      if let data = data,
          let info = try? JSONDecoder().decode([DefaultInfo].self, from: data) {
          completionHandler(.success(info))
      }
    })
    
    task.resume()
  }
}

class NetworkManagerMock: NetworkManagerInterface {
  var result: Result<[DefaultInfo], NetworkError>?
  static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

  func fetchInfoByUrl(from urlString: String, completionHandler: @escaping (Result<[DefaultInfo], NetworkError>) -> Void) {
    if result == nil {
      let defaultInfo = [DefaultInfo(id: 123, color1: "#FF0000", color2: "#0000FF", name1: "Sue", name2: "Henry")]
      completionHandler(.success(defaultInfo))
    }
  }
}
