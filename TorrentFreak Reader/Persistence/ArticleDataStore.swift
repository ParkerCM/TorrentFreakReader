//
//  ArticleDataStore.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 11/5/22.
//

import Foundation
import SQLite

class ArticleDataStore {
    
    private static let DB_NAME = "ArticleDB"
    
    private static let STORE_NAME = "articles.sqlite3"
    
    private let articles = Table("articles")
    
    private let id = Expression<Int>("id")
    
    private let title = Expression<String>("title")
    
    private let author = Expression<String>("author")
    
    private let imageUrl = Expression<String>("imageUrl")
    
    private let articleUrl = Expression<String>("articleUrl")
    
    private let category = Expression<String>("category")
    
    private let date = Expression<String>("date")
    
    public static let shared = ArticleDataStore()
    
    private var db: Connection? = nil
    
    private init() {
        if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let dirPath = docDir.appendingPathComponent(Self.DB_NAME)
            
            do {
                try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
                let dbPath = dirPath.appendingPathComponent(Self.STORE_NAME).path
                db = try Connection(dbPath)
                createTable()
                
                print("SQLiteDataStore init successfully at: \(dbPath) ")
            } catch {
                db = nil
                
                print("SQLiteDataStore init error: \(error)")
            }
        } else {
            db = nil
        }
    }
    
    private func createTable() {
        guard let database = db else { return }
        
        do {
            try database.run(articles.create { table in
                table.column(id, primaryKey: true)
                table.column(title)
                table.column(author)
                table.column(imageUrl)
                table.column(articleUrl)
                table.column(category)
                table.column(date)
            })
            print("Created the article table")
        } catch {
            print("Error while creating the article table: \(error)")
        }
    }
    
    public func insertArticle(article: Article) -> Bool {
        guard !findArticle(article: article) else { return false }
        guard let database = db else { return false }

        let insert = articles.insert(self.id <- article.hashValue,
                                     self.title <- article.title,
                                     self.author <- article.author,
                                     self.imageUrl <- article.imageUrl,
                                     self.articleUrl <- article.articleUrl,
                                     self.category <- article.category,
                                     self.date <- article.date)
        do {
            try database.run(insert)
            return true
        } catch {
            print("Error inserting row: \(error)")
            return false
        }
    }
    
    
    func getAllArticles() -> [Article] {
        var articles: [Article] = []
        guard let database = db else { return articles }

        do {
            for article in try database.prepare(self.articles) {
                articles.append(Article(title: article[title],
                                        author: article[author],
                                        imageUrl: article[imageUrl],
                                        articleUrl: article[articleUrl],
                                        category: article[category],
                                        date: article[date],
                                        isLeading: false))
            }
        } catch {
            print("Error getting all articles from the DB: \(error)")
        }
        
        return articles
    }
    
    private func findArticle(article: Article) -> Bool {
        guard let database = db else { return false }

        let filter = self.articles.filter(self.title == article.title && self.date == article.date)
        do {
            for _ in try database.prepare(filter) {
                return true
            }
        } catch {
            print("Unable to check if article is already in the DB: \(error)")
        }
        
        return false
    }
    
    public func deleteArticle(article: Article) -> Bool {
        guard let database = db else { return false }
        
        do {
            let filter = self.articles.filter(self.title == article.title && self.date == article.date)
            try database.run(filter.delete())
            
            return true
        } catch {
            print("Error deleting article from DB: \(error)")
            
            return false
        }
    }
    
}
