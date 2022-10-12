//
//  ArticleSection.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/2/22.
//

import Foundation

struct ArticleSection: Hashable {
    
    var article: Article
    
    var content: String
    
    var categories: [String]
    
    var sectionType: ArticleSectionType
    
    var tableData: [[String]]?
    
}
