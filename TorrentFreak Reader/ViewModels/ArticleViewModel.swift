//
//  ArticleViewModel.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/2/22.
//

import Foundation

@MainActor
class ArticleViewModel: ObservableObject {
    
    @Published var articleSections: [ArticleSection] = []
    
    private let sectionService = ArticleSectionService.shared
    
    func fetchArticleSections(article: Article) {
        Task.init {
            self.articleSections = await sectionService.getSections(article: article)
        }
    }
    
}
