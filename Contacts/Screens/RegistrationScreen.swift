//
//  RegistrationScreen.swift
//  Contacts
//
//  Created by Sherzod Fayziev on 2022/05/26.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @Environment(\.presentationMode) var presentation
    @State var fullname = ""
    @State var email = ""
    @State var password = ""
    @State var isLoading = false
    
    @ObservedObject var listen = SessionsStore()
    
    func doSignUp() {
        isLoading = true
        SessionsStore().signUp(email: email, password: password, completion: {(res,err) in
            isLoading = false
            if err != nil {
                print ("User not created, try again")
                return
            }
            print("User created")
            self.presentation.wrappedValue.dismiss()
        })
    }
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Spacer()
                    Text("Create your account")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundColor(.red)
                        .padding(.bottom)
                    TextField("Fullname", text: $fullname)
                        .padding()
                        .frame(maxWidth:.infinity, maxHeight: 50)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.842))
                        .cornerRadius(50)
                    
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
                        doSignUp()
                    }, label: {
                        Text("Sign Up")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }).frame(maxWidth:.infinity, maxHeight: 50)
                        .background(.red)
                        .cornerRadius(50)
                    Spacer()
                    HStack{
                        Text("Do you have an account ?")
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }, label: {
                            Text("Sign In")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                        })
                    }
                }.padding()
                    .navigationBarTitle("Registration", displayMode: .inline)
                    .navigationBarItems(leading:
                                            Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                    })
                    )
            }
            if isLoading {
                ProgressView()
            }
            
        }
    }
}

struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationScreen()
    }
}
