//
//  GitHubRepoModel.swift
//  InteractivePioneersTestTask
//
//  Created by dchantse on 25.11.2025.
//

struct GitHubRepo: Decodable, Identifiable, Equatable {
	let id: Int
	let name: String
	let description: String?
	let stars: Int
	let forks: Int
	let owner: RepoOwner
	
	enum CodingKeys: String, CodingKey {
		case id, name, description, owner
		case stars = "stargazers_count"
		case forks = "forks_count"
	}
}

