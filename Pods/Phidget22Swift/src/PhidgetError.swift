//
//  PhidgetError.swift
//  
//
//  Created by Patrick McNeil on 2018-01-10.
//

import Foundation
import Phidget22_C

public struct PhidgetError: Error {
	public let errorCode: ErrorCode
	public let description: String
	
	public init(code: PhidgetReturnCode) {
		errorCode = ErrorCode(rawValue: code.rawValue)!
		var errstr: UnsafePointer<Int8>? = nil
		let ret = Phidget_getErrorDescription(code, &errstr)
		if (ret == EPHIDGET_OK) {
			description = String(cString: errstr!)
		} else {
			description = ""
		}
	}
}

