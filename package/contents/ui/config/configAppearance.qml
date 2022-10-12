import QtQml 2.0
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras

ColumnLayout {
    property alias cfg_scale: scale.value
    property alias cfg_transparency: transparency.checked
    property alias cfg_showColorSwitcher: showColorSwitcher.checked
    property alias cfg_showKDEConnect: showKDEConnect.checked
    
    PlasmaExtras.Heading {
        text: i18n("Settings")
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
    Label {
        text: i18n("Transparency might not work correctly with some themes!")
    }
    RowLayout {
        Label {
            text: i18n("Replace Night Color with Color Scheme Switcher")
        }
        CheckBox {
            id: showColorSwitcher 
        }
    }
    RowLayout {
        Label {
            text: i18n("Hide KDE Connect")
        }
        CheckBox {
            id: showKDEConnect
        }
    }
    
    Item {
        Layout.fillHeight: true
    }
}