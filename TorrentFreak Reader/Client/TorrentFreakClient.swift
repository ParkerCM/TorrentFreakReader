//
//  TorrentFreakClient.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/28/22.
//

import Foundation

class TorrentFreakClient {
    
    func sendPageRequest(page: Int) async -> String? {
        var url: URL
        
        if page == 0 {
            url = URL(string: "https://www.torrentfreak.com")!
        } else {
            url = URL(string: "https://www.torrentfreak.com/page/\(page)/")!
        }
                
        do {
            print("URL is \(url)")
            let htmlString = try String(contentsOf: url, encoding: .ascii)
            
            return htmlString
        } catch {
            print("String error")
        }
        
        return nil
    }
    
}
