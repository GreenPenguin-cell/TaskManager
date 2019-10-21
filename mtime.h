#ifndef MTIME_H
#define MTIME_H
#include "QThread"
#include "taskmodel.h"

class MTime : public QThread
{
    Q_OBJECT
public:

    TaskModel* material;
    MTime();
    Q_INVOKABLE void run();
    Q_INVOKABLE void set_material(TaskModel* model);
    Q_INVOKABLE QString get_currentTime();
    Q_INVOKABLE QString plus_time( QString t,int hour_shift, int minute_shift,int seconds_shift);
    Q_INVOKABLE QString minus_time(QString t,int hour_shift, int minute_shift,int seconds_shift);
    Q_INVOKABLE QString get_currentDate();
    Q_INVOKABLE void stop();


signals:
    void sendTaskSIgnal(int id);
    void sendTimeToQml(QString time);

public slots:

private:
    bool scan;
};

#endif // MTIME_H
