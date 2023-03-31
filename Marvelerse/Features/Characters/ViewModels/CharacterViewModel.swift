//
//  CharacterViewModel.swift
//  Marvelerse
//
//  Created by Hinrik Helgason on 31.3.2023.
//

import Foundation
import SwiftUI


@MainActor
class CharactersViewModel: ObservableObject {
  
  @Published private(set) var characters: [Character] = []
  @Published var errorMessage = ""
  @Published var hasError = false
  
  func getCharacters() async {
    NetworkingManager.shared.request(to: ApiUtils.urlWithHash(APIConstants.baseURL.appending("/v1/public/characters")),
                                     type: ApiCharacterResult.self) { res in
      switch res {
      case .success(let response):
        self.characters = response.data.results.map({ item in
          Character(id: item.id,
                    name: item.name,
                    description: item.description,
                    thumbnail: item.thumbnail,
                    urls: item.urls)
        })
      case .failure(let error):
        print(error)
      }
    }
  }
}
