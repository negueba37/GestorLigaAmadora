unit Model.Entities.Confronto;

interface
  Type
  TModelEntitiesConfronto = record
    CodigoConfronto:Integer;
    CodigoAspMandante:Integer;
    CodigoAspVisitante:Integer;
    CodigoTitMandante:Integer;
    CodigoTitVisitante:Integer;
    NomeTimeMandante:string;
    NomeTimeVisitante:string;
    GolAspMandante:Integer;
    GolAspVisitante:Integer;
    GolTitMandante:Integer;
    GolTitVisitante:Integer;
    NumeroRodada:Integer;
    DataRodada:String;
  end;

implementation

end.
