//
//  ContentView.swift
//  Moonshot
//
//  Created by Василий Буланов on 10/28/21.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State var showingDate = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
//                        .aspectRatio(contentMode: .fit)
                        .frame(width: showingDate ? 44 : 74, height: showingDate ? 44 : 74)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if (showingDate)
                        {
                            Text(mission.formattedLaunchDate)
                        } else {
                            ForEach(mission.crew, id: \.name) { crew in
                                if let astronaut = getAstrounaut(id: crew.name) {
                                    Text(astronaut.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarItems(leading:
                Button(action: {
                    self.showingDate.toggle()
                }){
                    Text("Change")
                }
            )
            .navigationBarTitle("Moonshot")
        }
    }
    
    func getAstrounaut(id: String) -> Astronaut? {
        for astronaut in astronauts {
            if (astronaut.id.elementsEqual(id)) {
                return (astronaut)
            }
        }
        return nil
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
