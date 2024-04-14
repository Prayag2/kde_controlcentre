import QtQml
import QtQuick
import QtQuick.Layouts
import "../lib" as Lib
import "../js/funcs.js" as Funcs
import org.kde.notificationmanager as NotificationManager

Lib.CardButton {
    visible: root.showDnd
    Layout.columnSpan: 2
    Layout.fillWidth: true
    Layout.fillHeight: true
    title: i18n("Do Not Disturb")

    // NOTIFICATION MANAGER
    property var notificationSettings: notificationSettings

    // Enables "Do Not Disturb" on click
    onClicked: {
        Funcs.toggleDoNotDisturb();
    }

    Lib.Icon {
        id: icon
        source: {
            return (Funcs.checkInhibition() ? "notifications-disabled" : "notifications");
        }
        anchors.fill: parent
    }

    // Components //

    NotificationManager.Settings {
        id: notificationSettings
    }
}
