//
//  ViewController.swift
//  Challenge1
//
//  Created by Olha Pylypiv on 09.01.2024.
//

import UIKit

class ViewController: UITableViewController {
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "World Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.rowHeight = 65
        // Set the background color to "Default"
        tableView.backgroundColor = .systemGroupedBackground
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try!fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png"){
                flags.append(item)
            }
        }
        print(flags)
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        //cell.textLabel?.text = flags[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(flags[indexPath.row])")?.stroked
        
        //cell.layer.borderWidth = 0.4
        //cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = flags[indexPath.row]
            vc.flags = flags
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    

}

