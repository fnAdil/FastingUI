//
//  ProgressRing.swift
//  FastingUI
//
//  Created by Adil Özdemir on 15.08.2022.
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var fastingViewModel: FastingViewModel
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            // MARK: Placeholder Ring

            Circle().stroke(lineWidth: 20)
                .foregroundColor(.gray).opacity(0.1)

            // MARK: Colored Ringsss

            Circle().trim(from: 0.0, to: min(1.0, fastingViewModel.progress))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3815178275, green: 0.5126912594, blue: 0.9887260795, alpha: 1)), Color(#colorLiteral(red: 0.9750345349, green: 0.4305874705, blue: 0.6954457164, alpha: 1)), Color(#colorLiteral(red: 0.8379017711, green: 0.6807327867, blue: 0.827745676, alpha: 1)), Color(#colorLiteral(red: 0.5732530355, green: 0.8310356736, blue: 0.8607185483, alpha: 1)), Color(#colorLiteral(red: 0.3773234487, green: 0.508472383, blue: 0.979355514, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round)).rotationEffect(Angle(degrees: 270)).animation(.easeInOut(duration: 1.0), value: fastingViewModel.progress)

            VStack(spacing: 30) {
                if fastingViewModel.fastingState == .initial {
                    // MARK: Upcoming Fast

                    VStack(spacing: 5) {
                        Text("Upcoming Fast")
                            .opacity(0.7)

                        Text("\(fastingViewModel.fastingPlan.fastingPeriod.formatted()) Hours")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                } else {
                    // MARK: Elapsed Time

                    VStack(spacing: 5) { Text("Elapsed Time (\(fastingViewModel.progress.formatted(.percent)))").opacity(0.7)
                        Text(fastingViewModel.startTime, style: .timer).font(.title).fontWeight(.bold)
                    }.padding(.top)

                    // MARK: Remaining Time

                    VStack(spacing: 5) {
                        if fastingViewModel.elapsed {
                            Text("Extra Time").opacity(0.7)
                        } else {
                            Text("Remaining Time (\((1-fastingViewModel.progress).formatted(.percent)))").opacity(0.7)
                        }

                        Text(fastingViewModel.endTime, style: .timer).font(.title2).fontWeight(.bold)
                    }
                }
            }
        }
        .frame(width: 250, height: 250)
        .padding()
        .onReceive(timer) { _ in
            fastingViewModel.track()
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing().environmentObject(FastingViewModel())
    }
}
