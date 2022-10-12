import QtQml 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../lib" as Lib
import "../js/funcs.js" as Funcs
import org.kde.notificationmanager 1.0 as NotificationManager

Lib.CardButton {
    visible: root.showDnd
    Layout.columnSpan: 2
    Layout.fillWidth: true
    Layout.fillHeight: true
    title: i18n("Do Not Disturb")
    
    Component.onCompleted: updateIcon()
    
    // NOTIFICATION MANAGER
    property var notificationSettings: notificationSettings
    NotificationManager.Settings {
        id: notificationSettings
    }
    
    // Enables "Do Not Disturb" on click
    onClicked: {
        var d= new Date();
        d.setYear(d.getFullYear()+1)
        
        // Checking if do not disturb is already enabled 
        if (Funcs.checkInhibition()) {
            Funcs.revokeInhibitions()
        } else {
            notificationSettings.notificationsInhibitedUntil = d
            notificationSettings.save()
        }
        updateIcon()
    }
    
    // Updates icon
    function updateIcon() {
        if (Funcs.checkInhibition()) {
            dndIcon.source = "notifications-disabled"
        } else {
            dndIcon.source = "notifications"
        }
    }
    
    Lib.Icon {
        id: dndIcon
        anchors.fill: parent
    }
}