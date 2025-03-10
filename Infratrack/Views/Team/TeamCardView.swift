//
//  TeamCardView.swift
//  Infratrack
//
//  Created by Christinne on 11/02/2025.
//

import SwiftUI

struct TeamCardView: View {
	let employee: Employee
	
	var body: some View {
		VStack {
			HStack(spacing: 12) {
				EmployeeInfoView(employee: employee)
			}
			.padding()
			.frame(maxWidth: .infinity, alignment: .leading)
			.background(
				RoundedRectangle(cornerRadius: 10)
					.foregroundColor(.gray.opacity(0.10))
			)
		}
		.frame(maxWidth: .infinity, alignment: .leading)
	}
}

