//
//  NetworkManager.swift
//  Marvelerse
//
//  Created by Hinrik Helgason on 31.3.2023.
//

import Foundation

enum APIConstants {
  static let baseURL = "https://gateway.marvel.com:443/"
}

final class NetworkingManager {
  static let shared = NetworkingManager()
  
  private init() {}
  
  func request<T: Codable>(to url: String,
                          type T: T.Type,
                          completion: @escaping (Result<T, Error>) -> Void) {

    guard let absoluteUrl = URL(string: ApiUtils.urlWithHash(url)) else {
      completion(.failure(NetworkError.invalidUrl))
      return
    }
    
    print(absoluteUrl)
    
    let request = URLRequest(url: absoluteUrl)

    let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in

      if error != nil {
        completion(.failure(NetworkError.custom(error: error!)))
        return
      }

      guard let response = response as? HTTPURLResponse,
            (200...300) ~= response.statusCode else {

        let statusCode = (response as! HTTPURLResponse).statusCode
        completion(.failure(NetworkError.invalidStatusCode(statusCode: statusCode)))

        return
      }

      guard let data = data else {
        completion(.failure(NetworkError.invalidData))
        return
      }

      do {
        let res = try JSONDecoder().decode(T.self, from: data)

        completion(.success(res))
      } catch {
        completion(.failure(NetworkError.decodeFailure(error: error)))
      }
    }

    dataTask.resume()
  }
}

extension NetworkingManager {
  enum NetworkError: Error {
    case invalidUrl
    case invalidStatusCode(statusCode: Int)
    case invalidData
    case custom(error: Error)
    case decodeFailure(error: Error)
  }
}
