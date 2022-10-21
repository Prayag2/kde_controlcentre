import QtQml 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import org.kde.kirigami 2.15 as Kirigami
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras

import "../components" as Components
import "../js/funcs.js" as Funcs

ColumnLayout {
    id: configCustomActions

    property alias cfg_customActions: customActions.text

    Layout.fillHeight: true
    Layout.fillWidth: true

    Kirigami.FormLayout {
        TextField {
            id: customActions
            Layout.fillWidth: true
            enabled: false
            visible: false
        }

        ColumnLayout {
            id: customActionsConfigColumn

            Component.onCompleted: Funcs.generateCustomActionsConfiguration(plasmoid.configuration.customActions);
        }

        Button {
            Layout.fillWidth: true
            text: "Add new action"
            onClicked: {
                Funcs.addObject();
            }
        }

        Label {
            text: "You should apply and restart your plasmashell to see your changes."
            color: PlasmaCore.Theme.neutralTextColor
        }

        Button {
            id: restartPlasmashellButton
            Layout.fillWidth: true
            text: "Save changes"
            enabled: customActions.text === plasmoid.configuration.customActions
            onClicked: {
                customActions.text = Funcs.saveJSON(customActionsConfigColumn);
            }
        }
    }
    
    function exec(cmd) {
        executable.connectSource(cmd)
    }
    
    PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []

        onNewData: {
            disconnectSource(connectedSources)
        }
    }
}