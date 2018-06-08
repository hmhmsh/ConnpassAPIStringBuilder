//
//  ConnpassAPIQueryBuilder.swift
//  ConnpassAPIStringBuilder
//
//  Created by hmhmsh on 2018/06/08.
//  Copyright © 2018年 hmhm. All rights reserved.
//

import Foundation

public class ConnpassAPIQueryBuilder {
    static let requestUrl = "https://connpass.com/api/v1/event/"
    private var query = ConnpassAPIQuery()
    
    /// イベント毎に割り当てられた番号で検索します。
    public func eventId(_ eventId: Int...) -> ConnpassAPIQueryBuilder {
        query.event_id = eventId.map { String($0) }
        return self
    }
    
    /// イベントのタイトル、キャッチ、概要、住所をAND条件部分一致で検索します。
    public func keywordAnd(_ keyword: String...) -> ConnpassAPIQueryBuilder {
        query.keyword = keyword
        return self
    }
    
    /// イベントのタイトル、キャッチ、概要、住所をOR条件部分一致で検索します。
    public func keywordOr(_ keyword: String...) -> ConnpassAPIQueryBuilder {
        query.keyword_or = keyword
        return self
    }
        
    /// 指定した年月に開催されているイベントを検索します。
    public func date(_ ym: ConnpassAPIDateYM...) -> ConnpassAPIQueryBuilder {
        query.ym = ym.map {
            let year = String(format: "%02d", $0.year)
            let month = String(format: "%02d", $0.month)
            return year + month
        }
        return self
    }
        
    /// 指定した年月日に開催されているイベントを検索します。
    public func date(_ ymd: ConnpassAPIDateYMD...) -> ConnpassAPIQueryBuilder {
        query.ymd = ymd.map {
            let year = String(format: "%02d", $0.year)
            let month = String(format: "%02d", $0.month)
            let day = String(format: "%02d", $0.day)
            return year + month + day
        }
        return self
    }
    
    /// 指定したニックネームのユーザが参加しているイベントを検索します。
    public func user(_ nickname: String...) -> ConnpassAPIQueryBuilder {
        query.nickname = nickname
        return self
    }
    
    /// 指定したニックネームのユーザが管理しているイベントを検索します。
    public func owner(_ ownerNeckname: String...) -> ConnpassAPIQueryBuilder {
        query.owner_nickname = ownerNeckname
        return self
    }
    
    /// グループ毎に割り当てられた番号で、ひもづいたイベントを検索します。
    public func seriesId(_ seriesId: Int...) -> ConnpassAPIQueryBuilder {
        query.series_id = seriesId.map { String($0) }
        return self
    }
    
    /// 検索結果の何件目から出力するかを指定します。default: 1
    public func start(_ start: Int) -> ConnpassAPIQueryBuilder {
        query.start = String(start)
        return self
    }
        
    /// 検索結果の表示順を、更新日時順、開催日時順、新着順で指定します。default: 更新日時順
    public func order(_ order: ConnpassAPIOrder) -> ConnpassAPIQueryBuilder {
        query.order = String(order.rawValue)
        return self
    }
    
    /// 検索結果の最大出力データ数を指定します。default: 10。min: 1。max: 100
    public func count(_ count: Int) -> ConnpassAPIQueryBuilder {
        let lowerLimit = 1
        let upperLimit = 100
        let value = min(max(count, lowerLimit), upperLimit)
        query.count = String(value)
        return self
    }
    
    public func build() -> String {
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
    
    private func createQueryString(param: [String]?, key: ConnpassAPIQueryKey) -> String? {
        guard let param = param else {
            return nil
        }
        
        return param.reduce("", { self.join(oridinal: $0, key: key, value: $1) })
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
