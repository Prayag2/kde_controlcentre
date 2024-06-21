import QtQml
import QtQuick
import QtQuick.Layouts

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.private.volume

import "../lib" as Lib
import "../js/funcs.js" as Funcs

Lib.Slider {
    Layout.fillWidth: true
    Layout.preferredHeight: root.sectionHeight/2
    visible: sinkAvailable && root.showVolume
    useIconButton: true
    title: i18n("Volume")

    // Audio source
    property var sink: PreferredDevice.sink

    readonly property bool sinkAvailable: sink && !(sink && sink.name == "auto_null")

    value: Math.round(sink.volume / PulseAudio.NormalVolume * 100)
    secondaryTitle: Math.round(sink.volume / PulseAudio.NormalVolume * 100) + "%"

    // Changes icon based on the current volume percentage
    source: getIconForVolume()

    onValueChanged: {
        if(!root.playVolumeFeedback || debounce.limit()) {
            return;
        }

        feedback.play(sink.index)
    }
    // Update volume
    onMoved: {
        sink.volume = value * PulseAudio.NormalVolume / 100
    }

    property var oldVol: 100 * PulseAudio.NormalVolume / 100
    onClicked: {
        if(value!=0){
            oldVol = sink.volume
            sink.volume=0
        } else {
            sink.volume=oldVol
        }
    }

    // Components //

    // Volume Feedback
    VolumeFeedback {
        id: feedback
    }

    Timer {
        id: debounce
        interval: 150 // ms

        function limit()
        {
            if (debounce.running) {
                return true;
            }

            debounce.start();
            return false;
        }
    }

    /// Functions ///

    function getIconForVolume()
    {
        return AudioIcon.forVolume(
            volumePercent(sink.volume),
            sink.muted, ""
        );
    }

    function volumePercent(volume) {
        return volume / PulseAudio.NormalVolume * 100;
    }
}
