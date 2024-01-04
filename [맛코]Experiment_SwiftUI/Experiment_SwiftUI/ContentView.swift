import SwiftUI

struct ContentView: View {
    @State private var toggle1: Bool = false
    @State private var toggle2: Bool = false
    @State private var toggle3: Bool = false
    @State private var toggle4: Bool = false
    @ObservedObject var environment = Model()
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 50) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(lineWidth: 3)
                            .foregroundColor(.red)
                            .frame(height: 200)
                        VStack {
                            toggle1 ? Text("State On") : Text("State Off")
                            Toggle("State", isOn: $toggle1)
                                .padding()
                            Toggle("Environment", isOn: $environment.state)
                                .padding()
                        }
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(lineWidth: 3)
                            .foregroundColor(.red)
                            .frame(height: 200)
                        VStack {
                            toggle2 ? Text("State On") : Text("State Off")
                            Toggle("State", isOn: $toggle2)
                                .padding()
                            Toggle("Environment", isOn: $environment.state)
                                .padding()
                        }
                    }
                }
                .padding()
                
                HStack(spacing: 50) {
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(lineWidth: 3)
                            .foregroundColor(.red)
                            .frame(height: 200)
                        VStack {
                            toggle3 ? Text("State On") : Text("State Off")
                            Toggle("State", isOn: $toggle3)
                                .padding()
                            Toggle("Environment", isOn: $environment.state)
                                .padding()
                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(lineWidth: 3)
                            .foregroundColor(.red)
                            .frame(height: 200)
                        VStack {
                            toggle4 ? Text("State On") : Text("State Off")
                            Toggle("State", isOn: $toggle4)
                                .padding()
                            Toggle("Environment", isOn: $environment.state)
                                .padding()
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
