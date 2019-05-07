import Foundation
import Phidget22_C

/**
The hub class allows you to control power to VINT hub ports.
*/
public class HubBase : Phidget {

	public init() {
		var h: PhidgetHandle?
		PhidgetHub_create(&h)
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
			PhidgetHub_delete(&chandle)
		}
	}

	/**
	Controls power to the VINT Hub Ports

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- port: The Hub port
		- state: The power state
	*/
	public func setPortPower(port: Int, state: Bool) throws {
		let result: PhidgetReturnCode
		result = PhidgetHub_setPortPower(chandle, Int32(port), (state ? 1 : 0))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

}
