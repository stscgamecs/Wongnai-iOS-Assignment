//
//  Model.swift
//  Wongnai-iOS-Assignment
//
//  Created by Z94me on 31/10/2562 BE.
//  Copyright © 2562 Z94me. All rights reserved.
//
import Foundation
// MARK: - Model
struct Model: Codable {
    let photos: [Photo]
    enum CodingKeys: String, CodingKey {
        case photos
    }
}
// MARK: - Photo
struct Photo: Codable {
    let description, name: String
    let votesCount: Int
    let images: [Image]
    enum CodingKeys: String, CodingKey {
        case description
        case name
        case votesCount = "votes_count"
        case images
    }
}
// MARK: - Image
struct Image: Codable {
    let url: String
}
