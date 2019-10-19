#include "taskmodel.h"
#include "QDebug"

TaskModel::TaskModel(QObject *parent):
    QAbstractListModel(parent)
{
    //    m_data.append("old");
    //    m_data.append("another old");
    //qDebug()<<QDate::currentDate().toString();
    p_categs.append("Хуета");
    p_categs.append("Говно");

   f_clear_changed_values();

}

int TaskModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) {
        return 0;
    }

    return m_data.size();
}

QVariant TaskModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    switch (role) {
    case TaskNameRole:
        return m_data.at(index.row()).p_task_name;// QVariant(index.row() < 2 ? "orange" : "skyblue");
    case TaskDiscrRole:
        return m_data.at(index.row()).p_task_discr;
    case TaskDateRole:
        return m_data.at(index.row()).p_task_date.toString();
    case TaskTimeRole:
        return m_data.at(index.row()).p_task_time.toString();
    case TaskCategRole:
        return p_categs.at(m_data.at(index.row()).p_task_categ_id);
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> TaskModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[TaskNameRole] = "TaskNameRole";
    roles[TaskDiscrRole] = "TaskDiscrRole";
    roles[TaskTimeRole] = "TaskTimeRole";
    roles[TaskDateRole] = "TaskDateRole";
    roles[TaskCategRole] = "TaskCategRole";

    return roles;
}

void TaskModel::add(QString arg_task_name,
                    QString arg_task_discr,
                    QString arg_task_time,
                    QString arg_task_date,
                    int arg_task_categ_id)
{
    beginInsertRows(QModelIndex(), m_data.size(), m_data.size());
    Command com(arg_task_name,arg_task_discr,arg_task_time, arg_task_date,arg_task_categ_id);
    m_data.append(com);
    endInsertRows();

    //m_data[0] = QString("Size: %1").arg(m_data.size());
    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
    emit dataChanged(index, index);
}

bool TaskModel::removeRow(int row, const QModelIndex &parent)
{

    beginRemoveRows(parent, row,row);
    m_data.removeAt(row);
    endRemoveRows();
    return true;
}

void TaskModel::change(int  index_row, QString arg_task_name,
                       QString arg_task_discr,
                       QString arg_task_time,
                       QString arg_task_date,
                       int arg_task_categ_id)
{
    removeRow(index_row, QModelIndex());

    beginInsertRows(QModelIndex(), index_row, index_row);
    Command com(arg_task_name,arg_task_discr,arg_task_time,arg_task_date,arg_task_categ_id);
    m_data.insert(index_row, com);
    endInsertRows();
    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
    emit dataChanged(index, index);
}

void TaskModel::f_add_changed_values(int arg_id)
{
    if(arg_id==-1)
    {
        add(p_ChangedValues_Name, p_ChangedValues_Discr, p_ChangedValues_Time, p_ChangedValues_Date, p_ChangedValues_Categ_Id);
    }
    else
        change(arg_id,p_ChangedValues_Name, p_ChangedValues_Discr, p_ChangedValues_Time, p_ChangedValues_Date, p_ChangedValues_Categ_Id);
   f_clear_changed_values();

}

void TaskModel::f_set_changed_values(int arg_id)
{
    if(arg_id==-1)
    {
        f_clear_changed_values();
        return;
    }
    if(arg_id>m_data.count())
        return;
    p_ChangedValues_Name=m_data[arg_id].p_task_name;
    p_ChangedValues_Discr=m_data[arg_id].p_task_discr;
    p_ChangedValues_Time=m_data[arg_id].p_task_time.toString();
    p_ChangedValues_Date=m_data[arg_id].p_task_date.toString();
    p_ChangedValues_Categ_Id=m_data[arg_id].p_task_categ_id;


}

void TaskModel::f_clear_changed_values()
{
    p_ChangedValues_Name = "";
    p_ChangedValues_Discr = "";

    p_ChangedValues_Date = "";
    p_ChangedValues_Time = "";

    p_ChangedValues_Categ_Id = 0;
}

bool TaskModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid()) {
        return false;
    }
    if(role == -1)
    {
        m_data[index.row()].p_task_name = value.toString();
    }
    else
    {
        switch (role) {
        case TaskNameRole:
            m_data[index.row()].p_task_name = value.toString();
            break;
        case TaskDiscrRole:
            m_data[index.row()].p_task_discr = value.toString();
            break;
        case TaskTimeRole:
            m_data[index.row()].p_task_time = QTime::fromString(value.toString());
            break;
        case TaskDateRole:
            m_data[index.row()].p_task_date = QDate::fromString(value.toString());
            break;
        case TaskCategRole:
            m_data[index.row()].p_task_categ_id = value.toInt();
            break;
        default:
            return false;
        }
    }

    emit dataChanged(index, index, QVector<int>() << role);

    return true;
}

Qt::ItemFlags TaskModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::ItemIsEnabled;

    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}
