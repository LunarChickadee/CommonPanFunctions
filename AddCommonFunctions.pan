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