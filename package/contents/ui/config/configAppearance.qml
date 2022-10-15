import QtQml 2.0
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons

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
    
    PlasmaExtras.Heading {
        text: i18n("General")
    }
    RowLayout {
        Label {
            text: i18n("Scale")
        }
        SpinBox {
            id: scale 
            from: 0; to: 1000
        }
    }
    RowLayout {
        Label {
            text: i18n("Show Volume/Brightness Percentage")
        }
        CheckBox {
            id: showPercentage
        }
    }
    RowLayout {
        Label {
            text: i18n("Enable Transparency")
        }
        CheckBox {
            id: transparency 
        }
    } 
    RowLayout {
            Label {
                text: i18n("Control Centre Icon")
            }
            Button {
                id: mainIconName
                icon.height: PlasmaCore.Units.iconSizes.medium
                icon.width: icon.height
                
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= mainIconName.icon
                }
            }
        }
    
    PlasmaExtras.Heading {
        text: i18n("Quick Toggle Buttons")
        Layout.topMargin: PlasmaCore.Units.largeSpacing
    }
    Label {
        text: i18n("You can enable only TWO out of the following five components at a time.")
        color: PlasmaCore.Theme.neutralTextColor
    }
    RowLayout {
        Label {
            text: i18n('Show KDE Connect')
            color: showKDEConnect.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor

        }
        CheckBox {
            id: showKDEConnect
            enabled: !checked && numChecked < maxNum || checked
        }
    }
    RowLayout {
        Label {
            text: i18n('Show Night Color')
            color: showNightColor.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showNightColor
            enabled: !checked && numChecked < maxNum || checked
        }
    }
    RowLayout {
        Label {
            text: i18n('Show Color Scheme Switcher')
            color: showColorSwitcher.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor

        }
        CheckBox {
            id: showColorSwitcher
            enabled: !checked && numChecked < maxNum || checked
        }
    }
    RowLayout {
        Label {
            text: i18n('Show Custom Command Block 1')
            color: showCmd1.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showCmd1
            enabled: !checked && numChecked < maxNum || checked
        }
    }
    ColumnLayout {
        Layout.leftMargin: PlasmaCore.Units.largeSpacing
        visible: showCmd1.checked
        RowLayout {
            Label {
                text: i18n("Block Name")
            }
            TextField {
                id: cmdTitle1
            }
        }
        RowLayout {
            Label {
                text: i18n("Command")
            }
            TextField {
                id: cmdRun1
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: i18n("Icon")
            }
            Button {
                id: cmdIcon1
                icon.height: PlasmaCore.Units.iconSizes.medium
                icon.width: icon.height
                
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon1.icon
                }
            }
        }
    }
    RowLayout {
        Label {
            text: i18n('Show Custom Command Block 2')
            color: showCmd2.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showCmd2
            enabled: !checked && numChecked < maxNum || checked
        }
    }
    ColumnLayout {
        Layout.leftMargin: PlasmaCore.Units.largeSpacing
        visible: showCmd2.checked
        RowLayout {
            Label {
                text: i18n("Block Name")
            }
            TextField {
                id: cmdTitle2
            }
        }
        RowLayout {
            Label {
                text: i18n("Command")
            }
            TextField {
                id: cmdRun2
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: i18n("Icon")
            }
            Button {
                id: cmdIcon2
                icon.height: PlasmaCore.Units.iconSizes.medium
                icon.width: icon.height
                
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon2.icon
                }
            }
        }
    }
    PlasmaExtras.Heading {
        Layout.topMargin: PlasmaCore.Units.largeSpacing
        text: "Other Components"
    }
    RowLayout {
        Label {
            text: i18n('Show Volume Control')
        }
        CheckBox {
            id: showVolume
        }
    }
    RowLayout {
        Label {
            text: i18n('Show Brightness Control')
        }
        CheckBox {
            id: showBrightness
        }
    }
    RowLayout {
        Label {
            text: i18n('Show Media Player')
        }
        CheckBox {
            id: showMediaPlayer
        }
    }
    
    Item {
        Layout.fillHeight: true
    }
}