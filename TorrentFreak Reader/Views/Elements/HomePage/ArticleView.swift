//
//  ArticleView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/28/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArticleView: View {
    
    var article: Article
    
    let usePlaceHolderImage: Bool
    
    var body: some View {
        HStack (spacing: 15) {
            WebImage(url: URL(string: article.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 150)
                .cornerRadius(10)

            VStack {
                Text(article.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
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
        .background(NavigationLink("", destination: ArticlePageView(article: article)))
        .contextMenu(menuItems: {
            HomeContextMenuView(article: article)
        }, preview: {
            ArticlePageView(article: article)
        })
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        let article = Article(title: "This is the article title. Very cool. Maybe it could be a title with a lot of text and it goes on for a long time", author: "Andy", imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg", articleUrl: "null", category: "Lawsuits", date: "today", isLeading: false)
        ArticleView(article: article, usePlaceHolderImage: false)
    }
}
