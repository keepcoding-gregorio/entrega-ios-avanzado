//
//  CharacterViewCell.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import UIKit
import Kingfisher

class CharacterViewCell: UITableViewCell {
    static let identifier: String = "CharacterViewCell"
    static let height: CGFloat = 42
    
    // MARK: - IBOutlet -
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var characterDescription: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()

        name.text = nil
        picture.image = nil
        characterDescription.text = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        cellView.layer.cornerRadius = 8
        cellView.layer.shadowColor = UIColor.gray.cgColor
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowRadius = 8
        cellView.layer.shadowOpacity = 0.4

        picture.layer.cornerRadius = 8
        picture.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]

        selectionStyle = .none
    }

    func updateView(
        name: String? = nil,
        picture: String? = nil,
        description: String? = nil
    ) {
        self.name.text = name
        self.characterDescription.text = description
        self.picture.kf.setImage(with: URL(string: picture ?? ""))
    }
}
