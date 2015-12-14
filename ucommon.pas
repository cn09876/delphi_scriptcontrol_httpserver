{
功能：Delphi 通用函数库
作者：孙威威
}
unit uCommon;

interface

uses
	DB, ADODB,comobj,Dialogs,Variants,inifiles,Forms,windows,shellapi,
  sysutils,classes,registry,Tlhelp32;

const
  sTplConnectionString='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;'+'Jet OLEDB:Database Password=%s;';

type
    //自定义的记录集
    getrs=class(tObject)
    	private
      public
      	eof:boolean;
        sql:string;
        rs:tAdoQuery;
        ds:tDataSource;
        constructor Create(sql:string;ado_conn:tadoconnection=nil);
		    destructor Destroy;
        function getRecordCount:integer;
        property recordCount:integer read getRecordCount;
        procedure addnew;
        procedure update;
        procedure delete;
        function value(k:string):string;overload;
        function v(k:string):string;overload;
        function vdbl(k:string):Double;overload;
        function vint(k:string):Integer;overload;
        function value(i:integer):string;overload;

        procedure field(k:string;v:string);overload;
        procedure field(k:string;v:Integer);overload;
        procedure field(k:string;v:Double);overload;

        procedure next;
        procedure close;
    end;

    //初始化
    procedure init;

    //存取配置参数（在数据库中）
    function reg(key:string;v:string=''):string;
    procedure speak(s: string);
    function year(dt:tdatetime):integer;

    //读写INI配置文件
		function ini(key:string;v:string=''):string;

    //弹出信息提示框
		procedure msgbox(msg:variant);
    function GetPart(StrSource,StrBegin,StrEnd:string):string;


    //替换字符串
    function replace(a,b,c:string):string;

    //弹出确认提示框
    function confirm(str:string):boolean;

    procedure msgerr(str:string);

    //过滤字符串为安全字符
    function sqlstr(s:string):string;
    function py(Value: string): string;  


    //对tStrings进行排序
    procedure sortStrings(stringList:TStrings);
    function sqlValue(sql:string;ado_conn:TAdoConnection=nil):string;
    function sqlValueCache(sql:string;ado_conn:TAdoConnection=nil):string;
    function sv(sql:string;ado_conn:TAdoConnection=nil):string;
    function svc(sql:string;ado_conn:TAdoConnection=nil):string;
    procedure q(sql:string;ado_conn:TAdoConnection=nil);
    procedure q_(sql:string;ado_conn:TAdoConnection=nil);
    function num2min_sec_dot(sec:integer):string;

    function getSexStr(s:string):string;
    function getNjNum(s: string): string;
    function getNjStr(s: string): string;

    //字符串转化为整数
    function cint(str:string):integer;
    function isnum(str:string):boolean;
    function isint(str:string):boolean;

    function cstr(s:integer):string; overload;
    function cstr(s:double): string; overload;

    function pct(a,b:string):string;overload;
    function pct(a,b:double):string;overload;
    function pct(a,b:integer):string;overload;

    function num2gb(i:integer): string;

    function instr(a,b:string):boolean;
    //字符串转化为浮点数
    function cdbl(str:string):double;

    //增加到自动运行(注册表)
    function RegAddToRun(Name,Value:string):Boolean;

    //取得系统内串口
    function GetSysCom():tstrings;



    //读文本文件
    function readTextFile(fileName:string):tStrings;

    //写文本文件
    procedure writeTextFile(content:string;filename:string);

    //写日志
    procedure log(strFile:string;strLog:string);


    function wait(MaxWaitTime: Cardinal): Boolean;

    //解密字串

    //把字符串Str编码为Base64字符串返回
    function StrToBase64(const Str: string): string;

    //把Base64字符串解码为字符串返回
    function Base64ToStr(const Base64: string): string;

    function num2min_sec(ss:string):string;
    function jm(ss:string):string;
    {*******Base64内部调用********}
    //将SourceSize长度的源Source编码为Base64字符串返回
    function Base64Encode(const Source; SourceSize: Integer): string; overload;
    //将Source从StartPos开始的Size长度的内容源编码为Base64，写入流Dest。Size=0文件结束
    procedure Base64Encode(Source, Dest: TStream; StartPos: Int64 = 0; Size: Int64 = 0); overload;
    //按给定的编码源Source和长度Size计算并返回解码缓冲区实际所需长度
    function Base64DecodeBufSize(const Source; Size: Integer): Integer;
    //将Base64编码字符串Source解码存放在Buf中，返回解码长度
    function Base64Decode(const Source: string; var Buf): Integer; overload;
    //将Source从StartPos开始的Size长度的Base64编码内容解码，写入流Dest。Size=0文件结束
    procedure Base64Decode(Source, Dest: TStream; StartPos: Int64 = 0; Size: Int64 = 0); overload;
    {*******Base64内部调用********}
  function StrEncode(ss: string): string;
  function StrDecode(ss: string): string;
  function RunDosCommand(Command: string): string;


var
	cn:tAdoConnection;
  path:string;

