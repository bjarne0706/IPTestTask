//
//  AllReposModel.swift
//  InteractivePioneersTestTask
//
//  Created by dchantse on 25.11.2025.
//

protocol AllReposModelProtocol: AnyObject {
	func getRepos(for username: String, forPage: Int) async throws -> [GitHubRepo]
}

final class AllReposModel: AllReposModelProtocol {
	
	private let service: NetworkingService
	
	init(service: NetworkingService = NetworkingService()) {
		
		self.service = service
		
	}
	
	func getRepos(for username: String, forPage: Int = 1) async throws -> [GitHubRepo] {
		
		try await service.fetchRepos(for: username, forPage: forPage)
		
	}
}
