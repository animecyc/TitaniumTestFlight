# TitaniumTestFight

An implementation of the TestFlight SDK for Titanium.

## Usage

```
var TestFlight = require('com.animecyc.testflight'),
    mainWindow = Ti.UI.createWindow({
        backgroundColor : 'white'
    });

TestFlight.takeOff('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX');

mainWindow.open();
```

## Module Reference

### TestFlight.takeOff(accountToken, options);

Starts the TestFlight service

- accountToken (String):
	- The applications TestFlight application token
- options (Object):
	- An object containing the following:
		- options (Object):
			- inAppUpdates (Boolean)
			- flushInterval (Integer)
			- logonCheckpoint (Boolean)
			- logToStderr (Boolean)
			- reportCrashes (Boolean)
			- logOnlyOnCrash (Boolean)
			- sessionTimeout (Integer)
		- environment (Object)

### TestFlight.checkpoint(checkpointName);

Sends a checkpoint

- checkpointName (String):
	- The name of the checkpoint

### TestFlight.feedback(feedback);

Sends feeback information

- feedback (String):
	- A feedback message

### TestFlight.log(message);

Sends log messages to TestFlight

- message (String):
	- A general log message

### TestFlight.getDebugging();

Returns the current debug status flag

*This method takes no paramters.*

### TestFlight.setDebugging(debug);

Sets the debug status flag

- debug (Boolean):
	- Debugging status flag