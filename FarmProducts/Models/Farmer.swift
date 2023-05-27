//
//  Farm.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: Int
    let email: String
    let password: String
    
    static func getTempData() -> User {
        User(
            id: 1,
            email: "rvoltigo@gmail.com",
            password: "12345"
        )
    }
}

// MARK: - Register
struct Register {
    let id: Int
    let email: String
    let password: String
    let password_confirmation: String
}

// MARK: - Product
struct ProductData: Decodable {
    let data: [Product]
}

struct Product: Codable {
    let id: Int
    var name: String
    var price: String
    var description: String
    let store_id: Int
    let category_id: Int
    let calc_type: String
    
    var priceDescription: String {
        "Цена: \(price)"
    }
    
    var details: String {
        """
        Название: \(name)
        \(priceDescription)
        Описание \(description)
        """
    }
}

struct ProductAdapter: Codable {
    let name: String
    let price: String
    let description: String
    let store_id: String
    let category_id: String
    let calc_type: String
    
    init(from data: Product) {
        name = data.name
        price = data.price
        description = data.description
        store_id = String(data.store_id)
        category_id = String(data.category_id)
        calc_type = data.calc_type
    }
}

// MARK: - Order
struct Order: Decodable {
    let data: [OrderData]
}

struct OrderData: Decodable {
    let product: Product
    let store: Store
    let status: String
    let delivered_at: String
}

struct Store: Decodable {
    let id: Int
    let description: String
    let farmer_id: Int
    let created_at: String
    let updated_at: String
    let rate: Double
}

// MARK: - Category
struct CategoryData: Decodable {
    let data: [Category]
}

struct Category: Decodable {
    let id: Int
    var name: String
    var description: String
    let created_at: String
    let updated_at: String
}
