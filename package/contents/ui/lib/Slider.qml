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
        anchors.margins: root.margin
        clip: true

        PlasmaComponents.Label {
            id: title
            Layout.fillHeight: true
            Layout.fillWidth: true
            font.pixelSize: root.buttonTitleFontSize
            font.weight: Font.Bold
            font.capitalization: Font.Capitalize
        }
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: PlasmaCore.Units.mediumSpacing

            PlasmaCore.IconItem {
                id: icon
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: width
            }
            PlasmaComponents.Slider {
                id: slider
                Layout.fillHeight: true
                Layout.fillWidth: true
                from: sliderComp.from
                to: sliderCopm.to
                onMoved: {
                    sliderComp.moved()
                }
            }
        }
    }
}
