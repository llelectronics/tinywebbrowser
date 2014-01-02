import QtQuick 2.0
import Sailfish.Silica 1.0
Dialog
{
    id: urlPage
    //anchors.fill: parent
    allowedOrientations: Orientation.All

    // Needs to be set as dialog behaves buggy somehow
    width: urlPage.orientation == Orientation.Portrait ? screen.Width : screen.Height
    height: urlPage.orientation == Orientation.Portrait ? screen.Height : screen.Width

    property string siteURL
    property string siteTitle
    property QtObject dataContainer
    property ListModel bookmarks

    onAccepted: { siteURL = entryURL.text; dataContainer.url = siteURL; pageStack.pop(); }
    Component.onCompleted: { entryURL.selectAll(); }


    Column
    {
        //anchors.fill: parent
        width: parent.width
        height: parent.height
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
            focus: true
            Keys.onReturnPressed: {
                var valid = entryURL.text
                if (valid.indexOf(":")<0) {
                    if (valid.indexOf(".")<0 || valid.indexOf(" ")>=0) {
                        // Fall back to a search engine; hard-code Google
                        entryURL.text = "http://www.google.com/search?q="+valid
                    } else {
                        entryURL.text = "http://"+valid
                    }
                    urlPage.accept()
                }   
            }
            onFocusChanged: if (focus === true) entryURL.selectAll()
        }

        SilicaListView {
            id: repeater1
            width: parent.width
            height: urlPage.height - entryURL.height - 2*65 - bottomBar.height
            model: modelUrls
            delegate: ListItem {
                Label { text: title }
                onClicked: { siteURL = url; dataContainer.url = siteURL; pageStack.pop(); }
            }
        }
    }
    Row {
        id: bottomBar
        width: parent.width
        height: 65
        anchors {
//            left: parent.left; leftMargin: Theme.paddingMedium
//            right: parent.right; rightMargin: Theme.paddingMedium
            bottom: parent.bottom; bottomMargin: Theme.paddingMedium
            //verticalCenter: parent.verticalCenter
        }
        // 5 icons, 4 spaces between
        //spacing: (width - (favIcon.width * 5)) / 4

        IconButton {
            id: favIcon
            property bool favorited: bookmarks.count > 0 && bookmarks.contains(siteURL)
            icon.source: favorited ? "image://theme/icon-m-favorite-selected" : "image://theme/icon-m-favorite"
            onClicked: {
                if (favorited) {
                    console.debug("Remove Bookmark");
                    bookmarks.removeBookmark(siteURL)
                } else {
                    console.debug("Add Bookmark " + siteURL + " " + siteTitle);
                    bookmarks.addBookmark(siteURL, siteTitle)
                }
            }
        }
    }
}
