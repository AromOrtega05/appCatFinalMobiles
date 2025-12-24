//
//  RegisterViewController.swift
//  UNO
//
//  Created by Suite on 19/12/25.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    // Contenedores
    @IBOutlet weak var nameUIView: UIView!
    @IBOutlet weak var numberUIView: UIView!
    @IBOutlet weak var emailUIView: UIView!
    @IBOutlet weak var passwordUIView: UIView!
    
    // Iconos
    @IBOutlet weak var nameImage: UIImageView!
    @IBOutlet weak var numberImage: UIImageView!
    @IBOutlet weak var correoImage: UIImageView!
    @IBOutlet weak var passwordImage: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crear Cuenta"
        
        // Extension UIView
        view.setBackgroundColor(.systemGroupedBackground)
        
        setupUI()
        setupGestures()
        setupTextFieldDelegates()
    }
    
    // MARK: - Setup UI
    func setupUI() {
        
        // --- 1. CONFIGURACIÓN GENÉRICA DE CONTENEDORES ---
        let containers = [nameUIView, numberUIView, emailUIView, passwordUIView]
        containers.forEach { container in
            // Extensiones de UIView
            container?.setBackgroundColor(.systemBackground)
            container?.setCornerRadius(12)
            container?.setBorder(width: 1, color: .systemGray4)
        }
        
        // --- 2. CONFIGURACIÓN DE CAMPOS ---
        
        // NOMBRE
        nameImage.setSystemImage("person.fill")
        nameImage.setTintColor(.systemOrange)
        nameImage.setContentMode(.scaleAspectFit)
        
        nameTextField.setPlaceholderText("Nombre Completo")
        nameTextField.setNoAutoCorrection()
        nameTextField.setReturnKey(.next)
        nameTextField.autocapitalizationType = .words // Propiedad nativa (no requiere extension)
        nameTextField.borderStyle = .none
        
        // TELÉFONO
        numberImage.setSystemImage("phone.fill")
        numberImage.setTintColor(.systemOrange)
        numberImage.setContentMode(.scaleAspectFit)
        
        numberTextField.setPlaceholderText("Celular")
        numberTextField.keyboardType = .phonePad
        numberTextField.borderStyle = .none
        
        // EMAIL
        correoImage.setSystemImage("envelope.fill")
        correoImage.setTintColor(.systemOrange)
        correoImage.setContentMode(.scaleAspectFit)
        
        emailTextField.setPlaceholderText("Correo electrónico")
        emailTextField.setNoAutoCorrection()
        emailTextField.setReturnKey(.next)
        emailTextField.keyboardType = .emailAddress
        emailTextField.borderStyle = .none
        
        // PASSWORD
        passwordImage.setSystemImage("lock.fill")
        passwordImage.setTintColor(.systemOrange)
        passwordImage.setContentMode(.scaleAspectFit)
        
        passwordTextField.setPlaceholderText("Contraseña (min 6 caracteres)")
        passwordTextField.setIsSecure(true)
        passwordTextField.setReturnKey(.done)
        passwordTextField.borderStyle = .none
        
        // --- 3. BOTÓN Y LOADER ---
        
        // Extensiones de UIButton
        registerButton.setTitleText("Registrarse")
        registerButton.setBackgroundColor(.systemOrange)
        registerButton.setCornerRadius(12)
        registerButton.setTitleColor(.white)
        registerButton.setBoldFontSize(18)
        registerButton.setShadow() // Usa los valores por defecto de tu extensión
        
        // Extensiones de UIActivityIndicatorView
        activityIndicator.setColor(.systemOrange)
        activityIndicator.stopLoading() // Se oculta automáticamente
    }
    
    func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - Actions
    @IBAction func registerTapped(_ sender: UIButton) {
        dismissKeyboard()
        
        // 1. Validamos TODOS los campos
        guard let name = nameTextField.text, !name.isEmpty,
              let phone = numberTextField.text, !phone.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(msg: "Por favor completa todos los campos para continuar.")
            return
        }
        
        // Extension ActivityIndicator
        activityIndicator.startLoading()
        registerButton.isEnabled = false
        registerButton.alpha = 0.7
        
        // 2. Llamada al Servicio (Asegúrate de actualizar tu AuthService)
        AuthService.shared.register(email: email, pass: password, name: name, phone: phone) { [weak self] result in
            DispatchQueue.main.async {
                // Extension ActivityIndicator
                self?.activityIndicator.stopLoading()
                self?.registerButton.isEnabled = true
                self?.registerButton.alpha = 1.0
                
                switch result {
                case .success:
                    self?.showAlert(msg: "¡Bienvenido \(name)! Cuenta creada con éxito.", isSuccess: true)
                case .failure(let error):
                    self?.showAlert(msg: error.localizedDescription)
                }
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(msg: String, isSuccess: Bool = false) {
        let alert = UIAlertController(title: isSuccess ? "Éxito" : "Atención", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            if isSuccess {
                self.navigationController?.popViewController(animated: true)
            }
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate (Efecto Borde Naranja)
extension RegisterViewController: UITextFieldDelegate {
    
    func setupTextFieldDelegates() {
        nameTextField.delegate = self
        numberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // Cuando entras al campo (Foco) -> Borde Naranja (Extension UIView)
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField: nameUIView.animateBorder(active: true)
        case numberTextField: numberUIView.animateBorder(active: true)
        case emailTextField: emailUIView.animateBorder(active: true)
        case passwordTextField: passwordUIView.animateBorder(active: true)
        default: break
        }
    }
    
    // Cuando sales del campo (Blur) -> Borde Gris (Extension UIView)
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField: nameUIView.animateBorder(active: false)
        case numberTextField: numberUIView.animateBorder(active: false)
        case emailTextField: emailUIView.animateBorder(active: false)
        case passwordTextField: passwordUIView.animateBorder(active: false)
        default: break
        }
    }
    
    // Manejo del botón "Siguiente" o "Done" del teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            numberTextField.becomeFirstResponder()
        case numberTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            textField.resignFirstResponder()
            
            // registerTapped(registerButton)
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