const py__: array[216..247] of string = (
{216}'CJWGNSPGCGNESYPB' + 'TYYZDXYKYGTDJNMJ' + 'QMBSGZSCYJSYYZPG' +
{216}'KBZGYCYWYKGKLJSW' + 'KPJQHYZWDDZLSGMR' + 'YPYWWCCKZNKYDG',
{217}'TTNJJEYKKZYTCJNM' + 'CYLQLYPYQFQRPZSL' + 'WBTGKJFYXJWZLTBN' +  
{217}'CXJJJJZXDTTSQZYC' + 'DXXHGCKBPHFFSSYY' + 'BGMXLPBYLLLHLX',  
{218}'SPZMYJHSOJNGHDZQ' + 'YKLGJHXGQZHXQGKE' + 'ZZWYSCSCJXYEYXAD' +  
{218}'ZPMDSSMZJZQJYZCD' + 'JEWQJBDZBXGZNZCP' + 'WHKXHQKMWFBPBY',  
{219}'DTJZZKQHYLYGXFPT' + 'YJYYZPSZLFCHMQSH' + 'GMXXSXJJSDCSBBQB' +  
{219}'EFSJYHXWGZKPYLQB' + 'GLDLCCTNMAYDDKSS' + 'NGYCSGXLYZAYBN',  
{220}'PTSDKDYLHGYMYLCX' + 'PYCJNDQJWXQXFYYF' + 'JLEJBZRXCCQWQQSB' +  
{220}'ZKYMGPLBMJRQCFLN' + 'YMYQMSQYRBCJTHZT' + 'QFRXQHXMJJCJLX',  
{221}'QGJMSHZKBSWYEMYL' + 'TXFSYDSGLYCJQXSJ' + 'NQBSCTYHBFTDCYZD' +  
{221}'JWYGHQFRXWCKQKXE' + 'BPTLPXJZSRMEBWHJ' + 'LBJSLYYSMDXLCL',  
{222}'QKXLHXJRZJMFQHXH' + 'WYWSBHTRXXGLHQHF' + 'NMCYKLDYXZPWLGGS' +  
{222}'MTCFPAJJZYLJTYAN' + 'JGBJPLQGDZYQYAXB' + 'KYSECJSZNSLYZH',  
{223}'ZXLZCGHPXZHZNYTD' + 'SBCJKDLZAYFMYDLE' + 'BBGQYZKXGLDNDNYS' +  
{223}'KJSHDLYXBCGHXYPK' + 'DQMMZNGMMCLGWZSZ' + 'XZJFZNMLZZTHCS',  
{224}'YDBDLLSCDDNLKJYK' + 'JSYCJLKOHQASDKNH' + 'CSGANHDAASHTCPLC' +  
{224}'PQYBSDMPJLPCJOQL' + 'CDHJJYSPRCHNKNNL' + 'HLYYQYHWZPTCZG',  
{225}'WWMZFFJQQQQYXACL' + 'BHKDJXDGMMYDJXZL' + 'LSYGXGKJRYWZWYCL' +  
{225}'ZMSSJZLDBYDCPCXY' + 'HLXCHYZJQSQQAGMN' + 'YXPFRKSSBJLYXY',  
{226}'SYGLNSCMHCWWMNZJ' + 'JLXXHCHSYD CTXRY' + 'CYXBYHCSMXJSZNPW' +  
{226}'GPXXTAYBGAJCXLYS' + 'DCCWZOCWKCCSBNHC' + 'PDYZNFCYYTYCKX',  
{227}'KYBSQKKYTQQXFCWC' + 'HCYKELZQBSQYJQCC' + 'LMTHSYWHMKTLKJLY' +  
{227}'CXWHEQQHTQHZPQSQ' + 'SCFYMMDMGBWHWLGS' + 'LLYSDLMLXPTHMJ',  
{228}'HWLJZYHZJXHTXJLH' + 'XRSWLWZJCBXMHZQX' + 'SDZPMGFCSGLSXYMJ' +  
{228}'SHXPJXWMYQKSMYPL' + 'RTHBXFTPMHYXLCHL' + 'HLZYLXGSSSSTCL',  
{229}'SLDCLRPBHZHXYYFH' + 'BBGDMYCNQQWLQHJJ' + 'ZYWJZYEJJDHPBLQX' +  
{229}'TQKWHLCHQXAGTLXL' + 'JXMSLXHTZKZJECXJ' + 'CJNMFBYCSFYWYB',  
{230}'JZGNYSDZSQYRSLJP' + 'CLPWXSDWEJBJCBCN' + 'AYTWGMPABCLYQPCL' +  
{230}'ZXSBNMSGGFNZJJBZ' + 'SFZYNDXHPLQKZCZW' + 'ALSBCCJXJYZHWK',  
{231}'YPSGXFZFCDKHJGXD' + 'LQFSGDSLQWZKXTMH' + 'SBGZMJZRGLYJBPML' +  
{231}'MSXLZJQQHZSJCZYD' + 'JWBMJKLDDPMJEGXY' + 'HYLXHLQYQHKYCW',  
{232}'CJMYYXNATJHYCCXZ' + 'PCQLBZWWYTWBQCML' + 'PMYRJCCCXFPZNZZL' +  
{232}'JPLXXYZTZLGDLDCK' + 'LYRLZGQTGJHHGJLJ' + 'AXFGFJZSLCFDQZ',  
{233}'LCLGJDJCSNCLLJPJ' + 'QDCCLCJXMYZFTSXG' + 'CGSBRZXJQQCTZHGY' +  
{233}'QTJQQLZXJYLYLBCY' + 'AMCSTYLPDJBYREGK' + 'JZYZHLYSZQLZNW',  
{234}'CZCLLWJQJJJKDGJZ' + 'OLBBZPPGLGHTGZXY' + 'GHZMYCNQSYCYHBHG' +  
{234}'XKAMTXYXNBSKYZZG' + 'JZLQJDFCJXDYGJQJ' + 'JPMGWGJJJPKQSB',  
{235}'GBMMCJSSCLPQPDXC' + 'DYYKYWCJDDYYGYWR' + 'HJRTGZNYQLDKLJSZ' +  
{235}'ZGZQZJGDYKSHPZMT' + 'LCPWNJAFYZDJCNMW' + 'ESCYGLBTZCGMSS',  
{236}'LLYXQSXSBSJSBBGG' + 'GHFJLYPMZJNLYYWD' + 'QSHZXTYYWHMCYHYW' +  
{236}'DBXBTLMSYYYFSXJC' + 'SDXXLHJHF SXZQHF' + 'ZMZCZTQCXZXRTT',  
{237}'DJHNNYZQQMNQDMMG' + 'LYDXMJGDHCDYZBFF' + 'ALLZTDLTFXMXQZDN' +  
{237}'GWQDBDCZJDXBZGSQ' + 'QDDJCMBKZFFXMKDM' + 'DSYYSZCMLJDSYN',  
{238}'SPRSKMKMPCKLGDBQ' + 'TFZSWTFGGLYPLLJZ' + 'HGJJGYPZLTCSMCNB' +  
{238}'TJBQFKTHBYZGKPBB' + 'YMTDSSXTBNPDKLEY' + 'CJNYCDYKZDDHQH',  
{239}'SDZSCTARLLTKZLGE' + 'CLLKJLQJAQNBDKKG' + 'HPJTZQKSECSHALQF' +  
{239}'MMGJNLYJBBTMLYZX' + 'DCJPLDLPCQDHZYCB' + 'ZSCZBZMSLJFLKR',  
{240}'ZJSNFRGJHXPDHYJY' + 'BZGDLJCSEZGXLBLH' + 'YXTWMABCHECMWYJY' +  
{240}'ZLLJJYHLGBDJLSLY' + 'GKDZPZXJYYZLWCXS' + 'ZFGWYYDLYHCLJS',  
{241}'CMBJHBLYZLYCBLYD' + 'PDQYSXQZBYTDKYYJ' + 'YYCNRJMPDJGKLCLJ' +  
{241}'BCTBJDDBBLBLCZQR' + 'PPXJCGLZCSHLTOLJ' + 'NMDDDLNGKAQHQH',  
{242}'JHYKHEZNMSHRP QQ' + 'JCHGMFPRXHJGDYCH' + 'GHLYRZQLCYQJNZSQ' +  
{242}'TKQJYMSZSWLCFQQQ' + 'XYFGGYPTQWLMCRNF' + 'KKFSYYLQBMQAMM',  
{243}'MYXCTPSHCPTXXZZS' + 'MPHPSHMCLMLDQFYQ' + 'XSZYJDJJZZHQPDSZ' +  
{243}'GLSTJBCKBXYQZJSG' + 'PSXQZQZRQTBDKYXZ' + 'KHHGFLBCSMDLDG',  
{244}'DZDBLZYYCXNNCSYB' + 'ZBFGLZZXSWMSCCMQ' + 'NJQSBDQSJTXXMBLT' +  
{244}'XZCLZSHZCXRQJGJY' + 'LXZFJPHYXZQQYDFQ' + 'JJLZZNZJCDGZYG',  
{245}'CTXMZYSCTLKPHTXH' + 'TLBJXJLXSCDQXCBB' + 'TJFQZFSLTJBTKQBX' +  
{245}'XJJLJCHCZDBZJDCZ' + 'JDCPRNPQCJPFCZLC' + 'LZXBDMXMPHJSGZ',  
{246}'GSZZQLYLWTJPFSYA' + 'SMCJBTZYYCWMYTCS' + 'JJLQCQLWZMALBXYF' +  
{246}'BPNLSFHTGJWEJJXX' + 'GLLJSTGSHJQLZFKC' + 'GNNDSZFDEQFHBS',  
{247}'AQTGYLBXMMYGSZLD' + 'YDQMJJRGBJTKGDHG' + 'KBLQKBDMBYLXWCXY' +  
{247}'TTYBKMRTJZXQJBHL' + 'MHMJJZMQASLDCYXY' + 'QDLQCAFYWYXQHZ');
    
