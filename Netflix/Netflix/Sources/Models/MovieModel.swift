//
//  MovieModel.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/12.
//

import Foundation

final class MovieModel {
    private let service = MovieService()
    private var data: [Movie] = []
    
    func getData() {
        service.getData1()
        service.getData2()
        service.getData3()
    }
}
