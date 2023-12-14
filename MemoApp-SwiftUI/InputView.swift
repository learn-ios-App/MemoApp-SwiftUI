//
//  InputView.swift
//  MemoApp-SwiftUI
//
//  Created by 渡邊魁優 on 2023/12/12.
//

import SwiftUI

struct InputView: View {
    
    @State var title = ""
    @State var content = ""
    let save: (Memo) -> Void
    let cancel: () -> Void
    
    var body: some View {
        NavigationStack {
            List {
                TextField("title", text: $title)
                TextField("content", text: $content)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        cancel()
                    }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let memo = Memo(id: UUID().uuidString, title: title, content: content)
                        save(memo)
                    } label: {
                        Text("Add")
                    }
                }
            
            }
        }
    }
}

#Preview {
    InputView(save: { _ in }, cancel: {})
}