function f0j1(a: double): double;
function round45(dd: double): double;
procedure log_sys(s: string);
function g(sql: string;ado_conn:TAdoConnection=nil): getrs;
function len(s: string): integer;
Function getHDDSN(): string;
function getSysSN():string;
function getSYSSerial(s:string):string;
function m2s(vm:Double):integer;
function s2m(vs:integer):double;
function KillTask(ExeFileName: string): integer;
function isDate(str: string): boolean;
procedure showInfoWin(str: string);
function md5_(s: string): string;
procedure showFrm(strFormName: string);
function CompactDatabase(AFileName,APassWord:string):boolean;
procedure ShowPhpRpt(strRptName:string);
procedure check1024;
function leftstr(s:string;i:integer):string;
function replace_common(s: string): string;
function mz(n: integer): string;
procedure add_taskbar_menu;
function cdate(sTime:String):TDateTime;


implementation


const
	Base64_Chars: array[0..63] of char = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

type
  Base64Proc = function(const Source; var Buf; SourceSize: Integer): Integer;


function jm(ss:string):string;
var
  i:integer;
begin
  for i:=1 to length(ss) do ss[i]:=chr((ord(ss[i]) xor i)-133);
  result:=ss;
end;


function RunDosCommand(Command: string): string;
var
  hReadPipe: THandle;
  hWritePipe: THandle;
  SI: TStartUpInfo;
  PI: TProcessInformation;
  SA: TSecurityAttributes;
  //     SD   :   TSecurityDescriptor;
  BytesRead: DWORD;
  Dest: array[0..1023] of char;
  CmdLine: array[0..512] of char;
  TmpList: TStringList;
  Avail, ExitCode, wrResult: DWORD;
  osVer: TOSVERSIONINFO;
  tmpstr: AnsiString;
begin
  osVer.dwOSVersionInfoSize := Sizeof(TOSVERSIONINFO);
  GetVersionEX(osVer);

  if osVer.dwPlatformId = VER_PLATFORM_WIN32_NT then
  begin
  //         InitializeSecurityDescriptor(@SD,   SECURITY_DESCRIPTOR_REVISION);
  //         SetSecurityDescriptorDacl(@SD,   True,   nil,   False);
    SA.nLength := SizeOf(SA);
    SA.lpSecurityDescriptor := nil; //@SD;
    SA.bInheritHandle := True;
    CreatePipe(hReadPipe, hWritePipe, @SA, 0);
  end
  else
    CreatePipe(hReadPipe, hWritePipe, nil, 1024);
  try
    FillChar(SI, SizeOf(SI), 0);
    SI.cb := SizeOf(TStartUpInfo);
    SI.wShowWindow := SW_HIDE;
    SI.dwFlags := STARTF_USESHOWWINDOW;
    SI.dwFlags := SI.dwFlags or STARTF_USESTDHANDLES;
    SI.hStdOutput := hWritePipe;
    SI.hStdError := hWritePipe;
    StrPCopy(CmdLine, Command);
    if CreateProcess(nil, CmdLine, nil, nil, True, NORMAL_PRIORITY_CLASS, nil, nil, SI, PI) then
    begin
      ExitCode := 0;
      while ExitCode = 0 do
      begin
        wrResult := WaitForSingleObject(PI.hProcess, 500);
        if PeekNamedPipe(hReadPipe, @Dest[0], 1024, @Avail, nil, nil) then
        begin
          if Avail > 0 then
          begin
            TmpList := TStringList.Create;
            try
              FillChar(Dest, SizeOf(Dest), 0);
              ReadFile(hReadPipe, Dest[0], Avail, BytesRead, nil);
              TmpStr := Copy(Dest, 0, BytesRead - 1);
              TmpList.Text := TmpStr;
              Result := tmpstr;
            finally
              TmpList.Free;
            end;
          end;
        end;
        if wrResult <> WAIT_TIMEOUT then ExitCode := 1;
      end;
      GetExitCodeProcess(PI.hProcess, ExitCode);
      CloseHandle(PI.hProcess);
      CloseHandle(PI.hThread);
    end;
  finally
    CloseHandle(hReadPipe);
    CloseHandle(hWritePipe);
  end;
end;


function num2min_sec(ss:string):string;
var
  s1,s2,s3:string;
begin
  if ss='' then
  begin
    result:='';
    exit;
  end;
  if instr(ss,'.') then
  begin
    s1:=ss;
    s2:=copy(s1,0,pos('.',s1)-1);
    s3:=copy(s1,pos('.',s1)+1,2);
    if length(s3)=1 then s3:=s3+'0';
    result:=s2+'′'+s3+'″';
  end
  else
  begin
    result:=ss+'′00″';
  end;
end;


procedure sortStrings(stringList:TStrings);
var
  I, J, P,L,R: Integer;
  vot:string;
begin
  L:=0;
  R:=stringlist.Count-1;
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      vot := stringList.Strings[P];
      while CompareStr(vot,stringList.Strings[I]) < 0 do Inc(I);
      while CompareStr(vot,stringList.Strings[J]) > 0 do Dec(J);
      if I <= J then
      begin
        vot := stringList.Strings[I];
        stringList.Strings[I] := stringList.Strings[J];
        stringList.Strings[J] := vot;
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then Sortstrings(stringList);
    L := I;
  until I >= R;
end;


function GetSysCom():tstrings;
var
	i: integer;
	Reg: TRegistry;
	RegStr: string;
	tmpList,list: TStrings;
begin
	list:=tstringlist.Create;
	RegStr := '\HARDWARE\DEVICEMAP\SERIALCOMM';
	Reg := TRegistry.Create;
	Reg.RootKey := HKEY_LOCAL_MACHINE;
	if Reg.OpenKey(RegStr, False) then
	begin
		tmpList := TStringList.Create;
		Reg.GetValueNames(tmpList);
		for i := 0 to tmpList.Count - 1 do
		begin
      if tmpList.Strings[i]<>'Winachsf0' then list.Add(Reg.ReadString(tmpList.Strings[i]));
		end;
		freeAndnil(tmpList);
	end;
	freeAndnil(Reg);
	result:=list;
