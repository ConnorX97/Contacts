import SwiftUI

struct StarterScreen: View {
    
    @EnvironmentObject var session: SessionsStore
    
    var body: some View {
        VStack{
            if self.session.session != nil {
                HomeScreen()
            }else{
                LogInScreen()
            }
        }.onAppear{
            session.listen()
        }
    }
}

struct StarterScreen_Previews: PreviewProvider {
    static var previews: some View {
        StarterScreen()
    }
}
