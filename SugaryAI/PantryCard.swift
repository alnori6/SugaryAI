import SwiftUI

struct PantryCard: View {
    let item: PantryItem
    let cardWidth: CGFloat
    let cardHeight: CGFloat

    let glycemicIndicatorWidth: CGFloat = 30
    let glycemicIndicatorHeight: CGFloat = 98
    let glycemicIndicatorOffset: CGFloat = -160

    // ✅ متغيرات التحكم بالصورة
    @State private var imageSize: CGFloat = 60 // 🔹 التحكم في حجم الصورة
    @State private var imageOffsetX: CGFloat = 0 // 🔹 تحريك الصورة أفقيًا
    @State private var imageOffsetY: CGFloat = 0 // 🔹 تحريك الصورة عموديًا

    // ✅ متغيرات التحكم بالنصوص
    @State private var textSize: CGFloat = 18 // 🔹 التحكم بحجم النص الرئيسي
    @State private var textOffsetX: CGFloat = 0 // 🔹 تحريك النص أفقيًا
    @State private var textOffsetY: CGFloat = 0 // 🔹 تحريك النص عموديًا

    var body: some View {
        ZStack {
            // ✅ Glycemic Load Indicator (اللون الجانبي)
            GeometryReader { _ in
                Path { path in
                    let rect = CGRect(x: 0, y: 0, width: glycemicIndicatorWidth, height: glycemicIndicatorHeight)
                    let cornerRadius: CGFloat = 15

                    path.move(to: CGPoint(x: rect.width, y: 0))
                    path.addLine(to: CGPoint(x: cornerRadius, y: 0))
                    path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius),
                                radius: cornerRadius,
                                startAngle: Angle(degrees: -90),
                                endAngle: Angle(degrees: -180),
                                clockwise: true)
                    path.addLine(to: CGPoint(x: 0, y: rect.height - cornerRadius))
                    path.addArc(center: CGPoint(x: cornerRadius, y: rect.height - cornerRadius),
                                radius: cornerRadius,
                                startAngle: Angle(degrees: 180),
                                endAngle: Angle(degrees: 90),
                                clockwise: true)
                    path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                    path.closeSubpath()
                }
                .fill(item.glycemicLoad.color)
            }
            .frame(width: glycemicIndicatorWidth, height: glycemicIndicatorHeight)
            .offset(x: glycemicIndicatorOffset)
            .zIndex(1)

            // ✅ محتويات البطاقة
            HStack(spacing: 12) {
                // ✅ صورة المنتج مع إمكانية التحكم بالمكان والحجم
                Image("item.image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .offset(x: 10, y: -5)

                VStack(alignment: .leading, spacing: 5) {
                    // ✅ النص الرئيسي مع إمكانية التحكم في الحجم والموقع
                    Text(item.name)
                        .font(.system(size: textSize, weight: .bold))
                        .foregroundColor(Color(hex: "#333674"))
                        .offset(x: 10, y: -5) // ✅ التحكم في موقع النص

                    // ✅ بيانات التغذية
                    HStack(spacing: 10) {
                        HStack(spacing: 4) {
                            Text("🍞")
                                .offset(x: 6, y: 10)
                            Text("\(item.carbs) Carbs")
                                .font(.system(size: textSize - 5, weight: .medium))
                                .foregroundColor(Color(hex: "8E8E93"))
                                .offset(x: 3, y: 10)
                        }

                        HStack(spacing: 4) {
                            Text("🔥")
                                .offset(x: 11, y: 10)
                            Text("\(item.calories) Calories")
                                .font(.system(size: textSize - 5, weight: .medium))
                                .foregroundColor(Color(hex: "#8E8E93"))
                                .offset(x: 9, y: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .frame(width: cardWidth, height: cardHeight)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 4)
        }
    }
}
