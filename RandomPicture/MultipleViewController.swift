//
//  MultipleViewController.swift
//  RandomPicture
//
//  Created by Robert Lin on 2022/12/15.
//

import UIKit

class MultipleViewController: UIViewController {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstImageView.layer.cornerRadius = 15
        firstImageView.layer.borderColor = UIColor.black.cgColor
        firstImageView.layer.borderWidth = 1
        secondImageView.layer.cornerRadius = 15
        secondImageView.layer.borderColor = UIColor.black.cgColor
        secondImageView.layer.borderWidth = 1
        fetchPic()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func fetchPic(){
        let urlString = "https://picsum.photos/300/300"
        //讀取欲抓的資料url
        print("urlString : \(urlString)")
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    //主執行緒執行Main thread
                    DispatchQueue.main.sync {
                        self.firstImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    //主執行緒執行Main thread
                    DispatchQueue.main.sync {
                        self.secondImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
            
        }
    }

    @IBAction func get(_ sender: Any) {
        fetchPic()
    }
}
