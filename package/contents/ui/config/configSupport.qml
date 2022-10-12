import QtQml 2.0
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras

ColumnLayout {
    Layout.fillHeight: true
    Layout.fillWidth: true
    
    PlasmaExtras.Heading {
        text: i18n("If you'd like to support me :)")
    }
    Row {
        spacing: 10
        height: PlasmaCore.Units.gridUnit * 2.5
        Image {
            height: parent.height
            source: "../../assets/LiberaPay.png"
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Qt.openUrlExternally("https://liberapay.com/Prayag/donate")
                }
            }
        }
        Image {
            height: parent.height
            source: "../../assets/Paypal.png"
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Qt.openUrlExternally("https://coindrop.to/prayagjain")
                }
            }
        }
        Image {
            height: parent.height
            source: "../../assets/Ko-Fi.png"
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Qt.openUrlExternally("https://ko-fi.com/O5O1FJ70D")
                }
            }
        }
    }
    Item {
        Layout.fillHeight: true
    }
}