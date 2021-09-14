//
//  Spinner.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

open class Spinner {
    
    // MARK: - Properties
    internal static var spinner: UIActivityIndicatorView?
    public static var style: UIActivityIndicatorView.Style = .large
    public static var baseBackColor = UIColor.blue.withAlphaComponent(0.2)
    public static var baseColor = UIColor.blue
    
    // MARK: - Public methods
    public static func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
        if spinner == nil {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner?.backgroundColor = backColor
            spinner?.style = style
            spinner?.color = baseColor
            window?.addSubview(spinner ?? UIView())
            spinner?.startAnimating()
        }
    }
    
    public static func stop() {
        guard let spinner = spinner else { return }
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.spinner = nil
    }
    
    @objc private static func update() {
        guard let _ = spinner else { return }
        stop()
        start()
    }
}
