___ PROCEDURE .arraybuilds _____________________________________________________
/*
Goal: Display Repair History on Form InventoryManager
This function takes the line item arrays that hold repair info, puts them into a single array for readability, and reverses the order
so that the newest repair shows up first. 
*/
global HistoryArray, RepairDateArray,RepairedByArray, NewLineArray,NotesArray
NewLineArray=""
HistoryArray=lineitemarray(RepairHistoryΩ,¶)
RepairDateArray=lineitemarray(RepairDateΩ,¶)
RepairedByArray=lineitemarray(RepairedByΩ,¶)
NotesArray=lineitemarray(RepairNotesΩ,¶)
arrayfilter HistoryArray,HistoryArray,¶,?(extract(RepairDateArray,¶,seq())≠"",extract(RepairDateArray,¶,seq())+
" - "+extract(HistoryArray,¶,seq())+" - "+extract(NotesArray,¶,seq())+" - "+extract(RepairedByArray,¶,seq()),"")

HistoryArray=arrayreverse(HistoryArray,¶)
arraystrip HistoryArray,¶
bigmessage HistoryArray
FullHistory=HistoryArray
___ ENDPROCEDURE .arraybuilds __________________________________________________

___ PROCEDURE .CompleteRepair __________________________________________________
global RecordSave,HistoryAdd,vName,WhereToAdd,vNotes,FieldsToUpdate,UpdatedFields,counter,vChoice1,vStrAdd,vEnd,vFldChoice,vDate


Yesno "DId you complete the repair on "+«Model»+"('s)"+" "+RepairsToDo
save
if clipboard()="No"
stop
endif
CopyRecord
RecordSave=clipboard()
gettext "Type Your Name",vName
gettext "Add any Additional Notes here: ",vNotes


vDate=str(datepattern(today(),"mm-dd-yy"))
HistoryAdd=RepairsToDo+";"+vDate+";"+vName+";"+vNotes
//finds next blank date to add repair info
WhereToAdd=arraysearch(lineitemarray(RepairDateΩ,¶),"",1,¶)

//finds the list of fields with that number
FieldsToUpdate=dbinfo("fields","")

counter=1
UpdatedFields=""
loop
vChoice1=array(FieldsToUpdate,counter,¶)
vStrAdd=str(WhereToAdd)
vEnd=arraylast(FieldsToUpdate,¶)
    if vChoice1 contains vStrAdd
        UpdatedFields=UpdatedFields+¶+vChoice1
        increment counter
    else
        increment counter
        endif
    until vChoice1 contains vEnd

arraystrip UpdatedFields,¶
clipboard()=UpdatedFields 
//Loops through the fields and adds the appropriate info
counter=1
vEnd=arraylast(UpdatedFields,¶)
loop
vFldChoice=array(UpdatedFields,counter,¶)
field (vFldChoice)
vChoice1=array(HistoryAdd,counter,";")
if vFldChoice contains "Date"
    vChoice1=date(vChoice1)
endif
«» = vChoice1
increment counter
until vFldChoice contains vEnd


«NeedsRepair?»="No"
RepairsToDo=""

call .arraybuilds


___ ENDPROCEDURE .CompleteRepair _______________________________________________

___ PROCEDURE testEditCell _____________________________________________________
editcell
cell "07-01-22"
editcellstop
___ ENDPROCEDURE testEditCell __________________________________________________

___ PROCEDURE AddToInventory ___________________________________________________
if info("trigger") = "Button.Create New Item"
addrecord
message "Yes"
endif

loop
    rundialog
       “Form="AddToInventory"
        Movable=yes
        Menus=normal
        WindowTitle={AddToInventory}
        Height=300 Width=514
        AutoEdit="Type"
        Variable:"dType=Type"
        Variable:"dModel=Model"
        Variable:"dCurrentUser=CurrentUser"
        Variable:"dHasPanLicense=HasPanLicense"
        Variable:"dSerialNum=SerialNum"
        Variable:"dNeedsRepair=NeedsRepair"
        Variable:"dRepairsToDo=RepairsToDo"
        Variable:"dPanLicenseCode=PanLicenseCode"”
    stoploopif info("trigger")="Dialog.Close"
while forever


___ ENDPROCEDURE AddToInventory ________________________________________________

___ PROCEDURE .SKUBuild ________________________________________________________
local BuildSKU
BuildSKU=upperword(ItemName[1,6])+upperword(CurrentUser[1,6])+upperword(Type[1,6])+upperword(Model[1,6])+upperword(Barcode[-4,-1])
SKU=BuildSKU

___ ENDPROCEDURE .SKUBuild _____________________________________________________

___ PROCEDURE .CreateTicket ____________________________________________________

___ ENDPROCEDURE .CreateTicket _________________________________________________

___ PROCEDURE ..ActivateForm ___________________________________________________

___ ENDPROCEDURE ..ActivateForm ________________________________________________

___ PROCEDURE ..OpenForm _______________________________________________________
if info("formname") beginswith "Repair"
select NeedsRepair contains "yes"
case info("empty")
message "No Repairs Currently Needed"
endcase
endif
___ ENDPROCEDURE ..OpenForm ____________________________________________________

___ PROCEDURE AddF _____________________________________________________________
global StartingWinList, EndWindowList, vCount, WinChoice, EndSize
vCount=0
StartingWinList=ListWindows("")

