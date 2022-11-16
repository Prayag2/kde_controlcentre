import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import org.kde.plasma.core 2.0 as PlasmaCore

Item
{
    property alias sourceColor:rect.color
    property alias source: icon.source

    Rectangle {
        id: rect
        radius: width/2
        color: PlasmaCore.Theme.highlightColor
        anchors.fill: parent
        

        PlasmaCore.IconItem {
            id: icon
            anchors.fill: parent
            anchors.margins: root.smallSpacing
            anchors.centerIn: parent
            status: PlasmaCore.IconItem.Selected
        }
    }
}
