//
//  PlaceHolderData.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/3/22.
//

import Foundation

class PlaceHolderData {
    
    public static let articles = [
        Article(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pharetra pharetra massa massa ultricies.",
                author: "Andy",
                imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg",
                articleUrl: "null",
                category: "Lawsuits",
                date: "today",
                isLeading: true,
                read: false),
        Article(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Interdum posuere lorem ipsum dolor sit.",
                author: "Andy",
                imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg",
                articleUrl: "null",
                category: "Stats",
                date: "today",
                isLeading: false,
                read: false),
        Article(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et malesuada fames ac turpis egestas integer eget.",
                author: "Andy",
                imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg",
                articleUrl: "null",
                category: "Anti-Piracy",
                date: "today",
                isLeading: false,
                read: false),
        Article(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Maecenas sed enim ut sem viverra aliquet eget.",
                author: "Andy",
                imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg",
                articleUrl: "null",
                category: "Opinion Article",
                date: "today",
                isLeading: false,
                read: false),
        Article(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Urna condimentum mattis pellentesque id.",
                author: "Andy",
                imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg",
                articleUrl: "null",
                category: "Piracy",
                date: "today",
                isLeading: false,
                read: false),
        Article(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non enim praesent elementum facilisis.",
                author: "Andy",
                imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg",
                articleUrl: "null",
                category: "IPTV and Streaming",
                date: "today",
                isLeading: false,
                read: false),
        Article(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Rutrum quisque non tellus orci.",
                author: "Andy",
                imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg",
                articleUrl: "null",
                category: "Repeat Infringer",
                date: "today",
                isLeading: false,
                read: false),
        Article(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat.",
                author: "Andy",
                imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg",
                articleUrl: "null",
                category: "DMCA",
                date: "today",
                isLeading: false,
                read: false)]
    
    public static let section = ArticleSection(article: articles[1], content: "https://torrentfreak.com/images/russia-kremlin.jpg", categories: ["Lawsuits"], sectionType: .image)
    
    public static let sectionTable = ArticleSection(article: articles[1], content: "https://torrentfreak.com/images/russia-kremlin.jpg", categories: ["Lawsuits"], sectionType: .image, tableData: articleTable)
    
    public static let articleTable = ArticleTable(headers: ["Movie Rank", "Rank Last Week", "Movie Name", "IMDB Rating / Trailer"], rows: [["1", "(1)", "Bullet Train", "7.4 / trailer"], ["1", "(1)", "Bullet Train", "7.4 / trailer"], ["1", "(1)", "Bullet Train", "7.4 / trailer"], ["1", "(1)", "Bullet Train", "7.4 / trailer"], ["1", "(1)", "Bullet Train", "7.4 / trailer"], ["1", "(1)", "Bullet Train", "7.4 / trailer"]])
}
