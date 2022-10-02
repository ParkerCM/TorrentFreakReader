//
//  ArticlesViewModel.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/28/22.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    
    private let service: ArticleService = ArticleService()
    
    func fetchNewArticles(page: Int) {
        Task.init {
            self.articles.append(contentsOf: await service.getArticles(page: page))
        }
    }
    
    func fetchRefreshedArticles() {
        Task.init {
            self.articles = await service.getArticles(page: 1)
        }
    }
    
}
