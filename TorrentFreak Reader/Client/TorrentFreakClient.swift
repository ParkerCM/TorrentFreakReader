//
//  TorrentFreakClient.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/28/22.
//

import Foundation

class TorrentFreakClient {
    
    public static let shared: TorrentFreakClient = TorrentFreakClient()
    
    private init() { }
    
    public func sendRequest(url: URL) async -> String {
        print("URL is \(url)")
        
        do {
            let htmlString = try String(contentsOf: url, encoding: .utf8)
            
            return htmlString
        } catch {
            print("Error sending request to TF: \(error)")
            return ""
        }
    }
    
}
