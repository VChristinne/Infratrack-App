//
//  EquipmentTypeCard.swift
//  Infratrack
//
//  Created by Christinne on 10/03/2025.
//

import SwiftUI

struct EquipmentCardView: View {
	let type: String
	
	var body: some View {
		VStack {
			Text(type)
				.font(.headline)
				.padding()
		}
		.tint(.black)
		.frame(maxWidth: .infinity, alignment: .center)
		.background(
			RoundedRectangle(cornerRadius: 10)
				.foregroundColor(.gray.opacity(0.10))
		)
	}
}
