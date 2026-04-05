//
//  GitHubRepo.swift
//  GitHubUserApp
//
//  Created by Siddharth Pandey on 03/04/26.
//

import Foundation

struct GitHubRepo: Codable, Identifiable {
    let id: Int
    let name: String
    let html_url: String
}

