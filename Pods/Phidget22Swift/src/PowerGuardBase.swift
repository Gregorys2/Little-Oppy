import Foundation
import Phidget22_C

/**
The Power Guard class controls the safety features and thresholds of a programmable power guard Phidget board.
*/
public class PowerGuardBase : Phidget {

	public init() {
		var h: PhidgetHandle?
		PhidgetPowerGuard_create(&h)
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
			PhidgetPowerGuard_delete(&chandle)
		}
	}

	/**
	The `FanMode` dictates the operating condition of the fan.

	*   Choose between on, off, or automatic (based on temperature).
	*   If the `FanMode` is set to automatic, the fan will turn on when the temperature reaches 70°C and it will remain on until the temperature falls below 55°C.
	*   If the `FanMode` is off, the device will still turn on the fan if the temperature reaches 85°C and it will remain on until it falls below 70°C.

	- returns:
	The fan mode value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getFanMode() throws -> FanMode {
		let result: PhidgetReturnCode
		var fanMode: Phidget_FanMode = FAN_MODE_OFF
		result = PhidgetPowerGuard_getFanMode(chandle, &fanMode)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return FanMode(rawValue: fanMode.rawValue)!
	}

	/**
	The `FanMode` dictates the operating condition of the fan.

	*   Choose between on, off, or automatic (based on temperature).
	*   If the `FanMode` is set to automatic, the fan will turn on when the temperature reaches 70°C and it will remain on until the temperature falls below 55°C.
	*   If the `FanMode` is off, the device will still turn on the fan if the temperature reaches 85°C and it will remain on until it falls below 70°C.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- fanMode: The fan mode value
	*/
	public func setFanMode(_ fanMode: FanMode) throws {
		let result: PhidgetReturnCode
		result = PhidgetPowerGuard_setFanMode(chandle, Phidget_FanMode(fanMode.rawValue))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The device constantly monitors the output voltage, and if it exceeds the `OverVoltage` value, it will disconnect the input from the output.

	*   This functionality is critical for protecting power supplies from regenerated voltage coming from motors. Many power supplies assume that a higher than output expected voltage is related to an internal failure to the power supply, and will permanently disable themselves to protect the system. A typical safe value is to set OverVoltage to 1-2 volts higher than the output voltage of the supply. For instance, a 12V supply would be protected by setting OverVoltage to 13V.
	*   The device will connect the input to the output again when the voltage drops to (`OverVoltage` \- 1V)

	- returns:
	The voltage value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getOverVoltage() throws -> Double {
		let result: PhidgetReturnCode
		var overVoltage: Double = 0
		result = PhidgetPowerGuard_getOverVoltage(chandle, &overVoltage)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return overVoltage
	}

	/**
	The device constantly monitors the output voltage, and if it exceeds the `OverVoltage` value, it will disconnect the input from the output.

	*   This functionality is critical for protecting power supplies from regenerated voltage coming from motors. Many power supplies assume that a higher than output expected voltage is related to an internal failure to the power supply, and will permanently disable themselves to protect the system. A typical safe value is to set OverVoltage to 1-2 volts higher than the output voltage of the supply. For instance, a 12V supply would be protected by setting OverVoltage to 13V.
	*   The device will connect the input to the output again when the voltage drops to (`OverVoltage` \- 1V)

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- overVoltage: The voltage value
	*/
	public func setOverVoltage(_ overVoltage: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetPowerGuard_setOverVoltage(chandle, overVoltage)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `OverVoltage` can be set to.

	- returns:
	The voltage value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinOverVoltage() throws -> Double {
		let result: PhidgetReturnCode
		var minOverVoltage: Double = 0
		result = PhidgetPowerGuard_getMinOverVoltage(chandle, &minOverVoltage)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minOverVoltage
	}

	/**
	The maximum value that `OverVoltage` can be set to.

	- returns:
	The voltage value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxOverVoltage() throws -> Double {
		let result: PhidgetReturnCode
		var maxOverVoltage: Double = 0
		result = PhidgetPowerGuard_getMaxOverVoltage(chandle, &maxOverVoltage)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxOverVoltage
	}

	/**
	When `PowerEnabled` is true, the device will connect the input to the output and begin monitoring.

	*   The output voltage is constantly monitored and will be automatically disconnected from the input when the output exceeds the `OverVoltage` value.
	*   `PowerEnabled` allows the device to operate as a Solid State Relay, powering on or off all devices connected to the output.

	- returns:
	The power enabled value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getPowerEnabled() throws -> Bool {
		let result: PhidgetReturnCode
		var powerEnabled: Int32 = 0
		result = PhidgetPowerGuard_getPowerEnabled(chandle, &powerEnabled)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return (powerEnabled == 0 ? false : true)
	}

	/**
	When `PowerEnabled` is true, the device will connect the input to the output and begin monitoring.

	*   The output voltage is constantly monitored and will be automatically disconnected from the input when the output exceeds the `OverVoltage` value.
	*   `PowerEnabled` allows the device to operate as a Solid State Relay, powering on or off all devices connected to the output.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- powerEnabled: The power enabled value.
	*/
	public func setPowerEnabled(_ powerEnabled: Bool) throws {
		let result: PhidgetReturnCode
		result = PhidgetPowerGuard_setPowerEnabled(chandle, (powerEnabled ? 1 : 0))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

}
