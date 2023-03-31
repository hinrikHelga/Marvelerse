//
//  ApiUtils.swift
//  Marvelerse
//
//  Created by Hinrik Helgason on 31.3.2023.
//

import Foundation
import CryptoKit

struct ApiUtils {
  static func urlWithHash(_ url: String) -> String {
    let ts = String(Date().timeIntervalSince1970)
    let hash = MD5(string: "\(ts)\(API_PRIVATE_KEY)\(API_PUBLIC_KEY)")
    
    return url.appending("?ts=\(ts)&apikey=\(API_PUBLIC_KEY)&hash=\(hash)")
  }
  
  static func MD5(string: String) -> String {
    let hash = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
    
    return hash.map {
      String(format: "%02hhx", $0)
    }
    .joined()
  }
}
