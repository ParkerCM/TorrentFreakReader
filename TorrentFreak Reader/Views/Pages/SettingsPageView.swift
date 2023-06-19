//
//  SettingsPageView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 11/18/22.
//

import SwiftUI

struct SettingsPageView: View {
    
    @State
    private var readIndicatorSetting = UserDefaults.standard.bool(forKey: UserDefaultsKeys.displayReadIndicator)
        
    var body: some View {
        NavigationView {
            List {
                Section("App Settings") {
                    Toggle(isOn: $readIndicatorSetting, label: {
                        Text("Display read indicator")
                    }).onChange(of: readIndicatorSetting) { value in
                        readIndicatorSetting.toggle()
                        UserDefaults.standard.set(readIndicatorSetting, forKey: UserDefaultsKeys.displayReadIndicator)
                    }
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
