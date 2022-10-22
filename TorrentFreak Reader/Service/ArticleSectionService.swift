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
        
        return ArticleSection(article: article, content: exerpt.trimmingCharacters(in: .whitespacesAndNewlines), sectionType: .exerpt)
    }
    
    private func getMainArticleSections(article: Article, document: HTMLDocument) -> [ArticleSection] {
        let parts = document.xpath("//article/div/p|//article/div/h2|//article/div/center/a|//article/div/center/img|//article/div/p/img|//article/div/p/a/img|//article/div/table|//article/div/div/iframe")
        var sections: [ArticleSection] = []
        
        for part in parts {
            if let tag = part.tag {
                switch tag {
                case "p":
                    if !part.stringValue.isEmpty {
                        // if it's the last paragraph and has the em tag as a child then it's likely an ending paragraph and should be processed as such
                        if part == parts[parts.endIndex - 1] && part.children.first?.tag == "em" {
                            sections.append(ArticleSection(article: article, content: getParagraphContent(part: part.children.first!) ,sectionType: .ending))
                        } else {
                            sections.append(ArticleSection(article: article, content: getParagraphContent(part: part), sectionType: .content))
                        }
                    }
                case "h2":
                    sections.append(ArticleSection(article: article, content: part.stringValue, sectionType: .subHeader))
                case "a":
                    fallthrough
                case "img":
                    if let imageLink = part[tag == "img" ? "src" : "href"] {
                        sections.append(ArticleSection(article: article, content: imageLink, sectionType: .image))
                    }
                case "table":
                    sections.append(ArticleSection(article: article, content: "", sectionType: .table, tableData: getTableData(document: part)))
                case "iframe":
                    if let videoLink = part["src"] {
                        sections.append(ArticleSection(article: article, content: videoLink, sectionType: .video))
                    }
                default:
                    print("Hit the default case")
                }
            }
        }
        
        return sections
    }
    
    private func getParagraphContent(part: XMLElement) -> String {
        var contentXml = part.rawXML
        
        if !part.children.isEmpty {
            for child in part.children {
                if child.tag == "a" {
                    if let link = child["href"] {
                        contentXml = contentXml.replacingOccurrences(of: child.rawXML, with: "[\(child.stringValue)](\(link))")
                    }
                }
            }
        }
        
        do {
            let xml = try XMLDocument(string: contentXml, encoding: .utf8)
            
            return xml.root!.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            print("Error getting paragraph content")
            return "Error getting section"
        }
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
    
    private func getTableData(document: XMLElement) -> ArticleTable {
        let headerRow = document.xpath("//thead/tr")
        let rows = document.xpath("//table/tr")
        
        let header = getRow(element: headerRow.first!)
        var body: [[String]] = [[String]]()
        
        for row in rows {
            body.append(getRow(element: row))
        }
        
        return ArticleTable(headers: header, rows: body)
    }
    
    private func getRow(element: XMLElement) -> [String] {
        var row = [String]()
        
        for el in element.children {
            row.append(el.stringValue)
        }
        
        return row
    }
    
}
