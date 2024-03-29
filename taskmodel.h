#ifndef TaskModel_H
#define TaskModel_H

#include <QObject>
#include "QAbstractItemModel"
#include "QMap"
#include "QDateTime"
#include "mihafileobject.h"
#include "QString"
#include "QStringList"
#include "QDebug"

class TaskModel : public QAbstractListModel
{
    Q_OBJECT

public:


    Q_PROPERTY(QStringList p_categs READ get_p_categs WRITE set_p_categs NOTIFY s_p_categsChanged)
    Q_PROPERTY(QString p_ChangedValues_Name READ get_p_test WRITE set_p_test NOTIFY s_p_testChanged)
    Q_PROPERTY(QString p_ChangedValues_Discr READ get_p_ChangedValues_Discr WRITE set_p_ChangedValues_Discr NOTIFY s_p_ChangedValues_DiscrChanged)
    Q_PROPERTY(QString p_ChangedValues_Time READ get_p_ChangedValues_Time WRITE set_p_ChangedValues_Time NOTIFY s_p_ChangedValues_TimeChanged)
    Q_PROPERTY(QString p_ChangedValues_Date READ get_p_ChangedValues_Date WRITE set_p_ChangedValues_Date NOTIFY s_p_ChangedValues_DateChanged)
    Q_PROPERTY(int p_ChangedValues_Categ_Id READ get_p_ChangedValues_Categ_Id WRITE set_p_ChangedValues_Categ_Id NOTIFY s_p_ChangedValues_Categ_IdChanged)
    Q_PROPERTY(QString p_sound_path READ get_p_sound_path WRITE set_p_sound_path NOTIFY s_p_sound_pathChanged)
   //Хранит путь к звуковому файлу, который проигрывается при дедлайней задач


    void set_p_sound_path(QString value)
    {
        p_sound_path = value;
    }
    QString get_p_sound_path()
    {
        return p_sound_path;
    }

    //Хранит список категорий
    void set_p_categs(QStringList value)
    {
        p_categs=value;
    }
    QStringList get_p_categs()
    {
        return p_categs;
    }

    void set_p_ChangedValues_Time(QString value)
    {
        p_ChangedValues_Time=value;
    }
    QString get_p_ChangedValues_Time()
    {
        return p_ChangedValues_Time;
    }

    void set_p_ChangedValues_Discr(QString value)
    {
        p_ChangedValues_Discr=value;
    }
    QString get_p_ChangedValues_Discr()
    {
        return p_ChangedValues_Discr;
    }

    void set_p_ChangedValues_Date(QString value)
    {
//        int pos = value.indexOf("GMT");
//        value.remove(pos-1, value.length()-1);
        p_ChangedValues_Date=value;
    }
    QString get_p_ChangedValues_Date()
    {
        return p_ChangedValues_Date;
    }

    void set_p_ChangedValues_Categ_Id(int value)
    {
        p_ChangedValues_Categ_Id = value;
    }
    int get_p_ChangedValues_Categ_Id()
    {
        return p_ChangedValues_Categ_Id;
    }


    void set_p_test(QString value)
    {
        p_ChangedValues_Name=value;
    }
    QString get_p_test()
    {
        return p_ChangedValues_Name;
    }

    struct Command
    {
        Command(QString name, QString alias, QString task_time, QString task_date, int task_categ_id) {
            this->p_task_discr = alias;
            this->p_task_name = name;
            p_task_date=QDate::fromString(task_date);
            p_task_time=QTime::fromString(task_time);
            p_task_categ_id=task_categ_id;
        }
        Command(QStringList arg_data)
        {
           if(arg_data.count()!=5)
               return;
           this->p_task_discr = arg_data[1];
           this->p_task_name = arg_data[0];
           p_task_date=QDate::fromString(arg_data[3]);
           p_task_time=QTime::fromString(arg_data[2]);
           p_task_categ_id=arg_data[4].toInt();
        }
        QString p_task_name;
        QString p_task_discr;
        QTime p_task_time;
        QDate p_task_date;
        int p_task_categ_id;

    };

    enum Roles {
        TaskNameRole = Qt::UserRole + 1,
        TaskDiscrRole=Qt::UserRole + 2,
        TaskTimeRole=Qt::UserRole + 3,
        TaskDateRole=Qt::UserRole + 4,
        TaskCategRole
    };

    TaskModel(QObject *parent = 0);

    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    virtual QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE virtual bool setData(const QModelIndex &index, const QVariant &value, int role);
    virtual Qt::ItemFlags flags(const QModelIndex &index) const;

    Q_INVOKABLE void add(QString arg_task_name,
                         QString arg_task_discr,
                         QString arg_task_time,
                         QString arg_task_date,
                         int arg_task_categ_id);
    Q_INVOKABLE virtual bool removeRow(int row, const QModelIndex &parent);
    Q_INVOKABLE void change(int  index_row, QString arg_task_name,
                            QString arg_task_discr,
                            QString arg_task_time,
                            QString arg_task_date,
                            int arg_task_categ_id);
    //Добавляет текущие изменяемые значения из p_ChangedValues
    Q_INVOKABLE void f_add_changed_values(int arg_id = -1);
    //Устанавливает изменяемые значения в те же что у заданной задачи
    Q_INVOKABLE void f_set_changed_values(int arg_id = -1);
    //Устанавливает значения пустыми
    Q_INVOKABLE void f_clear_changed_values();
    //Сохраняет данные
    Q_INVOKABLE void f_save_data(bool arg_true = true);
    //Читает данные
    Q_INVOKABLE void f_read_data();
    //Возвращает наличие/отсутствие изменений
    Q_INVOKABLE bool get_has_modifications()
    {
        return has_modifications;
    }
    //Получить число строк без модел-индекса
    Q_INVOKABLE int get_rowCount()
    {
        return m_data.count();
    }
    //Скрывает все задачи, кроме указанной категории
    Q_INVOKABLE void f_hide_cat(int arg_id_cat);
    //Восстанавливаем список задач из резервного
    Q_INVOKABLE void f_refresh_tasks();
    //пока публичная, дальше придумаю как скрыть
     QList<Command> m_data;

signals:
    //Сигналы для свойств
    void s_p_categsChanged();
    void s_p_testChanged();
    void s_p_ChangedValues_DiscrChanged();
    void s_p_ChangedValues_TimeChanged();
    void s_p_ChangedValues_DateChanged();
    void s_p_ChangedValues_Categ_IdChanged();
    void s_p_sound_pathChanged();
    //Отправка в QML сигнала о дедлайней задачи
    void s_task_deadLine(QString arg_task_name);
public slots:
    //Подаем сигнал о дедлайне задачи
    void sl_task_deadLine(int arg_task_id);

private:

    //MTime p_timer;
    QString p_ChangedValues_Name;
    QString p_ChangedValues_Discr;
    QString p_ChangedValues_Time;
    QString p_ChangedValues_Date;
    int p_ChangedValues_Categ_Id;
    QString p_sound_path;
    QStringList p_categs;
    MihaFileObject p_data_save;
    bool has_modifications;
    //Проигрывает звук при дедлайне
    void f_play_sound();
    //Резервный список задач, сюда помещаются те который не должны быть показаны
    QList<Command> m_data_reserv;


};

#endif // TaskModel_H
