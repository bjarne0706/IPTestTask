//
//  RepoOwnerModel.swift
//  InteractivePioneersTestTask
//
//  Created by dchantse on 25.11.2025.
//


struct RepoOwner: Decodable, Equatable {
	let login: String
	let avatarURL: String
	
	enum CodingKeys: String, CodingKey {
		case login
		case avatarURL = "avatar_url"
	}
}
