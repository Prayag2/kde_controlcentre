import QtQml 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.0

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.components 2.0 as PlasmaComponents

import "lib" as Lib
import "components" as Components
import "js/funcs.js" as Funcs 


Item {
    id: fullRep
    
    // PROPERTIES
    Layout.preferredWidth: root.fullRepWidth
    Layout.preferredHeight: wrapper.implicitHeight
    Layout.minimumWidth: Layout.preferredWidth
    Layout.maximumWidth: Layout.preferredWidth
    Layout.minimumHeight: Layout.preferredHeight
    Layout.maximumHeight: Layout.preferredHeight
    clip: true
    
    // Lists all available network connections
    Components.SectionNetworks{
        id: sectionNetworks
    }

    // Main wrapper
    ColumnLayout {
        id: wrapper

        anchors.fill: parent
        spacing: 0

        RowLayout {
            id: sectionA

            spacing: 0
            Layout.fillWidth: true
            Layout.preferredHeight: root.sectionHeight
            Layout.maximumHeight: root.sectionHeight
            
            // Network, Bluetooth and Settings Button
            Components.SectionButtons{}
            
            // Quick Toggle Buttons
            ColumnLayout {
                spacing: 0
                
                Components.DndButton{}
                RowLayout {
                    spacing: 0
                    
                    // Two blocks for custom commands
                    Components.CommandRun{
                        visible: root.showCmd1
                        title: root.cmdTitle1
                        icon: root.cmdIcon1
                        command: root.cmdRun1
                    }
                    Components.CommandRun{
                        visible: root.showCmd2
                        title: root.cmdTitle2
                        icon: root.cmdIcon2
                        command: root.cmdRun2
                    }
                    
                    // Other blocks
                    Components.KDEConnect{}
                    Components.RedShift{}
                    Components.ColorSchemeSwitcher{}
                }
            }
        }
        Item {
            Layout.fillHeight: true
        }
        ColumnLayout {
            id: sectionB

            spacing: 0
            Layout.fillWidth: true

            Components.Volume{}
            Components.BrightnessSlider{}
            Components.MediaPlayer{}
        }
        

    }
}
