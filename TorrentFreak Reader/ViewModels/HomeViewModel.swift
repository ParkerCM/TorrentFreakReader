//
//  ArticlesViewModel.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/28/22.
//

import Foundation

@MainActor
class HomeViewModel: BaseArticleViewModel {
        
    @Published
    public var isGettingNextPage = false
    
    @Published
    public var isPlaceHolder = true
    
    private let service: ArticleService = ArticleService.shared
        
    override init() {
        super.init()
        self.articles = PlaceHolderData.articles
    }
    
    public func fetchNewArticles(page: Int) {
        Task.init {
            self.isGettingNextPage = true
            let articles = await service.getArticles(page: page)
            
            if self.isPlaceHolder {
                self.articles = articles
                self.isPlaceHolder = false
            } else {
                self.articles.append(contentsOf: articles)
            }
            
            updateReadIndicator()
            
            self.isGettingNextPage = false
        }
    }
    
    public func fetchRefreshedArticles() async {
        self.articles = await service.getArticles(page: 1)
        updateReadIndicator()
    }
    
}
