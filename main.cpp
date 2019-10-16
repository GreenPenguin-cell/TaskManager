#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "taskmodel.h"
#include "QQmlContext"
#include "pagesdiscripion.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);



    qmlRegisterType<TaskModel>("dataModel", 1,0, "TaskModel");

    QQmlApplicationEngine engine;

    PagesDiscripion pagesDiscripion;
    QQmlContext *ctxt = engine.rootContext();
    ctxt->setContextProperty("pagesDiscripion", &pagesDiscripion);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));




    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
