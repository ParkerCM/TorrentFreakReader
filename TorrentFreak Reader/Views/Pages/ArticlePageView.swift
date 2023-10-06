//
//  ArticlePageView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/2/22.
//

import AlertToast
import SwiftUI

struct ArticlePageView: View {
    
    @EnvironmentObject
    private var alertViewModel: AlertViewModel
    
    @EnvironmentObject
    private var baseViewModel: BaseArticleViewModel
    
    @StateObject
    private var viewModel = ArticleViewModel()
    
    @State
    private var initialLoad = true
    
    public let article: Article
    
    public let fromContextMenu: Bool
    
    private let haptic = UIImpactFeedbackGenerator(style: .rigid)
    
    init(article: Article) {
        self.article = article
        self.fromContextMenu = false
    }
    
    init(article: Article, fromContextMenu: Bool) {
        self.article = article
        self.fromContextMenu = fromContextMenu
    }
    
    var body: some View {
        List {
            if viewModel.articleSections.count > 1 {
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
                    case .quote:
                        ArticleQuoteView(section: section)
                            .listRowInsets(EdgeInsets())
                    }
                }
                .listRowSeparator(.hidden)
                .textSelection(.enabled)
            }
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("Article", displayMode: .inline)
        .onAppear {
            if self.initialLoad {
                viewModel.fetchArticleSections(article: article, baseViewModel: baseViewModel, fromContextMenu: fromContextMenu)
                
                if !fromContextMenu {
                    haptic.impactOccurred()
                }
                
                self.initialLoad = false
            }
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
                    if viewModel.saveArticleToDataStore(article: article) {
                        alertViewModel.toast = alertViewModel.successToast
                    } else {
                        alertViewModel.toast = alertViewModel.errorToast
                    }
                } label: {
                    Image(systemName: "square.and.arrow.down")
                }
            })
        }
        .overlay {
            if viewModel.articleSections.isEmpty {
                ProgressView()
            } else if viewModel.articleSections.count == 1 {
                ErrorTextView(main: "Unable to load article content", secondary: "Try again later")
            }
        }
    }
}

struct ArticlePageView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlePageView(article: Article(title: "This is the article title. Very cool. Maybe it could be a title with a lot of text and it goes on for a long time", author: "Andy", imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg", articleUrl: "null", category: "Lawsuit", date: "today", isLeading: false))
    }
}
