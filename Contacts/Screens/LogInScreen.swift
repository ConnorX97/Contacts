//
//  LogInScreen.swift
//  Contacts
//
//  Created by Sherzod Fayziev on 2022/05/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import Firebase


struct LogInScreen: View {
    @State var email = ""
       @State var password = ""
       @State var signUpToggle = false
       @ObservedObject var session = SessionsStore()
       @State var isLoading = false
       
       func doSignIn() {
           isLoading = true
           SessionsStore().signIn(email: email, password: password, completion: {(res,err) in
               isLoading = false
               if err != nil {
                   print ("Check your email or password")
   //                return
               }
               session.listen()
               print("User signed in")
               
           })
       }
       
       var body: some View {

               ZStack{
                   VStack(spacing:10){
                       Spacer()
                       Text("Wellcome back")
                           .font(.largeTitle)
                           .fontWeight(.medium)
                           .foregroundColor(.red)
                           .padding(.bottom)
                       TextField("Email", text: $email)
                           .padding()
                           .frame(maxWidth:.infinity, maxHeight: 50)
                           .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.842))
                           .cornerRadius(50)
                       SecureField("Password", text: $password)
                           .padding()
                           .frame(maxWidth:.infinity, maxHeight: 50)
                           .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.842))
                           .cornerRadius(50)
                       Button (action: {
                        doSignIn()
                       }, label: {
                           Text("Sign In")
                               .font(.system(size: 20))
                               .foregroundColor(.white)
                       }).frame(maxWidth:.infinity, maxHeight: 50)
                       .background(.red)
                       .cornerRadius(50)
                       Spacer()
                       HStack{
                       Text("Don't have an account ?")
                           Button(action: {
                               self.signUpToggle.toggle()
                               
                           }, label: {
                               Text("Sign Up")
                                   .foregroundColor(.black)
                                   .fontWeight(.bold)
                           }).sheet(isPresented: $signUpToggle) {
                               RegistrationScreen()
                           }
                       }
                       
                   }.padding()
                   if isLoading {
                       ProgressView()
                   }
           }
       }
   }


struct LogInScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogInScreen()
    }
}
