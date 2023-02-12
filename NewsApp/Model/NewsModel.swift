//
//  CategoryModel.swift
//  NewsApp
//
//  Created by Halil Bakar on 9.02.2023.
//

import Foundation

struct NewsResponse: Codable {
    var articles: [Articles]?
}

struct Articles: Codable {
    let source: Source
    let title: String?
    let description: String?
    let urlToImage: String?
    let content: String?
    let url: String?
}

struct Source: Codable {
    let name: String?
}

