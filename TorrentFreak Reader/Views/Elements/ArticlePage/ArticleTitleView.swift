//
//  ArticleTitleView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/2/22.
//

import SwiftUI

struct ArticleTitleView: View {
    
    let article: Article
    
    var body: some View {
        VStack (spacing: 15) {
            Text(article.title)
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing, 35)
            
            HStack {
                Image(systemName: "line.3.horizontal.decrease")
                
                VStack {
                    Text(article.author)
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(article.date)
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if !article.category.isEmpty {
                CategoryView(category: article.category)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ArticleTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleTitleView(article: Article(title: "This is the article title. Very cool. Maybe it could be a title with a lot of text and it goes on for a long time", author: "Ernesto Van der Sar", imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg", articleUrl: "null", category: "Lawsuit", date: "today", isLeading: false))
    }
}
