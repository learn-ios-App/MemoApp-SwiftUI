//
//  MemoData.swift
//  MemoApp-SwiftUI
//
//  Created by 渡邊魁優 on 2023/12/12.
//

import Foundation

class MemoData: ObservableObject {
    @Published var memos: [Memo] = []
    @Published var isInput = false
    
    private let apiClient = APIClient()
    
    @MainActor func onAppear() {
        Task {
            do {
                let memos = try await apiClient.fetchMemos()
                self.memos = memos
            } catch {
                let error = error as? APIError ?? APIError.other
                print(error.title)
            }
        }
    }
    
    @MainActor func didTapSaveButton(memo: Memo) {
        Task {
            do {
                let memo = try await apiClient.postMemo(memo: memo)
                self.memos.append(memo)
            } catch {
                let error = error as? APIError ?? APIError.other
                print(error.title)
            }
        }
        self.isInput = false
    }
    
    @MainActor func didTapDeleteButton(memo: Memo) {
        Task {
            do {
                let memo = try await apiClient.deleteMemo(memo: memo)
                try self.memos.remove(at: self.searchIndex(memo: memo))
            } catch {
                let error = error as? APIError ?? APIError.other
                print(error.title)
            }
        }
    }
    
    @MainActor func didTapUpdateButton(memo: Memo) {
        Task {
            do {
                let memo = try await apiClient.updateMemo(memo: memo)
                self.memos[try self.searchIndex(memo: memo)] = memo
            } catch {
                let error = error as? APIError ?? APIError.other
                print(error.title)
            }
        }
    }
    
    func didTapCancelButton() {
        self.isInput = false
    }
    
    func didTapPlusButton() {
        self.isInput = true
    }
    
    private func searchIndex(memo: Memo) throws -> Int {
        guard let index = memos.firstIndex(where: { $0.id == memo.id }) else {
            throw APIError.other
        }
        return index
    }
}
