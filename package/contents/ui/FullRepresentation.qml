import QtQuick 2.0
import QtQuick.Layouts 1.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import "lib" as Lib

Item {
    id: fullRep

    // PROPERTIES
    Layout.preferredWidth: root.fullRepWidth
    Layout.preferredHeight: wrapper.implicitHeight
    Layout.minimumWidth: Layout.preferredWidth
    Layout.minimumHeight: Layout.preferredHeight
    clip: true

    ColumnLayout {
        id: wrapper

        width: root.fullRepWidth
        height: root.fullRepHeight
        spacing: 0

        GridLayout {
            id: sectionA

            rowSpacing: 0
            columnSpacing: 0
            columns: 4
            rows: 2
            Layout.preferredWidth: wrapper.width

            Lib.Card {
                Layout.columnSpan: 2
                Layout.rowSpan: 2
                Layout.preferredWidth: parent.width/2
                Layout.preferredHeight: sectionButtons.implicitHeight + margins.top*2 + margins.bottom*2

                ColumnLayout {
                    id: sectionButtons
                    anchors.fill: parent
                    anchors.bottomMargin: root.gridMargin
                    anchors.topMargin: root.gridMargin
                    spacing: 0

                    Lib.DeRect {
                        border.color: "yellow"
                    }

                    Lib.LongButton {
                        title: "Wi-Fi"
                        subtitle: "Bharat Jain_5GHz"
                        source: "network-wireless"
                    }
                    Lib.LongButton {
                        title: "Bluetooth"
                        subtitle: "Off"
                        source: "network-bluetooth"
                    }
                    Lib.LongButton {
                        title: "Clipboard"
                        subtitle: "some text"
                        source: "klipper"
                    }
                }
            }
            Lib.CardButton {
                Layout.columnSpan: 2
                Layout.preferredWidth: parent.width/2
                Layout.preferredHeight: parent.height/2
                title: "Do Not Disturb"
                onClicked: {
                    console.log("Clicked!!!")
                }

                Lib.Icon {
                    anchors.fill: parent
                    source: "notifications-disabled"
                }
            }
            Lib.CardButton {
                Layout.preferredWidth: parent.width/4
                Layout.preferredHeight: parent.height/2
                title: "KDE Connect"
                PlasmaCore.IconItem {
                    anchors.fill: parent
                    source: "kdeconnect-tray"
                }
            }
            Lib.CardButton {
                Layout.preferredWidth: parent.width/4
                Layout.preferredHeight: parent.height/2
                title: "Night Color Control"
                PlasmaCore.IconItem {
                    anchors.fill: parent
                    source: "redshift-status-off"
                }
            }
        }
        ColumnLayout {
            id: sectionB

            spacing: 0
            Layout.preferredWidth: wrapper.width

            Lib.Slider {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: sectionA.height/2
                title: "Sound"
                source: "audio-volume-high"
            }
            Lib.Slider {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: sectionA.height/2
                title: "Brightness"
                source: "brightness-high"
            }
            MediaPlayer{}
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
