import QtQml 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import org.kde.kirigami 2.15 as Kirigami
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras

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
