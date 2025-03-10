//
//  EmployeeAvatarView.swift
//  Infratrack
//
//  Created by Christinne on 11/02/2025.
//

import SwiftUI

struct EmployeeAvatarView: View {
	let avatarName: String
	
	var body: some View {
		Image(avatarName)
			.resizable()
			.scaledToFill()
			.frame(width: 120, height: 120)
			.clipShape(Circle())
			.shadow(radius: 0.8)
	}
}
