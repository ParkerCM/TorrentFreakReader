//
//  LabelView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/28/22.
//

import SwiftUI

struct CategoryView: View {
    
    var category: String
    
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
