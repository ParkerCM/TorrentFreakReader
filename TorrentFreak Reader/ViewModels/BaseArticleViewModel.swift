//
//  BaseArticleViewModel.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 6/19/23.
//

import Foundation

class BaseArticleViewModel: ObservableObject {
    
    @Published
    public var articles: [Article] = []
    
    @Published
    public var popularArticles: [Article] = []
    
    @Published
    public var otherArticles: [Article] = []
        
    private let dataStore = ArticleDataStore.shared
    
    public func updateReadIndicator() {
        print("Updating read indicator")
        
        for (index, article) in self.articles.enumerated() {
            self.articles[index].read = dataStore.isInHistory(url: article.articleUrl)
        }
        
        for (index, article) in self.popularArticles.enumerated() {
            self.popularArticles[index].read = dataStore.isInHistory(url: article.articleUrl)
        }
        
        for (index, article) in self.otherArticles.enumerated() {
            self.otherArticles[index].read = dataStore.isInHistory(url: article.articleUrl)
        }
    }
    
    public func isArticleInHistory(url: String) -> Bool {
        return dataStore.isInHistory(url: url)
    }
    
    private func shouldUpdateReadIndicator(articleUrl: String) -> Bool {
        if dataStore.isInHistory(url: articleUrl) {
            return true
        }
        
        return false
    }
    
}
