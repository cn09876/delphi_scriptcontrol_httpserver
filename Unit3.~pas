unit Unit3;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, Project1_TLB, StdVcl,classes,forms,dialogs,ComServ;

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
    procedure query; safecall;
    procedure sv; safecall;
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

procedure TTSwSSP.query;
begin

end;

procedure TTSwSSP.sv;
begin

end;

initialization
  CoInitialize(nil);
  TAutoObjectFactory.Create(ComServer, TTSwSSP, Class_TSwSSP,
    ciMultiInstance, tmApartment);
end.
