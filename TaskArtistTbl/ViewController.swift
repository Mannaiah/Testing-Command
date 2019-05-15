//
//  ViewController.swift
//  TaskArtistTbl
//
//  Created by rizenew on 9/28/18.
//  Copyright © 2018 rizenew. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var nsArrayResult = NSArray()
    var nsDictionary = NSDictionary()
    @IBOutlet weak var tbl_artist: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GetData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func GetData(){
        let str = "https://rss.itunes.apple.com/api/v1/in/apple-music/hot-tracks/all/25/explicit.json"
        let url = URL(string:str)
        let task = URLSession.shared.dataTask(with:url!) { (data, response, error) in
            guard let dataReceived = data else{
                return
            }
            do{
                let str12 = try JSONSerialization.jsonObject(with: dataReceived, options: JSONSerialization.ReadingOptions.allowFragments)
               // print(str)
                self.nsDictionary = str12 as! NSDictionary
               // print("Nsdictionary%@",self.nsDictionary)
                let dict = self.nsDictionary.value(forKey:"feed") as! NSDictionary
                self.nsArrayResult = dict.value(forKey: "results") as! NSArray
                print("NSArray%@",self.nsArrayResult)
                DispatchQueue.main.async {
                    self.tbl_artist.reloadData()
                }
                
            }catch{
                print(error)
            }
        }
        task.resume()
        
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nsArrayResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ArtistTblCell") as! ArtistTblCell
        let dict = nsArrayResult[indexPath.row] as! NSDictionary
        cell.lbl_artistName.text = dict.value(forKey:"artistName") as? String ?? ""
        cell.lbl_artistName.adjustsFontSizeToFitWidth = true
        cell.lbl_artistName.sizeToFit()
        cell.lbl_collName.adjustsFontSizeToFitWidth = true
        cell.lbl_collName.sizeToFit()
        cell.lbl_collName.text = dict.value(forKey:"collectionName") as? String ?? ""
        let str = dict.value(forKey:"artworkUrl100") as! String
        let url = URL(string:str)
        cell.img_artist.load(url:url!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
