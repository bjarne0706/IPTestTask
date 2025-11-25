//
//  NetworkingService.swift
//  InteractivePioneersTestTask
//
//  Created by dchantse on 25.11.2025.
//

import Foundation

final class NetworkingService {
	
	func fetchRepos(for username: String, forPage: Int = 1) async throws -> [GitHubRepo] {
		
		guard var components = URLComponents(string: "https://api.github.com/users/\(username)/repos") else {
			throw NetworkingErrors.invalidURL
		}
		
		components.queryItems = [
			URLQueryItem(name: "page", value: "\(forPage)")
		]
		
		guard let url = components.url else {
			throw NetworkingErrors.invalidURL
		}
		
		let (data, _) = try await URLSession.shared.data(from: url)
		
		guard !data.isEmpty else {
			throw NetworkingErrors.invalidData
		}
		
		do {
			return try JSONDecoder().decode([GitHubRepo].self, from: data)
		} catch {
			throw NetworkingErrors.decodingError
		}
	}
	
}
