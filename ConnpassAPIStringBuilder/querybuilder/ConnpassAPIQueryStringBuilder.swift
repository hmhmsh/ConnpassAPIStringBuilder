//
//  ConnpassAPIQueryStringBuilder.swift
//  ConnpassAPIStringBuilder
//
//  Created by 長谷川瞬哉 on 2018/06/08.
//  Copyright © 2018年 hmhm. All rights reserved.
//

import Foundation

struct ConnpassAPIQueryStringBuilder {
    let query: ConnpassAPIQuery
    
    func build() -> String {
        var result = [String]()
        
        if let eventId = createQueryString(param: query.event_id, key: .event_id) {
            result.append(eventId)
        }
        
        if let keyword = createQueryString(param: query.keyword, key: .keyword) {
            result.append(keyword)
        }
        
        if let keywordOr = createQueryString(param: query.keyword_or, key: .keyword_or) {
            result.append(keywordOr)
        }
        
        if let ym = createQueryString(param: query.ym, key: .ym) {
            result.append(ym)
        }
        
        if let ymd = createQueryString(param: query.ymd, key: .ymd) {
            result.append(ymd)
        }
        
        if let nickname = createQueryString(param: query.nickname, key: .nickname) {
            result.append(nickname)
        }
        
        if let ownerNickname = createQueryString(param: query.owner_nickname, key: .owner_nickname) {
            result.append(ownerNickname)
        }
        
        if let seriesId = createQueryString(param: query.series_id, key: .series_id) {
            result.append(seriesId)
        }
        
        if let start = createQueryString(param: query.start, key: .start) {
            result.append(start)
        }
        
        if let order = createQueryString(param: query.order, key: .order) {
            result.append(order)
        }
        
        if let count = createQueryString(param: query.count, key: .count) {
            result.append(count)
        }
        
        let queryResult = result.reduce("", {
            let result = $0 == "" ? $0 : $0 + "&"
            return result + $1
        })
        
        if queryResult == "" {
            return ConnpassAPIQueryBuilder.requestUrl
        } else {
            return ConnpassAPIQueryBuilder.requestUrl + "?" + queryResult
        }
    }

    private func createQueryString(param: [Int]?, key: ConnpassAPIQueryKey) -> String? {
        guard let param = param?.map({ String($0) }) else {
            return nil
        }
        
        return createQueryString(param: param, key: key)
    }

    private func createQueryString(param: [String]?, key: ConnpassAPIQueryKey) -> String? {
        guard let param = param else {
            return nil
        }
        
        return param.reduce("", { self.join(oridinal: $0, key: key, value: $1) })
    }

    private func createQueryString(param: Int?, key: ConnpassAPIQueryKey) -> String? {
        guard let param = param else {
            return nil
        }
        
        return createQueryString(param: String(param), key: key)
    }

    private func createQueryString(param: String?, key: ConnpassAPIQueryKey) -> String? {
        guard let param = param else {
            return nil
        }
        
        return self.join(oridinal: "", key: key, value: param)
    }
    
    /// 文字列の結合。間に&を挟む。
    private func join(oridinal: String, key: ConnpassAPIQueryKey, value: String) -> String {
        let result = oridinal == "" ? oridinal : oridinal + "&"
        return "\(result)\(key.rawValue)=\(value)"
    }
}
