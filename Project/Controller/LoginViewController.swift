//
//  ViewController.swift
//  finalProject
//
//  Created by Yassine FATIHI / Maxime GOUENARD on 14/02/2019.
//  Copyright © 2019 Yassine FATIHI / Maxime GOUENARD All rights reserved.
//

import UIKit

class LoginViewControler: UIViewController, SignInViewDelegate, SignUpViewDelegate, ProfilViewDelegate, TetrisViewDelegate {
    
    // IBOutlets
    @IBOutlet weak var signInView: SignInView!
    @IBOutlet weak var signUpView: SignUpView!
    @IBOutlet weak var profilView: ProfilView!
    @IBOutlet weak var tetrisView: TetrisView!
    
    // Initialisation
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInView.delegate = self
        signUpView.delegate = self
        profilView.delegate = self
        tetrisView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Méthodes permettant la "navigation" entre les Views
    func goToSignUp() {
        signUpView.isHidden = false
        signInView.isHidden = true
        profilView.isHidden = true
        tetrisView.isHidden = true
        resetLabelErrorRegister()
    }
    func goToSignIn() {
        signInView.isHidden = false
        signUpView.isHidden = true
        profilView.isHidden = true
        tetrisView.isHidden = true
        resetLabelErrorSignIn()
    }
    func goToProfile() {
        profilView.isHidden = false
        signInView.isHidden = true
        signUpView.isHidden = true
        tetrisView.isHidden = true
        resetFieldsLabelProfilView()
    }
    func goToSurprise() {
        tetrisView.isHidden = false
        profilView.isHidden = true
        signUpView.isHidden = true
        signInView.isHidden = true
    }
    func backToProfile() {
        profilView.isHidden = false
        signInView.isHidden = true
        signUpView.isHidden = true
        tetrisView.isHidden = true
    }
    
    // Méthode permettant la création d'un User ainsi que la vérification des champs => Action button Register (SignUpView)
    func createRegister() {
        
        resetLabelErrorRegister()
        
        guard let email: String = signUpView.emailInput.text else {return}
        guard let password: String =  signUpView.passInput.text else {return}
        guard let confirmPassword: String = signUpView.passConfirmInput.text else {return}
        
        if (email != "" && password == confirmPassword) {
            if confirmEmail(param: email) == false {
                signUpView.validationEmail.text = "Error email @"
                signUpView.validationEmail.textColor = UIColor.red
            }else if password.count < 5 {
                signUpView.validationPassword.text = "Error Password < 5 characters"
                signUpView.validationPassword.textColor = UIColor.red

            }else {
                let newUserRegister: User = User.init(email: email, password: password)
                RegisterUser.register(user: newUserRegister)
                print("Successful sign up")
                goToSignIn()
            }
        }else {
            signUpView.ErrorField.text = "Fields are not completed"
            signUpView.ErrorField.textColor = UIColor.red
        }
    }
    
    // Méthode permettant la connexion de l'User ainsi que la vérification des champs => Action button Login (SignUpView)
    func login() {
        
        guard let email = signInView.email.text else {return}
        guard let password =  signInView.password.text else {return}
        
        if(RegisterUser.instance?.email == email && RegisterUser.instance?.password == password){
            profilView.emailLabel.text = RegisterUser.instance?.email
            print("Successful login")
            goToProfile()
        }
        else{
            signInView.errorLogin.text = "Unable to find a match with this pair of email / password"
            signInView.errorLogin.textColor = UIColor.red
        }
   }
    
    // Méthode permettant le changement de password de l'User ainsi que la vérification des champs => Action button Change Password (ProfilView)
    func changePassword(){
    
        guard let password = profilView.password.text else {return}
        guard let confirmPassword = profilView.confirmPassword.text else {return}
        
        if ( (password != "" || confirmPassword !=  "") && confirmPassword == password) {
            if (password.count < 5) {
                profilView.errorPassword.text = "Error Password < 5 characters"
                profilView.errorPassword.textColor = UIColor.red
            }else {
                RegisterUser.instance?.password = password
                print("Password change is a succes")
                profilView.errorPassword.text = "password matching"
                profilView.errorPassword.textColor = UIColor.green
            }
        } else {
            profilView.errorPassword.text = "Password are not matching"
            profilView.errorPassword.textColor = UIColor.red
        }
    }
    
    // Méthode permettant la verification syntaxique d'un Email
    func confirmEmail(param: String) -> Bool {
        var result: Bool = false
        for character in param {
            if (character == "@"){
                result = true
            }
        }
        return result
    }
    
    
    // Méthodes permettant de réinitialiser les TextInput ainsi que les Labels
    func resetFieldsLabelProfilView() {
        profilView.password.text = ""
        profilView.confirmPassword.text = ""
        profilView.errorPassword.text = ""
    }
    func resetLabelErrorRegister() {
        signUpView.ErrorField.text = ""
        signUpView.validationPassword.text = ""
        signUpView.validationEmail.text = ""
    }
    func resetLabelErrorSignIn(){
        signInView.errorLogin.text = ""
    }
}
