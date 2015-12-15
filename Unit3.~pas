unit Unit3;

{$WARN SYMBOL_PLATFORM OFF}
{$TYPEDADDRESS OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}

interface

uses
  ComObj, ActiveX, StdVcl,classes,forms,dialogs,ComServ,ucommon,sysutils;

const
  CLASS_TSwSSP: TGUID = '{AAAAAAAD-6446-43F4-9089-8C94EFE45287}';

type

  ISwSSP=interface(IDispatch)
    ['{65DE76C2-1556-49D2-BCE7-20836275168C}']
    procedure echo(str: OleVariant); safecall;
    function rq(s: OleVariant): OleVariant; safecall;
    function query_sql(s: OleVariant): OleVariant; safecall;
    procedure q; safecall;
    function sv(s: OleVariant): OleVariant; safecall;
  end;


type
  TTSwSSP = class(TAutoObject, ISwSSP)
  protected
    procedure echo(str: OleVariant); safecall;
    function rq(s: OleVariant): OleVariant; safecall;
    procedure q; safecall;
    function sv(s: OleVariant): OleVariant; safecall;
    function query_sql(s: OleVariant): OleVariant; safecall;
  public
    requestParams:tstrings;
    responseText:string;
  end;

implementation


procedure TTSwSSP.echo(str: OleVariant);
begin
  responseText:=responseText+str;
end;

function TTSwSSP.rq(s: OleVariant): OleVariant;
begin
  try
    result:=requestParams.Values[s];
  except
    result:='';
  end;
end;


procedure TTSwSSP.q;
begin

end;

function TTSwSSP.query_sql(s: OleVariant): OleVariant;
var
  sRet:string;
  r:getrs;
  i:integer;
begin
  try
    r:=getrs.Create(s);
  except
    on e:Exception do
    begin
      self.echo('error execute sql: '+#13#10+s+#13#10+e.message);
      result:='';
      exit;
    end;
  end;

  sRet:='<data>'+#13#10;
  sRet:=sRet+'<cols>';
  for i:=0 to r.rs.Fields.Count-1 do
  begin
    sRet:=sRet+r.rs.Fields[i].DisplayName;
    if i<r.rs.Fields.Count-1 then sRet:=sRet+',';
  end;
  sRet:=sRet+'</cols>'+#13#10;


  sRet:=sRet+'<rows>';
  while not r.eof do
  begin
    for i:=0 to r.rs.Fields.Count-1 do
    begin
      sRet:=sRet+r.rs.Fields[i].AsString;
      if i<r.rs.Fields.Count-1 then sRet:=sRet+'###';
    end;
    r.next;
    if not r.eof then sRet:=sRet+'```';
  end;
  sRet:=sRet+'</rows>'+#13#10;
  r.close;
  sRet:=sRet+'</data>';
  result:=sRet;
end;

function TTSwSSP.sv(s: OleVariant): OleVariant;
begin
  result:=ucommon.sv(s);
end;

initialization
  CoInitialize(nil);
  TAutoObjectFactory.Create(ComServer, TTSwSSP, Class_TSwSSP,ciMultiInstance, tmApartment);
  
end.
