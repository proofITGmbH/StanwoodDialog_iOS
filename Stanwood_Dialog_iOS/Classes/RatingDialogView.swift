//
//  RatingDialogView.swift
//  StanwoodDialog
//
//  Created by Eugène Peschard on 08/01/2018.
//

import UIKit
import Kingfisher

public class RatingDialogView: UIView {
    
    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var devFace: UIImageView!
    @IBOutlet weak var paragraph1: UILabel!
    @IBOutlet weak var paragraph2: UILabel!
    @IBOutlet weak var paragraph3: UILabel!
    @IBOutlet weak var paragraph4: UILabel!
    @IBOutlet weak var accept: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    /// Container view to present the Rating Dialog overlay
    var overlayBannerContainer: UIView?
    /// The URL for rating the app on the appStore
    var appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id1316369720")!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        frame = CGRect(x: 0, y: 0, width: 300, height: 450)
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
    }
    
    /**
     It adds a popup asking the user to rate the app on the app store
     
     - parameter presenter: the `UIViewController` hosting the ad overlay
     - parameter body1: the text displayed in the ad overlay's 1st paragraph
     - parameter body2: the text displayed in the ad overlay's 2nd paragraph
     - parameter body3: the text displayed in the ad overlay's 3rd paragraph
     - parameter body4: the text displayed in the ad overlay's 4th paragraph
     - parameter devProfile: the URL for the developer's profile image
     - parameter background: the URL for a banner image displayed behind `devProfile`
     - parameter rateMeLink: the link to the appStore for rating
     - parameter accentTint: a `UIColor` for the buttons accent over white
     - parameter cancelText: a text to be displayed in the cancel `UIButton`
     - parameter acceptText: a text to be displayed in the accept `UIButton`
     
     -version: 0.6.1
     */
    @objc
    dynamic func buildAd(over presenter: UIViewController,
                        with body1: String?,
                        _ body2: String?,
                        _ body3: String?,
                        _ body4: String?,
                        from devProfile: URL,
                        over background: URL,
                        link rateMeLink: URL,
                        tint accentTint: UIColor,
                        cancel cancelText: String?,
                        accept acceptText: String?) {

        paragraph1.text = body1 ?? ""
        paragraph2.text = body2 ?? ""
        paragraph3.text = body3 ?? ""
        paragraph4.text = body4 ?? ""
        
        devFace.kf.setImage(with: devProfile)
        banner.kf.setImage(with: background)
        
        appStoreURL = rateMeLink
        
        accept.backgroundColor = accentTint
        accept.setTitle(acceptText, for: .normal)
        cancel.tintColor = accentTint
        cancel.setTitle(cancelText, for: .normal)
        
        buildOverlayAd(with: presenter)
    }
    
    /**
     It builds the container view of a specified `size`
     
     - parameter size: the size of the overlay containing the ad
    
     - version: 0.6.1
     */
    func buildOverlayAd(with presenter: UIViewController) {
        overlayBannerContainer = UIView(frame: CGRect(x: 0.0,
                                                      y: 0.0,
                                                      width: presenter.view.frame.size.width,
                                                      height: presenter.view.frame.size.height))
        overlayBannerContainer?.backgroundColor = UIColor(white: 0, alpha: 0.5)
        guard let overlaySize = overlayBannerContainer?.frame.size else {
            return
        }
        frame.origin.x = (overlaySize.width - frame.size.width) / 2
        frame.origin.y = (overlaySize.height - frame.size.height) / 2
        overlayBannerContainer?.addSubview(self)
        overlayBannerContainer?.alpha = CGFloat(0.0)
        transform = CGAffineTransform(scaleX: CGFloat(1.2), y: CGFloat(1.2))
        
        presenter.view.addSubview(overlayBannerContainer!)
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {() -> Void in
            self.overlayBannerContainer?.alpha = CGFloat(1.0)
            self.transform = CGAffineTransform(scaleX: CGFloat(1.0), y: CGFloat(1.0))
        }) { _ in }
        perform(#selector(closeOverlayAd(_:)), with: nil, afterDelay: 30)
    }
    
    @IBAction func closeOverlayAd(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {() -> Void in
            self.overlayBannerContainer?.alpha = CGFloat(0.0)
            self.transform = CGAffineTransform(scaleX: CGFloat(1.2), y: CGFloat(1.2))
        }, completion: {(_ finished: Bool) -> Void in
            self.overlayBannerContainer?.removeFromSuperview()
        })
    }
    
    @IBAction func rateApp(_ sender: Any) {
        
        UIApplication.shared.openURL(appStoreURL)
        closeOverlayAd(self)
    }
}