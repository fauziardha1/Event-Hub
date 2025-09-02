//
//  LogoutViewController.swift
//  Event Hub
//
//  Created by Fauzi Arda on 02/09/25.
//

import UIKit

class LogoutConfirmationViewController: UIViewController {
    
    private let viewModel: LogoutViewModel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Logout Confirmation"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .red
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let confirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "Are you sure you want to log out?"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "You will need to log in again to access your account."
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    init(viewModel: LogoutViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .pageSheet
        sheetPresentationController?.detents = [.custom { context in
            return context.maximumDetentValue * 0.4
        }, .large()]
        sheetPresentationController?.prefersGrabberVisible = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupActions()
    }
    
    // MARK: - Setup
    private func setupViews() {
        view.backgroundColor = .white
        
        [titleLabel, confirmationLabel, infoLabel, logoutButton, cancelButton].forEach {view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            confirmationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            confirmationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            confirmationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            infoLabel.topAnchor.constraint(equalTo: confirmationLabel.bottomAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            logoutButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 24),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            
            cancelButton.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 16),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupActions() {
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func logoutButtonTapped() {
        dismiss(animated: true) { [weak self] in
            self?.viewModel.performLogout()
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
