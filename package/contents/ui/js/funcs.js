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

function getVolumeIconName(volume, muted) {
    var icon = null;
    const percent = volumePercent(volume);

    if (percent <= 0 || muted) {
        icon = prefix + "-muted";
    } else if (percent <= 25) {
        icon = prefix + "-low";
    } else if (percent <= 75) {
        icon = prefix + "-medium";
    } else if (percent <= highUpperBound) {
        icon = prefix + "-high";
    } else if (percent <= veryHighUpperBound) {
        icon = `-high-warning`;
    } else {
        icon = `-high-danger`;
    }

    return "audio-volume" + icon;
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

function volumePercent(volume) {
    return volume / Vol.PulseAudio.NormalVolume * 100
}

function boundVolume(volume) {
    return Math.max(Vol.PulseAudio.MinimalVolume, Math.min(volume, Vol.PulseAudio.NormalVolume));
}

function changeVolumeByPercent(volumeObject, deltaPercent) {
    const oldVolume = volumeObject.volume;
    const oldPercent = volumePercent(oldVolume);
    const targetPercent = oldPercent + deltaPercent;
    const newVolume = boundVolume(Math.round(Vol.PulseAudio.NormalVolume * (targetPercent/100)));
    const newPercent = volumePercent(newVolume);
    volumeObject.muted = newPercent == 0;
    volumeObject.volume = newVolume;
    return newPercent;
}

