//
//  View.swift
//  Infratrack
//
//  Created by Christinne on 10/03/2025.
//

import SwiftUI

enum Tabs: Equatable, Hashable {
	case dashboard
	case team
	case documentation
	case maintain
	case tracking
	case settings
	case search
}

struct MainView: View {
	
	@State private var selectedTab: Tabs = .maintain

	var body: some View {
		TabView(selection: $selectedTab) {
			
			Tab("Dashboard", systemImage: "house", value: .dashboard) {
				DashboardView()
			}
			
			Tab("Docs", systemImage: "doc.text", value: .documentation) {
				DocumentView()
			}
			
			Tab("Manutenção", systemImage: "wrench", value: .maintain) {
				MaintainView()
			}
			
			Tab("Rastreamento", systemImage: "mappin.and.ellipse", value: .tracking) {
				TrackingView()
			}
			
			Tab("Equipe", systemImage: "person.crop.square.on.square.angled", value: .team) {
				TeamView()
			}
			
			/*
			Tab("Configurações", systemImage: "gear", value: .settings) {
				//SettingsView()
			}
			*/
			
			Tab(value: .search, role: .search) {
					// ...
			}
		}
		.tabViewStyle(.sidebarAdaptable)
	}
}
