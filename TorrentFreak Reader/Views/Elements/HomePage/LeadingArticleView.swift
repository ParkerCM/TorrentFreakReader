//
//  LeadingArticleView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/27/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct LeadingArticleView: View {
    
    public var article: Article
    
    public let usePlaceHolderImage: Bool
    
    var body: some View {
        WebImage(url: URL(string: article.imageUrl))
            .resizable()
            .placeholder {
                if usePlaceHolderImage {
                    Image("placeholder_image")
                        .frame(width: 375, height: 225)
                        .cornerRadius(15)
                        .overlay {
                            Text(article.title)
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
                Text(article.title)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
            }
            .background(NavigationLink("", destination: ArticlePageView(article: article))
                .opacity(0.0))
            .contextMenu(menuItems: {
                HomeContextMenuView(article: article)
            }, preview: {
                ArticlePageView(article: article)
            })
    }
}

struct LeadingArticleView_Previews: PreviewProvider {
    static var previews: some View {
        let article = Article(title: "This is the article title. Very cool. Maybe it could be a title with a lot of text and it goes on for a long time", author: "Andy", imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg", articleUrl: "null", category: "Lawsuits", date: "today", isLeading: false)
        LeadingArticleView(article: article, usePlaceHolderImage: false)
    }
}
