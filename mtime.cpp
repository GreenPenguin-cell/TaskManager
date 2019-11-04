#include "mtime.h"
#include "QTime"
#include "QDebug"
#include "QDateTime"


MTime::MTime()
{
    TaskModel mod;
    set_material(&mod);
    p_skip_id=-1;
}
//Date format пн окт. 21 2019

void MTime::run()
{


    scan = true;
    while(scan)
    {

        emit s_time_send(QTime::currentTime().toString());
        if(material->get_rowCount()==0)
            continue;
        for(int i=0;i<material->get_rowCount();i++)
        {
            QTime taskTime = material->m_data[i].p_task_time;
            QDate taskDate = material->m_data[i].p_task_date;
            //qDebug()<<taskTime;
            if((taskTime==QTime::currentTime()&&(p_skip_id!=i))&(taskDate==QDate::currentDate()))
            {
                qDebug()<<i;
                p_skip_id=i;
                if(i!=-1)
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


