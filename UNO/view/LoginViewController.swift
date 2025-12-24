import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var usernameContainerView: UIView!
    @IBOutlet weak var usernameIconImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordIconImageView: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var registerStackView: UIStackView!
    @IBOutlet weak var noAccountLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        setupActions()            // Configura botones
        setupGestures()           // Tap para cerrar teclado
        setupKeyboardObservers()  // Scroll al escribir
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Setup Actions
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions (Botones)
    @objc func loginButtonTapped() {
        dismissKeyboard()
        
        guard let email = usernameTextField.text, !email.isEmpty else {
            showAlert(title: "Error", message: "Por favor ingresa tu correo")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Por favor ingresa tu contraseña")
            return
        }
        
        performLogin(email: email, password: password)
    }
    
    @objc func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
        showPasswordButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    // --- Lógica Recuperar Contraseña ---
    @objc func forgotPasswordTapped() {
        let alert = UIAlertController(title: "Restablecer Contraseña", message: "Ingresa tu correo para enviarte el enlace de recuperación.", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "ejemplo@correo.com"
            textField.keyboardType = .emailAddress
            if let text = self.usernameTextField.text, !text.isEmpty {
                textField.text = text
            }
        }
        
        let sendAction = UIAlertAction(title: "Enviar", style: .default) { _ in
            guard let email = alert.textFields?.first?.text, !email.isEmpty else {
                self.showAlert(title: "Error", message: "Por favor escribe un correo válido.")
                return
            }
            
            AuthService.shared.resetPassword(email: email) { [weak self] error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.showAlert(title: "Error", message: error.localizedDescription)
                    } else {
                        self?.showAlert(title: "Correo Enviado", message: "Revisa tu bandeja de entrada para cambiar tu contraseña.")
                    }
                }
            }
        }
        
        alert.addAction(sendAction)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func registerButtonTapped() {
        let registerVC = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Keyboard & Helpers
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height + 20, right: 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    private func performLogin(email: String, password: String) {
        loginButton.setTitle("", for: .normal)
        loginButton.isEnabled = false
        activityIndicator.startLoading()
        
        AuthService.shared.login(email: email, pass: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopLoading()
                self?.loginButton.setTitle("Iniciar Sesión", for: .normal)
                self?.loginButton.isEnabled = true
                
                switch result {
                case .success:
                    self?.navigateToBreedList()
                case .failure(let error):
                    self?.showAlert(title: "Error de acceso", message: error.localizedDescription)
                }
            }
        }
    }
    
    private func navigateToBreedList() {
        let breedListVC = BreedListViewController(nibName: "BreedListViewController", bundle: nil)
        navigationController?.setViewControllers([breedListVC], animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
