import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13

BaseDelegate {

    SpinBox {
        id: choiceBox
        width: 210
        height: 48
        font.pixelSize: 14
        from: 0
        to: 100
        stepSize: 1
        value: model.value
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 18
        // @disable-check M223
        onValueChanged: {
            model.value = value
            model.modified = true
        }
        enabled: !model.disabled
    }
}
