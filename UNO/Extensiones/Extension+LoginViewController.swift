import UIKit

extension LoginViewController {
    
    func setupStyle() {
        // --- VIEW ---
        view.setBackgroundColor(.systemGroupedBackground)
        
        // --- IMÁGENES ---
        logoImageView.setSystemImage("pawprint.circle.fill")
        logoImageView.setTintColor(.systemOrange)
        logoImageView.setContentMode(.scaleAspectFit)
        logoImageView.setShadow(opacity: 0.1)
        
        usernameIconImageView.setSystemImage("person.fill")
        usernameIconImageView.setTintColor(.systemOrange)
        
        passwordIconImageView.setSystemImage("lock.fill")
        passwordIconImageView.setTintColor(.systemOrange)
        
        // --- TEXTOS ---
        titleLabel.setText("Find Your Perfect Cat")
        titleLabel.setBoldFontSize(28)
        titleLabel.setColor(.label)
        titleLabel.setAlignment(.center)
        
        subtitleLabel.setText("Inicia sesión para descubrir razas increíbles")
        subtitleLabel.setFontSize(16)
        subtitleLabel.setColor(.secondaryLabel)
        subtitleLabel.setLinesFree()
        subtitleLabel.setAlignment(.center)
        
        noAccountLabel.setText("¿No tienes cuenta?")
        noAccountLabel.setFontSize(14)
        noAccountLabel.setColor(.secondaryLabel)
        
        // --- INPUTS ---
        usernameTextField.setPlaceholderText("Usuario")
        usernameTextField.setNoAutoCorrection()
        usernameTextField.setReturnKey(.next)
        
        passwordTextField.setPlaceholderText("Contraseña")
        passwordTextField.setIsSecure(true)
        passwordTextField.setNoAutoCorrection()
        passwordTextField.setReturnKey(.done)
        
        // --- CONTENEDORES ---
        usernameContainerView.setBackgroundColor(.systemBackground)
        usernameContainerView.setCornerRadius(12)
        usernameContainerView.setBorder(width: 1, color: .systemGray4)
        
        passwordContainerView.setBackgroundColor(.systemBackground)
        passwordContainerView.setCornerRadius(12)
        passwordContainerView.setBorder(width: 1, color: .systemGray4)
        
        // --- BOTONES ---
        showPasswordButton.setSystemImage("eye.fill")
        showPasswordButton.setTintColor(.systemGray)
        
        loginButton.setTitleText("Iniciar Sesión")
        loginButton.setBackgroundColor(.systemOrange)
        loginButton.setTitleColor(.white)
        loginButton.setBoldFontSize(18)
        loginButton.setCornerRadius(12)
        loginButton.setShadow()
        
        forgotPasswordButton.setTitleText("¿Olvidaste tu contraseña?")
        forgotPasswordButton.setTitleColor(.systemOrange)
        forgotPasswordButton.setFontSize(14)
        
        registerButton.setTitleText("Regístrate")
        registerButton.setTitleColor(.systemOrange)
        registerButton.setBoldFontSize(14)
        
        // --- INDICATOR ---
        activityIndicator.setColor(.systemOrange)
        activityIndicator.hidesWhenStopped = true
    }
}
