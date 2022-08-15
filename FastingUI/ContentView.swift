//
//  ContentView.swift
//  FastingUI
//
//  Created by Adil Özdemir on 15.08.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fastingViewModel = FastingViewModel()

    var title: String {
        switch fastingViewModel.fastingState {
        case .initial:
            return "Let's get started!"
        case .fasting:
            return "You are now fasting"
        case .feeding:
            return "You are now feeding"
        }
    }

    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.09308278258, green: 0.01094840008, blue: 0.171029317, alpha: 1)).ignoresSafeArea()

            // MARK: progress view

            Content
        }
    }

    var Content: some View {
        ZStack {
            VStack(spacing: 40) {
                // MARK: Title

                Text(title).font(.headline).foregroundColor(Color(#colorLiteral(red: 0.3815178275, green: 0.5126912594, blue: 0.9887260795, alpha: 1)))

                // MARK: Fasting Plan

                Button {
                    fastingViewModel.toggleFastingPlan()
                } label: {
                    Text(fastingViewModel.fastingPlan.rawValue)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                }

                Spacer()
            }
            VStack(spacing: 40) {
                // MARK: progress Ring

                ProgressRing().environmentObject(fastingViewModel)

                HStack(spacing: 60) {
                    // MARK: Start Time

                    VStack(spacing: 5) {
                        Text(fastingViewModel.fastingState == .initial ? "Start" : "Started").opacity(0.7)
                        Text(fastingViewModel.startTime, format: .dateTime.weekday().hour().minute().second()).fontWeight(.bold)
                    }

                    // MARK: End Time

                    VStack(spacing: 5) {
                        Text(fastingViewModel.fastingState == .initial ? "End" : "Ends").opacity(0.7)
                        Text(fastingViewModel.endTime, format: .dateTime.weekday().hour().minute().second()).fontWeight(.bold)
                    }
                }

                // MARK: Button

                Button {
                    fastingViewModel.toggleFastingState()
                } label: {
                    Text(fastingViewModel.fastingState == .fasting ? "End fasting" : "Start fasting")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                }
            }.padding()
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
