//
//  EventListViewController.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//

import UIKit

class EventListViewController: UIViewController {
    
    private let viewModel: EventListViewModel
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemGray6
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // Empty state view
    private let emptyStateView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar.badge.exclamationmark")
        imageView.tintColor = .systemGray3
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No events available.\nCreate a new event to get started!"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Bottom button container
    private let buttonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Logout", for: .normal)
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.forward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        button.setTitleColor(.red, for: .normal)
        button.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        return button
    }()
    
    private let addEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Add Event", for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        button.clipsToBounds = true
        return button
    }()
    
    init(viewModel: EventListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupBindings()
        viewModel.fetchEvents()
    }
    
    private func setupView() {
        title = "Event Hub"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(emptyStateView)
        view.addSubview(buttonContainerView)
        
        emptyStateView.addSubview(emptyStateImageView)
        emptyStateView.addSubview(emptyStateLabel)
        
        buttonContainerView.addSubview(logoutButton)
        buttonContainerView.addSubview(addEventButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: buttonContainerView.topAnchor),
            
            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            emptyStateImageView.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            emptyStateImageView.topAnchor.constraint(equalTo: emptyStateView.topAnchor),
            emptyStateImageView.widthAnchor.constraint(equalToConstant: 80),
            emptyStateImageView.heightAnchor.constraint(equalToConstant: 80),
            
            emptyStateLabel.topAnchor.constraint(equalTo: emptyStateImageView.bottomAnchor, constant: 16),
            emptyStateLabel.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor),
            emptyStateLabel.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor),
            emptyStateLabel.bottomAnchor.constraint(equalTo: emptyStateView.bottomAnchor),
            
            buttonContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonContainerView.heightAnchor.constraint(equalToConstant: 60),
            
            addEventButton.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor),
            addEventButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor),
            addEventButton.heightAnchor.constraint(equalToConstant: 50),
            addEventButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            logoutButton.trailingAnchor.constraint(equalTo: addEventButton.leadingAnchor, constant: -16),
            logoutButton.centerYAnchor.constraint(equalTo: buttonContainerView.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UpcomingEventCell.self, forCellReuseIdentifier: UpcomingEventCell.identifier)
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
    }
    
    private func setupBindings() {
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        addEventButton.addTarget(self, action: #selector(addEventButtonTapped), for: .touchUpInside)
        
        viewModel.onEventsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
    
    private func updateUI() {
        emptyStateView.isHidden = !viewModel.events.isEmpty
        tableView.reloadData()
    }
    
    @objc private func logoutButtonTapped() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { [weak self] _ in
            self?.viewModel.logout()
        })
        
        present(alert, animated: true)
    }
    
    @objc private func addEventButtonTapped() {
        viewModel.navigateToCreateEvent()
    }
}

// MARK: - UITableViewDataSource
extension EventListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.events.isEmpty ? 0 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.hasUpcomingEvent ? 1 : 0
        }
        return viewModel.events.count - (viewModel.hasUpcomingEvent ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && viewModel.hasUpcomingEvent {
            let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingEventCell.identifier, for: indexPath) as? UpcomingEventCell ?? UpcomingEventCell()
            guard let upcomingEvent = viewModel.upcomingEvent else { return cell }
            cell.configure(with: upcomingEvent)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell ?? EventCell()
            let event = viewModel.events[indexPath.row + (viewModel.hasUpcomingEvent ? 1 : 0)]
            cell.configure(with: event)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? UITableView.automaticDimension : 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Upcoming Event" : "Other Events"
    }
}
