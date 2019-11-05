#include "taskmodel.h"
#include "QDebug"
#include "QtMultimedia/QMediaPlayer"

TaskModel::TaskModel(QObject *parent):
    QAbstractListModel(parent)
{
    //    m_data.append("old");
    //    m_data.append("another old");
    //qDebug()<<QDate::currentDate().toString();
    p_categs.append("Работа");
    p_categs.append("Увлечения");
    p_categs.append("Спорт");
    p_categs.append("Здоровье");
    f_read_data();

    has_modifications = false;
    f_clear_changed_values();
    //qDebug()<<QDate::currentDate().toString();
    //qDebug()<<QTime::currentTime().toString();
    qDebug()<<QDateTime::currentDateTime().toString();



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
    has_modifications=true;
}

bool TaskModel::removeRow(int row, const QModelIndex &parent)
{

    has_modifications=true;
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
    has_modifications=true;
    qDebug()<<m_data[index_row].p_task_time;
}

void TaskModel::f_add_changed_values(int arg_id)
{
    if(arg_id==-1)
    {
//        qDebug()<<"this";
//        QDateTime val;
//        val=QDateTime::fromString(p_ChangedValues_Date);

//        qDebug()<<p_ChangedValues_Date;
        add(p_ChangedValues_Name, p_ChangedValues_Discr, p_ChangedValues_Time, p_ChangedValues_Date, p_ChangedValues_Categ_Id);
    }
    else
    {
//        qDebug()<<"this";
//        QDateTime val;
//        val=QDateTime::fromString(p_ChangedValues_Date);

//        qDebug()<<p_ChangedValues_Date;
        change(arg_id,p_ChangedValues_Name, p_ChangedValues_Discr, p_ChangedValues_Time, p_ChangedValues_Date, p_ChangedValues_Categ_Id);
    }
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
    QDateTime val;
    val.setTime(m_data[arg_id].p_task_time);
    val.setDate(m_data[arg_id].p_task_date);
    p_ChangedValues_Date=val.toString();//m_data[arg_id].p_task_date.toString();
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

void TaskModel::f_save_data(bool arg_true)
{

    if(!arg_true)
        return;
    //qDebug()<<"tyt";
    p_data_save.setPath("data");
    for(int i =0;i<m_data.count();i++)
    {
        p_data_save.CreateOrClearCurrentObject();
        p_data_save.AddValueToCurrentObject(m_data[i].p_task_name);
        p_data_save.AddValueToCurrentObject(m_data[i].p_task_discr);
        p_data_save.AddValueToCurrentObject(m_data[i].p_task_time.toString());
        p_data_save.AddValueToCurrentObject(m_data[i].p_task_date.toString());
        p_data_save.AddValueToCurrentObject(QString::number(m_data[i].p_task_categ_id));
        p_data_save.WriteCurrentObject();
    }
    p_data_save.WriteData();
    p_data_save.ClearData();
    has_modifications=false;
}

void TaskModel::f_read_data()
{

    if(!QFile::exists("data"))
        return;
    p_data_save.setPath("data");
    p_data_save.ReadDataFromFile();
    for(int i=0;i<p_data_save.getCountObjects();i++)
    {
        QStringList dat = p_data_save.getOneFileObject(i);
        add(dat[0],dat[1],dat[2],dat[3],dat[4].toInt());

    }
    p_data_save.ClearData();

}

void TaskModel::f_hide_cat(int arg_id_cat)
{
    f_refresh_tasks();
    qDebug()<<QString::number(arg_id_cat);

    QList<int> deleted_indexes;
    for(int i=m_data.count()-1;i<=0;i--)
    {
        if(m_data[i].p_task_categ_id!=arg_id_cat)
        {
            m_data_reserv.append(m_data[i]);
            //removeRow(i,QModelIndex());
            deleted_indexes.append(i);
            //m_data.removeAt(i);
        }
    }

    qDebug()<<"Tasks_count - "<<QString::number(m_data.count());
}

void TaskModel::f_refresh_tasks()
{
    for(int i=0;i<m_data_reserv.count();i++)
    {
        add(m_data_reserv[i].p_task_name, m_data_reserv[i].p_task_discr,m_data_reserv[i].p_task_time.toString(), m_data_reserv[i].p_task_date.toString(), m_data_reserv[i].p_task_categ_id);
        //m_data.append(m_data_reserv[i]);
    }
    m_data_reserv.clear();
}

void TaskModel::sl_task_deadLine(int arg_task_id)
{
    emit s_task_deadLine(m_data[arg_task_id].p_task_name);
    //f_play_sound();
    removeRow(arg_task_id, QModelIndex());
}

void TaskModel::f_play_sound()
{
    QMediaPlayer player;// = new QMediaPlayer;
    // ...
    player.setMedia(QUrl::fromLocalFile("sound.mp3"));
    player.setVolume(50);
    player.play();
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
