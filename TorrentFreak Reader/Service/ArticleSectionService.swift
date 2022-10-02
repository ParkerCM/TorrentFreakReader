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
                
                articleSections.append(ArticleSection(article: article, content: "", categories: getCategories(document: document), sectionType: .title))
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
        
        return ArticleSection(article: article, content: exerpt.replacingOccurrences(of: "\n", with: "").trimmingCharacters(in: .whitespacesAndNewlines), categories: getCategories(document: document), sectionType: .exerpt)
    }
    
    private func getMainArticleSections(article: Article, document: HTMLDocument) -> [ArticleSection] {
        let parts = document.xpath("//article/div/p|//article/div/h2|//article/div/center/a|//article/div/center/img|//article/div/p/img|//article/div/p/a/img")
        var sections: [ArticleSection] = []
        
        for part in parts {
            if let tag = part.tag {
                switch tag {
                case "p":
                    if !part.stringValue.isEmpty {
                        sections.append(ArticleSection(article: article, content: part.stringValue, categories: getCategories(document: document),sectionType: .content))
                    }
                case "h2":
                    sections.append(ArticleSection(article: article, content: part.stringValue, categories: getCategories(document: document),sectionType: .subHeader))
                case "a":
                    if let imageLink = part["href"] {
                        sections.append(ArticleSection(article: article, content: imageLink, categories: getCategories(document: document),sectionType: .image))
                    }
                case "img":
                    if let imageLink = part["src"] {
                        sections.append(ArticleSection(article: article, content: imageLink, categories: getCategories(document: document),sectionType: .image))
                    }
                default:
                    print("Hit the default case")
                }
            }
        }
        
        return sections
    }
    
    private func getCategories(document: HTMLDocument) -> [String] {
        let categories = document.xpath("//header/p/span/a")
        var categoryArray: [String] = []
        
        for categoy in categories {
            if categoy.stringValue != "Home" {
                categoryArray.append(categoy.stringValue)
            }
        }
        
        return categoryArray
    }
    
}
