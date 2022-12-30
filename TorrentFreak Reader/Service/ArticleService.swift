//
//  ArticleService.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/28/22.
//

import Foundation
import Fuzi

class ArticleService {
    
    public static let shared = ArticleService()
    
    private let client = TorrentFreakClient.shared
    
    private let TOTAL_HOME_ARTICLES = 9
    
    private let TOTAL_POPULAR = 2
    
    private let TOTAL_OTHER_RESULTS = 12
    
    private init() { }
    
    func getArticles(page: Int) async -> [Article] {
        let html = await client.sendRequest(url: createUrl(page: page))
                
        return parseAllArticles(html: html)
    }
    
    func getArticles(page: Int, query: String) async -> ArticleSearchResult? {
        let html = await client.sendRequest(url: createUrl(page: page, query: query))
        
        return parseArticles(html: html, isFirstPage: page == 1)
    }
    
    private func createUrl(page: Int) -> URL {
        if page == 0 {
            return URL(string: "https://www.torrentfreak.com")!
        } else {
            return URL(string: "https://www.torrentfreak.com/page/\(page)/")!
        }
    }
    
    private func createUrl(page: Int, query: String) -> URL {
        let cleanQuery = query.replacingOccurrences(of: " ", with: "+")

        if page == 1 {
            return URL(string: "https://torrentfreak.com/?s=\(cleanQuery)")!
        } else {
            return URL(string: "https://torrentfreak.com/page/\(page)/?s=\(cleanQuery)")!
        }
    }
    
    private func parseAllArticles(html: String?) -> [Article] {
        if let html = html {
            do {
                let document = try HTMLDocument(string: html)
                var articles: [Article] = []
                
                let leadArticle = parseLeadArticle(document: document)
                let otherArticles = parseArticles(document: document)
                
                if let leadArticle = leadArticle {
                    articles.append(leadArticle)
                }
                articles.append(contentsOf: otherArticles)
                
                return articles
            } catch {
                print("Error while getting articles: \(error)")
            }
        }
        
        return []
    }
    
    private func parseLeadArticle(document: HTMLDocument) -> Article? {
        let title = document.xpath("//section//h1").first?.stringValue ?? ""
        let author = document.xpath("//section/a//footer/div").first?.stringValue ?? ""
        let imageUrl = document.xpath("//section/a").first?["style"] ?? ""
        let articleUrl = document.xpath("//section/a").first?["href"] ?? ""
        let date = document.xpath("//section/a//time").first?.stringValue ?? ""
        
        if title.isEmpty {
            return nil
        }
        
        // Extract the image url from the style element
        let types: NSTextCheckingResult.CheckingType = .link
        let detector = try? NSDataDetector(types: types.rawValue)

        guard let detect = detector else {
           return nil
        }

        let matches = detect.matches(in: imageUrl, options: .reportCompletion, range: NSMakeRange(0, imageUrl.count))
        
        return Article(title: title, author: getAuthorName(name: author), imageUrl: matches.first?.url?.absoluteString ?? "", articleUrl: articleUrl, category: "News", date: date, isLeading: true)
    }
    
    private func parsePosts(document: HTMLDocument, getPopular: Bool) -> [Article] {
        var articles: [Article] = []
        let sectionIndex = getPopular ? "1" : "2"
        let total = getPopular ? TOTAL_POPULAR : TOTAL_OTHER_RESULTS
        
        for i in (1...total) {
            let title = document.xpath("//section/section[\(sectionIndex)]//div[\(i)]/article//h3").first?.stringValue ?? ""
            let author = document.xpath("//section/section[\(sectionIndex)]//div[\(i)]/article//span").first?.stringValue ?? ""
            let category = document.xpath("//section/section[\(sectionIndex)]//div[\(i)]/article//header/p").first?.stringValue ?? "News"
            let imageUrl = document.xpath("//section/section[\(sectionIndex)]//div[\(i)]/article//header/img").first?["src"] ?? ""
            let articleUrl = document.xpath("//section/section[\(sectionIndex)]//div[\(i)]/article/a").first?["href"] ?? ""
            let date = document.xpath("//section/section[\(sectionIndex)]//div[\(i)]/article//time").first?.stringValue ?? ""
            
            if !title.isEmpty {
                articles.append(Article(title: title, author: getAuthorName(name: author), imageUrl: imageUrl, articleUrl: articleUrl, category: category, date: date, isLeading: false))
            }
        }
        
        return articles
    }
    
    private func parseArticles(document: HTMLDocument) -> [Article] {
        var articles: [Article] = []
        
        for i in (1...TOTAL_HOME_ARTICLES) {
            if i == 3 { continue }
            
            let title = document.xpath("//div[\(i)]/article//h3").first?.stringValue ?? ""
            let author = document.xpath("//div[\(i)]/article//span").first?.stringValue ?? ""
            let category = document.xpath("//div[\(i)]/article//header//p").first?.stringValue ?? "News"
            let imageUrl = document.xpath("//div[\(i)]/article//header//img").first?["data-src"] ?? ""
            let articleUrl = document.xpath("//div[\(i)]/article/a").first?["href"] ?? ""
            let date = document.xpath("//div[\(i)]/article//time").first?.stringValue ?? ""
            
            if !title.isEmpty {
                articles.append(Article(title: title, author: getAuthorName(name: author), imageUrl: imageUrl, articleUrl: articleUrl, category: category, date: date, isLeading: false))
            }
        }
        
        return articles
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
    
}
