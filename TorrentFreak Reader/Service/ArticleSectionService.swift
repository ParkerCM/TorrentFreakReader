//
//  ArticleSectionService.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/2/22.
//

import Foundation
import Fuzi

class ArticleSectionService {
    
    private let client = TorrentFreakClient.shared
    
    func getSections(article: Article) async -> [ArticleSection] {
        let html = await client.sendArticleRequest(url: article.articleUrl)
        
        return getAllSections(article: article, html: html)
    }
    
    private func getAllSections(article: Article, html: String?) -> [ArticleSection] {
        if let html = html {
            do {
                let document = try HTMLDocument(string: html)
                
                var articleSections: [ArticleSection] = []
                
                articleSections.append(ArticleSection(article: article, content: "", sectionType: .title))
                articleSections.append(getArticleExerpt(article: article, document: document))
                articleSections.append(contentsOf: getMainArticleSections(article: article, document: document))
                
                return articleSections
            } catch {
                print("Error getting all article sections")
            }
        }
        
        return []
    }
    
    private func getArticleExerpt(article: Article, document: HTMLDocument) -> ArticleSection {
        let exerpt = document.xpath("//article/header/p[2]").first?.stringValue ?? ""
        
        return ArticleSection(article: article, content: exerpt.replacingOccurrences(of: "\n", with: ""), sectionType: .exerpt)
    }
    
    private func getMainArticleSections(article: Article, document: HTMLDocument) -> [ArticleSection] {
        let parts = document.xpath("//article/div/p|//article/div/h2")
        var sections: [ArticleSection] = []
        
        for part in parts {
            if let tag = part.tag {
                switch tag {
                case "p":
                    if !part.stringValue.isEmpty {
                        sections.append(ArticleSection(article: article, content: part.stringValue, sectionType: .content))
                    }
                case "h2":
                    sections.append(ArticleSection(article: article, content: part.stringValue, sectionType: .subHeader))
                default:
                    print("Hit the default case")
                }
            }
        }
        
        return sections
    }
    
}
