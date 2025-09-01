import UIKit

final class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back!"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.borderStyle = .roundedRect
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Initialization
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            emailField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor)
        ])
    }
    
    private func setupBindings() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        viewModel.onLoginSuccess = { [weak self] in
            self?.handleLoginSuccess()
        }
        
        viewModel.onLoginFailure = { [weak self] message in
            self?.showAlert(message: message)
        }
    }
    
    // MARK: - Actions
    @objc private func loginButtonTapped() {
        guard let email = emailField.text, let password = passwordField.text else { return }
        setLoading(true)
        viewModel.login(username: email, password: password)
    }
    
    private func setLoading(_ isLoading: Bool) {
        loginButton.isEnabled = !isLoading
        emailField.isEnabled = !isLoading
        passwordField.isEnabled = !isLoading
        
        if isLoading {
            loadingIndicator.startAnimating()
            loginButton.setTitle("", for: .normal)
        } else {
            loadingIndicator.stopAnimating()
            loginButton.setTitle("Log In", for: .normal)
        }
    }
    
    private func handleLoginSuccess() {
        setLoading(false)
        viewModel.goToEventPage()
    }
    
    private func showAlert(message: String) {
        setLoading(false)
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
