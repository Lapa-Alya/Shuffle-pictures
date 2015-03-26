#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>

int main(int argc, char* argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine(QUrl("qrc:///main.qml"));

    return app.exec();
}
