#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QDebug>

int main(int argc, char* argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine(QUrl("qrc:///main.qml"));
    QQuickWindow *window = qobject_cast<QQuickWindow *>(engine.rootObjects().first());
    window->showFullScreen();
    return app.exec();
}

void keyPressEvent (QKeyEvent* event)
{
    if (event->key () == Qt::Key_Back)
    {
        qDebug () << "<<keyPressEvent>> " << "[[Back button]]";
    }
}
