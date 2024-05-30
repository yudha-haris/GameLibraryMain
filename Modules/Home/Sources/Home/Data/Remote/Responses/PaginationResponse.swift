//
//  File.swift
//  
//
//  Created by Yudha Haris Purnama on 27/05/24.
//

import Foundation

struct PaginationResponse<T : Codable>: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [T]
}
