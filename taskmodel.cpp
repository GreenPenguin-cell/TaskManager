#include "taskmodel.h"

TaskModel::TaskModel(QObject *parent):
    QAbstractListModel(parent)
{
    //    m_data.append("old");
    //    m_data.append("another old");
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
    case CommandNameRole:
        return m_data.at(index.row()).name;// QVariant(index.row() < 2 ? "orange" : "skyblue");
    case CommandAliasRole:
        return m_data.at(index.row()).alias;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> TaskModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[CommandNameRole] = "CommandNameRole";
    roles[CommandAliasRole] = "CommandAliasRole";

    return roles;
}

void TaskModel::add(QString command, QString alias)
{
    beginInsertRows(QModelIndex(), m_data.size(), m_data.size());
    Command com(command,alias);
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

void TaskModel::change(int  index_row, QString command_value, QString alias_value)
{
    removeRow(index_row, QModelIndex());

    beginInsertRows(QModelIndex(), index_row, index_row);
    Command com(command_value,alias_value);
    m_data.insert(index_row, com);
    endInsertRows();
    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
    emit dataChanged(index, index);
}

bool TaskModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid()) {
        return false;
    }
    if(role == -1)
    {
        m_data[index.row()].name = value.toString();
    }
    else
    {
        switch (role) {
        case CommandNameRole:
            m_data[index.row()].name = value.toString();
            break;
        case CommandAliasRole:
            m_data[index.row()].alias = value.toString();
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
