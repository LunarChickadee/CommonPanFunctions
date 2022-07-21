ordered=str(id_number) 
+¬+str(item)+
"-"+
upper(size)+¬+
/*item number*/
?(item >=10000,""," ")+
?(item=8999,extract(extract(enter,¶,numb),chr(43),5)[1,19] + rep(chr(32),19-length(extract(extract(enter,¶,numb),chr(43),5)[1,19])),

lookup(
    ?(item≥10000 and item≤30000,"45ogscomments.warehouse","45ogscomments.linked")
    ,"Item", 
    str(item) + "-" + upper(size),
    "Description",
    "Not OGS",0)
    [1,23])
+
/*adds description looked up from 45ogscomments.linked*/
rep(chr(32),23-length(
    lookup(
        ?(item≥10000 and item≤30000,"45ogscomments.warehouse","45ogscomments.linked"),
        "Item",
        str(item) + "-" + upper(size),
        "Description",
            "Not OGS",0)
            [1,23]))                                                                                    
            /*if item number is 8999 or 9999, put some padding and then the manually entered description. Otherwise, add padding. */
            +rep(chr(32),5-length(str(lookup(?(item≥10000 and item≤30000,"45ogscomments.warehouse","45ogscomments.linked"),"Item",str(item) + "-" + upper(size),«Sz.»,
            0,0))))+¬+str(lookup(?(item≥10000 and item≤30000,"45ogscomments.warehouse","45ogscomments.linked"),"Item",str(item) + "-" + upper(size),«Sz.»,
            0,0))+"#"+¬+                                                                                                /*adds spacing for size, and size, from 45ogscomments.linked (manual items get size 0#)*/
            rep(chr(32), 6-length(str(quant)))+str(quant)+¬+
            rep(chr(32),7-length(pattern(price,"#.##")))+pattern(price,"$#.##")+¬+
            rep(chr(32),8-length(pattern(tot,"#.##")))+pattern(tot,"$#.##")+¶