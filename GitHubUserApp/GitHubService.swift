//
//  GitHubService.swift
//  GitHubUserApp
//
//  Created by Siddharth Pandey on 03/04/26.
//
import Foundation

class GitHubService{
    func fetchUser(username: String) async throws -> GitHubUser {
        
        let urlString = "https://api.github.com/users/" + username
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("Status Code:", httpResponse.statusCode) // 👈 DEBUG

        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(GitHubUser.self, from: data)
    }
    
    func fetchRepos(username: String) async throws -> [GitHubRepo] {
        let urlString = "https://api.github.com/users/" + username + "/repos"

        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let repos = try JSONDecoder().decode([GitHubRepo].self, from: data)
        return repos
    }
}


