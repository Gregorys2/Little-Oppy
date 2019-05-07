import Foundation
import Phidget22_C

/**
The Voltage Output class controls the variable DC voltage output on a Phidget board. This class provides settings for the output voltage as well as various safety controls.
*/
public class VoltageOutputBase : Phidget {

	public init() {
		var h: PhidgetHandle?
		PhidgetVoltageOutput_create(&h)
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
			PhidgetVoltageOutput_delete(&chandle)
		}
	}

	/**
	Enable the output voltage by setting `Enabled` to true.

	*   Disable the output by seting `Enabled` to false to save power.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- enabled: The enabled value
	*/
	public func setEnabled(_ enabled: Bool) throws {
		let result: PhidgetReturnCode
		result = PhidgetVoltageOutput_setEnabled(chandle, (enabled ? 1 : 0))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	Enable the output voltage by setting `Enabled` to true.

	*   Disable the output by seting `Enabled` to false to save power.

	- returns:
	The enabled value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getEnabled() throws -> Bool {
		let result: PhidgetReturnCode
		var enabled: Int32 = 0
		result = PhidgetVoltageOutput_getEnabled(chandle, &enabled)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return (enabled == 0 ? false : true)
	}

	/**
	The voltage value that the channel will output.

	*   The `Voltage` value is bounded by `MinVoltage` and `MaxVoltage`.
	*   The voltage value will not be output until `Enabled` is set to true.

	- returns:
	The voltage value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getVoltage() throws -> Double {
		let result: PhidgetReturnCode
		var voltage: Double = 0
		result = PhidgetVoltageOutput_getVoltage(chandle, &voltage)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return voltage
	}

	/**
	The voltage value that the channel will output.

	*   The `Voltage` value is bounded by `MinVoltage` and `MaxVoltage`.
	*   The voltage value will not be output until `Enabled` is set to true.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- voltage: The voltage value
	*/
	public func setVoltage(_ voltage: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetVoltageOutput_setVoltage(chandle, voltage)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The voltage value that the channel will output.

	*   The `Voltage` value is bounded by `MinVoltage` and `MaxVoltage`.
	*   The voltage value will not be output until `Enabled` is set to true.

	- parameters:
		- voltage: The voltage value
		- completion: Asynchronous completion callback
	*/
	public func setVoltage(_ voltage: Double, completion: @escaping (ErrorCode) -> ()) {
		let callback = AsyncCallback(completion)
		let callbackCtx = Unmanaged.passRetained(callback)
		PhidgetVoltageOutput_setVoltage_async(chandle, voltage, AsyncCallback.nativeAsyncCallback, UnsafeMutableRawPointer(callbackCtx.toOpaque()))
	}

	/**
	The minimum value that `Voltage` can be set to.

	- returns:
	The voltage value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinVoltage() throws -> Double {
		let result: PhidgetReturnCode
		var minVoltage: Double = 0
		result = PhidgetVoltageOutput_getMinVoltage(chandle, &minVoltage)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minVoltage
	}

	/**
	The maximum value that `Voltage` can be set to.

	- returns:
	The voltage value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxVoltage() throws -> Double {
		let result: PhidgetReturnCode
		var maxVoltage: Double = 0
		result = PhidgetVoltageOutput_getMaxVoltage(chandle, &maxVoltage)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxVoltage
	}

	/**
	Choose a `VoltageOutputRange` that best suits your application.

	*   Changing the `VoltageOutputRange` will also affect the `MinVoltage` and `MaxVoltage` values.

	- returns:
	The output range value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getVoltageOutputRange() throws -> VoltageOutputRange {
		let result: PhidgetReturnCode
		var voltageOutputRange: PhidgetVoltageOutput_VoltageOutputRange = VOLTAGE_OUTPUT_RANGE_10V
		result = PhidgetVoltageOutput_getVoltageOutputRange(chandle, &voltageOutputRange)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return VoltageOutputRange(rawValue: voltageOutputRange.rawValue)!
	}

	/**
	Choose a `VoltageOutputRange` that best suits your application.

	*   Changing the `VoltageOutputRange` will also affect the `MinVoltage` and `MaxVoltage` values.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- voltageOutputRange: The output range value
	*/
	public func setVoltageOutputRange(_ voltageOutputRange: VoltageOutputRange) throws {
		let result: PhidgetReturnCode
		result = PhidgetVoltageOutput_setVoltageOutputRange(chandle, PhidgetVoltageOutput_VoltageOutputRange(voltageOutputRange.rawValue))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

}
