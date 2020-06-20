//
//  Contacts.swift
//  nokia show off
//
//  Created by Alfredo Uzumaki on 6/20/20.
//  Copyright © 2020 Alfredo Uzumaki. All rights reserved.
//

import Foundation
import ContactsUI

class PhoneContacts {
    
    class func getContacts() -> [CNContact] {
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey] as [Any]
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        var results: [CNContact] = []
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                print("Error fetching containers")
            }
        }
        return results
    }
}

extension CNContact {
    
    func getPhone()-> String {
        return self.phoneNumbers.first?.value.stringValue ?? "No Phone Number"
    }
    
    func getName()-> String {
        return
            !self.givenName.isEmpty ? self.givenName :
            !self.nickname.isEmpty ? self.nickname :
            !self.familyName.isEmpty ? self.familyName :
            !self.middleName.isEmpty ? self.middleName : "Unknown"
    }
}
