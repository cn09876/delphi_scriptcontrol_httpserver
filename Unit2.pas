unit Unit2;

interface


type
clsUtil=class
  public
    function make(s:string):string;
end;


implementation

function clsUtil.make(s:string):string;
begin
  result:=s+' OK';
end;

end.
 