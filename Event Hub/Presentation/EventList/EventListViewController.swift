//
//  EvenListViewController.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//

import UIKit

class EventListViewController: UIViewController {
    
    private let viewModel: EventListViewModel
    private let tableView = UITableView()
    
    // floating buttons of logout button in the left and add event button in the right, the button add event should be circular on the left and bottom side, those buttons will be inside of a container view, then the container view of those buttons will be sticked to the bottom of the screen
    private let buttonContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // add shadow to the container view in the top of it
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 4
        view.backgroundColor = .white
        return view
    }()
    
    // The Logout Button has image in the left side and text in the right side, the image is a logout icon, the icon color and the text color is red, and rotate the image 180 degrees
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Logout", for: .normal)
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.forward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        button.setTitleColor(.red, for: .normal)
        button.imageView?.transform = CGAffineTransform(rotationAngle: .pi) // Rotate 180 degrees
        return button
    }()
    
    // The Add Event button has image in the left side and text in the right side, the image is a plus icon
    private let addEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Add Event", for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        
        // only add corner radius to the top left and bottom left side
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
    }
    
    private func setupView() {
        title = "Event Hub"
        view.backgroundColor = .white
        
        view.addSubview(buttonContainerView)
        buttonContainerView.addSubview(logoutButton)
        buttonContainerView.addSubview(addEventButton)
        
        NSLayoutConstraint.activate([
            buttonContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonContainerView.heightAnchor.constraint(equalToConstant: 60),
            
            addEventButton.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor),
            addEventButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor),
            addEventButton.heightAnchor.constraint(equalToConstant: 50),
            addEventButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            logoutButton.trailingAnchor.constraint(equalTo: addEventButton.leadingAnchor, constant: -16),
            logoutButton.centerYAnchor.constraint(equalTo: buttonContainerView.centerYAnchor),
        ])
        
    }
    
}
