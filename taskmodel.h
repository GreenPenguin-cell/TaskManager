#ifndef TaskModel_H
#define TaskModel_H

#include <QObject>
#include "QAbstractItemModel"
#include "QMap"
#include "QDateTime"

class TaskModel : public QAbstractListModel
{
    Q_OBJECT

public:

    Q_PROPERTY(QStringList p_categs READ get_p_categs WRITE set_p_categs NOTIFY s_p_categsChanged)
    Q_PROPERTY(QStringList p_test READ get_p_test WRITE set_p_test NOTIFY s_p_testChanged)
    //Хранит список категорий
    void set_p_categs(QStringList value)
    {
        p_categs=value;
    }
    QStringList get_p_categs()
    {
        return p_categs;
    }

    QStringList p_test;
    void set_p_test(QStringList value)
    {
        p_test=value;
    }
    QStringList get_p_test()
    {
        return p_test;
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
signals:
    void s_p_categsChanged();
    void s_p_testChanged();

private:
    QList<Command> m_data;

    QStringList p_categs;

};

#endif // TaskModel_H
