//
//  Resoults.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import Foundation
struct Results {
    static func makeArray() -> [Result1] {
        [
            .init(name: "duck", score: 3),
            .init(name: "buk", score: 4),
            .init(name: "luck", score: 9),
            .init(name: "kat", score: 5),
            .init(name: "batat", score: 8),
            .init(name: "org", score: 10),
            .init(name: "lider", score: 12),
            .init(name: "fluck", score: 15),
            .init(name: "finik", score: 44),
        ]
    }
}

struct Result1 {
    let name: String
    let score: Int
}
