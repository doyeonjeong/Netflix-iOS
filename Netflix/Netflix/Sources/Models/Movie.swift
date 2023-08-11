//
//  Movie.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/12.
//

import Foundation

struct Movie: Hashable {
    let title: String
    let imageName: String
}

extension Movie {
    static let list = [
        Movie(title: "영화제목1", imageName: "photo"),
        Movie(title: "영화제목2", imageName: "photo"),
        Movie(title: "영화제목3", imageName: "photo"),
        Movie(title: "영화제목4", imageName: "photo"),
        Movie(title: "영화제목5", imageName: "photo"),
        Movie(title: "영화제목6", imageName: "photo"),
        Movie(title: "영화제목7", imageName: "photo"),
        Movie(title: "영화제목8", imageName: "photo"),
        Movie(title: "영화제목9", imageName: "photo"),
        Movie(title: "영화제목10", imageName: "photo"),
        Movie(title: "영화제목11", imageName: "photo")
    ]
}
