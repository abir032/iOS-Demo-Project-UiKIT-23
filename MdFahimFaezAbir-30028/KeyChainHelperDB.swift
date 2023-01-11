//
//  KeyChainHelperDB.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 11/1/23.
//

import Foundation
class KeyChainHelperClass{
    static let keyChainShared = KeyChainHelperClass()
    func writeToKeychain(pass: String, email: String) {
        guard let data =  try? JSONEncoder().encode(pass) else {return}
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: email,
            kSecAttrService: "password",
            kSecValueData: data
        ] as CFDictionary
        SecItemAdd(query, nil)
    }
    
    func readFromKeyChain(account: String, service: String)-> String {
    
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: true,
            kSecReturnAttributes: true
        ] as CFDictionary
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query, &result)
        if status == errSecSuccess{
            var pass = " "
            if let result = result as? [CFString: Any]{
                print(result[kSecValueData]!)
                print(result[kSecAttrAccount]!)
                print(result[kSecAttrService]!)
                if let data = result[kSecValueData] as? Data {
                    let passwords = try? JSONDecoder().decode(String.self, from: data)
                    if let passwords = passwords{
                        pass = passwords
                    }
                    
                }
                
            }
            print(pass)
            return pass
        }else{
            return " "
        }

    }
}

