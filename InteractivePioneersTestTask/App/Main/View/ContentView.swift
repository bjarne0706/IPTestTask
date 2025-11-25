//
//  ContentView.swift
//  InteractivePioneersTestTask
//
//  Created by dchantse on 25.11.2025.
//

import SwiftUI

struct AllReposView: View {
	
	private let username: String = "cs50" // Use "cs50" for 129 repos
	
	@StateObject var viewModel = AllReposViewModel(AllReposModel())
	
    var body: some View {
        NavigationView {
			Group {
				if viewModel.isLoading {
					Text("Loading...")
						.opacity(viewModel.repos.isEmpty ? 1 : 0)
				} else if viewModel.repos.isEmpty {
					Text("No repos")
				} else {
					ScrollView {
						LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
							ForEach(viewModel.repos) { repo in
								RepoTileView(repo: repo)
									.onAppear {
										if repo.id == viewModel.repos.last?.id {
											viewModel.loadNextPage(for: username)
										}
									}
							}
						}
						if viewModel.isLoadingNextPage {
							ProgressView()
								.frame(maxWidth: .infinity)
								.padding()
						}
					}
					.padding(.horizontal, 4)
					
				}
				
			}
			.navigationBarTitle("Repositories", displayMode: .inline)
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button() {
						viewModel.load(for: username)
					} label: {
						Image(systemName: "arrow.2.circlepath.circle")
					}
				}
			}
			.task {
				viewModel.load(for: username)
			}
		}
    }
}

#Preview {
	AllReposView()
}
