//
//  TorrentFreakClient.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/28/22.
//

import Foundation

class TorrentFreakClient {
    
    static let shared: TorrentFreakClient = TorrentFreakClient()
    
    private init() { }
    
    func sendPageRequest(page: Int) async -> String {
        var url: URL?
        
        if page == 0 {
            url = URL(string: "https://www.torrentfreak.com")
        } else {
            url = URL(string: "https://www.torrentfreak.com/page/\(page)/")
        }
        
        if let url = url {
            return await sendRequest(url: url)
        }
        
        return ""
    }
    
    func sendArticleRequest(url: String) async -> String {
        let url = URL(string: url)
        
        if let url = url {
            return await sendRequest(url: url)
        }
        
        return ""
    }
    
    private func sendRequest(url: URL) async -> String {
        print("URL is \(url)")
        
        do {
            let htmlString = try String(contentsOf: url, encoding: .ascii)
            
            return htmlString
        } catch {
            print("Error sending request to TF")
            return ""
        }
    }
    
}
