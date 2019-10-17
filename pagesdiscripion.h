#ifndef PAGESDISCRIPION_H
#define PAGESDISCRIPION_H

#include <QObject>
#include "QList"
#include "QString"

class PagesDiscripion : public QObject
{
    //Класс хранит описание страниц

    Q_OBJECT
public:
    //explicit PagesDiscripion(QObject *parent = nullptr);





    struct page //Структура хранит описание отдельной страницы
    {
        page(QString arg_sourse="", QString arg_command="")
        {
            p_sourse=arg_sourse;
            p_upCommand=arg_command;
        }
        //Путь к странице, используется в QML
        QString p_sourse;
        //Команда, по которой объект должен стать активным
        QString p_upCommand;

    };
    PagesDiscripion();
    Q_INVOKABLE void f_set_current_page(QString command);
    Q_INVOKABLE QString f_get_current_page_sourse();

signals:
    void s_p_current_idChanged();

public slots:
private:
    //Хранит описание страниц
    QList<page> p_pages;
    //Хранит активную страницу
    page p_current_page;

};

#endif // PAGESDISCRIPION_H
