//
//  DashboardView.swift
//  Marvelerse
//
//  Created by Hinrik Helgason on 31.3.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
      TabView {
        CharactersView()
          .tabItem {
            Image(systemName: "person.3.fill")
            Text("Characters")
          }
        Text("Comics")
          .tabItem {
            Image(systemName: "books.vertical.fill")
            Text("Comics")
          }
      }
      
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
