//
//  ContentView.swift
//  NEW Spotify ASL
//
//  Created by Prasa Pirabagaran on 2025-12-30.
//

import SwiftUI

struct ContentView: View {
    @State private var showLogin = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient (approximate to screenshot)
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.02, green: 0.05, blue: 0.04), // near-black with a hint of green
                        Color(red: 0.02, green: 0.10, blue: 0.06)  // deep green
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    Spacer(minLength: 0)

                    // Main content
                    VStack(spacing: 16) {
                        Text("Experience Music Through\nSound, Sign & Vibration")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(.system(size: 34, weight: .bold, design: .default))
                            .lineSpacing(4)

                        Text("A new way for Deaf and Hard-of-Hearing users to feel music.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.white.opacity(0.7))
                            .font(.system(size: 16, weight: .regular))
                            .lineSpacing(2)
                            .padding(.top, 4)
                    }
                    .padding(.horizontal, 28)

                    Spacer()

                    // Bottom button pinned above home indicator
                    ContinueButton(title: "Continue") {
                        showLogin = true
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                }
            }
            .navigationDestination(isPresented: $showLogin) {
                SpotifyLoginScreen()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

private struct ContinueButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black) // Dark text on the bright green button
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(buttonGreen) // #1DB954
                        .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
                )
        }
        .accessibilityLabel(Text(title))
        .accessibilityAddTraits(.isButton)
    }

    // Spotify green: #1DB954
    private var buttonGreen: Color {
        Color(red: 0.1176, green: 0.7255, blue: 0.3294)
    }
}

#Preview {
    ContentView()
}
