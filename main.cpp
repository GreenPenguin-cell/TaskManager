#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "taskmodel.h"
#include "QQmlContext"
#include "pagesdiscripion.h"
#include "mtime.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);


   MTime task_timer;
   //task_timer.start();

    qmlRegisterType<TaskModel>("dataModel", 1,0, "TaskModel");

    QQmlApplicationEngine engine;

    PagesDiscripion pagesDiscripion;
    QQmlContext *ctxt = engine.rootContext();
    ctxt->setContextProperty("pagesDiscripion", &pagesDiscripion);
    QQmlContext *ctxt2 = engine.rootContext();
        ctxt2->setContextProperty("task_timer", &task_timer);


    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
   // QObject::connect(engine,SIGNAL(s_confirm_close(bool)),player,SLOT(slotChangeVolume(quint64)));




    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
