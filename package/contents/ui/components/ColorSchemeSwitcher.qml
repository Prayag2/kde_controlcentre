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
    title: i18n(isDarkTheme() ? "Light Theme" : "Dark Theme")
    Kirigami.Icon {
        anchors.fill: parent
        source: isDarkTheme() ? "brightness-high" : "brightness-low"
    }

    onClicked: executable.swapColorScheme()

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
            var usingDark = isDarkTheme();
            var colorSchemeName = usingDark ? Plasmoid.configuration.lightTheme : Plasmoid.configuration.darkTheme;
            var plasmaThemeName = usingDark ? Plasmoid.configuration.lightPlasmaTheme : Plasmoid.configuration.darkPlasmaTheme;

            Plasmoid.configuration.isDarkTheme = !usingDark ? 1 : 0;

            exec("plasma-apply-colorscheme " + colorSchemeName +
                ";plasma-apply-desktoptheme " + plasmaThemeName);
        }
    }

    // Functions //

    function isDarkTheme() {
        if (Plasmoid.configuration.isDarkTheme == -1)
        {
            // TODO: Try to find a better way of doing this
            // When first added, use the theme's background brightness to see if 'dark mode' is active
            // (May not detect some 'grey' dark themes).
            var darkMode = sysPalette.window.hslLightness <= 0.4;

            Plasmoid.configuration.isDarkTheme = darkMode ? 1 : 0;
            return darkMode;
        }

        return Plasmoid.configuration.isDarkTheme == 1;
    }

    // Components //

    SystemPalette {
        id: sysPalette
    }
}
