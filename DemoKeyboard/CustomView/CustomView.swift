//
//  CustomView.swift
//  DemoKeyboard
//
//  Created by admin on 05/03/21.
//

import UIKit

protocol KeyboardDelegate: class {
    func keyWasTapped(imgName: String,btnisSelect:Bool,isText:Bool)
}

class CustomView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collImages:UICollectionView!
    @IBOutlet weak var btnEmoji:UIButton!
    @IBOutlet weak var btnGif:UIButton!
    @IBOutlet weak var btnText:UIButton!
    @IBOutlet weak var viewMask:UIView!

    weak var delegate: KeyboardDelegate?
    var arrImages: [String] = []
    var arrEmojis: [String] = []
    var arrGalleryimg: [String] = []

    var imgname = String()
    var simpleimgname = String()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }

    override init(frame: CGRect)  {
        super.init(frame: frame)
        arrImages = ["img1", "img2","img3","img4","img5","img1", "img2","img3","img4","img5"]
        arrGalleryimg = ["Simg1","Simg2","Simg3","Simg4","tiger","Simg1","Simg2","Simg3","Simg4","tiger"]
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let lBundle = Bundle(for: type(of: self))
        let lKeyboardNib = UINib(nibName: "CustomView", bundle: lBundle)
        let lCellNib = UINib(nibName: "KeyboardKeyCollectionViewCell", bundle: lBundle)
        let lKeyboardNibView = lKeyboardNib.instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(lKeyboardNibView)
        lKeyboardNibView.frame = self.bounds
        imgname = ""
        btnGif.isSelected = true
        btnEmoji.isSelected = false
        btnText.isSelected = false
        collImages.dataSource = self
        collImages.delegate = self
        collImages.register(lCellNib, forCellWithReuseIdentifier: "idgaf")
        viewMask.layer.cornerRadius = 10
        viewMask.layer.borderColor = UIColor.lightText  .cgColor
        viewMask.layer.borderWidth = 1
        
        btnGif.layer.cornerRadius = btnGif.frame.size.width / 2
        btnGif.layer.borderColor = UIColor.black.cgColor
        btnGif.layer.borderWidth = 1
        
        btnEmoji.layer.cornerRadius = 8
        btnEmoji.layer.borderColor = UIColor.clear.cgColor
        btnEmoji.layer.borderWidth = 1
        
        btnText.layer.cornerRadius = 8
        btnText.layer.borderColor = UIColor.clear.cgColor
        btnText.layer.borderWidth = 1

        let emojiRanges = [
            0x1F601...0x1F64F,
            0x2702...0x27B0,
            0x1F680...0x1F6C0,
            0x1F170...0x1F251
        ]
        for range in emojiRanges {
            for i in range {
                let c = String(UnicodeScalar(i)!)
                arrEmojis.append(c)
            }
        }
        
        

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if btnGif.isSelected == true {
            return arrImages.count
        }
        else if btnText.isSelected == true {
            return arrGalleryimg.count
        }
        return arrEmojis.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if btnGif.isSelected == true {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idgaf", for: indexPath as IndexPath) as! KeyboardKeyCollectionViewCell
            cell.imgDisplay.clipsToBounds = true
            cell.imgDisplay.layer.cornerRadius = 8
            cell.imgDisplay.layer.borderWidth = 1
            cell.imgDisplay.layer.borderColor = UIColor.clear.cgColor
        let gifimg = UIImage.gifImageWithName(self.arrImages[indexPath.row])
        cell.imgDisplay.image = gifimg
        return cell
    }
        else if btnText.isSelected == true {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idgaf", for: indexPath as IndexPath) as! KeyboardKeyCollectionViewCell
                cell.imgDisplay.clipsToBounds = true
                cell.imgDisplay.layer.cornerRadius = 8
                cell.imgDisplay.layer.borderWidth = 1
                cell.imgDisplay.layer.borderColor = UIColor.clear.cgColor
            cell.imgDisplay.image = UIImage(named: self.arrGalleryimg[indexPath.row])
            return cell

        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idgaf", for: indexPath as IndexPath) as! KeyboardKeyCollectionViewCell
            cell.imgDisplay.image = arrEmojis[indexPath.row].image()
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if btnGif.isSelected == true {
            return CGSize(width:(self.collImages.frame.size.width / 3) - 10, height: (self.collImages.frame.size.width / 3) - 40)
        }
        else if btnText.isSelected == true {
            return CGSize(width:(self.collImages.frame.size.width / 3) - 10, height: (self.collImages.frame.size.width / 3) - 40)
        }
        else {
            return CGSize(width: 35, height: 35)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if btnGif.isSelected == true {
                imgname = self.arrImages[indexPath.row]
            self.delegate?.keyWasTapped(imgName:imgname, btnisSelect: true, isText: false)
        }
        else if btnText.isSelected == true {
//            if simpleimgname == "" {
                simpleimgname = self.arrGalleryimg[indexPath.row] + ".jpeg"
            self.delegate?.keyWasTapped(imgName:simpleimgname, btnisSelect: false, isText: true)
        }
        else {
            let emojiname  = self.arrEmojis[indexPath.row]
            self.delegate?.keyWasTapped(imgName:emojiname, btnisSelect: false, isText: false)
        }
    }

    
    @IBAction func btnEmojiClicked(_ sender:AnyObject) {
        btnEmoji.isSelected = true
        
        btnEmoji.layer.cornerRadius = btnEmoji.frame.size.width / 2
        btnEmoji.layer.borderColor = UIColor.black.cgColor
        btnEmoji.layer.borderWidth = 1
        
        btnGif.layer.cornerRadius = 8
        btnGif.layer.borderColor = UIColor.clear.cgColor
        btnGif.layer.borderWidth = 1
        
        btnText.layer.cornerRadius = 8
        btnText.layer.borderColor = UIColor.clear.cgColor
        btnText.layer.borderWidth = 1
        
        btnGif.isSelected = false
        btnText.isSelected = false
        self.collImages.reloadData()
    }
    
    @IBAction func btnGalleryClicked(_ sender:AnyObject) {
        btnEmoji.isSelected = false
        
        btnText.layer.cornerRadius = btnText.frame.size.width / 2
        btnText.layer.borderColor = UIColor.black.cgColor
        btnText.layer.borderWidth = 1
        
        btnEmoji.layer.cornerRadius = 8
        btnEmoji.layer.borderColor = UIColor.clear.cgColor
        btnEmoji.layer.borderWidth = 1
        
        btnGif.layer.cornerRadius = 8
        btnGif.layer.borderColor = UIColor.clear.cgColor
        btnGif.layer.borderWidth = 1
        
        btnGif.isSelected = false
        btnText.isSelected = true
        self.collImages.reloadData()
    }

    
    @IBAction func btnGifClicked(_ sender:AnyObject) {
        btnEmoji.isSelected = false
        
        btnGif.layer.cornerRadius = btnGif.frame.size.width / 2
        btnGif.layer.borderColor = UIColor.black.cgColor
        btnGif.layer.borderWidth = 1
        
        btnEmoji.layer.cornerRadius = 8
        btnEmoji.layer.borderColor = UIColor.clear.cgColor
        btnEmoji.layer.borderWidth = 1
        
        btnText.layer.cornerRadius = 8
        btnText.layer.borderColor = UIColor.clear.cgColor
        btnText.layer.borderWidth = 1
        
        btnGif.isSelected = true
        btnText.isSelected = false
        self.collImages.reloadData()

    }

    @IBAction func btnTextClicked(_ sender:AnyObject) {
        self.delegate?.keyWasTapped(imgName: "", btnisSelect: false, isText: true)
    }
}

extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 25, height: 30)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 25)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
