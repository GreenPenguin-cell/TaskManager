import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import dataModel 1.0
import "UI"
import "UI/UIComponents"
import "UI/UIPages"
//import TaskModel 1.0

ApplicationWindow {
    //Главное окно
    id:mainwindow
    visible: true
    width: 400
    height: 700

    property QtObject dataModel: dataModel
    onClosing:
    {
        if(dataModel.get_has_modifications())
        {
            close.accepted = false
            confim_wind.p_text = "Сохранить изменения?"
            confim_wind.is_DS = false
            confim_wind.p_object_caller = "wind_close"
            confim_wind.show()
        }
    }

    //Обьявляем основную модель, которая сделана как плагин
    TaskModel
    {
        id:dataModel
    }
    Component.onCompleted:
    {
        task_timer.set_material(dataModel)
        task_timer.start()//run()
    }


    //Сигнал поступающий с кнопок панелей(Отвечает за смену страниц
    /*


      */
    signal s_but_panel_click(string arg_but_param)

    //Сигнал вызывает
    signal s_task_click(int id)
    //Сигнал вызывается из страницы добавления при отменене
    signal s_task_addClose()
    //Сигнал подтверждения/не подтверждения чего либо
    signal s_confirm_close(bool arg_res, string arg_object_caller)

    UIWindows_Confim
    {
        id:confim_wind
        width:mainwindow.width/1.5
        height: mainwindow.height/2
        x:0
        y:0
        p_text: ""

    }
    Connections
    {
        target: dataModel
        onS_task_deadLine:
        {
            confim_wind.is_DS=true
            confim_wind.p_text = "Дедлайн задачи "+ arg_task_name
            confim_wind.p_object_caller = "task_deadLine"
            confim_wind.show()
            task_timer.sl_task_del_complete()


        }
    }

    Connections
    {
        target: mainwindow
        onS_task_click:
        {
            pagesDiscripion.f_set_current_page("but_addChange")
            load_pages.setSource("file:///home/batya/QtProjects/TaskManager/UI/UIPages/"+pagesDiscripion.f_get_current_page_sourse(), {p_changed_task_id:id, dataModel:dataModel})
        }
        onS_task_addClose:
        {
            pagesDiscripion.f_set_current_page("but_pageChange_list")
            f_load_page()
        }
        onS_but_panel_click:
        {
            pagesDiscripion.f_set_current_page(arg_but_param)
            f_load_page()
        }
        onS_confirm_close:
        {
            if(arg_object_caller=="wind_close")
            {
                dataModel.f_save_data(arg_res)
                Qt.quit()
                //mainwindow.close()
            }

        }
    }



    //    Loader
    //    {
    //        id:load_main
    //        anchors.fill: parent
    //        Component.onCompleted:
    //        {
    //            setSource("UI/UIPages/UIPages_Main.qml", {dataModel:dataModel})
    //        }
    //    }






    Loader
    {
        id:load_pages
        x:0
        y:0//upper_panel.height
        width: parent.width
        height: parent.height
        Component.onCompleted:
        {
            setSource("file:///home/batya/QtProjects/TaskManager/UI/UIPages/UIPages_TasksList.qml", {dataModel:dataModel})
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
        p_elements_count: pagesDiscripion.f_get_buts_cnt()
        Component.onCompleted:
        {
            var id = p_elements_count;
            for(var i = 0;i<p_elements_count;i++)
            {
                f_element_add(pagesDiscripion.f_get_but_text(i), pagesDiscripion.f_get_but_command(i), id)
                id-=1
            }

            //Каждая кнопка панели создаётся в репитере, и по клику отправляет сигнал с вот этим текстом
            //Текст PageChange значит что надо сменить страницу
            //            f_element_add("Задачи", "but_pageChange_list",6)
            //            f_element_add("Убить\nВремя", "but_pageChange_game",5)
            //            f_element_add("Категория", "but_pageChange_Cat",4)
            //            f_element_add("Приоретет", "but_PageChange_Prior",3)
            //            f_element_add("Добавить", "but_addChange",2)
            //            f_element_add("Настройки", "but_ChangePage_Set",1)
        }


    }

    //Загружает страницу
    function f_load_page()
    {
        load_pages.setSource("file:///home/batya/QtProjects/TaskManager/UI/UIPages/"+pagesDiscripion.f_get_current_page_sourse(), {dataModel:dataModel})
    }

}


