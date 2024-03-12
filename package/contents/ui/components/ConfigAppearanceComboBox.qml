import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


ComboBox {
    property bool isChangeAvailable: false
    property string lastText: ""

    Layout.column: 1
    Layout.minimumWidth: 300

    onCurrentTextChanged: {
        if (!isChangeAvailable)
            return;

        lastText = currentText;
    }

    // Functions //

    function configure(model) {
        this.model = model

        this.currentIndex = this.find(lastText);
        this.isChangeAvailable = true
    }
}