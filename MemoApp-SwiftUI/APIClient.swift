//
//  APIClient.swift
//  MemoApp-SwiftUI
//
//  Created by 渡邊魁優 on 2023/12/12.
//

import Foundation

class APIClient {
    
    private let urlCreater = URLCreater()
    
    //GET
    public func fetchMemos() async throws -> [Memo] {
        guard let url = urlCreater.createAllMemoURL().url else {
            throw APIError.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw APIError.urlSessionError
        }
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else { throw APIError.responseError }
        
        guard let memos = try? JSONDecoder().decode([Memo].self, from: data) else {
            throw APIError.decordError
        }
        return memos
    }
    
    //POST
    public func postMemo(memo: Memo) async throws -> Memo {
        guard let url = urlCreater.createAllMemoURL().url else {
            throw APIError.badURL
        }
        guard let body = try? JSONEncoder().encode(memo) else {
            throw APIError.encodeError
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw APIError.urlSessionError
        }
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else { throw APIError.responseError }

        guard let memo = try? JSONDecoder().decode(Memo.self, from: data) else {
            throw APIError.decordError
        }
        return memo
    }
    
    //PUT
    public func updateMemo(memo: Memo) async throws -> Memo {
        guard let url = urlCreater.createOneMemoURL(path: memo.id).url else {
            throw APIError.badURL
        }
        guard let body = try? JSONEncoder().encode(memo) else {
            throw APIError.encodeError
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw APIError.urlSessionError
        }
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else { throw APIError.responseError }

        guard let memo = try? JSONDecoder().decode(Memo.self, from: data) else {
            throw APIError.decordError
        }
        return memo
    }
    
    //DELETE
    public func deleteMemo(memo: Memo) async throws -> Memo {
        guard let url = urlCreater.createOneMemoURL(path: memo.id).url else {
            throw APIError.badURL
        }
        guard let body = try? JSONEncoder().encode(memo) else {
            throw APIError.encodeError
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw APIError.urlSessionError
        }
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else { throw APIError.responseError }

        guard let memo = try? JSONDecoder().decode(Memo.self, from: data) else {
            throw APIError.decordError
        }
        return memo
    }
}
