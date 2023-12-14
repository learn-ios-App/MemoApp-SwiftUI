//
//  ContentView.swift
//  MemoApp-SwiftUI
//
//  Created by 渡邊魁優 on 2023/12/12.
//

import SwiftUI

struct ContentView: View {
    @StateObject var memoData = MemoData()
    var body: some View {
        NavigationStack {
            List {
                ForEach(memoData.memos) { memo in
                    ListRow(memo: memo)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                memoData.didTapDeleteButton(memo: memo)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .onAppear(perform: {
                self.memoData.onAppear()
        })
            .navigationTitle("Memo")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        memoData.onAppear()
                    }) {
                        Image(systemName: "gobackward")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        memoData.didTapPlusButton()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $memoData.isInput, content: {
            InputView { memo in
                memoData.didTapSaveButton(memo: memo)
            } cancel: {
                memoData.didTapCancelButton()
            }

        })
    }
}

#Preview {
    ContentView()
}
