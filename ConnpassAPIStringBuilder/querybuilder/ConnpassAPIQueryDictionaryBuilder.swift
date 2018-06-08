//
//  ConnpassAPIQueryDictionaryBuilder.swift
//  ConnpassAPIStringBuilder
//
//  Created by 長谷川瞬哉 on 2018/06/08.
//  Copyright © 2018年 hmhm. All rights reserved.
//

import Foundation

struct ConnpassAPIQueryDictionaryBuilder {
    let query: ConnpassAPIQuery
    
    func build() -> [String: Any] {
        var result = [String: Any]()
        
        if let eventId = createQueryValue(param: query.event_id) {
            result[ConnpassAPIQueryKey.event_id.rawValue] = eventId
        }

        if let keyword = createQueryValue(param: query.keyword) {
            result[ConnpassAPIQueryKey.keyword.rawValue] = keyword
        }

        if let keywordOr = createQueryValue(param: query.keyword_or) {
            result[ConnpassAPIQueryKey.keyword_or.rawValue] = keywordOr
        }

        if let ym = createQueryValue(param: query.ym) {
            result[ConnpassAPIQueryKey.ym.rawValue] = ym
        }

        if let ymd = createQueryValue(param: query.ymd) {
            result[ConnpassAPIQueryKey.ymd.rawValue] = ymd
        }

        if let nickname = createQueryValue(param: query.nickname) {
            result[ConnpassAPIQueryKey.nickname.rawValue] = nickname
        }

        if let ownerNickname = createQueryValue(param: query.owner_nickname) {
            result[ConnpassAPIQueryKey.owner_nickname.rawValue] = ownerNickname
        }

        if let seriesId = createQueryValue(param: query.series_id) {
            result[ConnpassAPIQueryKey.series_id.rawValue] = seriesId
        }

        if let start = query.start {
            result[ConnpassAPIQueryKey.start.rawValue] = start
        }

        if let order = query.order {
            result[ConnpassAPIQueryKey.order.rawValue] = order
        }

        if let count = query.count {
            result[ConnpassAPIQueryKey.count.rawValue] = count
        }

        return result
    }
    
    private func createQueryValue(param: [Any]?) -> Any? {
        guard let param = param else {
            return nil
        }

        switch param.count {
        case 0:
            return nil
        case 1:
            return param[0]
        default:
            return param
        }
    }
}
