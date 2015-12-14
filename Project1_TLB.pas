unit Project1_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 2015/12/14 10:45:43 from Type Library described below.

// ************************************************************************  //
// Type Lib: Y:\Downloads\delphi_scriptcontrol_httpserver\Project1.tlb (1)
// LIBID: {BEB8853F-E41E-416D-ADE6-1BC18F3FFB9D}
// LCID: 0
// Helpfile: 
// HelpString: Project1 Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  Project1MajorVersion = 1;
  Project1MinorVersion = 0;

  LIBID_Project1: TGUID = '{BEB8853F-E41E-416D-ADE6-1BC18F3FFB9D}';

  IID_ISwSSP: TGUID = '{65DE76C2-1556-49D2-BCE7-20836275168C}';
  CLASS_TSwSSP: TGUID = '{2E8AE8CF-6446-43F4-9089-8C94EFE45287}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISwSSP = interface;
  ISwSSPDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  TSwSSP = ISwSSP;


// *********************************************************************//
// Interface: ISwSSP
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {65DE76C2-1556-49D2-BCE7-20836275168C}
// *********************************************************************//
  ISwSSP = interface(IDispatch)
    ['{65DE76C2-1556-49D2-BCE7-20836275168C}']
    function test(aa: OleVariant): OleVariant; safecall;
    procedure echo(str: OleVariant); safecall;
    function rq(s: OleVariant): OleVariant; safecall;
    function query(s: OleVariant): OleVariant; safecall;
    procedure q; safecall;
    procedure file_get_contents; safecall;
    function sv(s: OleVariant): OleVariant; safecall;
    procedure file_put_contents; safecall;
    procedure md5; safecall;
    procedure base64_encode; safecall;
    procedure base64_decode; safecall;
  end;

// *********************************************************************//
// DispIntf:  ISwSSPDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {65DE76C2-1556-49D2-BCE7-20836275168C}
// *********************************************************************//
  ISwSSPDisp = dispinterface
    ['{65DE76C2-1556-49D2-BCE7-20836275168C}']
    function test(aa: OleVariant): OleVariant; dispid 201;
    procedure echo(str: OleVariant); dispid 202;
    function rq(s: OleVariant): OleVariant; dispid 203;
    function query(s: OleVariant): OleVariant; dispid 204;
    procedure q; dispid 205;
    procedure file_get_contents; dispid 206;
    function sv(s: OleVariant): OleVariant; dispid 207;
    procedure file_put_contents; dispid 208;
    procedure md5; dispid 209;
    procedure base64_encode; dispid 210;
    procedure base64_decode; dispid 211;
  end;

// *********************************************************************//
// The Class CoTSwSSP provides a Create and CreateRemote method to          
// create instances of the default interface ISwSSP exposed by              
// the CoClass TSwSSP. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTSwSSP = class
    class function Create: ISwSSP;
    class function CreateRemote(const MachineName: string): ISwSSP;
  end;

implementation

uses ComObj;

class function CoTSwSSP.Create: ISwSSP;
begin
  Result := CreateComObject(CLASS_TSwSSP) as ISwSSP;
end;

class function CoTSwSSP.CreateRemote(const MachineName: string): ISwSSP;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TSwSSP) as ISwSSP;
end;

end.
