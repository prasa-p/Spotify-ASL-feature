import SwiftUI

struct PlaylistDetailView: View {
    @Environment(\.presentationMode) var presentationMode

    // State for Floating Player
    @State private var currentSongTitle: String = "For A Reason"
    @State private var currentSongArtist: String = "Karan Aujla, Ikky"
    @State private var currentSongImage: String = "for-a-reason"

    var body: some View {
        ZStack(alignment: .bottom) {
            
            // BACKGROUND & SCROLLABLE CONTENT
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.6, green: 0.3, blue: 0.0), // Deep Orange/Brown
                        Color.black,
                        Color.black
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        // Header (Back Button)
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)

                        // Main Album Art Centered (added)
                        HStack {
                            Spacer()
                            Image("deafinately-vibing") // Ensure asset name matches exactly
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, height: 250)
                                .shadow(color: .black.opacity(0.6), radius: 25, x: 0, y: 12)
                            Spacer()
                        }
                        .padding(.vertical, 20)

                        // Title & Metadata
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Deafinitely Vibin'")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("All vibes. No sound required.")
                                .font(.system(size: 14))
                                .foregroundColor(Color(white: 0.7))
                            
                            HStack(spacing: 6) {
                                // Use asset-based spotify-logo to match other screens
                                if UIImage(named: "spotify-logo") != nil {
                                    Image("spotify-logo")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(Color(red: 0.11, green: 0.84, blue: 0.38))
                                        .frame(width: 16, height: 16)
                                } else {
                                    // Fallback to SF Symbol if asset missing
                                    Image(systemName: "spotify.logo")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color(red: 0.11, green: 0.84, blue: 0.38))
                                }
                                
                                Text("Made for pra5a")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .padding(.top, 4)
                            
                            Text("2h 44m")
                                .font(.system(size: 12))
                                .foregroundColor(Color(white: 0.7))
                                .padding(.top, 2)
                        }
                        .padding(.horizontal)

                        // Buttons Row
                        HStack(alignment: .center) { // Ensures vertical centers align
                            // Left Side Actions (UPDATED)
                            HStack(spacing: 22) {
                                // Mini art preview (UPDATED: New Asset & Rectangle shape)
                                Image("JENNIE-Doechii-ExtraL")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 25, height: 25)
                                    .cornerRadius(4) // Square with rounded corners
                                
                                Image(systemName: "plus.circle")
                                Image(systemName: "arrow.down.circle")
                                Image(systemName: "ellipsis")
                            }
                            .font(.system(size: 24)) // Uniform size for alignment
                            .foregroundColor(Color(white: 0.7))
                            
                            Spacer()
                            
                            // Right Side Actions
                            HStack(spacing: 24) {
                                Button(action: {}) {
                                    Image(systemName: "shuffle")
                                        .font(.system(size: 24))
                                        .foregroundColor(Color(red: 0.11, green: 0.84, blue: 0.38))
                                        .overlay(
                                            Circle()
                                                .fill(Color(red: 0.11, green: 0.84, blue: 0.38))
                                                .frame(width: 4, height: 4)
                                                .offset(y: 14)
                                        )
                                }

                                Button(action: {}) {
                                    ZStack {
                                        Circle()
                                            .fill(Color(red: 0.11, green: 0.84, blue: 0.38))
                                            .frame(width: 56, height: 56)
                                        
                                        Image(systemName: "play.fill")
                                            .font(.system(size: 26))
                                            .foregroundColor(.black)
                                            .offset(x: 2)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 4)
                        .padding(.bottom, 16)

                        // Song List (Interactive)
                        LazyVStack(spacing: 0) {
                            
                            // Song 1
                            SongListRow(title: "ExtraL (feat. Doechii)", artist: "JENNIE, Doechii", image: "jennie-ruby", isExplicit: true)
                                .onTapGesture {
                                    updatePlayer(title: "ExtraL (feat. Doechii)", artist: "JENNIE, Doechii", image: "jennie-ruby")
                                }

                            // Song 2
                            SongListRow(title: "supernatural", artist: "Ariana Grande", image: "eternal-sunshine", isExplicit: false)
                                .onTapGesture {
                                    updatePlayer(title: "supernatural", artist: "Ariana Grande", image: "eternal-sunshine")
                                }

                            // Song 3
                            SongListRow(title: "CHANEL", artist: "Tyla", image: "chanel-tyla", isExplicit: true)
                                .onTapGesture {
                                    updatePlayer(title: "CHANEL", artist: "Tyla", image: "chanel-tyla")
                                }

                            // Song 4
                            SongListRow(title: "Tonight I Might", artist: "KATSEYE", image: "sis-katseye", isExplicit: true)
                                .onTapGesture {
                                    updatePlayer(title: "Tonight I Might", artist: "KATSEYE", image: "sis-katseye")
                                }
                            
                            // Song 5: NOT LIKE US (tap updates the Floating Player)
                            SongListRow(title: "Not Like Us", artist: "Kendrick Lamar", image: "not-like-us-cover", isExplicit: true)
                                .onTapGesture {
                                    updatePlayer(title: "Not Like Us", artist: "Kendrick Lamar", image: "not-like-us-cover")
                                }
                            
                            Spacer().frame(height: 140) 
                        }
                    }
                }
            }
            
            // BOTTOM FLOATING BARS
            VStack(spacing: 0) {
                
                // Floating Player (Now using State variables)
                HStack {
                    Image(currentSongImage) 
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 38, height: 38)
                        .cornerRadius(4)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(currentSongTitle)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                        Text(currentSongArtist)
                            .font(.system(size: 12))
                            .foregroundColor(Color(white: 0.7))
                    }
                    .padding(.leading, 8)
                    
                    Spacer()
                    
                    Image(systemName: "hifispeaker.2")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.trailing, 16)
                    
                    Image(systemName: "play.fill")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                .padding(8)
                .background(Color(red: 0.2, green: 0.2, blue: 0.2))
                .cornerRadius(6)
                .padding(.horizontal, 8)
                .padding(.bottom, 6)
                
                // Custom Tab Bar overlay (visual only; Home selected)
                CustomTabBar(selected: .home)
                    .background(Color.black.opacity(0.95))
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // Helper to update the Floating Player
    func updatePlayer(title: String, artist: String, image: String) {
        self.currentSongTitle = title
        self.currentSongArtist = artist
        self.currentSongImage = image
    }
}

