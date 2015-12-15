unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ComObj, StdCtrls,OleCtrls,unit3, MSScriptControl_TLB,
  IdBaseComponent, IdComponent, IdTCPServer, IdCustomHTTPServer,
  IdHTTPServer,idglobal,idcontext,activex,ucommon,SHDocVw;

type
  TForm1 = class(TForm)
    httpd: TIdHTTPServer;
    WebBrowser1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure httpdCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo);
  private
    { Private declarations }
  public
    function file_get_contents(s: string): string;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.file_get_contents(s: string): string;
var
	list:tStrings;
begin
  list:=tStringList.Create;
  list.LoadFromFile(s);
  result:=list.Text;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  httpd.DefaultPort:=809;
  httpd.Active:=true;
  ucommon.init;
  self.WebBrowser1.Navigate('http://127.0.0.1:809/d.ssf');
end;

procedure TForm1.httpdCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  MyObject: TTSwSSP;
  vbs:TScriptControl;
  thePath:string;
  script_content:string;
begin
  thePath:=sysutils.ExtractFilePath(application.ExeName);
  CoInitialize(nil);

  if uppercase(sysutils.ExtractFileExt(arequestinfo.Document))<>'.SSF' then
  begin
    aresponseinfo.ServeFile(acontext,thePath+arequestinfo.Document);
    exit;
  end;

  try
    vbs:=TScriptControl.Create(self);
    MyObject:= TTSwSSP.Create;
    MyObject.ObjAddRef;
    myobject.requestParams:=arequestinfo.Params;
    myobject.responseText:='';
    vbs.Language:='VBScript';
    vbs.Reset;
    vbs.Error.Clear;

    vbs.AddObject('sw', MyObject, True);

    if fileexists(thePath+arequestinfo.Document) then
    begin
      script_content:=file_get_contents(thePath+arequestinfo.Document);
    end
    else
    begin
      aresponseinfo.ContentText:='404 '+ARequestInfo.Document+' not found';
      exit;
    end;

    try
      vbs.ExecuteStatement(script_content);
    except
      on e:exception do
      begin
        myobject.responseText:=myobject.responseText+e.Message;
      end;
    end;

    aresponseinfo.ContentText:=myobject.responseText;
    vbs.FreeOnRelease;
    vbs.Free;
    myobject.ObjRelease;
  except
    on e:exception do
    begin
      aresponseinfo.ContentText:='error execute '+ARequestInfo.Document+' '+e.Message;
    end;
  end;

  //


end;

initialization
  CoInitialize(nil);

  
end.
