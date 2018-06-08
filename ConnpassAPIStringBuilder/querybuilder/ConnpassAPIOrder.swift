//
//  ConnpassAPIOrder.swift
//  ConnpassAPIStringBuilder
//
//  Created by 長谷川瞬哉 on 2018/06/08.
//  Copyright © 2018年 hmhm. All rights reserved.
//

import Foundation

public enum ConnpassAPIOrder: Int {
    case update = 1 // 更新日時順
    case date = 2 // 開催日時順
    case new = 3 // 新着順
}
