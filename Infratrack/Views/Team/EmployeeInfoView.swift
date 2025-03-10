//
//  EmployeeInfoView.swift
//  Infratrack
//
//  Created by Christinne on 11/02/2025.
//

import SwiftUI

struct EmployeeInfoView: View {
	let employee: Employee
	
	var body: some View {
		HStack {
			EmployeeAvatarView(avatarName: employee.avatar)
			
			VStack(alignment: .leading, spacing: 5) {
				Text(employee.name)
					.font(.headline)
				
				Text(employee.role)
					.font(.subheadline)
			}
		}
	}
}
