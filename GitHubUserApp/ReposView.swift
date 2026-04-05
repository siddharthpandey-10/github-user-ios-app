//
//  ReposView.swift
//  GitHubUserApp
//
//  Created by Siddharth Pandey on 03/04/26.
//



import SwiftUI

struct ReposView: View {

    @ObservedObject var vm: GitHubViewModel

    var body: some View {
        List(vm.repos) { repo in
            VStack(alignment: .leading) {
                Text(repo.name)
                    .font(.headline)

                Text(repo.html_url)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Repositories")
        .onAppear {
            vm.loadRepos()
        }
    }
}
#Preview {
    NavigationStack {
        ReposView(vm: GitHubViewModel())
    }
}

