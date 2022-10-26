//
//  ArticleSearchService.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/25/22.
//

import Foundation
import Fuzi

class ArticleSearchService {
    
    public static let shared = ArticleSearchService()
    
    private let client = TorrentFreakClient.shared
    
    private let TOTAL_POSTS = 12
    
    private let TOTAL_POPULAR = 2
    
    private init() { }
    
    func getArticles(page: Int, query: String) async -> ArticleSearchResult? {
        let html = await client.sendArticleRequest(url: createSearchUrl(page: page, query: query))
        
        return parseArticles(html: html, isFirstPage: page == 1)
    }
    
    private func parseArticles(html: String?, isFirstPage: Bool) -> ArticleSearchResult? {
        if let html = html {
            do {
                let document = try HTMLDocument(string: html)
                var popular = [Article]()
                var other = [Article]()
                
                if isFirstPage {
                    popular.append(contentsOf: parsePosts(document: document, getPopular: true))
                }
                
                other.append(contentsOf: parsePosts(document: document, getPopular: false))
                
                return ArticleSearchResult(popularArticles: popular, otherArticles: other)
            } catch {
                print("Error while getting search articles: \(error)")
            }
        }
        
        return nil
    }
    
    private func parsePosts(document: HTMLDocument, getPopular: Bool) -> [Article] {
        var articles: [Article] = []
        let sectionIndex = getPopular ? "1" : "2"
        let total = getPopular ? TOTAL_POPULAR : TOTAL_POSTS
        
        for i in (1...total) {
            let title = document.xpath("//section/section[\(sectionIndex)]//div[\(i)]/article//h3").first?.stringValue ?? ""
            let author = document.xpath("//section/section[\(sectionIndex)]//div[\(i)]/article//span").first?.stringValue ?? ""
            let category = document.xpath("//section/section[\(sectionIndex)]//div[\(i)]/article//header/p").first?.stringValue ?? "Opinion Article"
            let imageUrl = document.xpath("//section/section[\(sectionIndex)]//div[\(i)]/article//header/img").first?["src"] ?? ""
            let articleUrl = document.xpath("//section/section[\(sectionIndex)]//div[\(i)]/article/a").first?["href"] ?? ""
            let date = document.xpath("//section/section[\(sectionIndex)]//div[\(i)]/article//time").first?.stringValue ?? ""
            
            articles.append(Article(title: title, author: getAuthorName(name: author), imageUrl: imageUrl, articleUrl: articleUrl, category: category, date: date, isLeading: false))
        }
        
        return articles
    }
    
    private func getAuthorName(name: String) -> String {
        var nameStr = name
        var strToFind: String
        
        if (name.contains("\n")) {
            strToFind = "by\n"
        } else {
            strToFind = "by "
        }
        
        if let range: Range<String.Index> = nameStr.range(of: strToFind) {
            let index: Int = nameStr.distance(from: nameStr.startIndex, to: range.upperBound)
            let strIndex = nameStr.index(nameStr.startIndex, offsetBy: index)
            
            nameStr.removeSubrange(nameStr.startIndex..<strIndex)
            
            return nameStr.replacingOccurrences(of: "\n", with: "")
        }
        else {
            print("Unable to get name from timestamp: \(name)")
            return ""
        }
    }
    
    private func createSearchUrl(page: Int, query: String) -> String {
        var cleanQuery = query.replacingOccurrences(of: " ", with: "+")

        if page == 1 {
            return "https://torrentfreak.com/?s=\(cleanQuery)"
        } else {
            return "https://torrentfreak.com/page/\(page)/?s=\(cleanQuery)"
        }
    }
    
}
