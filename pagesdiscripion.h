#ifndef PAGESDISCRIPION_H
#define PAGESDISCRIPION_H

#include <QObject>
#include "QList"
#include "QString"
#include "QStringList"

class PagesDiscripion : public QObject
{
    //Класс хранит описание страниц

    Q_OBJECT
public:
    //explicit PagesDiscripion(QObject *parent = nullptr);

    Q_PROPERTY(QMap<QString, QString> p_panel_buts READ get_p_panel_buts WRITE set_p_panel_buts NOTIFY s_p_panel_butsChanged)
    void set_p_panel_buts(QMap<QString, QString> value)
    {
        p_panel_buts = value;
    }
    QMap<QString, QString> get_p_panel_buts()
    {
        return p_panel_buts;
    }

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
    QMap<QString, QString> p_panel_buts;
    Q_INVOKABLE int f_get_buts_cnt()
    {
        return p_panel_buts.count();
    }
    Q_INVOKABLE QString f_get_but_text(int arg_id)
    {
        QStringList keys = p_panel_buts.keys();
        return keys[arg_id];
    }
    Q_INVOKABLE QString f_get_but_command(int arg_id)
    {
        QStringList values = p_panel_buts.values();
        return values[arg_id];
    }
    Q_INVOKABLE void f_set_current_page(QString command);
    Q_INVOKABLE QString f_get_current_page_sourse();


signals:
    void s_p_current_idChanged();
    void s_p_panel_butsChanged();

public slots:
private:
    //Хранит описание страниц
    QList<page> p_pages;
    //Хранит активную страницу
    page p_current_page;

};

#endif // PAGESDISCRIPION_H
