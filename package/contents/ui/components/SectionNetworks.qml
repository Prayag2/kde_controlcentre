import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.ksvg as KSvg
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.components as PlasmaComponents3
import org.kde.plasma.networkmanagement as PlasmaNM
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
                        icon.name: "arrow-left"
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

                        Layout.rightMargin: root.smallSpacing
                        checked: administrativelyEnabled && network.enabledConnections.wirelessEnabled
                        enabled: administrativelyEnabled
                        icon.name: administrativelyEnabled && network.enabledConnections.wirelessEnabled ? "network-wireless-on" : "network-wireless-off"
                        visible: network.availableDevices.wirelessDeviceAvailable
                        onToggled: network.handler.enableWireless(checked)

                        PlasmaComponents3.ToolTip {
                            text: wifiSwitchButton.checked ? i18n("Disable Wi-Fi") : i18n("Enable Wi-Fi")
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

                                interval: Kirigami.Units.humanMoment
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

                    // Airplane mode section
                    PlasmaComponents3.CheckBox {
                        id: airPlaneModeSwitchButton

                        property bool initialized: false

                        checked: PlasmaNM.Configuration.airplaneModeEnabled
                        icon.name: PlasmaNM.Configuration.airplaneModeEnabled ? "network-flightmode-on" : "network-flightmode-off"
                        visible: network.availableDevices.modemDeviceAvailable || network.availableDevices.wirelessDeviceAvailable
                        onToggled: {
                            network.handler.enableAirplaneMode(checked);
                            PlasmaNM.Configuration.airplaneModeEnabled = checked;
                        }

                        PlasmaComponents3.ToolTip {
                            text: airPlaneModeSwitchButton.checked ? i18n("Disable airplane mode") : i18n("Enable airplane mode")
                        }

                    }

                }

                KSvg.SvgItem {
                    id: separatorLine

                    z: 4
                    elementId: "horizontal-line"
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.scale

                    svg: KSvg.Svg {
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
