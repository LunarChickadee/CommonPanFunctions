      MYDESCRIPTION = lookup("45ogscomments","Item",Item,"Description","",0) + ?(lookup("45ogscomments","Item",Item,"UnitNumber","",0)<>"","-"+lookup("45ogscomments","Item",Item,"UnitNumber","",0)+lookup("45ogscomments","Item",Item,"UnitName","",0),"")


    +rep(chr(32),31-length(MYDESCRIPTION))
    +MYDESCRIPTION+¬

      
      
      
      
      MYDESCRIPTION = lookup("45ogscomments","Item",str(item) + "-" + upper(size),"Description","",0) + ?(lookup("45ogscomments","Item",str(item) + "-" + upper(size),"UnitNumber","",0)<>"","-"+lookup("45ogscomments","Item",str(item) + "-" + upper(size),"UnitNumber","",0)+lookup("45ogscomments","Item",str(item) + "-" + upper(size),"UnitName","",0),"")


//I tried to make a new one and failed

      newLookup=?(lookup("45ogscomments","Item",str(item) + "-" + upper(size),"UnitNumber","",0)<>"","-"+lookup("45ogscomments","Item",str(item) + "-" + upper(size),"UnitNumber","",0)+lookup("45ogscomments","Item",str(item) + "-" + upper(size),"UnitName","",0),"")
      newLookup=
      newLookup=