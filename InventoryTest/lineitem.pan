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