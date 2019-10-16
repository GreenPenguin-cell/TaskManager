import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "../UIComponents"

Item {
    id:main


    property QtObject dataModel: undefined

    //Сигнал поступающий с кнопок панелей
    /*
      but_add - такой параметр должен приходить с кнопки добавить

      */
    signal s_but_panel_click(string arg_but_param)
    Connections
    {
        target: main
        onS_but_panel_click:
        {

                pagesDiscripion.f_set_current_page(arg_but_param)
                f_load_page()


            if(arg_but_param=="but_add")
               dataModel.add("Commnad", "Alias Command")
            if(arg_but_param=="but_del")
               dataModel.removeRow(data_view.f_get_current_index(), dataModel)
            if(arg_but_param=="but_change")
                dataModel.change(data_view.f_get_current_index(), "new Command", "new Alias")
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
            //f_element_add("Добавить", "but_add",2)
            f_element_add("Настройки", "but_ChangePage_Set",1)
        }
    }
    //Загружает страницу
    function f_load_page()
    {
        load_pages.setSource(pagesDiscripion.f_get_current_page_sourse(), {dataModel:dataModel})
    }


}
