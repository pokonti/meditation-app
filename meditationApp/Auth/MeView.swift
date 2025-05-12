//
//  MeView.swift
//  meditationApp
//
//  Created by Firuza on 05.05.2025.
//

import SwiftUI

struct MeView: View {
    @ObservedObject var authVM: AuthViewModel
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing: 15) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                
                Text(authVM.userName)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Spacer()
            }
            .padding()
            
            menuItem(icon: "person", title: "Profile")
            menuItem(icon: "bell", title: "Notifications")
            menuItem(icon: "info.circle", title: "About")
            
            Divider()
                .padding(.vertical, 10)
        
            Button(action: {
                authVM.logout()
                router.showLogin()
            }) {
                HStack {
                    Image(systemName: "arrow.left.circle")
                        .font(.system(size: 22))
                    Text("Log out")
                        .font(.system(size: 18))
                    Spacer()
                }
                .foregroundColor(.primary)
                .padding(.horizontal)
                .padding(.vertical, 12)
            }
            
            Spacer()
        }
    }
    
    private func menuItem(icon: String, title: String) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 22))
                .frame(width: 30)
            Text(title)
                .font(.system(size: 18))
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}
