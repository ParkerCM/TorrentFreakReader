//
//  LabelView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/28/22.
//

import SwiftUI

struct CategoryView: View {
    
    public var category: String
    
    var body: some View {
        VStack  {
            Text(category)
                .foregroundColor(.white)
                .font(.caption2)
                .bold()
        }
        .padding(10)
        .background(getColor(category: category))
        .cornerRadius(10)
    }
    
    private func getColor(category: String) -> Color {
        switch category {
        case "Lawsuits":
            return .purple
        case "Anti-Piracy":
            return .orange
        case "Law and Politics":
            return .yellow
        case "Stats":
            return .red
        case "Research":
            return .blue
        case "Piracy":
            return .green
        case "Opinion Article":
            return .cyan
        case "News":
            return .red
        case "IPTV and Streaming":
            return.brown
        case "DMCA":
            return .pink
        case "DVDrip":
            return .mint
        case "Repeat Infringer":
            return .indigo
        case "Apps and Sites":
            return .teal
        case "Site Blocking":
            return .gray
        case "Copyright Trolls":
            return .red
        case "Takedowns and Seizures":
            return .red
        case "Piracy Research":
            return .red
        case "Technology":
            return .blue
        case "VPN Providers":
            return .orange
        case "Bittorrent":
            return .indigo
        case "Digital Freedon":
            return .green
        default:
            return .cyan
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: "Piracy")
    }
}
