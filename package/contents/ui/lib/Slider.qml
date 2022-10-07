import QtQuick 2.0
import QtQuick.Layouts 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents

Card {
    id: sliderComp
    signal moved

    property alias title: title.text
    property alias source: icon.source
    property alias value: slider.value

    property int from: 0
    property int to: 100


    ColumnLayout {
        anchors.fill: parent
        anchors.margins: root.largeSpacing
        clip: true

        PlasmaComponents.Label {
            id: title
            Layout.fillHeight: true
            Layout.fillWidth: true
            font.pixelSize: root.largeFontSize
            font.weight: Font.Bold
            font.capitalization: Font.Capitalize
        }
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: root.smallSpacing

            PlasmaCore.IconItem {
                id: icon
                Layout.preferredHeight: root.largeFontSize*2
                Layout.preferredWidth: Layout.preferredHeight
            }
            PlasmaComponents.Slider {
                id: slider
                Layout.fillHeight: true
                Layout.fillWidth: true
                from: sliderComp.from
                to: sliderComp.to
                onMoved: {
                    sliderComp.moved()
                }
            }
        }
    }
}
