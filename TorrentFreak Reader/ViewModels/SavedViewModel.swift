//
//  SavedViewModel.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 11/5/22.
//

import Foundation

class SavedViewModel: BaseArticleViewModel {
    
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
