//
//  StartView.swift
//  MatheMentor
//
//  Created by Mark Eggebrecht on 06.06.24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            HighscoreView()
                .tabItem {
                    Label("Highscore", systemImage: "medal")
                }
        }
        
    }
}

#Preview {
    StartView()
}