// --- Sub-Components ---

struct SongListRow: View {
    var title: String
    var artist: String
    var image: String
    var isExplicit: Bool
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 48, height: 48)
                .cornerRadius(4)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    if isExplicit {
                        Image(systemName: "e.square.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    Text(artist)
                        .font(.system(size: 14))
                        .foregroundColor(Color(white: 0.7))
                }
            }
            .padding(.leading, 8)
            
            Spacer()
            
            Image(systemName: "ellipsis")
                .foregroundColor(Color(white: 0.7))
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .contentShape(Rectangle()) // Entire row tappable
    }
}

// MARK: - Custom Tab Bar for Playlist Screen

enum TabSelection {
    case home, search, library, premium, create
}

struct CustomTabBar: View {
    var selected: TabSelection

    var body: some View {
        HStack(spacing: 0) {
            CustomTabBarItem(icon: "house.fill", title: "Home", isSelected: selected == .home)
            CustomTabBarItem(icon: "magnifyingglass", title: "Search", isSelected: selected == .search)
            CustomTabBarItem(icon: "books.vertical.fill", title: "Your Library", isSelected: selected == .library)
            CustomTabBarItem(icon: "star.fill", title: "Premium", isSelected: selected == .premium)
            CustomTabBarItem(icon: "plus", title: "Create", isSelected: selected == .create)
        }
        .padding(.horizontal, 8)
        .padding(.top, 8)
        .padding(.bottom, 30) // space above home indicator
        .background(Color.black.opacity(0.95))
    }
}

struct CustomTabBarItem: View {
    let icon: String
    let title: String
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                if isSelected {
                    // Rounded “pill” behind the icon to match screenshot
                    Capsule()
                        .fill(Color(white: 0.2))
                        .frame(width: 52, height: 40)
                }
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
            }
            Text(title)
                .font(.caption2)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}

struct PlaylistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistDetailView()
    }
}
