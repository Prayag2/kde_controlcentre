import QtQml 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.0

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

import "../lib" as Lib


Lib.CardButton {
    id: colorSchemeSwitcher

    visible: root.showColorSwitcher
    Layout.fillHeight: true
    Layout.fillWidth: true
    title: i18n(Plasmoid.configuration.isDarkTheme ? "Light Theme" : "Dark Theme")
    PlasmaCore.IconItem {
        anchors.fill: parent
        source: Plasmoid.configuration.isDarkTheme ? "brightness-high" : "brightness-low"
    }

    onClicked: {
        executable.swapColorScheme();
        Plasmoid.configuration.isDarkTheme = !Plasmoid.configuration.isDarkTheme
    }

    PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: { 
            disconnectSource(sourceName)
        }
        
        function exec(cmd) {
            connectSource(cmd)
        }

        function swapColorScheme() {
            var colorSchemeName = Plasmoid.configuration.isDarkTheme ? Plasmoid.configuration.lightTheme : Plasmoid.configuration.darkTheme
            exec("plasma-apply-colorscheme " + colorSchemeName)
        }
    }
}
