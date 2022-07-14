local BuildSKU
BuildSKU=upperword(CurrentUser[1,6])+upperword(Type[1,6])+upperword(Model[1,6])+upperword(Barcode[-4,-1])
message BuildSKU