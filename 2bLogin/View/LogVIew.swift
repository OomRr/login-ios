//
//  LogVIew.swift
//  2bLogin
//
//  Created by Omar on 27/04/2026.
//

import UIKit

class LogVIew: UIViewController {
    
    var viewModel: LoginViewModel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
       @IBOutlet weak var usernameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
          setupPasswordToggle()
        
 
       let h = loginBtn.isEnabled
        if h {
            loginBtn.backgroundColor = .black
        }
        
        bindViewModel()
        
    }
    func bindViewModel(){
        viewModel.onStateChanged = { [weak self] state in
            self?.render(state: state)
        }
    }
    func render(state: LoginState){
        switch state {
            
        case .idleState:
            loginBtn.isEnabled = true
            loginBtn.backgroundColor = .systemGray6
        case .loadingState:
            loginBtn.isEnabled = false
            loginBtn.backgroundColor = .systemGray6
            
        case .successState(_):
            loginBtn.backgroundColor = .systemGray6
            self.navigationController?.pushViewController(HomeViewController(), animated: true)
            if let u = getSavedUser() {
                showAlert(messageTitle: "done", messageBody: "welcom \(u.userName)")
            }
            
        case .failureState(let message):
            loginBtn.isEnabled = true
         //   loginBtn.backgroundColor = .red
            showAlert(messageTitle: message, messageBody: "Please try again")
        }
    }
    @IBAction func btnPushed(_ sender: Any) {
    
        viewModel.didTapped(userName: usernameTF.text ?? "", password: passwordTF.text ?? "")
    }
    func showAlert(messageTitle: String, messageBody: String){
        let ac = UIAlertController(title: messageTitle, message: messageBody, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        ac.addAction(action)
        present(ac, animated: true)
    }
        func setupPasswordToggle(){
            let eyeButton: UIButton = UIButton(type: .custom)
            eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            eyeButton.setImage(UIImage(systemName: "eye"), for: .selected)
            eyeButton.tintColor = .lightGray
            eyeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
            let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
            eyeButton.center = CGPoint(x: container.bounds.midX - 5, y: container.bounds.midY)
            container.addSubview(eyeButton)

            passwordTF.rightView = container
            passwordTF.rightViewMode = .always
    }
        @objc func togglePasswordVisibility(_ senderButton:UIButton){
            senderButton.isSelected.toggle()
            passwordTF.isSecureTextEntry.toggle()
            if let existingText = passwordTF.text {
                passwordTF.text = nil
                passwordTF.insertText(existingText)
            }
       }
    func getSavedUser() -> User? {
        guard let userName = UserDefaults.standard.string(forKey: "userName"),
              let token = UserDefaults.standard.string(forKey: "token") else {
            return nil
        }
        return User(userName: userName, token: token)
    }
}
