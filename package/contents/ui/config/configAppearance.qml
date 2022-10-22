import QtQml 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import org.kde.kirigami 2.15 as Kirigami
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras

ColumnLayout {
    property alias cfg_scale: scale.value
    property alias cfg_transparency: transparency.checked
    property alias cfg_showKDEConnect: showKDEConnect.checked
    property alias cfg_showNightColor: showNightColor.checked
    property alias cfg_showColorSwitcher: showColorSwitcher.checked
    property alias cfg_showVolume: showVolume.checked
    property alias cfg_showBrightness: showBrightness.checked
    property alias cfg_showMediaPlayer: showMediaPlayer.checked
    property alias cfg_showCmd1: showCmd1.checked
    property alias cfg_showCmd2: showCmd2.checked
    property alias cfg_showPercentage: showPercentage.checked
    property alias cfg_mainIconName: mainIconName.icon.name
    property alias cfg_cmdIcon1: cmdIcon1.icon.name
    property alias cfg_cmdRun1: cmdRun1.text
    property alias cfg_cmdTitle1: cmdTitle1.text
    property alias cfg_cmdIcon2: cmdIcon2.icon.name
    property alias cfg_cmdRun2: cmdRun2.text
    property alias cfg_cmdTitle2: cmdTitle2.text

    property int numChecked: showKDEConnect.checked + showColorSwitcher.checked + showNightColor.checked + showCmd1.checked + showCmd2.checked
    property int maxNum: 2

    // Used to select icons
    KQuickAddons.IconDialog {
        id: iconDialog
        property var iconObj
        onIconNameChanged: iconObj.name = iconName
    }

    Kirigami.FormLayout {
        Button {
            id: mainIconName
            Kirigami.FormData.label: i18n("Icon:")
            icon.width: PlasmaCore.Units.iconSizes.medium
            icon.height: icon.width
            onClicked: {
                iconDialog.open()
                iconDialog.iconObj= mainIconName.icon
            }
        }

        SpinBox {
            id: scale
            Kirigami.FormData.label: i18n("Scale:")
            from: 0; to: 1000
        }

        Item {
            Kirigami.FormData.isSection: true
        }

        CheckBox {
            id: showPercentage
            Kirigami.FormData.label: i18n("General:")
            text: i18n("Show volume/brightness percentage")
        }
        CheckBox {
            id: transparency
            text: i18n("Enable transparency")
        }

        Item {
            Kirigami.FormData.isSection: true
        }

        CheckBox {
            id: showKDEConnect
            Kirigami.FormData.label: i18n("Show quick toggle buttons:")
            text: i18n('KDE Connect')
            enabled: !checked && numChecked < maxNum || checked
        }
        CheckBox {
            id: showNightColor
            text: i18n('Night Color')
            enabled: !checked && numChecked < maxNum || checked
        }
        CheckBox {
            id: showColorSwitcher
            text: i18n('Color Scheme Switcher')
            enabled: !checked && numChecked < maxNum || checked
        }
        CheckBox {
            id: showCmd1
            text: i18n('Custom Command Block 1')
            enabled: !checked && numChecked < maxNum || checked
        }
        Kirigami.FormLayout {
            visible: showCmd1.checked
            TextField {
                id: cmdTitle1
                Kirigami.FormData.label: i18n("Name:")
            }
            TextField {
                id: cmdRun1
                Kirigami.FormData.label: i18n("Command:")
            }
            Button {
                id: cmdIcon1
                Kirigami.FormData.label: i18n("Icon:")
                icon.width: PlasmaCore.Units.iconSizes.medium
                icon.height: icon.width
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon1.icon
                }
            }
        }
        CheckBox {
            id: showCmd2
            text: i18n('Custom Command Block 2')
            enabled: !checked && numChecked < maxNum || checked
        }
        Kirigami.FormLayout {
            visible: showCmd2.checked
            TextField {
                id: cmdTitle2
                Kirigami.FormData.label: i18n("Name:")
            }
            TextField {
                id: cmdRun2
                Kirigami.FormData.label: i18n("Command:")
            }
            Button {
                id: cmdIcon2
                Kirigami.FormData.label: i18n("Icon:")
                icon.width: PlasmaCore.Units.iconSizes.medium
                icon.height: icon.width
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon2.icon
                }
            }
        }
        Label {
            text: i18n("You can enable only 2 toggle buttons at a time.")
            font: PlasmaCore.Theme.smallestFont
            color: PlasmaCore.Theme.neutralTextColor
            Layout.fillWidth: true
            wrapMode: Text.Wrap
        }

        Item {
            Kirigami.FormData.isSection: true
        }

        CheckBox {
            id: showVolume
            Kirigami.FormData.label: i18n("Show other components:")
            text: i18n('Volume Control')
        }
        CheckBox {
            id: showBrightness
            text: i18n('Brightness Control')
        }
        CheckBox {
            id: showMediaPlayer
            text: i18n('Media Player')
        }
    }

    Item {
        Layout.fillHeight: true
    }
}
