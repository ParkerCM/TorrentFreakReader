//
//  ArticleService.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/28/22.
//

import Foundation
import Fuzi

class ArticleService {
    
    private let client = TorrentFreakClient.shared
    
    private let TOTAL_ARTICLES = 9
    
    func getArticles(page: Int) async -> [Article] {
        let html = await client.sendPageRequest(page: page)
                
        return parseAllArticles(html: html)
    }
    
    private func parseAllArticles(html: String?) -> [Article] {
        if let html = html {
            do {
                let document = try HTMLDocument(string: html)
                var articles: [Article] = []
                
                let leadArticle = parseLeadArticle(document: document, html: html)
                let otherArticles = parseArticles(document: document, html: html)
                
                if let leadArticle = leadArticle {
                    articles.append(leadArticle)
                }
                articles.append(contentsOf: otherArticles)
                
                return articles
            } catch {
                print("Error while getting articles")
            }
        }
        
        return []
    }
    
    private func parseLeadArticle(document: HTMLDocument, html: String) -> Article? {
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
        
        return Article(title: title, author: getAuthorName(name: author), imageUrl: matches.first?.url?.absoluteString ?? "", articleUrl: articleUrl, category: "", date: date, isLeading: true)
    }
    
    private func parseArticles(document: HTMLDocument, html: String) -> [Article] {
        var articles: [Article] = []
        
        for i in (1...TOTAL_ARTICLES) {
            if i == 3 { continue }
            
            let title = document.xpath("//div[\(i)]/article//h3").first?.stringValue ?? ""
            let author = document.xpath("//div[\(i)]/article//span").first?.stringValue ?? ""
            let category = document.xpath("//div[\(i)]/article//header//p").first?.stringValue ?? "Opinion Article"
            let imageUrl = document.xpath("//div[\(i)]/article//header//img").first?["src"] ?? ""
            let articleUrl = document.xpath("//div[\(i)]/article/a").first?["href"] ?? ""
            let date = document.xpath("//div[\(i)]/article//time").first?.stringValue ?? ""
            
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
    
}
