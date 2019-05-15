//
//  ArtistTblCell.swift
//  TaskArtistTbl
//
//  Created by rizenew on 9/28/18.
//  Copyright © 2018 rizenew. All rights reserved.
//

import UIKit

class ArtistTblCell: UITableViewCell {

    @IBOutlet weak var lbl_artistName: UILabel!
    @IBOutlet weak var img_artist: UIImageView!
    
    @IBOutlet weak var lbl_collName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
