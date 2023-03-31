//
//  CharacterView.swift
//  Marvelerse
//
//  Created by Hinrik Helgason on 31.3.2023.
//

import SwiftUI


struct CharactersView: View {
  @StateObject var vm = CharactersViewModel()
  
  fileprivate func listRow(_ character: Character) -> some View {
    VStack {
      Text("\(character.name)")
      Text("\(character.description)")
        .padding()
    }
    .padding()
  }
  
  var body: some View {
    Group {
      if (vm.characters.isEmpty) {
        VStack(spacing: 8) {
          ProgressView()
          Text("loading...")
        }
      } else {
        List {
          ForEach(vm.characters) { character in
            listRow(character)
          }
        }
      }
    }
    .navigationTitle("Characters")
    .task {
      await vm.getCharacters()
    }
    .alert("Error", isPresented: $vm.hasError) {
    } message: {
        Text(vm.errorMessage)
    }
  }
}

struct CharactersView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView{
      CharactersView()
    }.navigationViewStyle(StackNavigationViewStyle())
  }
}
