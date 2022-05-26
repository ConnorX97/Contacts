
import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SessionsStore: ObservableObject {
    
    var didChange = PassthroughSubject<SessionsStore, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen () {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Got user: \(user)")
                self.session = User(uid: user.uid, email: user.email, displayName: user.displayName)
            } else {
                self.session = nil
            }
        }
    }
    
    // additional methods (sign up, sign in) will go here
    
    
    func signIn(email: String,password : String,completion: @escaping (Bool,String)->Void){
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if err != nil{
                completion(false,(err?.localizedDescription)!)
                return
            }
            completion(true,(res?.user.email)!)
        }
    }
    
    
    func signUp(email: String,password : String,completion: @escaping (Bool,String)->Void){
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if err != nil{
                completion(false,(err?.localizedDescription)!)
                return
            }
            completion(true,(res?.user.email)!)
        }
    }
    
    
    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
}

class RealtimeStore: ObservableObject {
    var ref: DatabaseReference = Database.database().reference(withPath: "posts")
    @Published var items: [Post] = []
    
    func storePost(post: Post, completion: @escaping (_ success: Bool) -> ()) {
        var success = true
        let toBePosted = ["firstname": post.firstname!, "lastname": post.lastname!, "phone": post.phone!]
        
        ref.childByAutoId().setValue(toBePosted){ (error, ref) -> Void in
            if error != nil{
                success =  false
            }
        }
        completion(success)
    }
    
    func loadPosts(completion: @escaping () -> ()) {
        ref.observe(DataEventType.value) { (snapshot) in
            self.items = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    let value = snapshot.value as? [String: AnyObject]
                    let firstname = value!["firstname"] as? String
                    let lastname = value!["lastname"] as? String
                    let phone = value!["phone"] as? String
                    self.items.append(Post(firstname: firstname, lastname: lastname, phone: phone))
                }
            }
            completion()
        }
    }
}
