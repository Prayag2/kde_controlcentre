import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kcmutils as KCM

import "../components"
import "../js/funcs.js" as Funcs


KCM.SimpleKCM {
    property alias cfg_lightTheme: cboxLightColour.lastText
    property alias cfg_darkTheme: cboxDarkColour.lastText
    property alias cfg_lightPlasmaTheme: cboxLightPlasma.lastText
    property alias cfg_darkPlasmaTheme: cboxDarkPlasma.lastText

    ColumnLayout {
        GridLayout {
            columns: 2

            Label {
                text: i18n("Colour Theme")
                font.bold: true
                Layout.row: 0
            }

            // Light Colour Selection
            Label {
                text: i18n("Light")

                Layout.row: 1
                Layout.column: 0
            }

            ConfigAppearanceComboBox {
                id: cboxLightColour
                Layout.row: 1
            }

            // Dark Colour selection
            Label {
                text: i18n("Dark")

                Layout.row: 2
                Layout.column: 0
            }

            ConfigAppearanceComboBox {
                id: cboxDarkColour
                Layout.row: 2
            }

            Label {
                text: i18n("Plasma Theme")
                font.bold: true
                Layout.row: 3
            }

            // Light plasma theme selection
            Label {
                text: i18n("Light")

                Layout.row: 4
                Layout.column: 0
            }

            ConfigAppearanceComboBox {
                id: cboxLightPlasma
                Layout.row: 4
            }

            // Dark plasma theme selection
            Label {
                text: i18n("Dark")

                Layout.row: 5
                Layout.column: 0
            }

            ConfigAppearanceComboBox {
                id: cboxDarkPlasma
                Layout.row: 5
            }
        }
    }

    Component.onCompleted: {
        dataSource.getItems();
    }

    // Components //

    ConfigAppearanceDataSource {
        id: dataSource
    }

    Connections {
        target: dataSource

        onItemsReady: (items, itemType) => {
            switch (itemType) {
                case ConfigAppearanceDataSource.ItemType.ColourThemes:
                    cboxLightColour.configure(items);
                    cboxDarkColour.configure(items);
                    break;

                case ConfigAppearanceDataSource.ItemType.PlasmaThemes:
                    cboxLightPlasma.configure(items);
                    cboxDarkPlasma.configure(items);
                    break;
            }
        }
    }
}
