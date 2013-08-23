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
            sessionTimeout : 30      // Time in seconds for a new session to start
        }
    });

    mainWindow.addEventListener('open', function () {
        TestFlight.checkpoint("Main Window Opened");
        TestFlight.feedback("Main window works great...");
        TestFlight.log("Application has started successfully.");
    });

    mainWindow.open();
}());