import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Hero
                    VStack(spacing: 10) {
                        ZStack {
                            Circle().fill(AppConfig.primaryColor.opacity(0.15)).frame(width: 90, height: 90)
                            Text(AppConfig.avatarEmoji).font(.system(size: 48))
                        }
                        Text(AppConfig.ownerName)
                            .font(.system(size: 24, weight: .bold, design: AppConfig.fontDesign))
                        Text(AppConfig.ownerTitle)
                            .font(.system(size: 15, weight: .semibold, design: AppConfig.fontDesign))
                            .foregroundColor(AppConfig.primaryColor)
                        Text(AppConfig.ownerBio)
                            .font(.system(size: 13, design: AppConfig.fontDesign))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 28)
                    .background(LinearGradient(colors: [AppConfig.primaryColor.opacity(0.1), .clear], startPoint: .top, endPoint: .bottom))

                    // Skills
                    VStack(alignment: .leading, spacing: 12) {
                        Text("المهارات")
                            .font(.system(size: 11, weight: .semibold, design: AppConfig.fontDesign))
                            .foregroundColor(.secondary).textCase(.uppercase)
                        FlowLayout(spacing: 8) {
                            ForEach(AppConfig.skills, id: \\.self) { skill in
                                Text(skill)
                                    .font(.system(size: 13, weight: .semibold, design: AppConfig.fontDesign))
                                    .padding(.horizontal, 14).padding(.vertical, 7)
                                    .background(AppConfig.primaryColor.opacity(0.1))
                                    .foregroundColor(AppConfig.primaryColor)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(AppConfig.primaryColor.opacity(0.25), lineWidth: 1))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()

                    Divider().padding(.horizontal)

                    // Projects
                    VStack(alignment: .leading, spacing: 12) {
                        Text("المشاريع")
                            .font(.system(size: 11, weight: .semibold, design: AppConfig.fontDesign))
                            .foregroundColor(.secondary).textCase(.uppercase)
                        ForEach(AppConfig.projects, id: \\.name) { project in
                            HStack(spacing: 14) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12).fill(AppConfig.accentColor.opacity(0.12)).frame(width: 44, height: 44)
                                    Text(project.emoji).font(.system(size: 22))
                                }
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(project.name).font(.system(size: 15, weight: .semibold, design: AppConfig.fontDesign))
                                    Text("اضغط للتفاصيل").font(.system(size: 12, design: AppConfig.fontDesign)).foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.left").foregroundColor(.secondary).font(.system(size: 13))
                            }
                            .padding(14)
                            .background(Color(.systemBackground))
                            .cornerRadius(14)
                            .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
            .navigationTitle("").navigationBarHidden(true)
        }
        .environment(\\.layoutDirection, .rightToLeft)
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let w = proposal.width ?? .infinity
        var x: CGFloat = 0; var y: CGFloat = 0; var rowH: CGFloat = 0
        for sv in subviews {
            let s = sv.sizeThatFits(.unspecified)
            if x + s.width > w && x > 0 { y += rowH + spacing; x = 0; rowH = 0 }
            rowH = max(rowH, s.height); x += s.width + spacing
        }
        return CGSize(width: w, height: y + rowH)
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX; var y = bounds.minY; var rowH: CGFloat = 0
        for sv in subviews {
            let s = sv.sizeThatFits(.unspecified)
            if x + s.width > bounds.maxX && x > bounds.minX { y += rowH + spacing; x = bounds.minX; rowH = 0 }
            sv.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(s))
            rowH = max(rowH, s.height); x += s.width + spacing
        }
    }
}
