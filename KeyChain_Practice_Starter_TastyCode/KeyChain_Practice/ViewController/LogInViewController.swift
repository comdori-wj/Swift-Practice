//
// LogInViewController.swift
//

import UIKit

struct Credentials {
    var password: String
}

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

class LogInViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    let password = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addKeyChain() {
        guard let data = passwordTextField.text else { fatalError("비번 없음.")}
        
        print(data)
        let credentials = Credentials(password: data)
        let password = credentials.password.data(using: String.Encoding.utf8)!
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword, kSecValueData as String: password]
        let status = SecItemAdd(query as CFDictionary, nil)
        
        //        guard status == errSecSuccess else {
        //            throw KeychainError.unhandledError(status: status)
        //        }
        
        if status == errSecSuccess {
            print("add success")
        } else if status == errSecDuplicateItem {
            print("keychain에 Item이 이미 있음")
            //            updateItemOnKeyChain(value: password)
        } else {
            KeychainError.unhandledError(status: status)
        }
    }
    
    func updateItemOnKeyChain(value: Any) {
        let previousQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword]
        let updateQuery: [CFString: Any] = [kSecValueData: value]
        let status = SecItemUpdate(previousQuery as CFDictionary, updateQuery as CFDictionary)
        if status == errSecSuccess {
            print("update complete")
        } else {
            debugPrint(KeychainError.unhandledError(status: status))
            print("not finished update")
        }
    }
    
    func deleteItemOnKeyChain() {
        let deleteQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword]
        let status = SecItemDelete(deleteQuery as CFDictionary)
        if status == errSecSuccess {
            print("remove key-data complete")
        } else {
            print("remove key-data failed")
        }
    }
    
    func readItemsOnKeyChain() -> String {
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                           kSecReturnAttributes: true,
                                 kSecReturnData: true]
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess {
            print("read failed")
            return "read failed"
        }
        guard let existingItem = item as? [String: Any] else { return ""}
        guard let data = existingItem[kSecValueData as String] as? Data else { return ""}
        guard let password = String(data: data, encoding: .utf8) else { return ""}
        return password
        
    }
    
    @IBAction func addNewPassword(_ sender: Any) {
        // passwordTextField에 입력된 패스워드를 저장합니다.
        // 이미 저장된 비밀번호가 있다 하더라도, 버튼을 누를 때마다 새로운 비밀번호로 업데이트 됩니다.
        addKeyChain()
        //        password.setValue(passwordTextField.text, forKey: "password")
        
        
    }
    
    @IBAction func deletePassword(_ sender: UIButton) {
        // 등록된 비밀번호를 삭제합니다.
        //        password.removeObject(forKey: "password")
        deleteItemOnKeyChain()
        
        
    }
    
    @IBAction func tapLogInButton(_ sender: Any) {
        // 저장된 패스워드가 passwordTextField에 입력된 패스워드와 일치하는지 확인합니다.
        // 패스워드가 일치하지 않는다면 DiaryViewController를 보여주어선 안됩니다.
        // 패스워드가 일치하면 DiaryViewController를 push합니다.
        //        let data = UserDefaults.standard.string(forKey: "password")
        var pwd = readItemsOnKeyChain()
        print("로그인탭 패스워드: ", pwd)        
        if passwordTextField.text == pwd {
            guard let diaryViewController = self.storyboard?.instantiateViewController(withIdentifier: "diary") as? DiaryViewController else { return }
            self.navigationController?.pushViewController(diaryViewController, animated: true)
        } else {
            showAlert("비밀번호가 틀렸습니다.")
        }
        
    }
    
    // Show Alert: 간단한 Alert를 띄울 일이 있다면 활용해보세요. (ex. 비밀번호 일치하지 않음 알림 등)
    private func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true)
    }
}

