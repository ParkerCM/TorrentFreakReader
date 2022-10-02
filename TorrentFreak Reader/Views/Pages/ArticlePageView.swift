//
//  ArticlePageView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/2/22.
//

import SwiftUI

struct ArticlePageView: View {
    
    @StateObject var viewModel = ArticleViewModel()
    
    let article: Article
    
    var body: some View {
        List {
            ForEach(viewModel.articleSections, id: \.self) { section in
                switch section.sectionType {
                case .title:
                    ArticleTitleView(article: article)
                case .image:
                    ArticleTitleView(article: article)
                case .subHeader:
                    ArticleSubHeaderView(section: section)
                case .exerpt:
                    ArticleExcerptView(section: section)
                case .content:
                    ArticleContentView(section: section)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("TorrentFreak", displayMode: .inline)
        .onAppear {
            viewModel.fetchArticleSections(article: article)
        }
        .refreshable {
            // Do nothing
        }
    }
}

struct ArticlePageView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlePageView(article: Article(title: "This is the article title. Very cool. Maybe it could be a title with a lot of text and it goes on for a long time", author: "Andy", imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg", articleUrl: "null", category: "Lawsuit", date: "today", isLeading: false))
    }
}
