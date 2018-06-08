//
//  ConnpassAPIQueryBuilder.swift
//  ConnpassAPIStringBuilder
//
//  Created by hmhmsh on 2018/06/08.
//  Copyright © 2018年 hmhm. All rights reserved.
//

import Foundation

public struct ConnpassAPIQueryBuilder {
    static let requestUrl = "https://connpass.com/api/v1/event/"
    private var query = ConnpassAPIQuery()
    
    /// イベント毎に割り当てられた番号で検索します。
    public mutating func eventId(_ eventId: Int...) -> ConnpassAPIQueryBuilder {
        query.event_id = eventId.map { String($0) }
        return self
    }
    
    /// イベントのタイトル、キャッチ、概要、住所をAND条件部分一致で検索します。
    public mutating func keywordAnd(_ keyword: String...) -> ConnpassAPIQueryBuilder {
        query.keyword = keyword
        return self
    }
    
    /// イベントのタイトル、キャッチ、概要、住所をOR条件部分一致で検索します。
    public mutating func keywordOr(_ keyword: String...) -> ConnpassAPIQueryBuilder {
        query.keyword_or = keyword
        return self
    }
    
    public struct DateYM {
        let year: Int
        let month: Int
    }
    
    /// 指定した年月に開催されているイベントを検索します。
    public mutating func date(_ ym: DateYM...) -> ConnpassAPIQueryBuilder {
        query.ym = ym.map { "\($0.year)\($0.month)" }
        return self
    }
    
    public struct DateYMD {
        let year: Int
        let month: Int
        let day: Int
    }
    
    /// 指定した年月日に開催されているイベントを検索します。
    public mutating func date(_ ymd: DateYMD...) -> ConnpassAPIQueryBuilder {
        query.ymd = ymd.map { "\($0.year)\($0.month)\($0.day)" }
        return self
    }
    
    /// 指定したニックネームのユーザが参加しているイベントを検索します。
    public mutating func user(_ nickname: String...) -> ConnpassAPIQueryBuilder {
        query.nickname = nickname
        return self
    }
    
    /// 指定したニックネームのユーザが管理しているイベントを検索します。
    public mutating func owner(_ ownerNeckname: String...) -> ConnpassAPIQueryBuilder {
        query.owner_nickname = ownerNeckname
        return self
    }
    
    /// グループ毎に割り当てられた番号で、ひもづいたイベントを検索します。
    public mutating func seriesId(_ seriesId: Int...) -> ConnpassAPIQueryBuilder {
        query.series_id = seriesId.map { String($0) }
        return self
    }
    
    /// 検索結果の何件目から出力するかを指定します。default: 1
    public mutating func start(_ start: Int) -> ConnpassAPIQueryBuilder {
        query.start = String(start)
        return self
    }
    
    public enum Order: Int {
        case update = 1 // 更新日時順
        case date = 2 // 開催日時順
        case new = 3 // 新着順
    }
    
    /// 検索結果の表示順を、更新日時順、開催日時順、新着順で指定します。default: 更新日時順
    public mutating func order(_ order: Order) -> ConnpassAPIQueryBuilder {
        query.order = String(order.rawValue)
        return self
    }
    
    /// 検索結果の最大出力データ数を指定します。default: 10。min: 1。max: 100
    public mutating func count(count: Int) -> ConnpassAPIQueryBuilder {
        let lowerLimit = 1
        let upperLimit = 100
        let value = min(max(count, lowerLimit), upperLimit)
        query.count = String(value)
        return self
    }
    
    public func build() -> String {
        var result = ""
        
        if let eventId = createQueryString(param: query.event_id, key: .event_id) {
            result += eventId
        }

        if let keyword = createQueryString(param: query.keyword, key: .keyword) {
            result += "&"
            result += keyword
        }

        if let keywordOr = createQueryString(param: query.keyword_or, key: .keyword_or) {
            result += "&"
            result += keywordOr
        }

        if let ym = createQueryString(param: query.ym, key: .ym) {
            result += "&"
            result += ym
        }

        if let ymd = createQueryString(param: query.ymd, key: .ymd) {
            result += "&"
            result += ymd
        }

        if let nickname = createQueryString(param: query.nickname, key: .nickname) {
            result += "&"
            result += nickname
        }

        if let ownerNickname = createQueryString(param: query.owner_nickname, key: .owner_nickname) {
            result += "&"
            result += ownerNickname
        }

        if let seriesId = createQueryString(param: query.series_id, key: .series_id) {
            result += "&"
            result += seriesId
        }

        if let start = createQueryString(param: query.start, key: .start) {
            result += "&"
            result += start
        }

        if let order = createQueryString(param: query.order, key: .order) {
            result += "&"
            result += order
        }

        if let count = createQueryString(param: query.count, key: .count) {
            result += "&"
            result += count
        }

        if result == "" {
            return ConnpassAPIQueryBuilder.requestUrl
        } else {
            return ConnpassAPIQueryBuilder.requestUrl + "&" + result
        }
    }
    
    private func createQueryString(param: [String]?, key: ConnpassAPIQueryKey) -> String? {
        guard let param = param else {
            return nil
        }
        
        let result = param.reduce("", { self.join(oridinal: $0, key: key, value: $1) })
        if result == "" {
            return nil
        }
        return result
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
