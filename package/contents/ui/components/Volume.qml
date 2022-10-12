import QtQml 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.private.volume 0.1 as Vol

import "../lib" as Lib
import "../js/funcs.js" as Funcs

Lib.Slider {
    Layout.fillWidth: true
    Layout.preferredHeight: root.sectionHeight/2
    visible: sinkAvailable && root.showVolume
    title: i18n("Volume")
    
    // Audio source
    property var sink: paSinkModel.preferredSink
    readonly property bool sinkAvailable: sink && !(sink && sink.name == "auto_null")
    readonly property Vol.SinkModel paSinkModel: Vol.SinkModel {
        id: paSinkModel
    }
    
    value: (sink.volume / Vol.PulseAudio.NormalVolume * 100)
    secondaryTitle: Math.round(sink.volume / Vol.PulseAudio.NormalVolume * 100) + "%"
    
    // Changes icon based on the current volume percentage
    source: Funcs.volIconName(sink.volume, sink.muted)
    
    // Update volume
    onMoved: {
        sink.volume = value * Vol.PulseAudio.NormalVolume / 100
    }
}