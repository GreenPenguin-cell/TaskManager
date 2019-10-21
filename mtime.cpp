#include "mtime.h"
#include "QTime"
#include "QDebug"


MTime::MTime()
{
    TaskModel mod;
    set_material(&mod);
}

void MTime::run()
{

    int skip_id=-1;
    scan = true;
    while(scan)
    {

        if(material->get_rowCount()==0)
            continue;
        for(int i=0;i<material->get_rowCount();i++)
        {
             QTime taskTime = material->m_data[i].p_task_time;
             //qDebug()<<taskTime;
             if(taskTime==QTime::currentTime()&&(skip_id!=i))
             {
                 qDebug()<<i;
                 skip_id=i;
                 emit sendTaskSIgnal(i);
             }
        }
    }


}

void MTime::set_material(TaskModel *model)
{
    material = model;
    connect(this, SIGNAL(sendTaskSIgnal(int)), material, SLOT(sl_task_deadLine(int)));
}

QString MTime::get_currentTime()
{
    return QTime::currentTime().toString();
}

QString MTime::plus_time(QString t,int hour_shift, int minute_shift,int seconds_shift)
{
    QTime time = QTime::fromString(t);



    QTime newTime(time.hour() + hour_shift, time.minute()+minute_shift, time.second()+ seconds_shift);
    return newTime.toString();
}

QString MTime::minus_time(QString t, int hour_shift, int minute_shift, int seconds_shift)
{
    QTime time = QTime::fromString(t);

    if(time.hour() == 0)
        hour_shift =0;
    if(time.minute() == 0)
        minute_shift =0;
    if(time.second()==0)
        seconds_shift =0;

    QTime newTime(time.hour() - hour_shift, time.minute()-minute_shift, time.second()- seconds_shift);
    return newTime.toString();
}

QString MTime::get_currentDate()
{
    return QDate::currentDate().toString();
}

void MTime::stop()
{
    scan = false;
}


