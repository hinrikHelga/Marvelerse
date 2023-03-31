//
//  Character.swift
//  Marvelerse
//
//  Created by Hinrik Helgason on 31.3.2023.
//

import Foundation

struct ApiCharacterResult: Codable {
  let data: ApiCharacterData
}

struct ApiCharacterData: Codable {
  let count: Int
  let results: [Character]
}

struct Character: Codable, Identifiable {
  let id: Int
  let name: String
  let description: String
  let thumbnail: [String: String]
  let urls: [[String: String]]
}
