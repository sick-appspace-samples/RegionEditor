## RegionEditor
Edit shape region in viewer on user interface
### Description
This Sample shows how to edit shapes within the viewer on the user interface.
There are two iconics added to the viewer, a background image and a rectangle.
When clicking anywhere in the viewer it sends an "OnPointer" event with additional
data to determine what pointer action was done on what element. This information
is then used within the script to determine if the editor should be installed
on the selected element. In this sample this is the case when the user clicked
on the rectangle. After the editor is installed it is possible to change the
rectangle directly in the viewer with mouse interactions. These changes are
then recognized and an "OnChange" event is thrown by the viewer, which also
includes the information on what iconic was changed and also contains the new
iconic object, in this case the new rectangle.
### How to Run
Starting this Sample is possible by running the App (F5). After running the
Sample, the user interface can be seen on the DevicePage tab or in the webbrowser
by using the according device address. To show the image and the shape, the Sample
must be restarted or the button "Update View" must be clicked. A rectangle
is shown on a gray background image in the viewer.
To go into the selection mode, the mouse-pointer icon in the viewer toolbar must be
clicked. Now it is possible to select the rectangle by clicking on it, this will
install the editor and enables to change it.  To run this sample a device with the according functionality and AppEngine >= 2.5.0
is required. For example SIM4000 with latest firmware. Alternatively the
Emulator on AppStudio 2.3 or higher can be used.
### Implementation
The Sample already includes an AppSpace 2D visualization control in the correct
version. When using this code in another application it must be made sure,
that it requires the at least the V2.1.3.0 of the 2D visualization control

### Topics
System, User-Interface, Getting-Started, Sample, SICK-AppSpace