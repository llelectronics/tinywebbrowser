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
import "pages"

ApplicationWindow
{
    id: app
    property string siteURL: "http://talk.maemo.org"
    property bool urlLoading: false
    property string version: "0.0.6"
    property string appname: "Tiny Web Browser"
    property string appicon: "qrc:/harbour-tinywebbrowser.png"
    property string errorText: ""
    cover: undefined
    pageStack.onCurrentPageChanged: { if (!timerHistory.running && pageStack.currentPage.objectName == "history")  timerHistory.start(); webPage.backward();}
    ListModel{
        id: modelUrls
        ListElement {
            title: "Jolla Together"
            url: "http://together.jolla.com/"
        }
        ListElement {
            title: "Maemo forum"
            url: "http://talk.maemo.org"
        }
        ListElement {
            title: "Jolla users"
            url: "http://jollausers.com"
        }
        ListElement {
            title: "Jolla users forum"
            url: "http://forum.jollausers.com"
        }
        ListElement {
            title: "Jolla Tides"
            url: "http://jollatides.com"
        }
        ListElement {
            title: "Review Jolla"
            url: "http://reviewjolla.blogspot.se/"
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

    onPageStackChanged: { console.log( "stack change")}
    Component.onCompleted: { webPage = pageStack.pushAttached(Qt.resolvedUrl("pages/FirstPage.qml")); }

    Timer {
        id: timerHistory
        repeat: false
        running: true
        interval: 250
        onTriggered: pageStack.navigateForward()
    }

}


