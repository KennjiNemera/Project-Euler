unit main_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, math, System.Generics.Collections;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    arrgen : array of array of integer;
    arrsol : array[0..5] of integer;
  public
    procedure findval();
    procedure generatevalues(split : integer);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  freq, start, stop : int64;
  n : integer;
begin

end;

procedure TForm1.findval;
begin
  generatevalues();
end;

procedure TForm1.generatevalues(split: integer);
var
  n, val : integer;
  arrvals : TList<Integer>;
  arrfinal : array of integer;
  I: Integer;
begin
  n := 0;
  val := 0;
  arrvals := TList<Integer>.Create;

  while val < 10000 do
    begin
      inc(n);
      case split of
        1: begin
            val := (n * (n + 1)) div 2;
            break;
           end;
        2: begin
            val := n * n;
            break;
           end;
        3: begin
            val := (n * (3 * n - 1)) div 2;
            break;
           end;
        4: begin
            val := (n * (2 * n - 1));
            break;
           end;
        5: begin
            val := (n * (5 * n - 3)) div 2;
            break;
           end;
        6: begin
            val := n * (3 * n - 2);
            break;
           end;
      end;

      if (val > 999) and (val < 10000) then
        begin
          arrvals.Add(val);
        end;
    end;

  setlength(arrfinal, arrvals.Count-1);

  for I := 0 to length(arrfinal) do arrfinal[i] := arrvals[i];

  arrgen[split] := arrfinal;

  arrvals.Free;




end;

end.
