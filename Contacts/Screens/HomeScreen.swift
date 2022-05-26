//
//  HomeScreen.swift
//  Contacts
//
//  Created by Sherzod Fayziev on 2022/05/26.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var session: SessionsStore
        
        func doSignout(){
            if SessionsStore().signOut() {
                session.listen()
            }
        }
        
        var body: some View {
            NavigationView{
                VStack{
                    if let email = session.session?.email {
                        Text("Wellcome " + email)
                    }
                }.navigationBarItems( trailing:
                                        Button (action: {
                    doSignout()
                }, label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                })
                )
            }
        }
    }


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
