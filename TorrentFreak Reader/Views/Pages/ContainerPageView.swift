//
//  ContainerPageView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/25/22.
//

import SwiftUI

struct ContainerPageView: View {
    
    @StateObject
    private var alertViewModel = AlertViewModel()
    
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
            
            SettingsPageView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .toast(isPresenting: $alertViewModel.show, offsetY: -275, alert: {
            alertViewModel.toast
        })
        .environmentObject(alertViewModel)
    }
}

struct ContainerPageView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerPageView()
    }
}
