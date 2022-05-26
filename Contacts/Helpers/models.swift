
import Foundation

class User {
    var uid: String?
    var email: String?
    var displayName: String?
    
    init(uid: String?, email: String?, displayName: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}


struct Post: Hashable {
    
    var firstname: String?
    var lastname: String?
    var phone: String?
    
    init(firstname: String?, lastname: String?,phone: String?){
        self.firstname = firstname
        self.lastname = lastname
        self.phone = phone
    }
    
}
