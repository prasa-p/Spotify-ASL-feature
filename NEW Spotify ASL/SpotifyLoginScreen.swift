import SwiftUI

struct SpotifyLoginScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var showHome: Bool = false

    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.07, green: 0.14, blue: 0.10) // Dark Forest Green
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // --- Header ---
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)

                ScrollView {
                    VStack(spacing: 25) {

                        // Title
                        Text("Log in to Spotify")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 10)

                        // --- Social Login Buttons ---
                        VStack(spacing: 12) {
                            // Google
                            SocialLoginButton(
                                text: "Continue with Google",
                                iconName: "google-logo", // in Assets
                                isSystemIcon: false
                            )

                            // Facebook
                            SocialLoginButton(
                                text: "Continue with Facebook",
                                iconName: "facebook-logo", // in Assets
                                isSystemIcon: false
                            )

                            // Apple (SF Symbol)
                            SocialLoginButton(
                                text: "Continue with Apple",
                                iconName: "applelogo",
                                isSystemIcon: true
                            )

                            // Phone Number (no icon)
                            Button(action: {}) {
                                Text("Continue with phone number")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                                    )
                            }
                        }

                        // --- Divider ---
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 1)
                            .padding(.vertical, 10)

                        // --- Input Fields ---
                        VStack(alignment: .leading, spacing: 15) {

                            // Email Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Email or username")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)

                                TextField("", text: $email)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                                    .autocorrectionDisabled()
                                    .placeholder(when: email.isEmpty) {
                                        Text("Email or username").foregroundColor(.gray)
                                    }
                                    .padding()
                                    .background(Color(white: 0.2)) // Dark grey input background
                                    .cornerRadius(5)
                                    .foregroundColor(.white)
                            }

                            // Password Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)

                                SecureField("", text: $password)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Password").foregroundColor(.gray)
                                    }
                                    .padding()
                                    .background(Color(white: 0.2))
                                    .cornerRadius(5)
                                    .foregroundColor(.white)
                            }

                            // Remember Me & Forgot Password
                            HStack {
                                Toggle(isOn: $rememberMe) {
                                    Text("Remember me")
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                }
                                .toggleStyle(SwitchToggleStyle(tint: Color(red: 0.1176, green: 0.7255, blue: 0.3294))) // #1DB954
                                .fixedSize()

                                Spacer()
                            }
                            .padding(.top, 5)

                            HStack {
                                Spacer()
                                Button("Forgot Password?") {
                                    // Action
                                }
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top, 10)
                                Spacer()
                            }
                        }

                        // --- Main Login Button (centered title) ---
                        Button(action: {
                            // Navigate to Home
                            showHome = true
                        }) {
                            ZStack {
                                // Centered title
                                Text("Log in with Spotify")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .center)

                                // Optional leading icon (kept left with padding)
                                HStack {
                                    if UIImage(named: "spotify-logo") != nil {
                                        Image("spotify-logo")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(.black)
                                            .scaledToFit()
                                            .frame(width: 24, height: 24)
                                    }
                                    Spacer()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.1176, green: 0.7255, blue: 0.3294)) // Spotify Green #1DB954
                            .cornerRadius(30)
                        }
                        .padding(.top, 10)

                        // Footer
                        Text("Prototype only — no real login required.")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
        // Push to Home when showHome becomes true
        .navigationDestination(isPresented: $showHome) {
            SpotifyHomeView()
                .navigationBarBackButtonHidden(true)
        }
    }
}

// --- Helper Components ---

// 1. Reusable Social Button Component
struct SocialLoginButton: View {
    var text: String
    var iconName: String
    var isSystemIcon: Bool

    var body: some View {
        Button(action: {}) {
            HStack(spacing: 12) {
                if isSystemIcon {
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                } else {
                    Image(iconName) // Uses Assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }

                Text(text)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.gray.opacity(0.6), lineWidth: 1)
            )
        }
    }
}

// 2. Placeholder Extension (for custom Placeholder color)
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    NavigationStack { SpotifyLoginScreen() }
}
