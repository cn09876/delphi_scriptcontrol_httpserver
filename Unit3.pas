unit Unit3;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, Project1_TLB, StdVcl,classes,forms,dialogs,ComServ,ucommon,sysutils;

type
  TTSwSSP = class(TAutoObject, ISwSSP)
  protected
    function test(aa: OleVariant): OleVariant; safecall;
    procedure echo(str: OleVariant); safecall;
    function rq(s: OleVariant): OleVariant; safecall;
    procedure base64_decode; safecall;
    procedure base64_encode; safecall;
    procedure file_get_contents; safecall;
    procedure file_put_contents; safecall;
    procedure md5; safecall;
    procedure q; safecall;
    function query(s: OleVariant): OleVariant; safecall;
    function sv(s: OleVariant): OleVariant; safecall;
  public
    requestParams:tstrings;
    responseText:string;
  end;

implementation

function TTSwSSP.test(aa: OleVariant): OleVariant;
begin
  showmessage(aa);
end;

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


procedure TTSwSSP.base64_decode;
begin

end;

procedure TTSwSSP.base64_encode;
begin

end;

procedure TTSwSSP.file_get_contents;
begin

end;

procedure TTSwSSP.file_put_contents;
begin

end;

procedure TTSwSSP.md5;
begin

end;

procedure TTSwSSP.q;
begin

end;

function TTSwSSP.query(s: OleVariant): OleVariant;
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
  TAutoObjectFactory.Create(ComServer, TTSwSSP, Class_TSwSSP,
    ciMultiInstance, tmApartment);
end.
