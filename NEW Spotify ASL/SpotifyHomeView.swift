import SwiftUI

struct SpotifyHomeView: View {
    // 2-Column Grid Configuration
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    // Tab Bar Appearance Setup
    init() {
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
    }

    var body: some View {
        NavigationStack {
            TabView {
                ZStack(alignment: .bottom) {
                    // Background
                    Color.black.ignoresSafeArea()
                    
                    // Main Scrollable Content
                    ScrollView {
                        VStack(spacing: 24) {
                            
                            // 1. Header (Profile & Filter Pills)
                            HomeHeaderView()
                            
                            // 2. Recent Grid
                            LazyVGrid(columns: columns, spacing: 8) {
                                // Row 1
                                RecentCard(title: "Liked Songs", imageName: "liked-songs")
                                RecentCard(title: "Tamil Mix", imageName: "tamil-mix")
                                
                                // Row 2
                                // Make Deafinitely Vibin' navigable
                                NavigationLink {
                                    PlaylistDetailView()
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    RecentCard(title: "Deafinitely Vibin'", imageName: "deafinately-vibing")
                                }
                                .buttonStyle(.plain) // preserve card look without link highlight
                                
                                RecentCard(title: "Your Top Songs 2025", imageName: "top-songs-2025")
                                
                                // Row 3
                                RecentCard(title: "chill/soft ariana grande songs", imageName: "chill-soft-ariana")
                                RecentCard(title: "eternal sunshine", imageName: "eternal-sunshine")
                                
                                // Row 4
                                RecentCard(title: "Afrobeats Mix", imageName: "afrobeats-mix")
                                RecentCard(title: "Daily Mix 1", imageName: "daily-mix1")
                            }
                            .padding(.horizontal, 12)
                            
                            // 3. Your Top Mixes Section
                            VStack(alignment: .leading) {
                                Text("Your top mixes")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        // Mix 1: 2010s
                                        MixCardView(
                                            imageName: "2010s-mix",
                                            description: "Rihanna, The Weeknd, Anirudh Ravichander..."
                                        )
                                        
                                        // Mix 2: Ariana Grande
                                        MixCardView(
                                            imageName: "ariana-grande-mix",
                                            description: "KATSEYE, Madison Beer and Tate McRae"
                                        )
                                        
                                        // Mix 3: Katseye
                                        MixCardView(
                                            imageName: "katseye-mix",
                                            description: "KATSEYE, Le Sserafim..."
                                        )
                                        
                                        // Daily Mix 1 at the end
                                        MixCardView(
                                            imageName: "daily-mix1",
                                            description: "Your personalized mix"
                                        )
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            
                            // 4. Soundtrack Wednesday Section
                            VStack(alignment: .leading) {
                                Text("Soundtrack your Wednesday evening")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                // Replaced placeholders with images
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        Image("daylight")
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fill)
                                            .frame(width: 150, height: 150)
                                            .clipped()
                                        
                                        Image("driving-mix")
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fill)
                                            .frame(width: 150, height: 150)
                                            .clipped()
                                        
                                        Image("workout-pop-mix")
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fill)
                                            .frame(width: 150, height: 150)
                                            .clipped()
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            
                            // Spacer to prevent content being hidden behind player
                            Spacer().frame(height: 120)
                        }
                        .padding(.top)
                    }
                    
                    // 5. Floating Player Overlay
                    VStack {
                        Spacer()
                        FloatingPlayerView()
                            .padding(.bottom, 4)
                    }
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                
                // Other Tabs
                Text("Search").tabItem { Label("Search", systemImage: "magnifyingglass") }
                Text("Library").tabItem { Label("Your Library", systemImage: "books.vertical.fill") }
                Text("Premium").tabItem { Label("Premium", systemImage: "star.fill") }
                Text("Create").tabItem { Label("Create", systemImage: "plus") }
            }
            .accentColor(.white)
        }
    }
}

// ---------------------------------------------------------
// COMPONENT: Header (Profile + Pills)
// ---------------------------------------------------------
struct HomeHeaderView: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                // Profile Icon
                ZStack {
                    Circle()
                        .fill(Color(red: 0.6, green: 0.4, blue: 0.3)) // Brownish
                        .frame(width: 35, height: 35)
                    Text("P")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                }
                
                // Filter Pills
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        PillButton(text: "All", isSelected: true)
                        PillButton(text: "Wrapped", isSelected: false)
                        PillButton(text: "Music", isSelected: false)
                        PillButton(text: "Podcasts", isSelected: false)
                        PillButton(text: "Audiobooks", isSelected: false)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct PillButton: View {
    var text: String
    var isSelected: Bool
    
    var body: some View {
        Text(text)
            .font(.subheadline)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Color(red: 0.11, green: 0.84, blue: 0.38) : Color(white: 0.2))
            .foregroundColor(isSelected ? .black : .white)
            .cornerRadius(20)
    }
}

// ---------------------------------------------------------
// COMPONENT: Recent Grid Card
// ---------------------------------------------------------
struct RecentCard: View {
    var title: String
    var imageName: String? = nil
    var fallbackColor: Color = .gray
    
    var body: some View {
        HStack {
            // Logic: If image asset exists, use it. Else use color.
            if let name = imageName {
                Image(name)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .clipped()
            } else {
                fallbackColor
                    .frame(width: 55, height: 55)
            }
            
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .lineLimit(2)
                .padding(.leading, 8)
                .padding(.trailing, 4)
            
            Spacer()
        }
        .background(Color(white: 0.15))
        .cornerRadius(4)
        .frame(height: 55)
    }
}

// ---------------------------------------------------------
// COMPONENT: Mix Card (Large Square)
// ---------------------------------------------------------
struct MixCardView: View {
    var imageName: String? = nil
    var fallbackColor: Color? = nil
    var titleOverlay: String? = nil
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            // Square Image Area
            ZStack(alignment: .bottomLeading) {
                if let name = imageName {
                    Image(name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                } else {
                    Rectangle()
                        .fill(fallbackColor ?? .gray)
                        .frame(width: 150, height: 150)
                    
                    if let title = titleOverlay {
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack {
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(width: 4, height: 20)
                                Text(title)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding(4)
                            .background(Color(red: 0.8, green: 1.0, blue: 0.6))
                        }
                    }
                }
            }
            
            // Description Text
            Text(description)
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .lineLimit(2)
                .frame(width: 150, alignment: .leading)
                .padding(.top, 4)
        }
    }
}

// ---------------------------------------------------------
// COMPONENT: Floating Player
// ---------------------------------------------------------
struct FloatingPlayerView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                // Album Art
                Image("jennie-ruby")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .cornerRadius(4)
                    .padding(.leading, 8)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("with the IE (way up)")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("JENNIE")
                        .font(.caption)
                        .foregroundColor(Color(white: 0.8))
                }
                .padding(.leading, 6)
                
                Spacer()
                
                // Device Icon
                Image(systemName: "hifispeaker.2")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.trailing, 16)
                
                // Play Button
                Image(systemName: "play.fill")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.trailing, 16)
            }
            .frame(height: 56)
            .background(Color(red: 0.35, green: 0.05, blue: 0.05)) // Deep Red
            
            // Progress Bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 2)
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: geo.size.width * 0.05, height: 2)
                }
            }
            .frame(height: 2)
        }
        .cornerRadius(6)
        .padding(.horizontal, 8)
        .shadow(radius: 5)
    }
}

struct SpotifyHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyHomeView()
    }
}
