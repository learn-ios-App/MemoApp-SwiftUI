//
//  ListRow.swift
//  MemoApp-SwiftUI
//
//  Created by 渡邊魁優 on 2023/12/12.
//

import SwiftUI

struct ListRow: View {
    @State var memo: Memo
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.title)
            Text(memo.content)
        }
    }
}

#Preview {
    ListRow(memo: Memo(id: "A", title: "title", content: "content"))
}
