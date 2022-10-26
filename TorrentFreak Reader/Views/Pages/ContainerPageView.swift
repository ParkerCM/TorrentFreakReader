//
//  ContainerPageView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/25/22.
//

import SwiftUI

struct ContainerPageView: View {
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("News")
                }
            
            SearchPageView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            SavedPageView()
                .tabItem {
                    Image(systemName: "square.and.arrow.down")
                    Text("Saved")
                }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

struct ContainerPageView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerPageView()
    }
}
