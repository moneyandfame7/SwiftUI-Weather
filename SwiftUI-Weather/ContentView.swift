//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Davyd Darusenkov on 24.11.2023.
//

import SwiftUI

private struct Weather: Identifiable {
    let id = UUID()

    let dayOfWeek: String
    let temperature: Int
    let icon: String
}

private let weathers: [Weather] = [
    Weather(dayOfWeek: "Tu", temperature: 75, icon: "cloud.sun.rain.fill"),
    Weather(dayOfWeek: "We", temperature: 117, icon: "cloud.sun.fill"),
    Weather(dayOfWeek: "Th", temperature: 33, icon: "cloud.sun.bolt.fill"),
    Weather(dayOfWeek: "Fr", temperature: 65, icon: "cloud.sun.fill"),
    Weather(dayOfWeek: "SA", temperature: 73, icon: "cloud.rainbow.half.fill"),
]

struct ContentView: View {
    var body: some View {
        ZStack {
            BackgroundView(topColor: .blue, bottomColor: Color("lightBlue"))

            VStack {
                CityTextView(name: "Cupertino, CA")

                WeatherDayView(
                    isLarge: true,
                    icon: "cloud.rainbow.half.fill",
                    temperature: 75
                )

                HStack(spacing: 25) {
                    ForEach(weathers) { weather in
                        WeatherDayView(
                            dayOfWeek: weather.dayOfWeek,
                            icon: weather.icon,
                            temperature: weather.temperature
                        )
                    }
                }
                Spacer()
                Button("Change day time") {
                    print("CLICKED")
                }
                .frame(width: 250, height: 50)
                .background(.white)
                .foregroundStyle(.blue)
                .font(.system(size: 18, weight: .bold))
                .clipShape(RoundedRectangle(cornerRadius: 12))

                Spacer()
            }
            .padding(.top, 10.0)
//            .border(.red, width: 5)
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    var isLarge: Bool
    var dayOfWeek: String?
    var icon: String
    var temperature: Int

    let temperatureSize: CGFloat
    let iconSize: CGFloat

    init(isLarge: Bool = false, dayOfWeek: String? = nil, icon: String, temperature: Int) {
        self.isLarge = isLarge
        self.dayOfWeek = dayOfWeek
        self.icon = icon
        self.temperature = temperature

        iconSize = isLarge ? 250 : 45
        temperatureSize = isLarge ? 75 : 24
    }

    var body: some View {
        VStack(alignment: .center) {
            if dayOfWeek != nil {
                Text(dayOfWeek!)
                    .textCase(.uppercase)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(.white)
            }

            Image(systemName: icon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: iconSize, height: iconSize)
            //                        .fontWidth(.)

            Text("\(temperature)°")
                .font(.system(size: temperatureSize, weight: .bold))
                .foregroundStyle(.white)
        }
    }
}

struct BackgroundView: View {
    var topColor: Color
    var bottomColor: Color

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [topColor, bottomColor]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea(.all)
    }
}

struct CityTextView: View {
    let name: String

    var body: some View {
        Text(name)
            .font(.system(size: 40, weight: .semibold))
            .foregroundStyle(.white)
    }
}

struct WeatherStatusView: View {
    let isLarge: Bool
    let icon: String
    let temperature: Int

    private let iconSize: CGFloat
    private let textSize: CGFloat
    init(isLarge: Bool, icon: String, temperature: Int) {
        self.isLarge = isLarge
        self.icon = icon
        self.temperature = temperature

        iconSize = isLarge ? 250 : 45
        textSize = isLarge ? 75 : 24
    }

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit) // .scaledToFit() - the same
                //
                .frame(width: iconSize, height: iconSize)

            Text("\(temperature)°")
                .foregroundStyle(.white)
                .font(.system(size: textSize, weight: .bold))
        }
        .padding(.top, isLarge ? 20 : 0)
        .padding(.bottom, isLarge ? 100 : 0)
    }
}
