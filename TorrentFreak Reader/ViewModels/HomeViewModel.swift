//
//  ArticlesViewModel.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/28/22.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var articles: [Article] = PlaceHolderData.articles
        
    @Published var isGettingNextPage = false
    
    @Published var isPlaceHolder = true
    
    private let service: ArticleService = ArticleService()
    
    func fetchNewArticles(page: Int) {
        Task.init {
            self.isGettingNextPage = true
            let articles = await service.getArticles(page: page)
            
            if self.isPlaceHolder {
                self.articles = articles
                self.isPlaceHolder = false
            } else {
                self.articles.append(contentsOf: await service.getArticles(page: page))
            }
            
            self.isGettingNextPage = false
        }
    }
    
    func fetchRefreshedArticles() async {
        self.articles = await service.getArticles(page: 1)
    }
    
}
