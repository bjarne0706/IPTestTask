//
//  RepoTileView.swift
//  InteractivePioneersTestTask
//
//  Created by dchantse on 25.11.2025.
//

import SwiftUI

struct RepoTileView: View {
	let repo: GitHubRepo
	@State private var image: Image?
	var body: some View {
		VStack(alignment: .leading) {
			
			Text(repo.name)
				.font(.headline)
			Text(repo.description ?? "No description")
				.font(.subheadline)
				.foregroundColor(.secondary)
			Spacer()
			HStack {
				Image(systemName: "star.fill")
					.imageScale(.small)
				Text("\(repo.stars)")

				Image(systemName: "tuningfork")
					.imageScale(.small)
				Text("\(repo.forks)")
				Spacer()
			}
			
			HStack {
				AsyncImage(url: URL(string: repo.owner.avatarURL)) { image in
					image.resizable()
				} placeholder: {
					ProgressView()
				}
				.frame(width: 20, height: 20)
				.clipShape(Circle())
				
				Text(repo.owner.login)
					.font(.caption)
					.foregroundColor(.secondary)
			}
			
		}
		.padding(8)
		.frame(height: 150)
		.background(Color(.lightGray).opacity(0.2))
		.clipShape(RoundedRectangle(cornerRadius: 16))
	}
}

#Preview {
	AllReposView()
}
