//
//  SearchViewModel.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/25/22.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    
    private let service = ArticleService.shared
    
    @Published var popularArticles = [Article]()
    
    @Published var otherArticles = [Article]()
    
    @Published var isGettingNextPage = false
    
    @Published var searchInProgress = false
    
    @Published var doesNextPageExist = true
    
    func performSearch(page: Int, query: String) {
        Task.init {
            self.isGettingNextPage = true
            let searchArticles = await service.getArticles(page: page, query: query)
            
            if let returnedArticles = searchArticles {
                if returnedArticles.otherArticles.count == 12 {
                    self.doesNextPageExist = true
                } else {
                    self.doesNextPageExist = false
                }
                
                if page == 1 {
                    self.popularArticles = returnedArticles.popularArticles
                    self.otherArticles = returnedArticles.otherArticles
                } else {
                    self.otherArticles.append(contentsOf: returnedArticles.otherArticles)
                }
            } else {
                self.doesNextPageExist = false
            }
            
            self.isGettingNextPage = false
        }
    }
    
    func areArticlesLoaded() -> Bool {
        return !popularArticles.isEmpty && !otherArticles.isEmpty
    }
    
    func removeArticles() {
        self.popularArticles = []
        self.otherArticles = []
    }
    
}
