//
//  CharacterViewCell.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import UIKit

class CharacterViewCell: UITableViewCell {
    
    // MARK: - IBOutlet -
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var characterDescription: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
