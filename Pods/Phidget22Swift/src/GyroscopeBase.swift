import Foundation
import Phidget22_C

/**
The Gyroscope class reports rotational data from the Phidget containing a gyroscope chip for use in your code. Phidget gyroscopes usually have multiple sensors, each oriented in a different axis, so multiple dimensions of heading can be recorded.

If the Phidget you're using also has an accelerometer and a magnetometer, you may want to use the Spatial classin order to get all of the data at the same time, in a single event.
*/
public class GyroscopeBase : Phidget {

	public init() {
		var h: PhidgetHandle?
		PhidgetGyroscope_create(&h)
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
			PhidgetGyroscope_delete(&chandle)
		}
	}

	/**
	The most recent angular rate value that the channel has reported.

	*   This value will always be between `MinAngularRate` and `MaxAngularRate`.

	- returns:
	The last reported angular rate

	- throws:
	An error or type `PhidgetError`
	*/
	public func getAngularRate() throws -> [Double] {
		let result: PhidgetReturnCode
		var angularRate: (Double, Double, Double) = (0, 0, 0)
		result = PhidgetGyroscope_getAngularRate(chandle, &angularRate)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return [Double](UnsafeBufferPointer(start: &angularRate.0, count: 3))
	}

	/**
	The minimum value the `AngularRateUpdate` event will report.

	- returns:
	The angular rate values

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinAngularRate() throws -> [Double] {
		let result: PhidgetReturnCode
		var minAngularRate: (Double, Double, Double) = (0, 0, 0)
		result = PhidgetGyroscope_getMinAngularRate(chandle, &minAngularRate)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return [Double](UnsafeBufferPointer(start: &minAngularRate.0, count: 3))
	}

	/**
	The maximum value the `AngularRateUpdate` event will report.

	- returns:
	The angular rate values

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxAngularRate() throws -> [Double] {
		let result: PhidgetReturnCode
		var maxAngularRate: (Double, Double, Double) = (0, 0, 0)
		result = PhidgetGyroscope_getMaxAngularRate(chandle, &maxAngularRate)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return [Double](UnsafeBufferPointer(start: &maxAngularRate.0, count: 3))
	}

	/**
	The number of axes the channel can measure angular rate on.

	*   See your device's User Guide for more information about the number of axes and their orientation.

	- returns:
	Axis count value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getAxisCount() throws -> Int {
		let result: PhidgetReturnCode
		var axisCount: Int32 = 0
		result = PhidgetGyroscope_getAxisCount(chandle, &axisCount)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return Int(axisCount)
	}

	/**
	The `DataInterval` is the time that must elapse before the channel will fire another `AngularRateUpdate` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var dataInterval: UInt32 = 0
		result = PhidgetGyroscope_getDataInterval(chandle, &dataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return dataInterval
	}

	/**
	The `DataInterval` is the time that must elapse before the channel will fire another `AngularRateUpdate` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- dataInterval: The data interval value
	*/
	public func setDataInterval(_ dataInterval: UInt32) throws {
		let result: PhidgetReturnCode
		result = PhidgetGyroscope_setDataInterval(chandle, dataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `DataInterval` can be set to.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var minDataInterval: UInt32 = 0
		result = PhidgetGyroscope_getMinDataInterval(chandle, &minDataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minDataInterval
	}

	/**
	The maximum value that `DataInterval` can be set to.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var maxDataInterval: UInt32 = 0
		result = PhidgetGyroscope_getMaxDataInterval(chandle, &maxDataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxDataInterval
	}

	/**
	The most recent timestamp value that the channel has reported. This is an extremely accurate time measurement streamed from the device.

	*   If your application requires a time measurement, you should use this value over a local software timestamp.

	- returns:
	The timestamp value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getTimestamp() throws -> Double {
		let result: PhidgetReturnCode
		var timestamp: Double = 0
		result = PhidgetGyroscope_getTimestamp(chandle, &timestamp)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return timestamp
	}

	/**
	Re-zeros the gyroscope in 1-2 seconds.

	*   The device must be stationary when zeroing.
	*   The angular rate will be reported as 0.0°/s while zeroing.
	*   Zeroing the gyroscope is a method of compensating for the drift that is inherent to all gyroscopes. See your device's User Guide for more information on dealing with drift.

	- throws:
	An error or type `PhidgetError`
	*/
	public func zero() throws {
		let result: PhidgetReturnCode
		result = PhidgetGyroscope_zero(chandle)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	internal override func initializeEvents() {
		initializeBaseEvents()
		PhidgetGyroscope_setOnAngularRateUpdateHandler(chandle, nativeAngularRateUpdateHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
	}

	internal override func uninitializeEvents() {
		uninitializeBaseEvents()
		PhidgetGyroscope_setOnAngularRateUpdateHandler(chandle, nil, nil)
	}

	/**
	The most recent angular rate and timestamp values the channel has measured will be reported in this event, which occurs when the `DataInterval` has elapsed.

	---
	## Parameters:
	*   `angularRate`: The angular rate values
	*   `timestamp`: The timestamp value
	*/
	public let angularRateUpdate = Event<Gyroscope, (angularRate: [Double], timestamp: Double)> ()
	let nativeAngularRateUpdateHandler : PhidgetGyroscope_OnAngularRateUpdateCallback = { ch, ctx, angularRate, timestamp in
		let me = Unmanaged<Gyroscope>.fromOpaque(ctx!).takeUnretainedValue()
		me.angularRateUpdate.raise(me, ([Double](UnsafeBufferPointer(start: angularRate!, count: 3)), timestamp));
	}

}
