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
        query.event_id = eventId
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
            let year = $0.year * 100
            let month = $0.month
            return year + month
        }
        return self
    }
        
    /// 指定した年月日に開催されているイベントを検索します。
    public func date(_ ymd: ConnpassAPIDateYMD...) -> ConnpassAPIQueryBuilder {
        query.ymd = ymd.map {
            let year = $0.year * 10000
            let month = $0.month * 100
            let day = $0.day
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
        query.series_id = seriesId
        return self
    }
    
    /// 検索結果の何件目から出力するかを指定します。default: 1
    public func start(_ start: Int) -> ConnpassAPIQueryBuilder {
        query.start = start
        return self
    }
        
    /// 検索結果の表示順を、更新日時順、開催日時順、新着順で指定します。default: 更新日時順
    public func order(_ order: ConnpassAPIOrder) -> ConnpassAPIQueryBuilder {
        query.order = order.rawValue
        return self
    }
    
    /// 検索結果の最大出力データ数を指定します。default: 10。min: 1。max: 100
    public func count(_ count: Int) -> ConnpassAPIQueryBuilder {
        let lowerLimit = 1
        let upperLimit = 100
        query.count = min(max(count, lowerLimit), upperLimit)
        return self
    }
    
    public func string() -> String {
        return ConnpassAPIQueryStringBuilder(query: query).build()
    }
    
    public func dictionary() -> [String: Any] {
        return ConnpassAPIQueryDictionaryBuilder(query: query).build()
    }
}
