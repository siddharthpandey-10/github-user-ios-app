//
//  GitHubViewModel.swift
//  GitHubUserApp
//
//  Created by Siddharth Pandey on 03/04/26.
//


import Foundation
import Combine

class GitHubViewModel:ObservableObject{
        @Published var username: String = ""
        @Published var user: GitHubUser?
        @Published var repos: [GitHubRepo] = []
        @Published var isLoading: Bool = false
        @Published var errorMessage: String?
    
    private let service = GitHubService()
    
    func fetchUser(){
        Task{
            isLoading = true
            errorMessage = nil
            
            do {
                let result = try await service.fetchUser(username: username)
                user = result
            }catch {
                errorMessage = "Failed to fetch user"
            }
            
            isLoading = false
            
        }
    }
    
    func loadRepos() {
        Task {
            do {
                repos = try await service.fetchRepos(username: username)
            } catch {
                errorMessage = "Failed to fetch repos"
            }
        }
    }
}
