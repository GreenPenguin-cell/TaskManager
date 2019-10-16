#include "pagesdiscripion.h"
#include "QDebug"

//PagesDiscripion::PagesDiscripion(QObject *parent) : QObject(parent)
//{

//}



PagesDiscripion::PagesDiscripion()
{
    page p("UIPages_TasksList.qml", "but_pageChange_list");
    p_pages.append(p);
    page p1("UIPages_TasksPriority.qml", "but_PageChange_Prior");
    p_pages.append(p1);
    page p2("UIPages_TasksCategory.qml", "but_pageChange_Cat");
    p_pages.append(p2);

    for(int i=0;i<p_pages.count();i++)
    {
        qDebug()<<p_pages[i].p_sourse;
    }

    p_current_page=p_pages[0];
}

void PagesDiscripion::f_set_current_page(QString command)
{
    for(int i=0;i<p_pages.count();i++)
    {
        if(p_pages[i].p_upCommand == command)
        {
            p_current_page = p_pages[i];
            return;
        }
    }
}

QString PagesDiscripion::f_get_current_page_sourse()
{
    return p_current_page.p_sourse;
}
