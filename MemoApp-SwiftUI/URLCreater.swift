//
//  URLCreater.swift
//  MemoApp-SwiftUI
//
//  Created by 渡邊魁優 on 2023/12/12.
//

import Foundation

class URLCreater {
    public func createAllMemoURL() -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "127.0.0.1"
        components.port = 5000
        components.path = "/memo"
        return components
    }
    public func createOneMemoURL(path: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "127.0.0.1"
        components.port = 5000
        components.path = "/memo/\(path)"
        return components
    }
}
