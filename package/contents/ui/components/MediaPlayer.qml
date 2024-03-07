import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasma5support as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami
import org.kde.plasma.private.mpris as Mpris

import "../lib" as Lib

Lib.Card {
    id: mediaPlayer
    visible: root.showMediaPlayer
    Layout.fillWidth: true
    Layout.preferredHeight: root.sectionHeight/2

    readonly property bool isPlaying: (model.currentPlayer?.playbackStatus ?? 0) == Mpris.PlaybackStatus.Playing

    readonly property string trackName: model.currentPlayer?.track ?? i18n("Unknown Media")
    readonly property string trackArtist: model.currentPlayer?.artist ?? i18n("Unknown Artist")
    readonly property string trackArt: model.currentPlayer?.artUrl ?? "../../assets/music.png"

    RowLayout {
        anchors.fill: parent
        anchors.margins: mediaPlayer.largeSpacing
        Layout.fillWidth: true
        Layout.preferredHeight: mediaPlayer.sectionHeight/2

        Image {
            id: audioThumb
            fillMode: Image.PreserveAspectCrop
            source: mediaPlayer.trackArt

            Layout.fillHeight: true
            Layout.preferredWidth: height
        }

        ColumnLayout {
            id: mediaNameWrapper
            Layout.margins: mediaPlayer.smallSpacing
            Layout.fillHeight: true
            spacing: 0

            PlasmaComponents.Label {
                id: audioTitle
                text: {
                    if (mediaPlayer.isStopped) {
                        return i18n("No Media Playing");
                    }

                    return mediaPlayer.trackName;
                }

                Layout.fillWidth: true
                font.capitalization: Font.Capitalize
                font.weight: Font.Bold
                font.pixelSize: mediaPlayer.largeFontSize
                horizontalAlignment: Text.AlignHCenter
                elide: Text.ElideRight
            }

            PlasmaComponents.Label {
                id: audioArtist
                text: mediaPlayer.trackArtist

                Layout.fillWidth: true
                font.pixelSize: mediaPlayer.mediumFontSize
            }
        }

        RowLayout {
            id: audioControls
            visible: !mediaPlayer.isStopped

            Layout.alignment: Qt.AlignRight

            Kirigami.Icon {
                Layout.preferredHeight: mediaNameWrapper.implicitHeight
                Layout.preferredWidth: height
                source: "media-skip-backward"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        model.currentPlayer.Previous();
                    }
                }
            }

            Kirigami.Icon {
                id: playIcon
                source: mediaPlayer.isPlaying ? "media-playback-pause" : "media-playback-start"

                Layout.preferredHeight: mediaNameWrapper.implicitHeight
                Layout.preferredWidth: height

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        model.currentPlayer.PlayPause();
                    }
                }
            }

            Kirigami.Icon {
                Layout.preferredHeight: mediaNameWrapper.implicitHeight
                Layout.preferredWidth: height
                source: "media-skip-forward"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        model.currentPlayer.Next();
                    }
                }
            }
        }
    }

    // Components //

    Mpris.Mpris2Model {
        id: model
    }
}
