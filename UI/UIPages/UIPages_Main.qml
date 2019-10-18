import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "../UIComponents"

Item {
    id:main_page


    property QtObject dataModel: undefined

    //Сигнал поступающий с кнопок панелей(Отвечает за смену страниц
    /*
      but_add - такой параметр должен приходить с кнопки добавить

      */
    signal s_but_panel_click(string arg_but_param)

    Connections
    {
        target: main_page
        onS_but_panel_click:
        {
            pagesDiscripion.f_set_current_page(arg_but_param)
            f_load_page()
        }
    }
    Component.onCompleted:
    {
        dataModel.add("Commnad", "Alias Command", "15:00", "вт окт. 18 2019", 0)
       dataModel.add("Commnad", "Alias Command", "15:00", "22.04.19", 0)
        dataModel.add("Commnad", "Alias Command", "15:00", "22.04.19", 0)
    }

    Connections
    {
        //Вызыввается из главного окна сигналом-перенаправителем из
        //страницы со списком задач при клике на одну из них
       target: mainwindow
       onS_task_click:
       {
           pagesDiscripion.f_set_current_page("but_addChange")
           load_pages.setSource(pagesDiscripion.f_get_current_page_sourse(), {p_changed_task_id:id})
       }
    }

    Loader
    {
        id:load_pages
        x:0
        y:0//upper_panel.height
        width: parent.width
        height: parent.height
        Component.onCompleted:
        {
            setSource("UIPages_TasksList.qml", {dataModel:dataModel})
        }
    }


    UIComponents_ButtonsPanel
    {
        //В верхней панели хранятся все кнопки, отвечающие за смену страниц
        id:upper_panel
        x:0
        y:0
        width: parent.width
        height: parent.height/15
        p_elements_count: 6
        Component.onCompleted:
        {
            //Каждая кнопка панели создаётся в репитере, и по клику отправляет сигнал с вот этим текстом
            //Текст PageChange значит что надо сменить страницу
            f_element_add("Задачи", "but_pageChange_list",6)
            f_element_add("Убить\nВремя", "but_pageChange_game",5)
            f_element_add("Категория", "but_pageChange_Cat",4)
            f_element_add("Приоретет", "but_PageChange_Prior",3)
            f_element_add("Добавить", "but_addChange",2)
            f_element_add("Настройки", "but_ChangePage_Set",1)
        }


    }

    //Загружает страницу
    function f_load_page()
    {
        load_pages.setSource(pagesDiscripion.f_get_current_page_sourse(), {dataModel:dataModel})
    }



}
