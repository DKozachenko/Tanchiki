//Enables specific compiler switches

{$IFNDEF WIN32}
  {$FATAL This unit must be compiled under Win32}
{$ENDIF}
{$IFDEF FPC}
  {$MODE DELPHI}
{$ELSE}
  {$DEFINE DELPHI} //if not Free Pascal then it must be Delphi
{$ENDIF}
