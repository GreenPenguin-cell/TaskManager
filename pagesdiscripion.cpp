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

    page p3("UIPages_AddChange.qml", "but_addChange");
    p_pages.append(p3);

    page p4("UIPages_Settings.qml", "but_ChangePage_Set");
    p_pages.append(p4);

    page p5("UIPages_Game.qml", "but_pageChange_game");
    p_pages.append(p5);


    //    for(int i=0;i<p_pages.count();i++)
    //    {
    //        qDebug()<<p_pages[i].p_sourse;
    //    }

    p_panel_buts.insert("Задачи", "but_pageChange_list");
    //p_panel_buts.insert("Убить\nВремя", "but_pageChange_game");
    p_panel_buts.insert("Категория", "but_pageChange_Cat");
    //p_panel_buts.insert("Приоретет", "but_PageChange_Prior");
    p_panel_buts.insert("Добавить", "but_addChange");
    //p_panel_buts.insert("Настройки", "but_ChangePage_Set");

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
