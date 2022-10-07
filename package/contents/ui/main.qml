import QtQuick 2.0
import QtQuick.Controls 2.15
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.1 as PlasmaCore

import "brightness.js" as BrightnessJS



Item {
    id: root
    
    property string currentPage: "fullRep"
    clip: true

    // PROPERTIES
    property bool enableTransparency: plasmoid.configuration.transparency
    property var animationDuration: PlasmaCore.Units.veryShortDuration

    property var scale: plasmoid.configuration.scale * PlasmaCore.Units.devicePixelRatio / 100
    property int fullRepWidth: 300 * scale
    property int fullRepHeight: 300 * scale

    property int largeSpacing: 10 * scale
    property int mediumSpacing: 7 * scale
    property int smallSpacing: 5 * scale

    property int buttonMargin: 4 * scale
    property int buttonHeight: 40 * scale

    property int largeFontSize: 12 * scale
    property int mediumFontSize: 10 * scale
    property int smallFontSize: 6 * scale

    // Screen brightness properties 
    property int screenBrightness
    property QtObject updateScreenBrightnessJob
    property bool disableBrightnessUpdate: true


    property QtObject pmSource: PlasmaCore.DataSource {
        id: pmSource
        engine: "powermanagement"
        connectedSources: sources
        onSourceAdded: {
            disconnectSource(source);
            connectSource(source);
        }
        onSourceRemoved: {
            disconnectSource(source);
        }
        onDataChanged: {
            BrightnessJS.updateBrightness(root, pmSource);
        }
    }

        onScreenBrightnessChanged: {
        if (disableBrightnessUpdate) {
            return;
        }
        const service = pmSource.serviceForSource("PowerDevil");
        const operation = service.operationDescription("setBrightness");
        operation.brightness = screenBrightness;
        updateScreenBrightnessJob = service.startOperationCall(operation);
        updateScreenBrightnessJob.finished.connect(job => {
            BrightnessJS.updateBrightness(root, pmSource);
        });
    }


    readonly property bool isBrightnessAvailable: pmSource.data["PowerDevil"] && pmSource.data["PowerDevil"]["Screen Brightness Available"] ? true : false
    readonly property int maximumScreenBrightness: pmSource.data["PowerDevil"] ? pmSource.data["PowerDevil"]["Maximum Screen Brightness"] || 0 : 0

    Plasmoid.fullRepresentation: FullRepresentation {}
    //Plasmoid.compactRepresentation: CompactRepresentation {}
}
