//
//  LeadingArticleView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/27/22.
//

import SwiftUI

struct LeadingArticleView: View {
    
    let title: String
    
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { image in 
            image.opacity(0.5)
                .frame(width: 375, height: 225)
                .cornerRadius(15)
                .overlay {
                    Text(title)
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.leading, 5)
                        .padding(.trailing, 5)
                }
        } placeholder: {
            ProgressView()
        }
        .frame(width: 375, height: 225)
    }
}

struct LeadingArticleView_Previews: PreviewProvider {
    static var previews: some View {
        LeadingArticleView(title: "This is a really cool title with some other things going on.", imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg")
    }
}
