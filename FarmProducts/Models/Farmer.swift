//
//  Farm.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import Foundation

// MARK: - User
struct User {
    let id: Int
    let email: String
    let password: String
    let token : String
    
    let categories: [Category]
    let products: [Product]
    
    static func getTempData() -> User {
        User(
            id: 0,
            email: "rvoltigo@gmail.com",
            password: "12345",
            token: "TOKEN",
            categories: Category.getCategories(),
            products: Product.getProducts()
        )
    }
}

// MARK: - Category
struct Category: Decodable {
    let id: Int
    let name: String
    let description: String
    let imgURL: String
    
    static func getCategories() -> [Category] {
        [
            Category(
                id: 0,
                name: "Рыба",
                description: "Прям с берегов Прибалтики",
                imgURL: "fish"
            ),
            
            Category(
                id: 1,
                name: "Ягоды",
                description: "Выращены с заботой",
                imgURL: "strawberry"
            ),
            
            Category(
                id: 1,
                name: "Овощи",
                description: "Без ГМО",
                imgURL: "vegetables"
            )
        ]
    }
}

// MARK: - Product
struct Product {
    let id: Int
    let name: String
    let price: String
    let description: String
    let storeId: Int
    let categoryId: Int
    let calcType: String
//    let createdAt: Date
//    let updatedAt: Date
    
    var priceDescription: String {
        "Цена: \(price)"
    }
    
    var details: String {
        """
        Название продукта: \(name)
        Описание: \(description)
        Цена: \(price)
        Категория: \(categoryId)
        """
    }
    
    static func getProducts() -> [Product] {
        [
            Product(
                id: 1,
                name: "Name",
                price: "172.5",
                description: "Lorem ipsum text",
                storeId: 1,
                categoryId: 1,
                calcType: "type"
            ),
            
            Product(
                id: 2,
                name: "Name2",
                price: "222",
                description: "Lorem ipsum text",
                storeId: 1,
                categoryId: 1,
                calcType: "type"
            ),
            
            Product(
                id: 3,
                name: "Name3",
                price: "333",
                description: "Lorem ipsum text",
                storeId: 1,
                categoryId: 1,
                calcType: "type"
            ),
        ]
    }
    
}

// MARK: - Order
struct Order {
    let data: [OrderData]
    
    static func getOrder() -> Order {
        Order(data: [
            OrderData(
                store: Store(
                    id: 1,
                    rate: 1,
                    description: "Descr",
                    farmer_id: 1,
                    createdAt: "123",
                    updatedAt: "123"
                ),
                product: Product(
                    id: 2,
                    name: "Name",
                    price: "123",
                    description: "Descr",
                    storeId: 1,
                    categoryId: 1,
                    calcType: "Type"
                ),
                count: 2,
                weight: "Weight",
                type: "Type"
            )
        ])
    }
}

struct OrderData {
    let store: Store
    let product: Product
    let count: Int
    let weight: String
    let type: String
}

struct Store {
    let id: Int
    let rate: Int
    let description: String
    let farmer_id: Int
    let createdAt: String
    let updatedAt: String
}

// MARK: - Category
struct CategoryTwo {
    let data: [CategoryData]
}

struct CategoryData {
    let id: Int
    let name: String
    let description: String
    let createdAt: Date
    let updatedAt: Date
}
