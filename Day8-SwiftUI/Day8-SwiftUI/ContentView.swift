import SwiftUI
import Day8

struct ContentView: View {
	let image = EncodedImage(input: input, width: 25, height: 6)

	var body: some View {
		ZStack {
			Color.black
			ForEach(image.layers.reversed(), id: \.self) { layer in
				VStack(spacing: 0) {
					ForEach(layer.chunked(into: self.image.width), id: \.self) { line in
						HStack(spacing: 0) {
							ForEach(line, id: \.self) { character -> Color in
								switch character {
								case "0":
									return .black
								case "1":
									return .white
								case "2":
									return .clear
								default:
									fatalError()
								}
							}
						}
					}
				}
			}
			.padding()
		}
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
