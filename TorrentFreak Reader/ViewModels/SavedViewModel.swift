//
//  SavedViewModel.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 11/5/22.
//

import Foundation

class SavedViewModel: ObservableObject {
    
    @Published
    public var articles: [Article] = []
    
    private let dataStore = ArticleDataStore.shared
    
    public func getArticles() {
        self.articles = dataStore.getAllArticles()
    }
    
    public func deleteArticle(article: Article) {
        let deleteSuccessful = dataStore.deleteArticle(article: article)
        
        if deleteSuccessful {
            getArticles()
        }
    }
    
}
