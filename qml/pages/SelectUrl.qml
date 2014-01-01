import QtQuick 2.0
import Sailfish.Silica 1.0
Dialog
{
    id: urlPage
    anchors.fill: parent
    onAccepted: { siteURL = entryURL.text; pageStack.pop(); }
    Column
    {
        anchors.fill: parent
        DialogHeader {
            id: topPanel
            acceptText: qsTr("Goto")
        }
        TextField{
            id: entryURL
            text: siteURL
            font.pixelSize: Theme.fontSizeMedium
            width: parent.width
            placeholderText: qsTr("Enter an url")
            inputMethodHints: Qt.ImhUrlCharactersOnly
            Keys.onReturnPressed: {
                var valid = entryURL.text
                if (valid.indexOf("http://") == -1 && valid.indexOf("https://") == -1)
                {
                    entryURL.text = "http://"+entryURL.text
                }
                urlPage.accept()
            }
            onFocusChanged: entryURL.selectAll()
        }

        Repeater {
            id: repeater1
            model: modelUrls
            Button {
                text: title
                onClicked: { siteURL = url; pageStack.pop(); }
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
