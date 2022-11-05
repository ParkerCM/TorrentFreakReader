//
//  ArticlePageView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/2/22.
//

import SwiftUI

struct ArticlePageView: View {
    
    @StateObject var viewModel = ArticleViewModel()
    
    @State private var initialLoad = true
    
    let article: Article
    
    private let haptic = UIImpactFeedbackGenerator(style: .rigid)
    
    var body: some View {
        List {
            ForEach(viewModel.articleSections, id: \.self) { section in
                switch section.sectionType {
                case .title:
                    ArticleTitleView(section: section)
                        .listRowInsets(EdgeInsets())
                case .image:
                    ArticleImageView(section: section)
                        .background(NavigationLink("", destination: ImageDetailPageView(articleSection: section))
                            .opacity(0.0))
                        .listRowInsets(EdgeInsets())
                case .subHeader:
                    ArticleSubHeaderView(section: section)
                case .ending:
                    ArticleExcerptView(section: section)
                case .exerpt:
                    ArticleExcerptView(section: section)
                case .content:
                    ArticleContentView(section: section)
                case .table:
                    ArticleTableView(section: section)
                        .listRowInsets(EdgeInsets())
                case .video:
                    ArticleVideoView(section: section)
                        .cornerRadius(15)
                        .frame(height: 225)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("Article", displayMode: .inline)
        .onAppear {
            if self.initialLoad {
                viewModel.fetchArticleSections(article: article)
                haptic.impactOccurred()
                self.initialLoad = false
            }
        }
        .refreshable {
            viewModel.fetchArticleSections(article: article)
            haptic.impactOccurred()
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing, content: {
                ShareLink(item: URL(string: article.articleUrl)!) {
                    Image(systemName: "square.and.arrow.up")
                }
                Link(destination: URL(string: article.articleUrl)!) {
                    Image(systemName: "link")
                }
                Button {
                    viewModel.saveArticleToDataStore(article: article)
                } label: {
                    Image(systemName: "square.and.arrow.down")
                }
            })
        }
        .overlay {
            if viewModel.articleSections.isEmpty {
                ProgressView()
            }
        }
    }
}

struct ArticlePageView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlePageView(article: Article(title: "This is the article title. Very cool. Maybe it could be a title with a lot of text and it goes on for a long time", author: "Andy", imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg", articleUrl: "null", category: "Lawsuit", date: "today", isLeading: false))
    }
}