end;


{原读取文本文件}
function readTextFile(fileName:string):tStrings;
var
	list:tStrings;
begin
  list:=tStringList.Create;
  list.LoadFromFile(fileName);
  result:=list;
end;

procedure writeTextFile(content:string;filename:string);
var
	list:tStrings;
begin
  list:=tStringList.Create;
  list.Text:=content;
  list.SaveToFile(filename);
  list.Free;
end;

function RegAddToRun(Name,Value:string):Boolean;
var
  Reg:TRegistry;
  Values:string;
begin
  Result:=False;

  try
    Reg:=TRegistry.Create;
    try
      Reg.RootKey:=HKEY_LOCAL_MACHINE;
      Reg.OpenKey('software\microsoft\windows\currentversion\run\',False);
      Values:=Reg.ReadString(Name);
      if Values<>Value then
      begin
        Reg.WriteString(Name,Value);
        Result:=True;
      end;
    finally
      Reg.Free;
    end;
  except

  end;
end;

procedure log(strFile:string;strLog:string);
var
  f:text;
begin
end;


{关闭计算机}
function WinExit(iFlags: integer) : Boolean;
{
 0:注销
 1:关闭计算机
 2:重新启动计算机
 4:强制注销(不保存状态)
 8:关闭电源
 16:注销
}

  function SetPrivilege (sPrivilegeName: string; bEnabled: Boolean) : Boolean;
  var
    TPPrev,TP: TTokenPrivileges;
    Token    : THandle;
    dwRetLen : DWORD;
  begin
    result := False;
    OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, Token);
    TP.PrivilegeCount := 1;
    if LookupPrivilegeValue (nil, PChar (sPrivilegeName), TP.Privileges[0].LUID) then
    begin
      if bEnabled then TP.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED
      else TP.Privileges[0].Attributes := 0;
      dwRetLen := 0;
      result := AdjustTokenPrivileges(Token, False, TP, SizeOf (TPPrev), TPPrev,dwRetLen);
    end;
    CloseHandle(Token);
  end;

begin
  Result:=False;
  if SetPrivilege ('SeShutdownPrivilege', true) then
  begin
    if  ExitWindowsEx(iFlags, 0) then result:=True;
    SetPrivilege ('SeShutdownPrivilege', False);
  end
end;





function StrEncode(ss: string): string;
var
  i:integer;
  crc:byte;
begin
  result:='';
  for i:=1 to Length(ss) do
  begin
    result:=result+inttohex(Ord(ss[i]) xor i*2,2);
  end;
  crc:=0;
  for i:=1 to Length(Result) do
  begin
    crc:=crc+ord(result[i]);
  end;
  result:=result+inttohex(crc,2);
end;

function StrDecode(ss: string): string;
var
  i:integer;
  crc:Byte;
begin
  ss:=UpperCase(ss);
  if Length(ss) mod 2<>0 then
  begin
    result:='';
    Exit;
  end;

  for i:=1 to Length(ss)-2 do crc:=crc+ord(ss[i]);
  if cint('$'+copy(ss,Length(ss)-1,2))<>crc then
  begin
    result:='';
    Exit;
  end;

  result:='';
  for i:=1 to (Length(ss)-2) div 2 do
  begin
    result:=result+chr(cint('$'+copy(ss,i*2-1,2)) xor i*2);
  end;
end;



procedure init;
var
  r:getrs;
  s:string;
  i,j:integer;
  b:boolean;
  sChkAll:String;
  connstr:string;
begin
  connstr:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+sysutils.ExtractFilePath(application.exename)+'/db.mdb;Jet OLEDB:Database Password=;';
  cn:=tAdoConnection.Create(nil);
  cn.ConnectionString:=connstr;
  cn.KeepConnection:=true;
  cn.LoginPrompt:=False;

  try
    cn.Open();
  except
    msgerr('系统初始化失败');
    Application.Terminate;
    ExitProcess(0);
  end;

end;

function wait(MaxWaitTime: Cardinal): Boolean;
var
  I:Integer;
  WaitedTime:Cardinal;
begin
  WaitedTime:=0;
  while WaitedTime<MaxWaitTime do
  begin
    SleepEx(100,False);
    Inc(WaitedTime,100);
    Application.ProcessMessages ;
  end
end;




function replace(a,b,c:string):string;
begin
	result:=stringreplace(a,b,c,[rfReplaceAll, rfIgnoreCase]);
end;

function cint(str:string):integer;
var
	e:integer;
begin
	if str='' then
  	result:=0
  else
  	val(str,result,e);
end;

function isnum(str:string):boolean;
var
  b:boolean;
begin
  try
    strtofloat(str);
    b:=true;
  except
    b:=false;
  end;

  result:=b;
end;

function isint(str:string):boolean;
var
  b:boolean;
begin
  try
    strtoint(str);
    b:=true;
  except
    b:=false;
  end;

  result:=b;
end;

function cstr(s:integer):string;
begin
  result:=inttostr(s);
end;

function cstr(s:double): string; overload;
begin
  result:=floattostr(s);
end;

function pct(a,b:string):string;overload;
var
  x1,x2:double;
begin
  x1:=cdbl(a);
  x2:=cdbl(b);
  result:=pct(x1,x2);
end;

function pct(a,b:integer):string;overload;
var
  x1,x2:double;
begin
  x1:=cdbl(cstr(a));
  x2:=cdbl(cstr(b));
  result:=pct(x1,x2);
end;


function pct(a,b:double):string;overload;
begin
  try
    result:=format('%2.2f',[(a/b)*100])+'%';
  except
    result:='0.00%';
  end;
end;


function num2gb(i:integer): string;
begin
  if i=0 then result:='零';
  if i=1 then result:='一';
  if i=2 then result:='二';
  if i=3 then result:='三';
  if i=4 then result:='四';
  if i=5 then result:='五';
  if i=6 then result:='六';
  if i=7 then result:='七';
  if i=8 then result:='八';
  if i=9 then result:='九';
end;

function instr(a,b:string):boolean;
begin
  result:=(pos(b,a)>0);
end;

function cdbl(str:string):double;
begin
  try
    result:=strtofloat(str);
  except
    result:=0.0;
  end;

end;


