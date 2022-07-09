// Qt/QML
import QtQuick 2.0
import QtQuick.Layouts 1.15

// Plasma
import org.kde.plasma.plasmoid 2.0

Item {
    id: card
    Layout.fillWidth: true
    Layout.fillHeight: true
    clip: true
    property int radius: plasmoid.configuration.border_radius
    property var bgOpacity: 0.2

    Rectangle {
        id: rect
        anchors.fill: parent
        color: root.cardColor
        radius: card.radius
        opacity: card.bgOpacity
    }
}
