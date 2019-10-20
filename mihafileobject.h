#ifndef MIHAFILEOBJECT_H
#define MIHAFILEOBJECT_H
#include "QString"
#include "QList"

class MihaFileObject
{
public:
    MihaFileObject();
    struct dataObj{
    public:
        dataObj(){}
        QStringList values;
        QString ToString()
        {
           QString data;
           for(int i = 0;i<values.count();i++)
           {
               data+= values[i]+ "\n";
           }
           return data;
        }
    };

    void WriteCurrentObject(bool createNew = false);//записываем редактируемый(активный обьект в список)
    void CreateOrClearCurrentObject(int id = -1);//обнуляем активный обьект или выбираем из существующих
    void AddValueToCurrentObject(QString value);//добавляем очередное значение в активный обьект
    void AddFileObject(QStringList data);
    void WriteData();
    void setPath(QString path = "MihaDataFile.txt");
    void delete_file(QString path);


    QString GetFullPath();
    void ReadDataFromFile();
    QStringList getOneFileObject(int number);
    void findValue(QString value, int &indexFileObject, int &indexInFO);
    void ClearData();
    int getCountObjects();
private:
    QList<dataObj> fileObjects;
    dataObj current_object;
    QString path;


};

#endif // MIHAFILEOBJECT_H
