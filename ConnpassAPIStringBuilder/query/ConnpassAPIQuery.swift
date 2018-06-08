//
//  ConnpassAPIQuery.swift
//  ConnpassAPIStringBuilder
//
//  Created by hmhmsh on 2018/06/08.
//  Copyright © 2018年 hmhm. All rights reserved.
//

import Foundation

struct ConnpassAPIQuery {
    /// item name: イベントID
    ///
    /// type: 整数
    ///
    /// description: イベント毎に割り当てられた番号で検索します。複数指定可能です
    var event_id: [String]?
    
    /// item name: キーワード (AND)
    ///
    /// type: 文字列(UTF-8)
    ///
    /// description: イベントのタイトル、キャッチ、概要、住所をAND条件部分一致で検索します。複数指定可能です
    var keyword: [String]?
    
    /// item name: キーワード (OR)
    ///
    /// type: 文字列(UTF-8)
    ///
    /// description: イベントのタイトル、キャッチ、概要、住所をOR条件部分一致で検索します。複数指定可能です
    var keyword_or: [String]?
    
    /// item name: イベント開催年月
    ///
    /// type: 整数(yyyymm)
    ///
    /// description: 指定した年月に開催されているイベントを検索します。複数指定可能です
    var ym: [String]?
    
    /// item name: イベント開催年月日
    ///
    /// type: 整数(yyyymmdd)
    ///
    /// description: 指定した年月日に開催されているイベントを検索します。複数指定可能です
    var ymd: [String]?
    
    /// item name: 参加者のニックネーム
    ///
    /// type: 文字列(UTF-8)
    ///
    /// description: 指定したニックネームのユーザが参加しているイベントを検索します。複数指定可能です
    var nickname: [String]?
    
    /// item name: 管理者のニックネーム
    ///
    /// type: 文字列(UTF-8)
    ///
    /// description: 指定したニックネームのユーザが管理しているイベントを検索します。複数指定可能です
    var owner_nickname: [String]?
    
    /// item name: グループID
    ///
    /// type: 整数
    ///
    /// description: グループ 毎に割り当てられた番号で、ひもづいたイベントを検索します。複数指定可能です
    var series_id: [String]?
    
    /// item name: 検索の開始位置
    ///
    /// type: 整数
    ///
    /// description: 検索結果の何件目から出力するかを指定します。
    ///
    /// default: 1
    var start: String?
    
    /// item name: 検索結果の表示順
    ///
    /// type: 整数
    ///
    /// description: 検索結果の表示順を、更新日時順、開催日時順、新着順で指定します。
    ///
    /// value: 1: 更新日時順 2: 開催日時順 3: 新着順
    ///
    /// default: 1
    var order: String?
    
    /// item name: 取得件数
    ///
    /// type: 整数
    ///
    /// description: 検索結果の最大出力データ数を指定します。
    ///
    /// default: 10
    ///
    /// min: 1
    ///
    /// max: 100
    var count: String?
    
    /// item name: レスポンス形式
    ///
    /// type: 文字列(UTF-8)
    ///
    /// description: レスポンスの形式を指定します。jsonに固定です。
    // format
}
