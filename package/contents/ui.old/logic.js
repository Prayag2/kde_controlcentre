function init() {
    btManager.deviceAdded.connect(updateStatus);
    btManager.deviceRemoved.connect(updateStatus);
    btManager.deviceChanged.connect(updateStatus);
    btManager.bluetoothBlockedChanged.connect(updateStatus);
    btManager.bluetoothOperationalChanged.connect(updateStatus);

    updateStatus();
}

function updateStatus() {
    var connectedDevices = []

    for (var i = 0; i < btManager.devices.length; i++) {
        var device = btManager.devices[i]
        if (device.connected) {
            connectedDevices.push(device)
        }
    }
    console.log("************************************\n", JSON.stringify(device))
    return connectedDevices.length ? true : false
}
