unit main_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, math;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    arr : array[1..15] of array[1..15] of integer;
    function getmax(curval, currow, parentid : integer) : integer;
    procedure readin();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
   i, j, ans : integer;
   freq, start, stop : int64;
begin
  readin;
  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(start);
  for I := 1 to 1000 do getmax(arr[1][1], 1, 1);
  QueryPerformanceCounter(stop);
  Label1.caption := IntToStr(ans);
  ShowMessage(floattostrf((stop-start)/(freq * 1000), ffNumber, 20, 5));
end;

function TForm1.getmax(curval, currow, parentid: integer): integer;
begin
  // dont go away
  if (currow = 16) then
    begin
      result := curval;
      exit;
    end;
  result := max(getmax(curval + arr[currow+1][parentid], currow + 1, parentid), getmax(curval + arr[currow+1][parentid + 1], currow + 1, parentid + 1));
end;

procedure TForm1.readin;
var
  tfile : textfile;
  soneline : string;
  posi, count, i, ival : integer;
begin
  assignfile(tfile, 'in.txt');
  reset(tfile);
  count := 1;
  while not EOF(tfile) do
    begin
      readln(tfile, soneline);
      for i := 1 to count do
        begin
          posi := pos(' ', soneline);
          if posi <> 0 then
            begin
              ival := StrToInt(copy(soneline, 1, posi-1));
              delete(soneline, 1, posi);
            end
          else
            begin
              ival := StrToInt(soneline);
            end;
          arr[count][i] := ival;
        end;
        inc(count);
    end;
  CloseFile(tfile);
end;

end.
