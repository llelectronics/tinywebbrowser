import QtQuick 2.0
import Sailfish.Silica 1.0
Dialog
{
    id: urlPage
    anchors.fill: parent
    Column
    {
        anchors.fill: parent
        DialogHeader {
            id: topPanel
            enabled: false
            acceptText: "Save"
        }
        TextField{
            id: entryURL
            text: siteURL
            font.pixelSize: Theme.fontSizeMedium
            width: parent.width
            placeholderText: qsTr("Enter an url")
            inputMethodHints: Qt.ImhUrlCharactersOnly
            Keys.onReturnPressed: {
                siteURL = entryURL.text
                pageStack.pop();
            }
        }

        Repeater {
            id: repeater1
            model: modelUrls
            Button {
                text: title
                onClicked: { siteUrl = url; pageStack.pop(); }
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
