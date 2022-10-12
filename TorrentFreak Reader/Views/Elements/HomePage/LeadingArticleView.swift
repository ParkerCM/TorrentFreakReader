//
//  LeadingArticleView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/27/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct LeadingArticleView: View {
    
    let title: String
    
    let imageUrl: String
    
    let usePlaceHolderImage: Bool
    
    var body: some View {
        WebImage(url: URL(string: imageUrl))
            .resizable()
            .placeholder {
                if usePlaceHolderImage {
                    Image("placeholder_image")
                        .frame(width: 375, height: 225)
                        .cornerRadius(15)
                        .overlay {
                            Text(title)
                                .foregroundColor(.white)
                                .font(.title)
                                .padding(.leading, 5)
                                .padding(.trailing, 5)
                        }
                } else {
                    ProgressView()
                }
            }
            .scaledToFill()
            .frame(width: 375, height: 225)
            .overlay(Color.black.opacity(usePlaceHolderImage ? 0.0 : 0.6))
            .cornerRadius(15)
            .overlay {
                Text(title)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
            }
            .frame(width: 375, height: 225)
    }
}

struct LeadingArticleView_Previews: PreviewProvider {
    static var previews: some View {
        LeadingArticleView(title: "This is a really cool title with some other things going on.", imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg", usePlaceHolderImage: false)
    }
}
