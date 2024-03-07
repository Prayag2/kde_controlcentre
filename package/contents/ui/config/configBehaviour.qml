import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import org.kde.kirigami as Kirigami
import org.kde.kquickcontrolsaddons as KQuickAddons
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.extras as PlasmaExtras

ColumnLayout {
    property alias cfg_playVolumeFeedback: playVolumeFeedback.checked


    Kirigami.FormLayout {
        CheckBox {
            id: playVolumeFeedback
            Kirigami.FormData.label: i18n("Volume:")
            text: i18n('Play Volume Feedback')
        }
    }

    Item {
        Layout.fillHeight: true
    }
}
