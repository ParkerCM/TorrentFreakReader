//
//  ArticleViewModel.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/2/22.
//

import Foundation

@MainActor
class ArticleViewModel: ObservableObject {
    
    @Published
    public var articleSections: [ArticleSection] = []
    
    private let sectionService = ArticleSectionService.shared
    
    private let dataStore = ArticleDataStore.shared
    
    public func fetchArticleSections(article: Article, baseViewModel: BaseArticleViewModel, fromContextMenu: Bool) {
        Task.init {
            self.articleSections = await sectionService.getSections(article: article)
            
            if !self.articleSections.isEmpty && !fromContextMenu {
                if saveArticleToHistory(url: article.articleUrl) {
                    print("Article was added to history")
                } else {
                    print("Article was not added to history")
                }
                
                baseViewModel.updateReadIndicator()
            }
        }
    }
    
    public func saveArticleToDataStore(article: Article) -> Bool {
        return dataStore.insertArticle(article: article)
    }
    
    public func saveArticleToHistory(url: String) -> Bool {
        return dataStore.addToHistory(url: url)
    }
    
}
