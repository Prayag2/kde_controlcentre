import QtQml 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.0

// Doing so many private imports can break the applet very easily but I have no choice.
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.private.bluetooth 1.0 as PlasmaBt
import org.kde.bluezqt 1.0 as BluezQt
import org.kde.kquickcontrolsaddons 2.0
import org.kde.notificationmanager 1.0 as NotificationManager
import org.kde.kdeconnect 1.0 as KdeConnect
import org.kde.plasma.private.nightcolorcontrol 1.0 as Redshift
import org.kde.plasma.private.volume 0.1 as Vol

import "lib" as Lib
import "components" as Components
import "funcs.js" as Funcs 


Item {
    id: fullRep
    
    // NETWORK
    property var network: network

    Network {
        id: network
    }
    
    // BLUETOOTH
    property QtObject btManager : BluezQt.Manager
    
    // NOTIFICATION MANAGER
    property var notificationSettings: notificationSettings
    NotificationManager.Settings {
        id: notificationSettings
    }
    
    // NIGHT COLOUR CONTROL
    property var monitor: redMonitor
    property var inhibitor: inhibitor
    Redshift.Monitor {
        id: redMonitor
    }
    Redshift.Inhibitor {
        id: inhibitor
    }
    
    // VOL
    readonly property Vol.SinkModel paSinkModel: Vol.SinkModel {
        id: paSinkModel
    }
    
    // PROPERTIES
    Layout.preferredWidth: root.fullRepWidth
    Layout.preferredHeight: wrapper.implicitHeight
    Layout.minimumWidth: Layout.preferredWidth
    Layout.maximumWidth: Layout.preferredWidth
    Layout.minimumHeight: Layout.preferredHeight
    Layout.maximumHeight: Layout.preferredHeight
    property var scale: root.scale
    clip: true
    
    
     function toggleNetworkSection() {
        if(!sectionNetworks.visible) {
            // sectionButtons.visible = false
            sectionNetworks.visible = true
        } else {
            // sectionButtons.visible = true
            sectionNetworks.visible = false
        }
    }
    
    Component.onCompleted: {
        wrapper.visible = true
        message.visible = false
    }
    onScaleChanged: {
        wrapper.visible = false
        message.visible = true
    }
    
    Item {
        id: message
        anchors.fill: parent
        visible: false
        
        PlasmaComponents.Label {
            anchors.centerIn: parent
            anchors.fill: parent
            text: "The scale was changed. Please reload plasmashell or log-out and log-in again."
            font.pixelSize: root.mediumFontSize
            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignVCenter
        }
    }
    
    Lib.Card {
        id: sectionNetworks
        height: wrapper.height
        width: wrapper.width
        z: 999
        visible: false
        
        
        Item {
            anchors.fill: parent
            anchors.margins: root.smallSpacing
            clip: true
            
            ListView {
                anchors.fill: parent
                ScrollBar.vertical: ScrollBar {}
                
                
                model: fullRep.network.appletProxyModel
                delegate: ConnectionItem {
                    width: parent.width
                    height: root.buttonHeight
                }
                header: ColumnLayout {
                    width: parent.width
                    RowLayout{
                        height: implicitHeight + root.smallSpacing
                        PlasmaComponents.ToolButton {
                            Layout.preferredHeight: root.largeFontSize*2.5
                            iconSource: "arrow-left"
                            
                            onClicked: {
                                fullRep.toggleNetworkSection()
                            }
                        }
                        PlasmaComponents.Label {
                            text: i18n("Network Connections")
                            font.pixelSize: root.largeFontSize * 1.2
                            Layout.fillWidth: true
                        }
                    }
                    PlasmaCore.SvgItem {
                        id: separatorLine
                        elementId: "horizontal-line"
                        Layout.fillWidth: true
                        Layout.preferredHeight: root.scale
                        svg: PlasmaCore.Svg {
                            imagePath: "widgets/line"
                        }
                    }
                    Rectangle {
                        height: root.smallSpacing
                    }
                }
            }
        }
    }
    ColumnLayout {
        id: wrapper

        anchors.fill: parent
        spacing: 0

        GridLayout {
            id: sectionA

            rowSpacing: 0
            columnSpacing: 0
            columns: 4
            rows: 2
            Layout.preferredWidth: wrapper.width
            
            Lib.Card {
                id: sectionButtons
                Layout.columnSpan: 2
                Layout.rowSpan: 2
                Layout.preferredWidth: parent.width/2
                Layout.alignment: Qt.AlignTop
                Layout.preferredHeight: buttonsColumn.implicitHeight + margins.top*2*root.scale + margins.bottom*2*root.scale
                // Layout.preferredHeight: root.buttonHeight+root.smallSpacing*2+root.buttonMargin*2
                // Layout.preferredHeight: root.buttonHeight*3 + margins.top*2*root.scale + margins.bottom*2*root.scale
                // Layout.preferredHeight: wrapper.height/2
                
                ColumnLayout {
                    id: buttonsColumn
                    anchors.fill: parent
                    anchors.bottomMargin: root.smallSpacing
                    anchors.topMargin: root.smallSpacing
                    spacing: 0
                    
                    Lib.LongButton {
                        title: i18n("Network")
                        subtitle: fullRep.network.networkStatus
                        source: fullRep.network.activeConnectionIcon
                        // visible: false
                        onClicked: {
                            fullRep.toggleNetworkSection()
                        }
                    }
                    Lib.LongButton {
                        title: i18n("Bluetooth")
                        subtitle: Funcs.getBtDevice()
                        source: "network-bluetooth"
                        
                        onClicked: {
                            Funcs.toggleBluetooth()
                        }
                    }
                    Lib.LongButton {
                        title: i18n("Settings")
                        subtitle: i18n("System Settings")
                        source: "settings-configure"
                        onClicked: {
                            KCMShell.openSystemSettings("")
                        }
                    }
                }
            }
            Lib.CardButton {
                Layout.columnSpan: 2
                Layout.preferredWidth: parent.width/2
                // Layout.preferredHeight: wrapper.height/4
                Layout.preferredHeight: parent.height/2
                title: i18n("Do Not Disturb")
                Component.onCompleted: updateIcon()
                
                onClicked: {
                    var d= new Date();
                    d.setYear(d.getFullYear()+1)
                    
                    // Checking if do not disturb is already enabled 
                    if (Funcs.checkInhibition()) {
                        Funcs.revokeInhibitions()
                    } else {
                        fullRep.notificationSettings.notificationsInhibitedUntil = d
                        fullRep.notificationSettings.save()
                    }
                    updateIcon()
                }
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
            Lib.CardButton {
                Layout.preferredWidth: parent.width/4
                // Layout.preferredHeight: wrapper.height/4
                Layout.preferredHeight: parent.height/2
                title: i18n("KDE Connect")
                PlasmaCore.IconItem {
                    anchors.fill: parent
                    source: "kdeconnect-tray"
                }
                onClicked: KdeConnect.OpenConfig.openConfiguration();
                visible: !Plasmoid.configuration.hideKdeConnect
            }
            Lib.CardButton {
                Layout.preferredWidth: Plasmoid.configuration.hideKdeConnect ? parent.width/2 : parent.width/4
                // Layout.preferredHeight: wrapper.height/4
                Layout.preferredHeight: parent.height/2
                title: i18n("Night Color")
                PlasmaCore.IconItem {
                    anchors.fill: parent
                    source: monitor.running ? "redshift-status-on" : "redshift-status-off"
                }
                onClicked: {
                    Funcs.toggleRedshiftInhibition();
                }
                visible: !Plasmoid.configuration.showColorSwitcher
            }
            Components.ColorSchemeSwitcher {
                visible: Plasmoid.configuration.showColorSwitcher
            }
        }
        ColumnLayout {
            id: sectionB

            spacing: 0
            Layout.preferredWidth: wrapper.width

            Lib.Slider {
                Layout.preferredWidth: parent.width
                // Layout.preferredHeight: wrapper.height/4
                Layout.preferredHeight: sectionA.height/2
                property var sink: fullRep.paSinkModel.preferredSink
                title: i18n("Volume")
                value: (sink.volume / Vol.PulseAudio.NormalVolume * 100)
                source: sink && !(sink && sink.name == "auto_null") ? Funcs.volIconName(sink.volume, sink.muted) : "player-volume-muted"
                onMoved: {
                    sink.volume = value * Vol.PulseAudio.NormalVolume / 100
                }
            }
            BrightnessSlider{}
            MediaPlayer{}
        }
        Item {
            Layout.fillHeight: true
        }
    }
}
