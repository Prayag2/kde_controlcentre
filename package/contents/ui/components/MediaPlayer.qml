import QtQuick 2.0
import QtQuick.Layouts 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import "../lib" as Lib

Lib.Card {
    id: mediaPlayer
    visible: root.showMediaPlayer
    Layout.fillWidth: true
    Layout.preferredHeight: root.sectionHeight/2
    
    PlasmaCore.DataSource {
        id: musicSource
        engine: "mpris2"
        
        onDataChanged: {
            connectedSources = ["@multiplex"]
            var audioData = data["@multiplex"]
            var playing = audioData["PlaybackStatus"] === "Playing"
            
            
            // show if and only if the audio source exists and the audio is currently playing
            if (audioData && playing) {
                
                var audioMetadata = audioData["Metadata"]
                var title = audioMetadata["xesam:title"]
                var artist = audioMetadata["xesam:artist"]
                var thumb = audioMetadata["mpris:artUrl"]   
                
                audioTitle.text = title ? title : i18n("Unknown Media")
                audioThumb.source = thumb ? thumb : "../../assets/music.png"
                
                audioArtist.visible = true
                audioThumb.visible = true
                audioControls.visible = true
                audioTitle.horizontalAlignment = Qt.AlignLeft
                playIcon.source = "media-playback-pause"
                try {
                    audioArtist.text = artist.join(", ")
                } catch(err) {
                    audioArtist.text = artist ? artist : i18n("Unknown Artist")
                } 
            } else {
                playIcon.source = "media-playback-start"
            }
        }
        onSourcesChanged: {
            dataChanged()
        }
        onSourceRemoved: {
            audioArtist.visible = false
            audioThumb.visible = false
            audioControls.visible = false
            audioTitle.horizontalAlignment = Qt.AlignHCenter
            audioTitle.text = i18n("No Media Playing")
            dataChanged()
        }
        Component.onCompleted: {
            audioArtist.visible = false
            audioThumb.visible = false
            audioControls.visible = false
            audioTitle.horizontalAlignment = Qt.AlignHCenter
            audioTitle.text = i18n("No Media Playing")
            dataChanged()
        }
    }

    function action(src, op) {
        var service = musicSource.serviceForSource(src);
        var operation = service.operationDescription(op);
        return service.startOperationCall(operation);
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: root.largeSpacing

        Image {
            id: audioThumb
            fillMode: Image.PreserveAspectCrop
            Layout.fillHeight: true
            Layout.preferredWidth: height
        }
        ColumnLayout {
            id: mediaNameWrapper
            Layout.margins: root.smallSpacing
            Layout.fillHeight: true
            spacing: 0

            PlasmaComponents.Label {
                id: audioTitle
                Layout.fillWidth: true
                font.capitalization: Font.Capitalize
                font.weight: Font.Bold
                font.pixelSize: root.largeFontSize
                horizontalAlignment: Text.AlignHCenter
                elide: Text.ElideRight
            }
            PlasmaComponents.Label {
                id: audioArtist
                Layout.fillWidth: true
                font.pixelSize: root.mediumFontSize
            }
        }
        RowLayout {
            id: audioControls
            Layout.alignment: Qt.AlignRight

            PlasmaCore.IconItem {
                Layout.preferredHeight: mediaNameWrapper.implicitHeight
                Layout.preferredWidth: height
                source: "media-skip-backward"
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mediaPlayer.action(musicSource.connectedSources, "Previous")
                    }
                }
            }

            PlasmaCore.IconItem {
                id: playIcon
                Layout.preferredHeight: mediaNameWrapper.implicitHeight
                Layout.preferredWidth: height
                source: "media-playback-start"
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mediaPlayer.action(musicSource.connectedSources, "PlayPause")
                    }
                }
            }
            PlasmaCore.IconItem {
                Layout.preferredHeight: mediaNameWrapper.implicitHeight
                Layout.preferredWidth: height
                source: "media-skip-forward"
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mediaPlayer.action(musicSource.connectedSources, "Next")
                    }
                }
            }
        }
    }
}
