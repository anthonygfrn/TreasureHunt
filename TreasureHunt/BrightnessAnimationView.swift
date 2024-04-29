import SwiftUI

struct BrightnessAnimationView: View {
    @State private var brightness: CGFloat = UIScreen.main.brightness
    @State private var backgroundColor: Color = .white

    var body: some View {
        VStack {
            Text("Brightness Level: \(brightness)")
                .padding()

            Spacer()

            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 200)
                .foregroundColor(backgroundColor)
                .padding()

            Spacer()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIScreen.brightnessDidChangeNotification)) { _ in
            // Update brightness value when brightness changes
            self.brightness = UIScreen.main.brightness

            // Update background color based on brightness
            if brightness < 0.5 {
                self.backgroundColor = .black // Dark background for low brightness
            } else {
                self.backgroundColor = .white // Light background for high brightness
            }
        }
        .onAppear {
            // Set up initial brightness value and background color
            self.brightness = UIScreen.main.brightness
            self.backgroundColor = brightness < 0.5 ? .black : .white
        }
    }
}

struct BrightnessAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        BrightnessAnimationView()
    }
}
