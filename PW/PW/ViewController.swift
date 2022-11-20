//
//  ViewController.swift
//  PW
//
//  Created by Mert Duran on 15.11.2022.
//

import UIKit

class ViewController: UIViewController {
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    let stackView = UIStackView()
    let passwordTextField = PasswordTextField(placeHolderText: "New Password")
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    var alert: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setup()
    }
}

extension ViewController {
    func style() {
        
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 15
        statusView.clipsToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.axis = .vertical
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset Password", for: [])
        resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
    
    func setup() {
        setupDismissKeyboardGesture()
        setupNewPassword()
        setupConfirmPassword()
        setupKeyboardHiding()
    }
    
    private func setupNewPassword() {
        let newPasswordValidation: CustomValidation = {text in
            
            guard let text = text, !text.isEmpty else {
                self.statusView.reset()
                return(false, "Enter Your Password")
            }
            
            let validCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#'"
            let invalidCharacters = CharacterSet(charactersIn: validCharacters).inverted
            guard text.rangeOfCharacter(from: invalidCharacters) == nil else {
                self.statusView.reset()
                return(false, "Enter valid characters(no spaces)")
            }
            
            self.statusView.updateDisplay(text)
            if !self.statusView.validate(text) {
                return (false, "Your password must meet the requirements!")
            }
            
            return (true, "")
        }
        passwordTextField.customValidation = newPasswordValidation
        passwordTextField.delegate = self
    }
    
        private func setupConfirmPassword() {
            let confirmPasswordValidation: CustomValidation = {text in
                guard let text = text, !text.isEmpty else {
                    return(false, "Enter your password.")
                }
                guard text == self.passwordTextField.text else {
                    return(false, "Passwords do not match")
                }
                return (true, "")
            }
            confirmPasswordTextField.customValidation = confirmPasswordValidation
            confirmPasswordTextField.delegate = self
        }
    
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
extension ViewController: PasswordTextFieldDelegate {
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender === passwordTextField {
            statusView.shouldResetCriteria = false
            _ = passwordTextField.validate()
        }else if sender == confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
    }
    
    func editingChanged(_ sender: PasswordTextField) {
        if sender === passwordTextField {
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }
}

//Keyboard
extension ViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else {return}
        
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

extension ViewController {
    
    @objc func resetPasswordButtonTapped(sender: UIButton) {
        view.endEditing(true)
        
        let isValidNewPassword = passwordTextField.validate()
        let isValidConfirmPassword = confirmPasswordTextField.validate()
        
        if isValidNewPassword && isValidConfirmPassword {
            showAlert(title: "Success", message: "You have successfully changed your password!")
        }
    }
    
    private func showAlert(title: String, message: String) {
        alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        guard let alert = alert else {return}
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        alert.title = title
        alert.message = message
        present(alert, animated: true, completion: nil)
    }
}

//Tests
extension ViewController {
    var newPasswordText: String? {
        get {return passwordTextField.text}
        set {passwordTextField.text = newValue}
    }
    var confirmPasswordText: String? {
        get {return confirmPasswordTextField.text}
        set {confirmPasswordTextField.text = newValue}
    }
}
