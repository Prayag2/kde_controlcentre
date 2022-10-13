import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.components 3.0 as PlasmaComponents3
import "../lib" as Lib

Lib.Card {
    id: sectionNetworks

    // NETWORK
    property var network: network

    function toggleNetworkSection() {
        if (!sectionNetworks.visible) {
            wrapper.visible = false;
            sectionNetworks.visible = true;
        } else {
            wrapper.visible = true;
            sectionNetworks.visible = false;
            
        }
    }

    anchors.fill: parent
    z: 999
    visible: false

    Network {
        id: network
    }

    Item {
        anchors.fill: parent
        anchors.margins: root.smallSpacing

        ListView {
            anchors.fill: parent
            model: network.appletProxyModel

            ScrollBar.vertical: ScrollBar {
            }

            delegate: ConnectionItem {
                width: parent.width
                height: root.buttonHeight
            }

            header: ColumnLayout {
                width: parent.width
                spacing: root.smallSpacing

                RowLayout {
                    height: implicitHeight + root.smallSpacing

                    PlasmaComponents.ToolButton {
                        Layout.preferredHeight: root.largeFontSize * 2.5
                        iconSource: "arrow-left"
                        onClicked: {
                            sectionNetworks.toggleNetworkSection();
                        }
                    }

                    PlasmaComponents.Label {
                        text: i18n("Network Connections")
                        font.pixelSize: root.largeFontSize * 1.2
                        Layout.fillWidth: true
                    }

                    PlasmaComponents3.CheckBox {
                        id: wifiSwitchButton

                        readonly property bool administrativelyEnabled: network.availableDevices.wirelessDeviceAvailable && network.enabledConnections.wirelessHwEnabled
                        property bool wifiCheck: administrativelyEnabled

                        checked: administrativelyEnabled && network.enabledConnections.wirelessEnabled
                        enabled: administrativelyEnabled
                        icon.name: wifiCheck && network.enabledConnections.wirelessEnabled ? "network-wireless-on" : "network-wireless-off"
                        visible: network.availableDevices.wirelessDeviceAvailable
                        nextCheckState: function() {
                            if (checkState === Qt.Checked) {
                                network.handler.enableWireless(false);
                                wifiCheck = false;
                                return Qt.Unchecked;
                            } else {
                                network.handler.enableWireless(true);
                                wifiCheck = true;
                                return Qt.Checked;
                            }
                        }

                        PlasmaComponents3.ToolTip {
                            text: i18n("Enable Wi-Fi")
                        }

                        PlasmaComponents3.BusyIndicator {
                            parent: wifiSwitchButton
                            running: network.handler.scanning || timer.running

                            anchors {
                                fill: wifiSwitchButton.contentItem
                                leftMargin: wifiSwitchButton.indicator.width + wifiSwitchButton.spacing
                            }

                            Timer {
                                id: timer

                                interval: PlasmaCore.Units.humanMoment
                            }

                            Connections {
                                function onScanningChanged() {
                                    if (network.handler.scanning)
                                        timer.restart();

                                }

                                target: network.handler
                            }

                        }

                    }

                }

                PlasmaCore.SvgItem {
                    id: separatorLine

                    z: 4
                    elementId: "horizontal-line"
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.scale

                    svg: PlasmaCore.Svg {
                        imagePath: "widgets/line"
                    }

                }

                Item {
                    Layout.fillHeight: true
                }

            }

        }

    }

}
