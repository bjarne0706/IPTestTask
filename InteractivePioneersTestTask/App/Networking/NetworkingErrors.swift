//
//  NetworkingErrors.swift
//  InteractivePioneersTestTask
//
//  Created by dchantse on 25.11.2025.
//

import Foundation

enum NetworkingErrors: Error, LocalizedError {
	
	case invalidURL
	case noDataReceived
	case invalidData
	case decodingError
	case unknown
	
	var errorDescription: String? {
		switch self {
		case .invalidURL: return "The URL is invalid."
		case .noDataReceived: return "No data received from the server."
		case .invalidData: return "Invalid data received from the server."
		case .decodingError: return "Failed to decode the received data."
		case .unknown: return "An unknown error occurred."
		}
	}
	
}
