//
// String+Localization.swift
//
// MIT License
//
// Copyright (c) 2017 Alex Zarochintsev
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation

public extension String {
    
    public func localized() -> String {
        return localized(using: nil, in: .main)
    }
    
    public func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized(), arguments: arguments)
    }
    
    public func pluralizedFormat(_ arguments: CVarArg...) -> String {
        return withVaList(arguments) {
            NSString(format: localized(), locale: NSLocale.current, arguments: $0) as String
        }
    }
    
    
    public func localized(using tableName: String?) -> String {
        return localized(using: tableName, in: .main)
    }
    
    public func localized(in bundle: Bundle?) -> String {
        return localized(using: nil, in: bundle)
    }
    
    public func localized(using tableName: String?, in bundle: Bundle?) -> String {
        let bundle: Bundle = bundle ?? .main
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value:"", comment: "")
    }
    
}
