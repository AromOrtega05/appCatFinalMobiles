import UIKit

class ProfileViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var userImage: UIImageView!
    
    // Iconos decorativos
    @IBOutlet weak var nombreImage: UIImageView!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var numberImage: UIImageView!
    
    // Labels de datos
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mi Perfil"
        view.setBackgroundColor(.systemGroupedBackground) // Fondo gris pro
        
        setupUI()
        fetchData() // <--- Carga los datos de Firebase
    }
    
    func setupUI() {
        // --- 1. Imagen de Perfil (Redonda con Borde) ---
        userImage.image = UIImage(systemName: "person.crop.circle.fill")
        userImage.tintColor = .systemGray3
        userImage.contentMode = .scaleAspectFill
        
        // Hacemos el círculo perfecto
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.clipsToBounds = true
        userImage.layer.borderWidth = 3
        userImage.layer.borderColor = UIColor.systemOrange.cgColor
        
        // --- 2. Estilos de Iconos Pequeños ---
        setupIcon(nombreImage, iconName: "person.fill")
        setupIcon(emailImage, iconName: "envelope.fill")
        setupIcon(numberImage, iconName: "phone.fill")
        
        // --- 3. Etiquetas (Labels) ---
        // Nombre
        nameLabel.setText("Cargando nombre...")
        nameLabel.setBoldFontSize(22)
        nameLabel.setAlignment(.left) // Alineado al icono
        
        // Email
        emailLabel.setText("Cargando correo...")
        emailLabel.setColor(.secondaryLabel)
        emailLabel.setFontSize(16)
        emailLabel.setAlignment(.left)
        
        // Teléfono
        numberLabel.setText("...")
        numberLabel.setColor(.secondaryLabel)
        numberLabel.setFontSize(16)
        numberLabel.setAlignment(.left)
        
        // --- 4. Botón Cerrar Sesión ---
        logoutButton.setTitleText("Cerrar Sesión")
        logoutButton.setBackgroundColor(.systemRed)
        logoutButton.setTitleColor(.white)
        logoutButton.setCornerRadius(12)
        logoutButton.setBoldFontSize(18)
        logoutButton.setShadow()
    }
    
    // Helper para configurar iconos
    private func setupIcon(_ imageView: UIImageView, iconName: String) {
        imageView.image = UIImage(systemName: iconName)
        imageView.tintColor = .systemOrange
        imageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - Traer Datos (Firebase)
    func fetchData() {
        // 1. Mostrar el email del Auth rápido
        if let email = AuthService.shared.getUserEmail() {
            emailLabel.text = email
        }
        
        // 2. Ir a buscar Nombre y Teléfono a Firestore
        AuthService.shared.fetchUserData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let name = data["name"] as? String ?? "Usuario"
                    let phone = data["phone"] as? String ?? "Sin teléfono"
                    
                    self?.nameLabel.text = name
                    self?.numberLabel.text = phone
                    
                case .failure(let error):
                    print("Error trayendo datos: \(error.localizedDescription)")
                    self?.nameLabel.text = "Usuario"
                    self?.numberLabel.text = "Desconocido"
                }
            }
        }
    }

    // MARK: - Actions
    @IBAction func logoutTapped(_ sender: UIButton) {
        // Alerta de confirmación (Toque de calidad)
        let alert = UIAlertController(title: "¿Cerrar Sesión?", message: "¿Estás seguro que quieres salir de tu cuenta?", preferredStyle: .actionSheet)
        
        let logoutAction = UIAlertAction(title: "Sí, Cerrar Sesión", style: .destructive) { _ in
            self.performLogout()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        
        // Para iPad (nos evita el crash)
        if let popover = alert.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
        }
        
        present(alert, animated: true)
    }
    
    func performLogout() {
        do {
            try AuthService.shared.logout()
            changeRootToLogin()
        } catch {
            print("Error al cerrar sesión: \(error)")
        }
    }
    
    // Navegación segura al Login
    private func changeRootToLogin() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let loginVC = LoginViewController()
        let nav = UINavigationController(rootViewController: loginVC)
        
        // Estilo del Navbar para que coincida con el resto de la app
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemOrange
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = appearance
        nav.navigationBar.tintColor = .white
        
        // Transición volteando la página (Flip)
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            window.rootViewController = nav
        }, completion: nil)
    }
}
