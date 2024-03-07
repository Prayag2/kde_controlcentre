import QtQml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import org.kde.plasma.plasma5support as PlasmaCore

import "../lib" as Lib


Lib.CardButton {
    id: colorSchemeSwitcher

    visible: root.showColorSwitcher
    Layout.fillHeight: true
    Layout.fillWidth: true
    title: i18n(Plasmoid.configuration.isDarkTheme ? "Light Theme" : "Dark Theme")
    Kirigami.Icon {
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
