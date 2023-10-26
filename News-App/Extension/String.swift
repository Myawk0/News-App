//
//  String.swift
//  News-App
//
//  Created by Мявкo on 25.10.23.
//

import Foundation
import UIKit

extension String {
    
    // MARK: - Change getting date format
    
    func changeDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        if let date = dateFormatter.date(from: self) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "dd MMM yyyy HH:mm"
            outputDateFormatter.locale = Locale(identifier: "ru_RU")
        
            let formattedDate = outputDateFormatter.string(from: date)
            return formattedDate
        }
        return ""
    }
    
    // MARK: - Processing HTML string to show with all settings as it is on web page
    
    func attributedStringFromHTML() -> NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            let attributedString = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            let range = NSRange(location: 0, length: attributedString.length)
           attributedString.enumerateAttribute(.font, in: range, options: []) { (value, range, stop) in
               if let font = value as? UIFont {
                   let newFont = font.withSize(18)
                   attributedString.addAttribute(.font, value: newFont, range: range)
                   attributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: range)
               }
           }
            return attributedString
        } catch {
            print("Error converting HTML to NSAttributedString: \(error)")
            return nil
        }
    }
}
