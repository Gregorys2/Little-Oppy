import Foundation
import Phidget22_C

/**
The RFID class provides methods for Phidget RFID boards to read and write (if writing is supported) to RFID tags.
*/
public class RFIDBase : Phidget {

	public init() {
		var h: PhidgetHandle?
		PhidgetRFID_create(&h)
		super.init(h!)
		initializeEvents()
	}

	internal override init(_ handle: PhidgetHandle) {
		super.init(handle)
	}

	deinit {
		if (retained) {
			Phidget_release(&chandle)
		} else {
			uninitializeEvents()
			PhidgetRFID_delete(&chandle)
		}
	}

	/**
	The on/off state of the antenna.

	*   You can turn the antenna off to save power.
	*   You must turn the antenna on in order to detect and read RFID tags.

	- returns:
	The state of the antenna

	- throws:
	An error or type `PhidgetError`
	*/
	public func getAntennaEnabled() throws -> Bool {
		let result: PhidgetReturnCode
		var antennaEnabled: Int32 = 0
		result = PhidgetRFID_getAntennaEnabled(chandle, &antennaEnabled)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return (antennaEnabled == 0 ? false : true)
	}

	/**
	The on/off state of the antenna.

	*   You can turn the antenna off to save power.
	*   You must turn the antenna on in order to detect and read RFID tags.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- antennaEnabled: The state of the antenna
	*/
	public func setAntennaEnabled(_ antennaEnabled: Bool) throws {
		let result: PhidgetReturnCode
		result = PhidgetRFID_setAntennaEnabled(chandle, (antennaEnabled ? 1 : 0))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	Gets the most recently read tag's data, even if that tag is no longer within read range.

	*   Only valid after at least one tag has been read.

	- returns:
		- tagString: The data stored on the most recently read tag
		- proto: Protocol of the most recently read tag

	- throws:
	An error or type `PhidgetError`
	*/
	public func getLastTag() throws -> (tagString: String, proto: RFIDProtocol) {
		let result: PhidgetReturnCode
		let tagString: UnsafeMutablePointer<CChar> = UnsafeMutablePointer<CChar>.allocate(capacity: 25)
		let tagStringLen: Int = 25
		var proto: PhidgetRFID_Protocol = PROTOCOL_EM4100
		result = PhidgetRFID_getLastTag(chandle, tagString, tagStringLen, &proto)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		let tagStringSwift = String(cString: tagString)
		tagString.deallocate(capacity: 25)
		return (tagString: tagStringSwift, proto: RFIDProtocol(rawValue: proto.rawValue)!)
	}

	/**
	This property is true if a compatibile RFID tag is being read by the reader.

	*   `TagPresent` will remain true until the tag is out of range and can no longer be read.

	- returns:
	Tag is in range

	- throws:
	An error or type `PhidgetError`
	*/
	public func getTagPresent() throws -> Bool {
		let result: PhidgetReturnCode
		var tagPresent: Int32 = 0
		result = PhidgetRFID_getTagPresent(chandle, &tagPresent)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return (tagPresent == 0 ? false : true)
	}

	/**
	Writes data to the tag being currently read by the reader.

	*   You cannot write to a read-only or locked tag.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- tagString: The data to write to the tag
		- proto: The communication protocol to use
		- lockTag: If true, permanently locks the tag so that it cannot be re-written after this write.
	*/
	public func write(tagString: String, proto: RFIDProtocol, lockTag: Bool) throws {
		let result: PhidgetReturnCode
		result = PhidgetRFID_write(chandle, tagString, PhidgetRFID_Protocol(proto.rawValue), (lockTag ? 1 : 0))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	internal override func initializeEvents() {
		initializeBaseEvents()
		PhidgetRFID_setOnTagHandler(chandle, nativeTagHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
		PhidgetRFID_setOnTagLostHandler(chandle, nativeTagLostHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
	}

	internal override func uninitializeEvents() {
		uninitializeBaseEvents()
		PhidgetRFID_setOnTagHandler(chandle, nil, nil)
		PhidgetRFID_setOnTagLostHandler(chandle, nil, nil)
	}

	/**
	Occurs when an RFID tag is read.

	---
	## Parameters:
	*   `tag`: Data from the tag
	*   `proto`: Communication protocol of the tag
	*/
	public let tag = Event<RFID, (tag: String, proto: RFIDProtocol)> ()
	let nativeTagHandler : PhidgetRFID_OnTagCallback = { ch, ctx, tag, proto in
		let me = Unmanaged<RFID>.fromOpaque(ctx!).takeUnretainedValue()
		me.tag.raise(me, (String(cString: tag!), RFIDProtocol(rawValue: proto.rawValue)!));
	}

	/**
	Occurs when an RFID tag that was being read is removed from the read range.

	---
	## Parameters:
	*   `tag`: Data from the lost tag
	*   `proto`: Communication protocol of the lost tag
	*/
	public let tagLost = Event<RFID, (tag: String, proto: RFIDProtocol)> ()
	let nativeTagLostHandler : PhidgetRFID_OnTagLostCallback = { ch, ctx, tag, proto in
		let me = Unmanaged<RFID>.fromOpaque(ctx!).takeUnretainedValue()
		me.tagLost.raise(me, (String(cString: tag!), RFIDProtocol(rawValue: proto.rawValue)!));
	}

}
