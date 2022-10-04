//
//  ArticleView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/28/22.
//

import SwiftUI

struct ArticleView: View {
    
    var article: Article
    
    let usePlaceHolderImage: Bool
    
    var body: some View {
        HStack (spacing: 15) {
            AsyncImage(url: URL(string: article.imageUrl)) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                if usePlaceHolderImage {
                    Image("placeholder_image")
                        .resizable()
                            .scaledToFill()
                } else {
                    ProgressView()
                }
            }
            .frame(width: 150)
            .cornerRadius(10)

            VStack {
                Text(article.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 5)
                
                Spacer()
                                
                if (!article.category.isEmpty) {
                    CategoryView(category: article.category)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 125)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        let article = Article(title: "This is the article title. Very cool. Maybe it could be a title with a lot of text and it goes on for a long time", author: "Andy", imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg", articleUrl: "null", category: "Lawsuits", date: "today", isLeading: false)
        ArticleView(article: article, usePlaceHolderImage: false)
    }
}
