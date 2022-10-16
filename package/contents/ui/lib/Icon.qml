import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import org.kde.plasma.core 2.0 as PlasmaCore

Rectangle {
    radius: width/2
    color: PlasmaCore.Theme.highlightColor
    property alias source: icon.source

    PlasmaCore.IconItem {
        id: icon
        anchors.fill: parent
        anchors.margins: root.smallSpacing //
        anchors.centerIn: parent
    }
    ColorOverlay {
        source: icon
        anchors.fill: icon
        color: PlasmaCore.Theme.highlightedTextColor
    }
}
