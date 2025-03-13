import SwiftUI

struct NutritionalValueBadge: View {
    let icon: String
    let value: String
    let label: String
    let width: CGFloat
    let height: CGFloat
    let offsetX: CGFloat
    let offsetY: CGFloat

    @State private var emojiWidth: CGFloat = 26
    @State private var emojiHeight: CGFloat = 40
    @State private var emojiOffsetX: CGFloat = 0
    @State private var emojiOffsetY: CGFloat = 5

    var body: some View {
        ZStack {
            Image("nutritional_badge")
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .offset(x: offsetX, y: offsetY)

            VStack(spacing: 2) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: emojiWidth, height: emojiHeight)
                    .offset(x: emojiOffsetX, y: emojiOffsetY)

                Text(value)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color.blue)

                Text(label)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color.gray)
            }
        }
        .frame(width: width, height: height)
        .offset(x: offsetX, y: offsetY)
    }
}
