import QtQml 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import "lib" as Lib
Lib.Slider {
    // FIXME: Need Help! I don't have a monitor that supports changing brightness from the PC itself.
    // Need someone to test this!
    visible: false
    Layout.preferredWidth: parent.width
    Layout.preferredHeight: wrapper.height/4
    title: "Brightness"
    source: "brightness-high"
    
    // PlasmaCore.DataSource {
    //     id: powerSource
    //     engine: "powermanagement"
    //     connectedSources: ["PowerDevil"]
    //     onDataChanged: {
    //         var powerData = data["PowerDevil"]
    //         console.log(powerData)
    //     }
    // }
}