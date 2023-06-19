//
//  ArticleDataStore.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 11/5/22.
//

import Foundation
import SQLite

class ArticleDataStore {
    
    // General DB values
    private static let DB_NAME = "ArticleDB"
    
    private static let STORE_NAME = "article.sqlite3"
    
    // Tables
    private let article_table = Table("articles")
    
    private let history_table = Table("history")
    
    // Article table columns
    private let article_id = Expression<Int>("id")
    
    private let article_title = Expression<String>("title")
    
    private let article_author = Expression<String>("author")
    
    private let article_imageUrl = Expression<String>("imageUrl")
    
    private let article_articleUrl = Expression<String>("articleUrl")
    
    private let article_category = Expression<String>("category")
    
    private let article_date = Expression<String>("date")
    
    private let article_addDate = Expression<Int>("addDate")
    
    // History table columns
    private let history_id = Expression<String>("id")
    
    private let hisotry_url = Expression<String>("url")
    
    // DB operation variables
    public static let shared = ArticleDataStore()
    
    private var db: Connection? = nil
    
    private init() {
        if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let dirPath = docDir.appendingPathComponent(Self.DB_NAME)
            
            do {
                try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
                let dbPath = dirPath.appendingPathComponent(Self.STORE_NAME).path
                db = try Connection(dbPath)
                createArticleTable()
                createHistoryTable()
                
                print("SQLiteDataStore init successfully at: \(dbPath) ")
            } catch {
                db = nil
                
                print("SQLiteDataStore init error: \(error)")
            }
        } else {
            db = nil
        }
    }
    
    private func createArticleTable() {
        guard let database = db else { return }
        
        do {
            try database.run(article_table.create { table in
                table.column(article_id, primaryKey: true)
                table.column(article_title)
                table.column(article_author)
                table.column(article_imageUrl)
                table.column(article_articleUrl)
                table.column(article_category)
                table.column(article_date)
                table.column(article_addDate)
            })
            print("Created the article table")
        } catch {
            print("Error while creating the article table: \(error)")
        }
    }
    
    private func createHistoryTable() {
        guard let database = db else { return }
        
        do {
            try database.run(history_table.create { table in
                table.column(history_id, primaryKey: true)
                table.column(hisotry_url)
            })
            print("Created the history table")
        } catch {
            print("Error while creating the history table: \(error)")
        }
    }
    
    // MARK: Article table operations
    
    public func insertArticle(article: Article) -> Bool {
        guard !findArticle(article: article) else { return false }
        guard let database = db else { return false }

        let insert = article_table.insert(self.article_id <- article.hashValue,
                                     self.article_title <- article.title,
                                     self.article_author <- article.author,
                                     self.article_imageUrl <- article.imageUrl,
                                     self.article_articleUrl <- article.articleUrl,
                                     self.article_category <- article.category,
                                     self.article_date <- article.date,
                                     self.article_addDate <- Int(Date().timeIntervalSince1970))
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
            for article in try database.prepare(self.article_table.order(article_addDate.desc)) {
                articles.append(Article(title: article[article_title],
                                        author: article[article_author],
                                        imageUrl: article[article_imageUrl],
                                        articleUrl: article[article_articleUrl],
                                        category: article[article_category],
                                        date: article[article_date],
                                        isLeading: false))
            }
        } catch {
            print("Error getting all articles from the DB: \(error)")
        }
        
        return articles
    }
    
    private func findArticle(article: Article) -> Bool {
        guard let database = db else { return false }

        let filter = self.article_table.filter(self.article_articleUrl == article.articleUrl)
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
            let filter = self.article_table.filter(self.article_articleUrl == article.articleUrl)
            try database.run(filter.delete())
            
            return true
        } catch {
            print("Error deleting article from DB: \(error)")
            
            return false
        }
    }
    
    // MARK: History table operations
    
    public func addToHistory(url: String) -> Bool {
        guard !isInHistory(url: url) else { return false }
        guard let database = db else { return false }

        let insert = history_table.insert(self.history_id <- UUID().uuidString, self.hisotry_url <- url)
        do {
            try database.run(insert)
            return true
        } catch {
            print("Error inserting row: \(error)")
            return false
        }
    }
    
    public func isInHistory(url: String) -> Bool {
        guard let database = db else { return false }

        let filter = self.history_table.filter(self.hisotry_url == url)
        do {
            for _ in try database.prepare(filter) {
                return true
            }
        } catch {
            print("Unable to check if article is already in history: \(error)")
        }
        
        return false
    }
    
    public func removeFromHistory(url: String) -> Bool {
        guard let database = db else { return false }
        
        do {
            let filter = self.history_table.filter(self.hisotry_url == url)
            try database.run(filter.delete())
            
            return true
        } catch {
            print("Error deleting article from history: \(error)")
            
            return false
        }
    }
    
    public func getAllHistory() -> [String] {
        var histories: [String] = []
        guard let database = db else { return histories }

        do {
            for history in try database.prepare(self.history_table) {
                histories.append(history[hisotry_url])
            }
        } catch {
            print("Error getting all history from the DB: \(error)")
        }
        
        return histories
    }
    
}
