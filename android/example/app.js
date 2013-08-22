/*global require,Ti*/
/*
 * A TestFlight SDK implementation for Titanium
 *
 * Copyright (C) 2013 Seth Benjamin
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

(function () {
    'use strict';

    var TestFlight = require('com.animecyc.testflight'),
        mainWindow = Ti.UI.createWindow({
            backgroundColor : 'white'
        });

    TestFlight.setDebugging(true);

    TestFlight.takeOff('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX', {
        options : {
            inAppUpdates : true,     // Enable OTA updates
            flushInterval : 60,      // Time in seconds to flush, can not be set lower than 30
            logonCheckpoint : true,  // Log checkpoints (synchronously)
            logToStderr : true,      // Send remote logs to STDERR
            reportCrashes : true,    // Report crashes
            logOnlyOnCrash : false,  // Logs will only send in the event of a crash
            sessionTimeout : 30      // Time in seconds for a new session to start
        },

        environment : {
            foo : 'bar',
            baz : 'foo'
        }
    });

    mainWindow.addEventListener('open', function () {
        TestFlight.checkpoint("Main Window Opened");
        TestFlight.feedback("Main window works great...");
        TestFlight.log("Application has started successfully.");
    });

    mainWindow.open();
}());