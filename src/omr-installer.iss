; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "smesp OMR v[VERSION]"
#define MyAppDir "[BASE_DIR_NAME]"
#define MyAppVersion "[VERSION]"
#define MyAppPublisher "smesp"
#define MyAppURL "http://www.smesp.com.br/"


[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{964B5EFE-B14E-4ED4-B7E8-41053DF79E61}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={#MyAppDir}
DisableDirPage=yes
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
Compression=lzma
SolidCompression=yes
PrivilegesRequired=poweruser

[Code]
procedure VCRedistx86();
var
 ResultCode: Integer;
begin
 if not Exec(ExpandConstant('{app}\bin\vcredist_x86.exe'), '/install /quiet /norestart', '', SW_SHOW, ewWaitUntilTerminated, ResultCode)
 then
  MsgBox('VCRedist_x86 failed to run!' + #13#10 + SysErrorMessage(ResultCode), mbError, MB_OK);
end;

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Dirs]
Name: "{app}\files"
Name: "{app}\logs"

[Files]
Source: "[SORUCE_DIR]config\*"; DestDir: "{app}\config"; Flags: onlyifdoesntexist ignoreversion recursesubdirs createallsubdirs 
Source: "[SORUCE_DIR]data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "[SORUCE_DIR]bin\*"; DestDir: "{app}\bin"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "[SORUCE_DIR]bin\vcredist_x86.exe"; DestDir: "{app}\bin"; BeforeInstall: VCRedistx86
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Run]
Filename: "{app}\bin\nssm.exe"; Parameters: "install OMR_ADMIN ""{app}\bin\admin.bat"""
Filename: "{app}\bin\nssm.exe"; Parameters: "install OMR_API ""{app}\bin\api.bat"""
Filename: "{app}\bin\nssm.exe"; Parameters: "install OMR_SCHEDULER ""{app}\bin\scheduler.bat"""
Filename: "{app}\bin\nssm.exe"; Parameters: "set OMR_ADMIN ObjectName ""{param:user|localsystem}"" {param:pwd}"""
Filename: "{app}\bin\nssm.exe"; Parameters: "set OMR_API ObjectName ""{param:user|localsystem}"" {param:pwd}"""
Filename: "{app}\bin\nssm.exe"; Parameters: "set OMR_SCHEDULER ObjectName ""{param:user|localsystem}"" {param:pwd}"""
Filename: "{app}\bin\configuration.bat"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallRun]
Filename: "{app}\bin\nssm.exe"; Parameters: "stop OMR_ADMIN confirm"
Filename: "{app}\bin\nssm.exe"; Parameters: "stop OMR_API confirm"
Filename: "{app}\bin\nssm.exe"; Parameters: "stop OMR_SCHEDULER confirm"
Filename: "{app}\bin\nssm.exe"; Parameters: "remove OMR_ADMIN confirm"
Filename: "{app}\bin\nssm.exe"; Parameters: "remove OMR_API confirm"
Filename: "{app}\bin\nssm.exe"; Parameters: "remove OMR_SCHEDULER confirm"