function getBtDevice() {
    var connectedDevices = [];

    for (var i = 0; i < btManager.devices.length; ++i) {
        var device = btManager.devices[i];
        if (device.connected) {
            connectedDevices.push(device);
        }
    }

    if (btManager.bluetoothBlocked) {
        return i18n("Disabled");
    } else if (!btManager.bluetoothOperational) {
        if (!btManager.adapters.length) {
            return i18n("Unavailable");
        } else {
            return i18n("Offline");
        }
    } else if (connectedDevices.length >= 1) {
        return i18n(connectedDevices[0].name)
    } else {
        return i18n("Not Connected");
    }
}

function toggleBluetooth()
{
    var enable = !btManager.bluetoothOperational;
    btManager.bluetoothBlocked = !enable;

    for (var i = 0; i < btManager.adapters.length; ++i) {
        var adapter = btManager.adapters[i];
        adapter.powered = enable;
    }
}

function checkInhibition() {
    var inhibited = false;

    if (!NotificationManager.Server.valid) {
        return false;
    }
    console.log("pass")
    var inhibitedUntil = notificationSettings.notificationsInhibitedUntil;
    if (!isNaN(inhibitedUntil.getTime())) {
        inhibited |= (Date.now() < inhibitedUntil.getTime());
    }

    if (notificationSettings.notificationsInhibitedByApplication) {
        inhibited |= true;
    }

    if (notificationSettings.inhibitNotificationsWhenScreensMirrored) {
        inhibited |= notificationSettings.screensMirrored;
    }
    return inhibited;
}

function toggleDoNotDisturb() {
    if (Funcs.checkInhibition()) {
        notificationSettings.notificationsInhibitedUntil = undefined;
        notificationSettings.revokeApplicationInhibitions();

        // overrules current mirrored screen setup, updates again when screen configuration
        notificationSettings.screensMirrored = false;
        notificationSettings.save();

        return;
    }

    var d = new Date();
    d.setYear(d.getFullYear()+1)

    notificationSettings.notificationsInhibitedUntil = d
    notificationSettings.save()
}