procedure q(sql:string;ado_conn:TAdoConnection=nil);
begin
  try
    if ado_conn=nil then
      cn.Execute(sql)
    else
      ado_conn.Execute(sql);
  except
    on e:exception do
    begin
      log('sql.err.log',sql);
      msgerr('SQL错误:'+#13#10#13#10+sql+#13#10+e.Message);
    end;
  end;
end;

procedure q_(sql:string;ado_conn:TAdoConnection=nil);
begin
  try
    if ado_conn=nil then
      cn.Execute(sql)
    else
      ado_conn.Execute(sql);
  except

  end;
end;

function num2min_sec_dot(sec:integer):string;
var
  imin,isec:integer;
  ssec:string;
begin
  result:='0';
  if sec<=0 then exit;
  imin:=sec div 60;
  isec:=sec mod 60;
  ssec:=cstr(isec);
  if isec<10 then ssec:='0'+cstr(isec);
  result:=cstr(imin)+'.'+ssec;
end;

function sqlValue(sql:string;ado_conn:TAdoConnection=nil):string;
begin
  result:='';
	with g(sql,ado_conn) do
  begin
    if not eof then result:=rs.fields[0].AsString;
    close;
  end;
end;

function sqlValueCache(sql:string;ado_conn:TAdoConnection=nil):string;
begin
end;


function svc(sql:string;ado_conn:TAdoConnection=nil):string;
var
  s:string;
begin
    s:=sv(sql);
  result:=s;
end;

function sv(sql:string;ado_conn:TAdoConnection=nil):string;
begin
  result:=sqlValue(sql,ado_conn);
end;

function getSexStr(s:string):string;
begin
  result:=s;
  if s='1' then result:='男';
  if s='2' then result:='女';
end;

function getNjNum(s: string): string;
begin
  result:=s;
  if s='小一' then result:='11';
  if s='小二' then result:='12';
  if s='小三' then result:='13';
  if s='小四' then result:='14';
  if s='小五' then result:='15';
  if s='小六' then result:='16';
  if s='初一' then result:='21';
  if s='初二' then result:='22';
  if s='初三' then result:='23';
  if s='高一' then result:='31';
  if s='高二' then result:='32';
  if s='高三' then result:='33';
  if s='大一' then result:='41';
  if s='大二' then result:='42';
  if s='大三' then result:='43';
  if s='大四' then result:='44';
end;

function getNjStr(s: string): string;
begin
  result:=s;
  if s='11' then result:='小一';
  if s='12' then result:='小二';
  if s='13' then result:='小三';
  if s='14' then result:='小四';
  if s='15' then result:='小五';
  if s='16' then result:='小六';
  if s='21' then result:='初一';
  if s='22' then result:='初二';
  if s='23' then result:='初三';
  if s='31' then result:='高一';
  if s='32' then result:='高二';
  if s='33' then result:='高三';
  if s='41' then result:='大一';
  if s='42' then result:='大二';
  if s='43' then result:='大三';
  if s='44' then result:='大四';
end;


function confirm(str:string):boolean;
begin
	result:=(messagebox(GetActiveWindow(),pchar(str),pchar(application.Title),MB_ICONASTERISK or MB_OKCANCEL)=1);
end;

procedure msgerr(str:string);
begin
  messagebox(GetActiveWindow(),pchar(replace((str),'\n',#13#10)),'错误',mb_iconerror);
end;

function sqlstr(s:string):string;
begin
  result:=replace(s,'''','''''');
  result:=replace(result,'--','－－');
end;

function reg(key:string;v:string=''):string;
var
  str:string;
begin
  if v='' then
	 	str:=sv('select v from reg where k='''+sqlstr(key)+'''  ')
  else
  begin
    q('delete from reg where k='''+sqlstr(key)+''' ');
  	q('insert into reg (k,v) values ('''+sqlstr(key)+''','''+sqlstr(v)+''') ');
  end;
  if str=null then str:='';
  result:=str;
end;

function ChnPy(Value: array of char): Char;  
begin  
  Result := #0;  
  case Byte(Value[0]) of  
    176:  
      case Byte(Value[1]) of  
        161..196: Result := 'A';  
        197..254: Result := 'B';  
      end; {case}  
    177:  
      Result := 'B';  
    178:  
      case Byte(Value[1]) of  
        161..192: Result := 'B';  
        193..205: Result := 'C';  
        206: Result := 'S'; //参  
        207..254: Result := 'C';  
      end; {case}  
    179:  
      Result := 'C';  
    180:  
      case Byte(Value[1]) of  
        161..237: Result := 'C';  
        238..254: Result := 'D';  
      end; {case}  
    181:  
      Result := 'D';  
    182:  
      case Byte(Value[1]) of  
        161..233: Result := 'D';  
        234..254: Result := 'E';  
      end; {case}  
    183:  
      case Byte(Value[1]) of  
        161: Result := 'E';  
        162..254: Result := 'F';  
      end; {case}  
    184:  
      case Byte(Value[1]) of  
        161..192: Result := 'F';  
        193..254: Result := 'G';  
      end; {case}  
    185:  
      case Byte(Value[1]) of  
        161..253: Result := 'G';  
        254: Result := 'H';  
      end; {case}  
    186:  
      Result := 'H';  
    187:  
      case Byte(Value[1]) of  
        161..246: Result := 'H';  
        247..254: Result := 'J';  
      end; {case}  
    188..190:  
      Result := 'J';  
    191:  
      case Byte(Value[1]) of  
        161..165: Result := 'J';  
        166..254: Result := 'K';  
      end; {case}  
    192:  
      case Byte(Value[1]) of  
        161..171: Result := 'K';  
        172..254: Result := 'L';  
      end; {case}  
    193:  
      Result := 'L';  
    194:  
      case Byte(Value[1]) of  
        161..231: Result := 'L';  
        232..254: Result := 'M';  
      end; {case}  
    195:  
      Result := 'M';  
    196:  
      case Byte(Value[1]) of  
        161..194: Result := 'M';  
        195..254: Result := 'N';  
      end; {case}  
    197:  
      case Byte(Value[1]) of  
        161..181: Result := 'N';  
        182..189: Result := 'O';  
        190..254: Result := 'P';  
      end; {case}  
    198:  
      case Byte(Value[1]) of  
        161..217: Result := 'P';  
        218..254: Result := 'Q';  
      end; {case}  
    199:  
      Result := 'Q';  
    200:  
      case Byte(Value[1]) of  
        161..186: Result := 'Q';  
        187..245: Result := 'R';  
        246..254: Result := 'S';  
      end; {case}  
    201..202:  
      Result := 'S';  
    203:  
      case Byte(Value[1]) of  
        161..249: Result := 'S';  
        250..254: Result := 'T';  
      end; {case}  
    204:  
      Result := 'T';  
    205:  
      case Byte(Value[1]) of  
        161..217: Result := 'T';  
        218..254: Result := 'W';  
      end; {case}  
    206:  
      case Byte(Value[1]) of  
        161..243: Result := 'W';  
        244..254: Result := 'X';  
      end; {case}  
    207..208:  
      Result := 'X';  
    209:  
      case Byte(Value[1]) of  
        161..184: Result := 'X';  
        185..254: Result := 'Y';  
      end; {case}  
    210..211:  
      Result := 'Y';  
    212:  
      case Byte(Value[1]) of  
        161..208: Result := 'Y';  
        209..254: Result := 'Z';  
      end; {case}  
    213..215:  
      Result := 'Z';  
    216..247:  
      Result := py__[Byte(Value[0])][Byte(Value[1]) - 160];  
  end; {case}  
end;  
  
function py(Value: string): string;  
var  
  I, L: Integer;  
  C: array[0..1] of char;  
  R: Char;  
begin  
  Result := '';  
  L := Length(Value);  
  I := 1;  
  while I <= (L - 1) do  
  begin  
    if Value[I] < #160 then  
    begin  
      //Result := Result + Value[I];  
      Inc(I);  
    end  
    else  
    begin  
      C[0] := Value[I];  
      C[1] := Value[I + 1];  
      R := ChnPY(C);  
      if r <> #0 then  
        Result := Result + R;  
      Inc(I, 2);  
    end;  
  end;  
  //if I = L then
    //Result := Result + Value[L];  
end;

procedure speak(s: string);
begin

end;

function year(dt:tdatetime):integer;
begin
  result:=cint(formatdatetime('YYYY',dt));
end;

function ini(key:string;v:string=''):string;
var
	objIni:tIniFile;
  str:string;
begin
	objIni:=tIniFile.Create(path+'\@.ini');
  if v='' then
	 	str:=objIni.ReadString('Sys',key,'')
  else
  	objIni.WriteString('Sys',key,v);
  result:=str;
end;


procedure msgbox(msg:variant);
begin
  MessageBox(GetActiveWindow(),PChar(replace(vartostr(msg),'\n',#13#10)),'提示',MB_OK or MB_ICONINFORMATION);
end;

function GetPart(StrSource,StrBegin,StrEnd:string):string;
var
  i1,in_star,in_end:integer;
  sSub:string;
  y1,y2:integer;
begin
  i1:=AnsiPos(strbegin,strsource);
  if i1<1 then
  begin
    result:='';
    exit;
  end;
  in_star:=i1+length(strbegin);
  sSub:=copy(strsource,i1+length(strBegin),length(StrSource)-i1+1);
  in_end:=AnsiPos(strend,sSub);

  y1:=in_star;
  y2:=in_end-length(strend);
  result:=copy(sSub,0,in_end-1);
end;


procedure getrs.close;
begin

  try rs.Close; except end;
  try rs.Free; except end;
  try ds.Free; except end;

end;


function getrs.getRecordCount():integer;
begin
	result:=rs.RecordCount;
end;

procedure getrs.field(k:string;v:string);
begin
	rs.FieldByName(k).AsString:=v;
end;

procedure getrs.field(k:string;v:Integer);
begin
	rs.FieldByName(k).AsString:=cstr(v);
end;

procedure getrs.field(k:string;v:Double);
begin
	rs.FieldByName(k).AsString:=cstr(v);
end;


function getrs.value(k:string):string;
begin
	result:=rs.FieldByName(k).AsString;
end;

function getrs.value(i:integer):string;
begin
	result:=rs.Fields[i].AsString;
end;
function getrs.vdbl(k:string):double;
begin
	result:=rs.FieldByName(k).AsFloat;
end;

function getrs.vint(k:string):integer;
begin
	result:=rs.FieldByName(k).AsInteger;
end;

function getrs.v(k:string):string;
begin
	result:=value(k);
end;

procedure getrs.addnew;
begin
	rs.Insert;
end;

procedure getrs.update;
begin
	rs.Post;
end;

procedure getrs.delete;
begin
  rs.Delete;
end;

constructor getrs.Create(sql:string;ado_conn:tadoconnection=nil);
begin
  eof:=false;
	rs:=tAdoQuery.Create(nil);

  ds:=tDataSource.Create(nil);
  if ado_conn=nil then
    rs.Connection:=cn
  else
    rs.Connection:=ado_conn;

  if sql='' then exit;
  rs.SQL.Text:=sql;
  rs.Open;
  rs.Edit;
  eof:=rs.Eof;
  ds.DataSet:=rs;
end;

destructor getrs.Destroy;
begin
  self.close;
end;

procedure getrs.next;
begin
	if not rs.Eof then rs.Next;
  eof:=rs.Eof;
end;

{base64相关}
function Base64_Encode(const Source; var Buf; SourceSize: Integer): Integer;
asm
  push  esi
  push  edi
  push  ebx
  mov   esi, eax    // esi = Source
  mov   edi, edx    // edi = Buf
  push  ecx
  add   ecx, esi    // ecx = esi + SourceSize
  xor   eax, eax
  cld
@Loop1:
  cmp   esi, ecx    // while (esi != ecx)
  je    @@11        // {
  xor   bl, bl      //   bl = 0
  mov   bh, 2       //   bh = 2
  mov   dl, 4       //   for (dl = 4; dl > 0; dl--)
@Loop2:             //   {
  cmp   dl, 1       //     if (dl > 1)
  jle   @@1         //     {
  cmp   esi, ecx
  je    @@0
  lodsb             //       if (esi < ecx)  al = *esi++
  jmp   @encode
@@0:
  xor   al, al      //       else al = 0
@encode:
  mov   dh, al      //       dh = al
  push  ecx
  mov   cl, bh      //       al = (al >> bh) | bl
  shr   al, cl
  or    al, bl
  inc   bh          //       bh += 2
  inc   bh
  mov   cl, 8       //       bl = (dh << (8 - bh)) & 0x3f
  sub   cl, bh
  shl   dh, cl
  and   dh, 03fh
  mov   bl, dh
  pop   ecx         //     }
  jmp   @@2
@@1:
  mov   al, bl      //     else al = bl
@@2:                //                                // al --> eax
  push  esi         //     al = *(Base64_Chars + eax)
  mov   esi, offset Base64_Chars
  mov   al, [esi + eax]
  pop   esi
  stosb             //     *Buf++ = al
  dec   dl
  jnz   @Loop2      //   }
  jmp   @Loop1      // }
@@11:
  pop   eax
  cdq
  mov   ecx, 3      // eax = SourceSize / 3
  div   ecx         // edx = SourceSize % 3
  test  edx, edx    // if (edx != 0)
  jz    @end        // {
  inc   eax         //   eax ++
  push  eax
  mov   al, 61      //   for (ecx = 3 - edx, edi -= ecx; ecx > 0; ecx --)
  sub   ecx, edx
  sub   edi, ecx
  rep   stosb       //     *edi ++ = '='
  pop   eax         // }
@end:
  shl   eax, 2      // eax *= 4        // return value
  pop   ebx
  pop   edi
  pop   esi
end;

function Base64Encode(const Source; SourceSize: Integer): string;
begin
  SetLength(Result, ((SourceSize + 2) div 3) shl 2);
  Base64_Encode(Source, Result[1], SourceSize);
end;

procedure Base64Stream(Source, Dest: TStream; Proc: Base64Proc;
  StartPos, Size: Int64; BufSize: Integer);
var
  RBuf: array[0..1023] of Byte;
  WBuf: array[0..1023] of Byte;
  RSize, WSize, BSize: Integer;
begin
  if (StartPos < 0) or (StartPos >= Source.Size) then Exit;
  Source.Position := StartPos;
  if (Size <= 0) or (Size > Source.Size - Source.Position) then
    Size := Source.Size
  else
    Size := Size + Source.Position;
  while Size <> Source.Position do
  begin
    if Size - Source.Position >= BufSize then
      BSize := BufSize
    else
      BSize := Size - Source.Position;
    RSize := Source.Read(RBuf, BSize);
    WSize := Proc(RBuf, WBuf, RSize);
    if WSize = -1 then
      raise Exception.Create('Invalid Base64 code.');
    Dest.Write(WBuf, WSize);
  end;
end;

procedure Base64Encode(Source, Dest: TStream; StartPos: Int64; Size: Int64);
begin
  Base64Stream(Source, Dest, Base64_Encode, StartPos, Size, 768);
end;

function StrToBase64(const Str: string): string;
begin
  Result := Base64Encode(Str[1], Length(Str));
end;

function Base64DecodeBufSize(const Source; Size: Integer): Integer;
asm
  push  edi
  mov   edi, eax    // edi = Source + Size - 1
  add   edi, edx
  dec   edi
  mov   eax, edx    // eax = Size / 4 * 3
  mov   ecx, edx
  shr   ecx, 1
  shr   eax, 2
  add   eax, ecx
  push  eax
  mov   ecx, edx
  mov   al,  61
  std               // for (ecx = Size; ecx > 0 && *edi == '='; ecx--, edi--);
  repz  scasb
  pop   eax
  jz    @end
  sub   edx, ecx    // if (zf != 0)
  sub   eax, edx    //   eax = eax - (Size - ecx) + 1
  inc   eax
@end:               // return eax
  pop   edi
end;

function Base64_Decode(const Source; var Buf; SourceSize: Integer): Integer;
asm
  push  ebp
  push  esi
  push  edi
  push  ebx
  mov   esi, eax       // esi = Source
  mov   edi, edx       // edi = Buf
  mov   edx, ecx
  push  edx
  call  Base64DecodeBufSize
  pop   edx
  push  eax            // eax = Base64DecodeBufSize(Source, SourceSize)  // return value
  test  edx, 80000003h // if (SourceSize < 0 || SourceSize % 4 != 0)
  jnz   @error         //   return -1
  add   edx, esi       // edx = esi + SourceSize
  mov   ebp, eax
  add   ebp, edi       // ebp = esi + eax
  cld
@Loop1:
  cmp   esi, edx       // while (esi != edx && edi != ebp)
  je    @@11           // {
  mov   ebx, 4         //   for (ebx = 4; ebx > 0; ebx--)
  xor   eax, eax       //   {
@Loop2:
  lodsb                //     al = *esi++
  cmp   al, 61         //     if (al == '=') al = 0
  jne   @@1
  mov   al, 0
  jmp   @@3
@@1:                   //     else{
  push  edi            //       edi = Base64_Chars
  mov   edi, offset Base64_Chars
  mov   ecx, 64        //       for (ecx = 64; ecx > 0 && *edi != al; ecx--, edi++);
  repnz scasb
  pop   edi
  jnz   @error         //       if (zf != 0) return -1
  mov   al, 63         //         al = 64 - cl - 1
  sub   al, cl
@@3:                   //     }
  ror   eax, 8         //     eax >>>= 8
  dec   ebx
  jnz   @Loop2         //   }
  mov   bl, 3
  mov   bh, 2
@Loop3:                //   for (bh = 2, bl = 3; bl > 0 && edi != ebp; bl--, bh += 2)
  cmp   edi, ebp       //   {
  je    @@11
  mov   cl, bh         //     *edi++ = (al << bh) | (ah >> (6 - bh)
  shl   al, cl
  mov   ch, al
  mov   cl, 6
  sub   cl, bh
  shr   eax, 8         //     eax >>= 8
  push  eax
  shr   al, cl
  or    al, ch
  stosb
  pop   eax
  inc   bh
  inc   bh
  dec   bl
  jnz   @Loop3        //    }
  jmp   @Loop1        // }
@@11:
  pop   eax           // return eax
  jmp   @end
@error:
  pop   eax
  mov   eax, -1
@end:
  pop   ebx
  pop   edi
  pop   esi
  pop   ebp
end;

function Base64Decode(const Source: string; var Buf): Integer;
begin
  Result := Base64_Decode(Source[1], Buf, Length(Source));
  if Result = -1 then
    raise Exception.Create('Invalid Base64 code.');
end;

procedure Base64Decode(Source, Dest: TStream; StartPos: Int64; Size: Int64);
begin
  Base64Stream(Source, Dest, Base64_Decode, StartPos, Size, 1024);
end;

function Base64ToStr(const Base64: string): string;
begin
  SetLength(Result, Base64DecodeBufSize(Base64, Length(Base64)));
  Base64Decode(Base64, Result[1]);
end;


function f0j1(a: double): double;
begin
  Result:=Trunc((a+0.09)*10)/10;
end;

function round45(dd: double): double;
var
  f:Double;
begin
  f:=Trunc(dd);
  if dd-f>=0.5 then
    Result:=f+1
  else
    Result:=f;
end;



procedure log_sys(s: string);
begin
  //
end;

function g(sql: string;ado_conn:TAdoConnection=nil): getrs;
begin
  Result:=getrs.Create(sql,ado_conn);
end;


function cdate(sTime:String):TDateTime;
var
  settings: TFormatSettings;
  dt: TDateTime;
begin
  GetLocaleFormatSettings(GetUserDefaultLCID, settings);
  settings.DateSeparator := '-';
  settings.TimeSeparator := ':';
  settings.ShortDateFormat := 'yyyy-mm-dd';
  settings.ShortTimeFormat := 'hh:nn:ss';
  try
    result:= strToDateTime(sTime,settings);
  except
    result:=strtodatetime('2000-01-01',settings);
  end;
end;

function len(s: string): integer;
begin
  Result:=Length(s);
end;

Function getHDDSN(): string;
var
  NotUsed,VolumeFlags,VSNumber: DWORD;
  PType: array[0..32] of Char;
  s,ret:string;
  i:integer;
begin
  GetVolumeInformation(PChar('c:\'), nil, 0, @VSNumber, NotUsed, VolumeFlags, PType, 32);
  s:=InttoHex(VSNumber,8);
  ret:='';
  for i:=0 to length(s)-1 do
  begin
    ret:=ret+copy(inttohex(ord(s[i])+i,2),2,1);
  end;
  result:=ret;
end;

function getSysSN():string;
var
  hdd_sn:string;
begin
end;

function getSYSSerial(s:string):string;
begin
  result:=md5_(s+'_');
  result:=replace(result,'0','A');
  result:=replace(result,'1','C');
  result:=replace(result,'2','Z');
  result:=replace(result,'3','P');
  result:=replace(result,'4','L');
  result:=replace(result,'5','S');
  result:=replace(result,'6','K');
  result:=replace(result,'7','Q');
  result:=replace(result,'8','W');
  result:=replace(result,'9','B');
  result:=copy(result,11,1)+copy(result,32,1)+copy(result,17,1)+copy(result,21,1)+copy(result,12,1)+copy(result,8,1);
end;

function m2s(vm:Double):integer;
var
  i1:Integer;
  f1:Double;
begin
  i1:=Trunc(vm)*60;
  f1:=frac(vm)*100;
  result:=i1+round(f1);
end;

function s2m(vs:integer):double;
var
  s:string;
  i:integer;
begin
  s:=cstr(vs div 60);
  s:=s+'.';
  i:=vs mod 60;

  if i<10 then
    s:=s+'0'+cstr(i)
  else
    s:=s+cstr(i);

  result:=cdbl(s);
end;


function left(s: string;i:Integer): string;
begin
  Result:=Copy(s,0,i);
end;

function KillTask(ExeFileName: string): integer;
const
  PROCESS_TERMINATE=$0001;
var
  ContinueLoop: Boolean;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := 0;

  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,FProcessEntry32);

  while integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))=UpperCase(ExeFileName))
     or (UpperCase(FProcessEntry32.szExeFile)=UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0),FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle,FProcessEntry32);
  end;

  CloseHandle(FSnapshotHandle);
end;

procedure showInfoWin(str: string);
begin
end;

function isDate(str: string): boolean;
var
  b:boolean;
begin
  try
    StrToDate(str);
    b:=true;
  except
    b:=false;
  end;

  result:=b;
end;

function md5_(s: string): string;
begin
end;

procedure ShowPhpRpt(strRptName:string);
begin
  shellapi.ShellExecute(application.Handle,'open',pchar('http://127.0.0.1:6875/'+strRptName),'','',1);
end;


//压缩与修复数据库,覆盖源文件
function CompactDatabase(AFileName,APassWord:string):boolean;
var
 STempFileName:string;
 vJE:OleVariant;
begin
 STempFileName:=path+'/~临时文件.压缩数据库.mdb';
 try
    vJE:=CreateOleObject('JRO.JetEngine');
    vJE.CompactDatabase(
        format(sTplConnectionString,[AFileName,APassWord]),
        format(sTplConnectionString,[STempFileName,APassWord])
    );
    result:=CopyFile(PChar(STempFileName),PChar(AFileName),false);
    DeleteFile(STempFileName);
 except
    result:=false;
 end;
end;

procedure showFrm(strFormName: string);
begin
  log('logs/system.log','try to show frm '+strFormName);
  try
    with TFormClass(FindClass(strFormName)).Create(application) do
    begin
      ShowModal;
      Free;
    end;
  except
    on e:exception do
    begin
      log('logs/system.log','fail to show frm -> '+e.Message);
      msgerr('无法启动['+strFormName+']功能'+#13#10#13#10+e.Message);
    end;
  end;
end;

procedure check1024;
begin
  if (screen.Width<>1024) or (screen.Height<>768) then msgerr('为获得最佳的显示效果请将屏幕分辨率更改为：\n\n1024*768');
end;

function leftstr(s:string;i:integer):string;
begin
  result:=copy(s,0,i);
end;


function replace_common(s: string): string;
begin
  result:=trim(s);
  result:=replace(result,#9,'');
  result:=replace(result,#13,'');
  result:=replace(result,#10,'');
  result:=replace(result,' ','');
  result:=replace(result,'　','');
  result:=replace(result,'１','1');
  result:=replace(result,'２','2');
  result:=replace(result,'３','3');
  result:=replace(result,'４','4');
  result:=replace(result,'５','5');
  result:=replace(result,'６','6');
  result:=replace(result,'７','7');
  result:=replace(result,'８','8');
  result:=replace(result,'９','9');
  result:=replace(result,'０','0');
  result:=replace(result,'．','.');
  result:=replace(result,'′','.');
  result:=replace(result,'〞','');
  result:=replace(result,'''','.');
  result:=replace(result,'，','.');
  result:=replace(result,',','.');

end;

function mz(n: integer): string;
var
  s:string;
begin
  s:='汉族';
	if n=1 then s:='汉族 ';
	if n=2 then s:='蒙古族 ';
	if n=3 then s:='回族 ';
	if n=4 then s:='藏族 ';
	if n=5 then s:='维吾尔族 ';
	if n=6 then s:='苗族 ';
	if n=7 then s:='彝族 ';
	if n=8 then s:='壮族 ';
	if n=9 then s:='布依族 ';
	if n=10 then s:='朝鲜族 ';
	if n=11 then s:='满族 ';
	if n=12 then s:='侗族 ';
	if n=13 then s:='瑶族 ';
	if n=14 then s:='白族 ';
	if n=15 then s:='土家族';
	if n=16 then s:='哈尼族';
	if n=17 then s:='哈萨克族';
	if n=18 then s:='傣族';
	if n=19 then s:='黎族';
	if n=20 then s:='傈僳族';
	if n=21 then s:='佤族';
	if n=22 then s:='畲族';
	if n=23 then s:='高山族';
	if n=24 then s:='拉祜族';
	if n=25 then s:='水族';
	if n=26 then s:='东乡族';
	if n=27 then s:='纳西族';
	if n=28 then s:='景颇族';
	if n=29 then s:='柯尔克孜族';
	if n=30 then s:='土族';
	if n=31 then s:='达斡尔族';
	if n=32 then s:='仫佬族';
	if n=33 then s:='羌族';
	if n=34 then s:='布朗族';
	if n=35 then s:='撒拉族';
	if n=36 then s:='毛南族';
	if n=37 then s:='仡佬族';
	if n=38 then s:='锡伯族';
	if n=39 then s:='阿昌族';
	if n=40 then s:='普米族';
	if n=41 then s:='塔吉克族';
	if n=42 then s:='怒族';
	if n=43 then s:='乌孜别克族';
	if n=44 then s:='俄罗斯族';
	if n=45 then s:='鄂温克族';
	if n=46 then s:='德昂族';
	if n=47 then s:='保安族';
	if n=48 then s:='裕固族';
	if n=49 then s:='京族';
	if n=50 then s:='塔塔尔族';
	if n=51 then s:='独龙族';
	if n=52 then s:='鄂伦春族';
	if n=53 then s:='赫哲族';
	if n=54 then s:='门巴族';
	if n=55 then s:='珞巴族';
	if n=56 then s:='基诺族';
	if n=57 then s:='其它';
	if n=58 then s:='外国血统';
  result:=trim(s);
end;


procedure add_taskbar_menu;
var
  mnu:Hmenu;
begin
  mnu:=getsystemmenu(application.Handle,false);
  appendmenu(mnu,mf_separator,0,nil);
  appendmenu(mnu,mf_string,$8001,pchar('关于...'));
 
end;

end.

