//
//  SearchViewModel.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/25/22.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    
    private let service = ArticleSearchService.shared
    
    @Published var popularArticles = [Article]()
    
    @Published var otherArticles = [Article]()
    
    @Published var isGettingNextPage = false
    
    func performSearch(page: Int, query: String) {
        Task.init {
            self.isGettingNextPage = true
            let searchArticles = await service.getArticles(page: page, query: query)
            
            if let returnedArticles = searchArticles {
                if page == 1 {
                    self.popularArticles = returnedArticles.popularArticles
                    self.otherArticles = returnedArticles.otherArticles
                } else {
                    self.otherArticles.append(contentsOf: returnedArticles.otherArticles)
                }
            }
            
            self.isGettingNextPage = false
        }
    }
    
    func areArticlesLoaded() -> Bool {
        return !popularArticles.isEmpty && !otherArticles.isEmpty
    }
    
}
