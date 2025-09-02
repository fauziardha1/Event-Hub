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
    
    private let organizerAndLocationLabel: UILabel = {
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
        containerView.addSubview(organizerAndLocationLabel)
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
            
            organizerAndLocationLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 8),
            organizerAndLocationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            organizerAndLocationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: organizerAndLocationLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with event: EventEntity) {
        titleLabel.text = event.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
        startDateLabel.text = "\(dateFormatter.string(from: event.startDate)) - \(dateFormatter.string(from: event.endDate))"
        organizerAndLocationLabel.text = "\(event.organizer) * \(event.location)"
        descriptionLabel.text = event.description
        
        // Load image if available
        if let thumbnailUrl = event.thumbnailPath, let image = loadImage(name: thumbnailUrl) {
            self.thumbnailImageView.image = image
        }
    }
    
    private func loadImage(name imageName: String) -> UIImage? {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = directory.appendingPathComponent(imageName)
        return UIImage(contentsOfFile: fileURL.path)
    }
}
