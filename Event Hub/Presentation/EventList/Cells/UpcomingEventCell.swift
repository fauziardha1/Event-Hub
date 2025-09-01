import UIKit

class UpcomingEventCell: UITableViewCell {
    static let identifier = "UpcomingEventCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let upcomingLabel: UILabel = {
        let label = UILabel()
        label.text = "Upcoming"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.backgroundColor = .systemBlue
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let endDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let organizerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .systemGray6
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(upcomingLabel)
        containerView.addSubview(thumbnailImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(startDateLabel)
        containerView.addSubview(endDateLabel)
        containerView.addSubview(organizerLabel)
        containerView.addSubview(locationLabel)
        containerView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            upcomingLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            upcomingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            upcomingLabel.widthAnchor.constraint(equalToConstant: 80),
            upcomingLabel.heightAnchor.constraint(equalToConstant: 24),
            
            thumbnailImageView.topAnchor.constraint(equalTo: upcomingLabel.bottomAnchor, constant: 16),
            thumbnailImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            thumbnailImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            startDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            startDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            startDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            endDateLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 4),
            endDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            endDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            organizerLabel.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 8),
            organizerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            organizerLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            locationLabel.topAnchor.constraint(equalTo: organizerLabel.bottomAnchor, constant: 4),
            locationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
//    func configure(with event: EventEntity) {
//        titleLabel.text = event.name
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
//        
//        startDateLabel.text = "Start: \(dateFormatter.string(from: event.startDate))"
//        if let endDate = event.dateEnd {
//            endDateLabel.text = "End: \(dateFormatter.string(from: endDate))"
//        }
//        
//        organizerLabel.text = "By \(event.organizer)"
//        locationLabel.text = "📍 \(event.location)"
//        descriptionLabel.text = event.description
//        
//        // Load image if available
//        if let thumbnailUrl = event.thumbnailUrl {
//            // Implement image loading here
//        }
//    }
}
