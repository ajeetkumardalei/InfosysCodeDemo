

import UIKit
import ImageViewer_swift



class DashboardCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with item:Row) {
        nameLabel.text = item.title
        jobTitleDetailedLabel.text = item.description 
        
        if let strImgURL = item.imageHref {
            profileImageView.setImageFromAlmofireURL(strImgURL: strImgURL, isShowIndicator: true, placeholderimg: Placeholder.noImage, completionHandler: { (isSuccess) in
                debugPrint(DownloadManager.succss)
            })
        }
            
        self.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:))))
    }
        
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        tappedImage.setupImageViewer()
    }

            let containerView:UIView = {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.clipsToBounds = true
                return view
            }()
            
            let profileImageView:UIImageView = {
                let img = UIImageView()
                img.contentMode = .scaleAspectFill
                img.backgroundColor = .clear
                img.translatesAutoresizingMaskIntoConstraints = false
                img.clipsToBounds = true
                img.isUserInteractionEnabled = true
                img.setRoundCornder(0.4, .gray)
                return img
                
            }()
            
            let nameLabel:UILabel = {
                let label = UILabel()
                label.font = UIFont.boldSystemFont(ofSize: 20)
                label.textColor = .black
                label.backgroundColor = .clear
                label.translatesAutoresizingMaskIntoConstraints = false
                label.lineBreakMode = NSLineBreakMode.byWordWrapping
                label.numberOfLines = 0
                return label
            }()
            
            let jobTitleDetailedLabel:UILabel = {
                let label = UILabel()
                label.font = UIFont.boldSystemFont(ofSize: 14)
                label.textColor =  .darkGray
                label.backgroundColor = .clear
                label.layer.cornerRadius = 5
                label.clipsToBounds = true
                label.translatesAutoresizingMaskIntoConstraints = false
                label.numberOfLines = 0
                label.lineBreakMode = NSLineBreakMode.byWordWrapping
                return label
            }()
            
            override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: reuseIdentifier)
                
                self.contentView.addSubview(profileImageView)
                containerView.addSubview(nameLabel)
                containerView.addSubview(jobTitleDetailedLabel)
                self.contentView.addSubview(containerView)
                
                profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
                profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
                profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
                profileImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
                
                containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
                containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:15).isActive = true
                containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:0).isActive = true
                containerView.heightAnchor.constraint(equalToConstant:100).isActive = true
                
                nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
                nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant: 0).isActive = true
                nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant: -15).isActive = true
                
                jobTitleDetailedLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor, constant: 4).isActive = true
                jobTitleDetailedLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant: 0).isActive = true
                jobTitleDetailedLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant: -15).isActive = true
                jobTitleDetailedLabel.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -4).isActive = true

            }
            
            required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
            }
    

}

