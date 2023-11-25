//
//  Book.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/24.
//

import Foundation

struct Book: Hashable {
    let uuid: UUID = .init()
    let title: String
    let image: String
    let descriotion: String
    // 詳細項目の色
    let isAttenstion: Bool
    let badge: Badge?
    
    enum Badge {
        case free
        case pass
    }
}
