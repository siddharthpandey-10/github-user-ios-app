//
//  ContentView.swift
//  GitHubUserApp
//
//  Created by Siddharth Pandey on 03/04/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = GitHubViewModel()
    var body : some View{
        NavigationStack {
            
            ZStack{
                LinearGradient(
                    colors: [
                        Color.blue,
                        Color.purple,
                        Color.black.opacity(0.8)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                
                VStack(spacing: 25) {

                    // 🔍 Search bar (clean)
                    TextField("Search username", text: $vm.username)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                    // 🔘 Button
                    Button("Get Profile") {
                        vm.fetchUser()
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // ⏳ Loading
                    if vm.isLoading {
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(1.5)
                    }

                    // 👤 User Data (MAIN DESIGN)
                    if let user = vm.user {
                        VStack(spacing: 15) {

                            AsyncImage(url: URL(string: user.avatar_url)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .scaleEffect(vm.user == nil ? 0.8 : 1.0)
                                    .animation(.spring(), value: vm.user != nil)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .shadow(radius: 10)

                            Text(user.name)
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)

                            Text("Followers")
                                .foregroundColor(.white.opacity(0.7))

                            Text("\(user.followers)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .padding()

                        // ✨ NEW
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .padding()

                        // 🎬 Animation
                        .transition(.move(edge: .bottom))
                    }
                    // ❌ Error
                    if let error = vm.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    }

                    Spacer()
                    NavigationLink("View Repositories") {
                        ReposView(vm: vm) 
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                }
            }
            
        }
        
    }
    
}

#Preview {
    ContentView()
}
