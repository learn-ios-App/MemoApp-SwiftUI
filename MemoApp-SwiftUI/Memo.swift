//
//  Memo.swift
//  MemoApp-SwiftUI
//
//  Created by 渡邊魁優 on 2023/12/12.
//

import Foundation

struct Memo: Codable, Identifiable {
    var id: String
    var title: String
    var content: String
}
