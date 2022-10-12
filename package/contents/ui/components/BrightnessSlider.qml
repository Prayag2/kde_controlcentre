import QtQml 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import "../lib" as Lib
import "../js/brightness.js" as BrightnessJS


Lib.Slider {
    id: brightnessControl
    
    // Should be visible ONLY if the monitor supports it
    visible: isBrightnessAvailable && root.showBrightness
    
    // Dimensions
    Layout.fillWidth: true
    Layout.preferredHeight: root.sectionHeight/2
    
    // Slider properties
    title: "Display Brightness"
    source: "brightness-high"
    secondaryTitle: Math.round((screenBrightness / maximumScreenBrightness)*100) + "%"
    
    from: 0
    to: maximumScreenBrightness
    value: screenBrightness
    
    // Other properties
    property int screenBrightness
    property QtObject updateScreenBrightnessJob
    property bool disableBrightnessUpdate: true

    // Power Management Data Source
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
            BrightnessJS.updateBrightness(brightnessControl, pmSource);
        }
    }

    readonly property bool isBrightnessAvailable: pmSource.data["PowerDevil"] && pmSource.data["PowerDevil"]["Screen Brightness Available"] ? true : false
    readonly property int maximumScreenBrightness: pmSource.data["PowerDevil"] ? pmSource.data["PowerDevil"]["Maximum Screen Brightness"] || 0 : 0


    onScreenBrightnessChanged: {
        if (disableBrightnessUpdate) {
            return;
        }
        const service = pmSource.serviceForSource("PowerDevil");
        const operation = service.operationDescription("setBrightness");
        operation.brightness = screenBrightness;
        updateScreenBrightnessJob = service.startOperationCall(operation);
        updateScreenBrightnessJob.finished.connect(job => {
            BrightnessJS.updateBrightness(brightnessControl, pmSource);
        });
    }
    
    onMoved: {
        screenBrightness = value
    }
}