makenewprocedure "(CommonFunctions)", ""
makenewprocedure "ExportMacros",""
makenewprocedure "ImportMacros",""
makenewprocedure "Symbol Reference",""
makenewprocedure "GetDBInfo",""
;---------
openprocedure "ExportMacros"
setproceduretext {local Dictionary1, ProcedureList
//this saves your procedures into a variable
exportallprocedures "", Dictionary1
clipboard()=Dictionary1

message "Macros are saved to your clipboard!"}
;---------
openprocedure "ImportMacros"
setproceduretext {local Dictionary1,Dictionary2, ProcedureList
Dictionary1=""
Dictionary1=clipboard()
yesno "Press yes to import all macros from clipboard"
if clipboard()="No"
stop
endif
//step one
importdictprocedures Dictionary1, Dictionary2
//changes the easy to read macros into a panorama readable file

 
//step 2
//this lets you load your changes back in from an editor and put them in
//copy your changed full procedure list back to your clipboard
//now comment out from step one to step 2
//run the procedure one step at a time to load the new list on your clipboard back in
//Dictionary2=clipboard()
loadallprocedures Dictionary2,ProcedureList
message ProcedureList //messages which procedures got changed
}

openprocedure "GetDBInfo"
setproceduretext {local DBChoice, vAnswer1, vClipHold

Message "This Procedure will give you the names of Fields, procedures, etc in the Database"
//The spaces are to make it look nicer on the text box
DBChoice="fields
forms
procedures
permanent
folder
level
autosave
fileglobals
filevariables
fieldtypes
records
selected
changes"
superchoicedialog DBChoice,vAnswer1,“caption="What Info Would You Like?"
captionheight=1”


vClipHold=dbinfo(vAnswer1,"")
bigmessage "Your clipboard now has the name(s) of "+str(vAnswer1)+"(s)"+¶+
"Preview: "+¶+str(vClipHold)
Clipboard()=vClipHold
}



openprocedure "Symbol Reference"
setproceduretext {bigmessage "Option+7= ¶  [in some functions use chr(13)
Option+= ≠ [not equal to]
Option+\= « || Option+Shift+\= » [chevron]
Option+L= ¬ [tab]
Option+Z= Ω [lineitem or Omega]
Option+V= √ [checkmark]
Option+M= µ [nano]
Option+<or>= ≤or≥ [than or equal to]"

}



///***********
///Clears all new windows made
//********
EndWindowList=listwindows("")
EndSize=arraysize(EndWindowList,¶)
vCount=1
loop 

WinChoice=str(array(EndWindowList,val(vCount),¶))
if StartingWinList notcontains WinChoice
  window WinChoice
closewindow
increment vCount
    case StartingWinList contains WinChoice
    increment vCount
        repeatloopif vCount≠EndSize+1
    endcase
else
increment vCount
endif
until vCount=EndSize+1
___ ENDPROCEDURE AddF __________________________________________________________

___ PROCEDURE (CommonFunctions) ________________________________________________

___ ENDPROCEDURE (CommonFunctions) _____________________________________________

___ PROCEDURE ExportMacros _____________________________________________________
local Dictionary1, ProcedureList
//this saves your procedures into a variable
exportallprocedures "", Dictionary1
clipboard()=Dictionary1

message "Macros are saved to your clipboard!"
___ ENDPROCEDURE ExportMacros __________________________________________________

___ PROCEDURE ImportMacros _____________________________________________________
local Dictionary1,Dictionary2, ProcedureList
Dictionary1=""
Dictionary1=clipboard()
yesno "Press yes to import all macros from clipboard"
if clipboard()="No"
stop
endif
//step one
importdictprocedures Dictionary1, Dictionary2
//changes the easy to read macros into a panorama readable file

 
//step 2
//this lets you load your changes back in from an editor and put them in
//copy your changed full procedure list back to your clipboard
//now comment out from step one to step 2
//run the procedure one step at a time to load the new list on your clipboard back in
//Dictionary2=clipboard()
loadallprocedures Dictionary2,ProcedureList
message ProcedureList //messages which procedures got changed

___ ENDPROCEDURE ImportMacros __________________________________________________

___ PROCEDURE Symbol Reference _________________________________________________
bigmessage "Option+7= ¶  [in some functions use chr(13)
Option+= ≠ [not equal to]
Option+\= « || Option+Shift+\= » [chevron]
Option+L= ¬ [tab]
Option+Z= Ω [lineitem or Omega]
Option+V= √ [checkmark]
Option+M= µ [nano]
Option+<or>= ≤or≥ [than or equal to]"


___ ENDPROCEDURE Symbol Reference ______________________________________________

___ PROCEDURE GetDBInfo ________________________________________________________
local DBChoice, vAnswer1, vClipHold

Message "This Procedure will give you the names of Fields, procedures, etc in the Database"
//The spaces are to make it look nicer on the text box
DBChoice="fields
forms
procedures
permanent
folder
level
autosave
fileglobals
filevariables
fieldtypes
records
selected
changes"
superchoicedialog DBChoice,vAnswer1,“caption="What Info Would You Like?"
captionheight=1”


vClipHold=dbinfo(vAnswer1,"")
bigmessage "Your clipboard now has the name(s) of "+str(vAnswer1)+"(s)"+¶+
"Preview: "+¶+str(vClipHold)
Clipboard()=vClipHold

___ ENDPROCEDURE GetDBInfo _____________________________________________________
