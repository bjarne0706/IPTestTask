//
//  AllReposViewModel.swift
//  InteractivePioneersTestTask
//
//  Created by dchantse on 25.11.2025.
//

import Combine

@MainActor
final class AllReposViewModel: ObservableObject {
	
	@Published var repos: [GitHubRepo] = []
	@Published var isLoading: Bool = false
	@Published var isLoadingNextPage: Bool = false
	@Published var error: Error? = nil
	
	private var currentPage: Int = 1
	private var canLoadMore: Bool = true
	private let itemsPerPage: Int = 30
	
	private let allReposModel: AllReposModelProtocol
	
	init(_ allReposModel: AllReposModelProtocol) {
		
		self.allReposModel = allReposModel
		
	}
	
	func load(for username: String) {
		self.currentPage = 1
		self.canLoadMore = true
		isLoading = true
		Task {
			
			self.repos = await getRepos(for: username)
			currentPage += 1
			self.isLoading = false
		}
	}
	
	func loadNextPage(for username: String) {
		guard !isLoadingNextPage && canLoadMore else { return }
		isLoadingNextPage = true
		
		Task {
			let newRepos = await getRepos(for: username, forPage: currentPage)
			currentPage += 1
			canLoadMore = newRepos.count == itemsPerPage
			self.repos.append(contentsOf: newRepos)
			self.isLoadingNextPage = false
		}
	}
	
	private func getRepos(for username: String, forPage: Int = 1) async -> [GitHubRepo]{
		
		error = nil
		
		do {
			
			return try await allReposModel.getRepos(for: username, forPage: forPage)
			
		} catch {
			
			self.error = error
			print(error)
			return []
			
		}
	}
}
