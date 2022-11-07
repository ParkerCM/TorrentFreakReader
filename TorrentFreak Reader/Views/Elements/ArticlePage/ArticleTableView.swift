//
//  ArticleTableView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/12/22.
//

import SwiftUI

struct ArticleTableView: View {
    
    var section: ArticleSection
    
    var body: some View {
        if let data = section.tableData {
            VStack {
                HStack {
                    ForEach(data.headers.indices, id: \.self) { item in
                        Text(data.headers[item])
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        Divider()
                    }
                }
                .background(.pink)
                                
                ForEach(data.rows, id: \.self) { row in
                    HStack {
                        ForEach(row.indices) { item in
                            Text(row[item])
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Divider()
                        }
                    }
                    if row != data.rows.last {
                        Divider()
                    }
                }
                
                HStack {
                    Text("Most downloaded movies via torrent sites")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(.pink)
            }
        }
    }
}

struct ArticleTableView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleTableView(section: PlaceHolderData.sectionTable)
    }
}
