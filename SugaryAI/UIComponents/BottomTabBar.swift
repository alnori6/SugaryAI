import SwiftUI

struct BottomTabBar: View {
    var body: some View {
        HStack {
            VStack(spacing: 4) {
                BottomTabItem(icon: "person.fill")
                Text("Profile")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#636BFF"))
            }

            Spacer()

            VStack(spacing: 4) {
                Image("scan_icon") // ✅ تعديل الحجم هنا
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 50) // 🔹 تغيير الحجم حسب رغبتك
                Text("Scan")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#A4A8FF"))
            }

            Spacer()

            VStack(spacing: 4) {
                BottomTabItem(icon: "archivebox.fill", isActive: true)
                Text("Pantry")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#A4A8FF"))
            }
        }
        .padding(.top, 1)
        .padding(.horizontal, 30)
        .background(Color(hex: "#E8EAF6"))
    }
}

// MARK: - Bottom Tab Item View
struct BottomTabItem: View {
    let icon: String?
    let imageName: String?
    var isActive: Bool = false

    init(icon: String? = nil, imageName: String? = nil, isActive: Bool = false) {
        self.icon = icon
        self.imageName = imageName
        self.isActive = isActive
    }

    var body: some View {
        VStack {
            if let icon = icon {
                Image(systemName: icon) // ✅ أيقونات SF Symbols
                    .font(.system(size: 26))
                    .foregroundColor(isActive ? Color(hex: "#636BFF") : Color(hex: "#A4A8FF"))
            } else if let imageName = imageName {
                Image(imageName) // ✅ استخدام الأيقونات من الـ Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
        }
    }
}

// MARK: - Preview
struct BottomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabBar()
    }
}
