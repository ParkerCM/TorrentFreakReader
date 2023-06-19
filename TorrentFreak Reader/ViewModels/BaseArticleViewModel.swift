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
    
    private var articlesInHistory: [String] = []
    
    private let dataStore = ArticleDataStore.shared
    
    public func updateReadIndicator() {
        print("Updating read indicator")
        
        for (index, article) in self.articles.enumerated() {
            if shouldUpdateReadIndicator(articleUrl: article.articleUrl) {
                articles[index].read = true
            }
        }
        
        for (index, article) in self.popularArticles.enumerated() {
            if shouldUpdateReadIndicator(articleUrl: article.articleUrl) {
                self.popularArticles[index].read = true
            }
        }
        
        for (index, article) in self.otherArticles.enumerated() {
            if shouldUpdateReadIndicator(articleUrl: article.articleUrl) {
                self.otherArticles[index].read = true
            }
        }
    }
    
    public func isArticleInHistory(url: String) -> Bool {
        return dataStore.isInHistory(url: url)
    }
    
    private func shouldUpdateReadIndicator(articleUrl: String) -> Bool {
        if dataStore.isInHistory(url: articleUrl) && !articlesInHistory.contains(articleUrl) {
            return true
        }
        
        return false
    }
    
}
