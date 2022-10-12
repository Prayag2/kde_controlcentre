import QtQml 2.0
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
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
    
    property int numChecked: showKDEConnect.checked + showColorSwitcher.checked + showNightColor.checked
    
    PlasmaExtras.Heading {
        text: i18n("General Settings")
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
            text: i18n("Enable Transparency")
        }
        CheckBox {
            id: transparency 
        }
    }
    
    PlasmaExtras.Heading {
        text: i18n("Components")
        Layout.topMargin: PlasmaCore.Units.largeSpacing
    }
    Label {
        text: i18n("You can only enable two out of the following three components at a time.")
    }
    RowLayout {
        Label {
            text: i18n('Show "KDE Connect"')
        }
        CheckBox {
            id: showKDEConnect
            enabled: !checked && numChecked < 2 || checked
        }
    }
    RowLayout {
        Label {
            text: i18n('Show "Night Color"')
        }
        CheckBox {
            id: showNightColor
            enabled: !checked && numChecked < 2 || checked
        }
    }
    RowLayout {
        Label {
            text: i18n('Show "Color Scheme Switcher"')
        }
        CheckBox {
            id: showColorSwitcher
            enabled: !checked && numChecked < 2 || checked
        }
    }
    RowLayout {
        Label {
            text: i18n('Show "Volume Control"')
        }
        CheckBox {
            id: showVolume
        }
    }
    RowLayout {
        Label {
            text: i18n('Show "Brightness Control"')
        }
        CheckBox {
            id: showBrightness
        }
    }
    RowLayout {
        Label {
            text: i18n('Show "Media Player"')
        }
        CheckBox {
            id: showMediaPlayer
        }
    }
    
    Item {
        Layout.fillHeight: true
    }
}