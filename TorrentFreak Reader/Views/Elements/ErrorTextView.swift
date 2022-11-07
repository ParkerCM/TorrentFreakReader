//
//  ErrorTextView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 11/7/22.
//

import SwiftUI

struct ErrorTextView: View {
    
    let main: String
    
    let secondary: String?
    
    var body: some View {
        VStack {
            Text(main)
                .bold()
                .font(.title)
                .multilineTextAlignment(.center)
            
            if let secondary = secondary {
                Text(secondary)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.leading, 25)
        .padding(.trailing, 25)
    }
}

struct ErrorTextView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorTextView(main: "Error getting article content", secondary: "For your query")
    }
}
