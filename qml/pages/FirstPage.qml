/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import QtWebKit.experimental 1.0

Page {
    id: page
    allowedOrientations: Orientation.All
    property alias url: webview.url
    property ListModel bookmarks
    // To enable PullDownMenu, place our content in a SilicaFlickable
    TextField{
        id: clip
        visible: false
        text: siteURL
    }

    ProgressCircle {
        id: progressCircle
        z: 2
        anchors.top: parent.top
        anchors.topMargin: 16
        anchors.horizontalCenter: parent.horizontalCenter
        visible: urlLoading
        width: 32
        height: 32
        Timer {
            interval: 32
            repeat: true
            onTriggered: progressCircle.value = (progressCircle.value + 0.005) % 1.0
            running: urlLoading
        }
    }

    Item{
        id: popup
        anchors.centerIn: parent
        z: 3
        width: 400
        height: 400
        visible: false
        Rectangle {
            anchors.fill: parent
            border.width: 2
            opacity: 0.5
            border.color: "black"
            Label {
                anchors.fill: parent
                color: "black" //Theme.fontColorHighlight
                text: errorText
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: popup.visible = false
        }
    }


    SilicaWebView {
        id: webview
        url: siteURL
        // Don't use fixed values otherwise you won't make it into harbour
        //        width: page.orientation == Orientation.Portrait ? 540 : 960
        //        height: page.orientation == Orientation.Portrait ? 960 : 540
        anchors.fill: parent // automatically changed width and heights according to orientation
        // onUrlChanged: {
        /* user clicked a link */
        //if (siteURL != url)
        //   siteURL = url     // WTF: Create a loop on redirects ?
        //               }

        header: PageHeader {height: 0}

        // Prevent crashes by loading the mobile site instead of the desktop one // TODO: Make this configurable
        experimental.userAgent: "Mozilla/5.0 (Linux; U; Android 2.2; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1"
        experimental.preferences.minimumFontSize: 17  // We need readable fonts on g+, youtube and so on. This might hurt tmo though

        onLoadingChanged:
        {
            if (loadRequest.status == WebView.LoadStartedStatus)
            {
                urlLoading = true;
            }
            else if (loadRequest.status == WebView.LoadFailedStatus)
            {
                urlLoading = false;
                errorText = "Load failed\n"+loadRequest.errorString
                popup.visible = true
            }
            else
            {
                urlLoading = false;
                if (url == "about:bookmarks") pageStack.push(Qt.resolvedUrl("SelectUrl.qml"), { dataContainer: page, siteURL: webview.url, bookmarks: page.bookmarks, siteTitle: webview.title})
            }
        }
        onNavigationRequested: {
            // detect URL scheme prefix, most likely an external link
            var schemaRE = /^\w+:/;
            if (schemaRE.test(request.url)) {
                request.action = WebView.AcceptRequest;
            } else {
                request.action = WebView.IgnoreRequest;
                popup.visible = true
                // delegate request.url here
            }
        }
        PullDownMenu {
            MenuItem {
                text: qsTr("About ")+appname
                visible: !webview.canGoBack
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Copy URL")
                onClicked: { clip.text = webview.url ; clip.selectAll(); clip.copy(); }
            }
            MenuItem {
                text: qsTr("Go forward")
                visible: webview.canGoForward
                onClicked: webview.goForward()
            }

            MenuItem {
                text: qsTr("Refresh")
                onClicked: webview.reload()
            }
            MenuItem {
                text: qsTr("Bottom")
                onClicked: webview.scrollToBottom()
            }
            MenuItem {
                text: qsTr("Go back")
                visible: webview.canGoBack
                onClicked: webview.goBack()
            }
            MenuItem {
                text: qsTr("Goto...")
                //onClicked: pageStack.navigateForward()
                onClicked: pageStack.push(Qt.resolvedUrl("SelectUrl.qml"), { dataContainer: page, siteURL: webview.url, bookmarks: page.bookmarks, siteTitle: webview.title})
            }
            Label {
                text: webview.title
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
            }

        }
        PushUpMenu {
            MenuItem {
                text: qsTr("Top")
                onClicked: webview.scrollToTop()
            }
            MenuItem {
                text: qsTr("Go Back")
                visible: webview.canGoBack
                onClicked: webview.goBack()
            }
            MenuItem {
                text: qsTr("Go Forward")
                visible: webview.canGoForward
                onClicked: webview.goForward()
            }
        }
    }
}


