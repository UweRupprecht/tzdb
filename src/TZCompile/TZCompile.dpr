(*
* Copyright (c) 2010, Ciobanu Alexandru
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of this library nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE AUTHOR ''AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

program TZCompile;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  DateUtils,
  Character,
  Classes,
  IOUtils,
  Types,
  StrUtils,
  TZSchema in 'TZSchema.pas',
  TZStrs in 'TZStrs.pas';

var
  LInputDir, LOutputFile: string;
begin
  { Process parameters }
  WriteLn(CCLIHeader);

  if ParamCount() < 2 then
  begin
    WriteLn(CCLIUsage);
    Exit;
  end;

  LInputDir := ParamStr(1);
  LOutputFile := ParamStr(2);

  { Verify input directory }
  if not DirectoryExists(LInputDir) then
    CLIFatal(Format(CCLIBadInputDir, [LInputDir]));

  { Verify output directory }
  if not DirectoryExists(ExtractFilePath(LOutputFile)) then
    CLIFatal(Format(CCLIBadOutputDir, [ExtractFilePath(LOutputFile)]));

  { Start the process! }
  try
    Process(LInputDir, LOutputFile);
  except
    on E: Exception do
      CLIFatal(Format(CCLIGlobalException, [E.ClassName, E.Message]));
  end;

  readln;
end.

