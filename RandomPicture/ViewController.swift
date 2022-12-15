//
//  ViewController.swift
//  RandomPicture
//
//  Created by Robert Lin on 2022/12/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var squareSwitch: UISwitch!
    @IBOutlet weak var grayscaleSwitch: UISwitch!
    @IBOutlet weak var blurSwitch: UISwitch!
    @IBOutlet weak var blurSlider: UISlider!
    @IBOutlet weak var getButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        blurSlider.isHidden = true
        
        picImageView.layer.cornerRadius = 15
        picImageView.layer.borderColor = UIColor.black.cgColor
        picImageView.layer.borderWidth = 1
    }
    
    //抓取圖片API
    func fetchPic(){
        var urlString = "https://picsum.photos/200/300"
        
        if squareSwitch.isOn{
            urlString = "https://picsum.photos/300/300"
            if grayscaleSwitch.isOn{
                urlString = "https://picsum.photos/300/300?grayscale"
                if blurSwitch.isOn{
                    urlString = "https://picsum.photos/300/300?grayscale&blur=\(Int(blurSlider.value))"
                }
            }else{
                // square & not grayscale
                if blurSwitch.isOn{
                    urlString = "https://picsum.photos/300/300?blur=\(Int(blurSlider.value))"
                }
            }
        }else{
            // not square
            if grayscaleSwitch.isOn {
                urlString = "https://picsum.photos/200/300?grayscale"
                if blurSwitch.isOn{
                    urlString = "https://picsum.photos/200/300?grayscale&blur=\(Int(blurSlider.value))"
                }
            } else {
                // not square & not grayscale
                if blurSwitch.isOn{
                    urlString = "https://picsum.photos/200/300?blur=\(Int(blurSlider.value))"
                }
            }
        }
            
        //讀取欲抓的資料url
        print("urlString : \(urlString)")
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    //主執行緒執行Main thread
                    DispatchQueue.main.sync {
                        self.picImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    @IBAction func get(_ sender: Any) {
        fetchPic()
    }
    
    @IBAction func showSlider(_ sender: UISwitch) {
        if blurSwitch.isOn{
            blurSlider.isHidden = false
        }else{
            blurSlider.isHidden = true
        }
            
    }
    

}

