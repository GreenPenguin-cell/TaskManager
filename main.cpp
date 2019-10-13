#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "taskmodel.h"
#include "QQmlContext"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    TaskModel dataModel;
    QQmlContext *ctxt = engine.rootContext();
    ctxt->setContextProperty("dataModel", &dataModel);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
