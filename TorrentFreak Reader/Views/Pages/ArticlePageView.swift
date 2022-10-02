//
//  ArticlePageView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/2/22.
//

import SwiftUI

struct ArticlePageView: View {
    
    let article: Article
    
    var body: some View {
        ArticleTitleView(article: article)
    }
}

struct ArticlePageView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlePageView(article: Article(title: "This is the article title. Very cool. Maybe it could be a title with a lot of text and it goes on for a long time", author: "Andy", imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg", articleUrl: "null", category: "Lawsuit", date: "today", isLeading: false))
    }
}
