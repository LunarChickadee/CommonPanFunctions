global RecordSave,HistoryAdd,vName,WhereToAdd,vNotes,FieldsToUpdate,UpdatedFields

/*
Yesno "DId you complete the repair on "+«Model»+"('s)"+" "+RepairsToDo
save
if clipboard()="Yes"
CopyRecord
RecordSave=clipboard()
gettext "Type Your Name",vName
gettext "Add any Additional Notes here: ",vNotes
*/
HistoryAdd=datepattern(today(),"mm-dd-yy")+";"+RepairsToDo+";"+vName+";"+vNotes
//finds next blank date to add repair info
WhereToAdd=arraysearch(lineitemarray(RepairDateΩ,¶),"",1,¶)
FieldsToUpdate=dbinfo("fields","")
arrayfilter FieldsToUpdate, UpdatedFields,¶,?(FieldsToUpdate contains str(WhereToAdd),UpdatedFields=FieldsToUpdate,"")
message UpdatedFields
stop
«NeedsRepair?»="No"
RepairsToDo=""
//endif

