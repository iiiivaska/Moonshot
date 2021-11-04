//
//  AstronautView.swift
//  Moonshot
//
//  Created by Василий Буланов on 10/29/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Spacer(minLength: 10)
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.95)
                    
                    Text(self.astronaut.description)
                        .padding()
                    
                    ForEach(self.missions, id: \.id) { miss in
                        NavigationLink(destination: MissionView(mission: miss, astronauts: Bundle.main.decode("astronauts.json")))
                        {
                            if (isInCrew(astronaut: astronaut, mission: miss)) {
                                HStack {
                                    Image(miss.image)
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                        .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                    
                                    VStack (alignment: .leading) {
                                        Text(miss.displayName)
                                            .font(.headline)
                                            .foregroundColor(.secondary)
                                        
                                        Text(miss.formattedLaunchDate)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.bottom)
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    func isInCrew(astronaut: Astronaut, mission: Mission) -> Bool {
        for crew in mission.crew {
            if (crew.name.elementsEqual(astronaut.id)) {
                return true
            }
        }
        return false
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
