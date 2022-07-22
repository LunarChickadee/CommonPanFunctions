      MYDESCRIPTION = lookup("45ogscomments","Item",str(item) + "-" + upper(size),"Description","",0) + ?(lookup("45ogscomments","Item",str(item) + "-" + upper(size),"UnitNumber","",0)<>"","-"+lookup("45ogscomments","Item",str(item) + "-" + upper(size),"UnitNumber","",0)+lookup("45ogscomments","Item",str(item) + "-" + upper(size),"UnitName","",0),"")

      newLookup=?(lookup("45ogscomments","Item",str(item) + "-" + upper(size),"UnitNumber","",0)<>"","-"+lookup("45ogscomments","Item",str(item) + "-" + upper(size),"UnitNumber","",0)+lookup("45ogscomments","Item",str(item) + "-" + upper(size),"UnitName","",0),"")
      newLookup=
      newLookup=