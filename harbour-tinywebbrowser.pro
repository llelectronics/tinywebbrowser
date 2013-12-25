# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-tinywebbrowser

CONFIG += sailfishapp webkit

SOURCES += src/harbour-tinywebbrowser.cpp

OTHER_FILES += qml/harbour-tinywebbrowser.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-tinywebbrowser.spec \
    rpm/harbour-tinywebbrowser.yaml \
    harbour-tinywebbrowser.desktop \
    qml/pages/SelectUrl.qml \
    qml/pages/AboutPage.qml \
    tinywebbrowser.svg \
    harbour-tinywebbrowser.png \
    qml/pages/HistoryPage.qml

RESOURCES += \
    qrc.qrc

