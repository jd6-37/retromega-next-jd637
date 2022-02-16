import QtQuick 2.15

import '../footer' as Footer
import '../header' as Header

Item {
    anchors.fill: parent;

    Keys.onUpPressed: {
        event.accepted = true;
        settingsScroll.settingsListView.decrementCurrentIndex();
        sounds.nav();
    }

    Keys.onDownPressed: {
        event.accepted = true;
        settingsScroll.settingsListView.incrementCurrentIndex();
        sounds.nav();
    }

    function onAcceptPressed() {
        const currentIndex = settingsScroll.settingsListView.currentIndex;
        const currentKey = settings.keys[currentIndex];
        settings.toggle(currentKey);
        sounds.nav();
    }

    function onCancelPressed() {
        currentView = 'collectionList';
        sounds.back();
    }

    Keys.onPressed: {
        if (api.keys.isCancel(event)) {
            event.accepted = true;
            onCancelPressed();
        }

        if (api.keys.isAccept(event)) {
            event.accepted = true;
            onAcceptPressed();
        }
    }

    Rectangle {
        color: '#f3f3f3';
        anchors.fill: parent;
    }

    SettingsScroll {
        id: settingsScroll;

        anchors {
            top: settingsHeader.bottom;
            bottom: settingsFooter.top;
            left: parent.left;
            right: parent.right;
        }
    }

    Footer.Component {
        id: settingsFooter;

        total: 0;

        buttons: [
            { title: 'Toggle', key: 'A', square: false, sigValue: 'accept' },
            { title: 'Back', key: 'B', square: false, sigValue: 'cancel' },
        ];

        onButtonClicked: {
            if (sigValue === 'accept') onAcceptPressed();
            if (sigValue === 'cancel') onCancelPressed();
        }
    }

    Header.Component {
        id: settingsHeader;

        showDivider: true;
        theme: 'dark';
        color: '#f3f3f3';
        showTitle: true;
        title: 'Settings';
        titleColor: 'black';
    }
}