#include "mihafileobject.h"
#include "QFile"
#include "QTextStream"
#include "QIODevice"

MihaFileObject::MihaFileObject()
{
    dataObj d;
    this->current_object = d;

}

void MihaFileObject::WriteCurrentObject(bool createNew)
{
    fileObjects.append(current_object);
    if(createNew)
        CreateOrClearCurrentObject();
}

void MihaFileObject::CreateOrClearCurrentObject(int id)
{
    if(id == -1)
    {
        dataObj d;
        this->current_object = d;
        return;
    }

    if(id > fileObjects.count())
        return;
    current_object = fileObjects[id];

}

void MihaFileObject::AddValueToCurrentObject(QString value)
{
    this->current_object.values.append(value);
}

void MihaFileObject::AddFileObject(QStringList data)
{
    dataObj o;
    o.values = data;
    fileObjects.append(o);
}

void MihaFileObject::WriteData()
{
    QFile writ(this->path);
    writ.open(QIODevice::WriteOnly);
    QTextStream writter(&writ);
    writter<<"$$begin$$\n";

    for(int i =0;i<fileObjects.count();i++)
    {
        writter<<fileObjects[i].ToString()+ "";
        writter<<"---\n";
    }
    writter<<"$$end$$";
    writ.close();
}

void MihaFileObject::setPath(QString path)
{

    this->path = path;
}

void MihaFileObject::delete_file(QString path)
{
    QFile file(path);
    file.remove();
    //file.close();
}



QString MihaFileObject::GetFullPath()
{
    return path;
}

void MihaFileObject::ReadDataFromFile()
{
    QFile readder(this->path);
    ClearData();
    readder.open(QIODevice::ReadOnly);
    QString data = readder.readAll();
    readder.close();
    QStringList list;
    list = data.split("\n");
    if(list[0] != "$$begin$$")
        return;
    if(!list.contains("$$end$$"))
        return;
    int pointer = 1;
    QString value= "";
    QStringList newfileobj;
    while(value!="$$end$$")
    {
        value = list[pointer];
        if(value == "---")
        {
            AddFileObject(newfileobj);
            newfileobj.clear();
        }
        else
            newfileobj.append(value);
        pointer +=1;
    }


}

QStringList MihaFileObject::getOneFileObject(int number)
{
    return this->fileObjects[number].values;
}

void MihaFileObject::findValue(QString value, int &indexFileObject, int &indexInFO)
{
    for(int i = 0;i<fileObjects.count();i++)
    {
        QStringList obj = fileObjects[i].values;
        for(int j =0;j<obj.count();j++)
        {
            if(obj[j] == value)
            {

                indexFileObject = i;
                indexInFO = j;
                return;
            }

        }
    }
    indexFileObject = -1;
    indexInFO = -1;
}

void MihaFileObject::ClearData()
{
    this->fileObjects.clear();
    path = "";
    CreateOrClearCurrentObject();
}

int MihaFileObject::getCountObjects()
{
    return fileObjects.count();
}
