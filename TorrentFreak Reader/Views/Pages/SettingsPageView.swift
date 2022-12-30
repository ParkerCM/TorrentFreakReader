//
//  SettingsPageView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 11/18/22.
//

import SwiftUI

struct SettingsPageView: View {
    
    @State var currentThing = OpenArticle.inApp
    
    var body: some View {
        NavigationView {
            List {
                Text("Hello")
                Section("App Settings") {
                    Picker("Thing", selection: $currentThing, content: {
                        Text("In App").tag(OpenArticle.inApp)
                        Text("Browser in App").tag(OpenArticle.browserInApp)
                        Text("Browser").tag(OpenArticle.browser)
                    })
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPageView()
    }
}
