import QtQml 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import org.kde.kirigami 2.15 as Kirigami
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras

import "../js/funcs.js" as Funcs

ColumnLayout {
    property string customIcon;
    property string command;
    property string title;

    id: customAction

    // Used to select icons
    KQuickAddons.IconDialog {
        id: iconDialog
        property var iconObj
        
        onIconNameChanged: customIcon = iconName
        
    }

    Kirigami.FormLayout {
        RowLayout {
            Kirigami.FormData.label: i18n("Icon and Name:")

            Button {
                icon.name: customIcon
                icon.width: PlasmaCore.Units.iconSizes.medium
                icon.height: icon.width
                onClicked: {
                    iconDialog.open()
                }
            }

            TextField {
                Layout.fillWidth: true
                placeholderText: "Custom command name"
                text: title;
                onTextEdited: {
                    title = this.text
                }
            }
        }

        TextField {
            Kirigami.FormData.label: i18n("Command:")
            placeholderText: "Custom command"
            text: command;
            onTextEdited: {
                command = this.text
            }
        }

        Button {
            Layout.fillWidth: true
            text: "Remove"
            onClicked: Funcs.destroyObject(customAction)
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
        }
    }
}