import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import Qt.labs.folderlistmodel 1.0

Window
{
    id: root
    visible: true
    width: 800; height: 600
    color: "black"
    title: "Shuffle Pictures"
    property int highestZ: 0
    property real defaultSize: 100
    property var currentFrame: undefined

    FileDialog
    {
        id: fileDialog
        title: "Choose a folder with some images"
        selectFolder: true
        onAccepted: folderModel.folder = fileUrl + "/"
    }

    Repeater // что то вроде цикла, repeat object
    {
        model: FolderListModel

        {
            id: folderModel
            objectName: "folderModel"
            showDirs: false
            nameFilters: ["*.png", "*.jpg", "*.gif"]
        }

        Rectangle
        {
            Timer
            {
                id: timer
                interval: 10;
                running: true;
                repeat: true;
                onTriggered:
                {
                    rotation();
                    checkBounds();
                    move();
                }

                function rotation()
                {
                    if(photoFrame.turner > 0)
                    {
                        photoFrame.rotation++;
                    }
                    else
                    {
                        photoFrame.rotation--;
                    }
                }

                function move()
                {
                    photoFrame.x += dx
                    photoFrame.y += dy
                }

                function checkBounds()
                {
                    if (photoFrame.x + photoFrame.width > root.width)
                    {
                        dx = -1
                    }
                    if (photoFrame.x < 0)
                    {
                        dx = 1
                    }
                    if( photoFrame.y + photoFrame.height > root.height)
                    {
                        dy = -1
                    }
                    if( photoFrame.y < 0)
                    {
                        dy = 1
                    }
                }
            }

            id: photoFrame
            width: image.width * image.scale + 20
            height: image.height * image.scale + 20
            border.color: "black"
            border.width: 2
            smooth: true
            antialiasing: true
            x: Math.random() * (root.width - defaultSize)
            y: Math.random() * (root.height - defaultSize)
            rotation: Math.random() * 13 - 6
            property int turner: Math.random() * 4 - 2
            property int dx: 1
            property int dy: 1

            Image
            {
                id: image
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit // Задаём пропорции изображения
                source: folderModel.folder + fileName // размещение
                scale: defaultSize / Math.max(sourceSize.width, sourceSize.height) // размер/масштаб
                antialiasing: true // сглаживание
            }

            PinchArea //обработка касаний
            {
                anchors.fill: parent
                pinch.target: photoFrame
                pinch.minimumRotation: -360
                pinch.maximumRotation: 360
                pinch.minimumScale: 0.1
                pinch.maximumScale: 10
                onPinchStarted: setFrameColor();

                MouseArea // обработка кликов
                {
                    id: dragArea
                    hoverEnabled: true
                    anchors.fill: parent
                    drag.target: photoFrame
                    onPressed:
                    {
                        photoFrame.z = ++root.highestZ;
                        parent.setFrameColor();
                    }

                    onEntered:
                    {
                        parent.setFrameColor(); // контроль выбора
                    }
                    onWheel: // обработчик работы мыши
                    {
                        if (wheel.modifiers & Qt.ControlModifier)
                        {
                            photoFrame.rotation += wheel.angleDelta.y / 120 * 5;
                            if (Math.abs(photoFrame.rotation) < 4)
                                photoFrame.rotation = 0;
                        }
                        else
                        {
                            photoFrame.rotation += wheel.angleDelta.x / 120;
                            if (Math.abs(photoFrame.rotation) < 0.6)
                                photoFrame.rotation = 0;
                            var scaleBefore = image.scale;
                            image.scale += image.scale * wheel.angleDelta.y / 120 / 10;
                            photoFrame.x -= image.width * (image.scale - scaleBefore) / 2.0;
                            photoFrame.y -= image.height * (image.scale - scaleBefore) / 2.0;
                        }
                    }
                }

                function setFrameColor() // выделяем selected изображение
                {
                    if (currentFrame)
                    {
                        currentFrame.border.color = "black";
                    }
                    if(currentFrame != photoFrame)
                    {
                       timer.stop();
                    }
                    else
                    {
                        timer.start();
                    }

                    currentFrame = photoFrame;
                    currentFrame.border.color = "red";

                    //***********************************************************//

                }
            }
        }
    }

    Image // загрузка картинок
    {
        id: folderpic
        anchors.top: parent.top
        anchors.left: parent.left
        //anchors.margins: 250
        source: "resources/StartGameButton.png"
        anchors.leftMargin: (root.width - folderpic.width)/2
        anchors.topMargin: (root.height - folderpic.height)/2

        MouseArea
        {
            anchors.fill: parent
            anchors.margins: -10
            onClicked:  parent.startButton();
        }

        function startButton() // On button
        {
            fileDialog.open();
            folderpic.visible = false;
        }
    }

    Text // Авторы Tested yet
    {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10
        anchors.leftMargin: (root.width)/2 - 90


        color: "lightgrey"
        wrapMode: Text.WordWrap
        font.pointSize: 8
        text: "Authors: Martinov Igor & Lapkina Alla"
    }

    //Component.onCompleted: fileDialog.open()
}
