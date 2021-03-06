//
//  datosApi.swift
//  iOSPostulacion
//
//  Created by Principal on 05/03/21.
//

import Foundation

// MARK: - Product
struct Product : Codable {
    var totalResults: Int?
    var page: Int?
    var items: [Item]
}

// MARK: - Item
struct Item : Codable {
    var id: String?
    var rating: Double?
    var price: Double?
    var image: String?
    var title: String?
}
