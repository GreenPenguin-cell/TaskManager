import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "../UIComponents"

Item {
    property QtObject dataModel
    //#e1e1b0
    Rectangle
    {
      anchors.fill: parent
      ComboBox
      {
          id:cb_cats
          x:0
          y:0
          width: parent.width/2
          height: parent.height/15
          model: dataModel.p_categs
          onCurrentIndexChanged:
          {

          }

      }
      UICOmponents_Button
      {
          id:but_show_cat
          x:cb_cats.width
          y:0
          width: parent.width/2
          height: cb_cats.height
          text: "Показать"
          onS_triggered:
          {
              dataModel.f_hide_cat(cb_cats.currentIndex)
          }

      }

      UIComponents_ListViewTable
      {
          id:tasks_list
          x:0
          y:cb_cats.height
          width: parent.width
          height: parent.height-cb_cats.height
          p_element_height: parent.height/5
          p_element_width: width
          dataSourse: dataModel
      }
    }




}
