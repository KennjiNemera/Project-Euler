unit main_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Samples.Spin, math, strutils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    RichEdit1: TRichEdit;
    procedure digitpower(n : integer);
    function getsum(s : string) : integer;
    procedure Button1Click(Sender: TObject);
    function multiply(s : string; n : integer) : string;
    function add(x, y : string) : string;
    procedure bubblesort();
    function drain(s : string) : string;
  private
    arrvalid : array[1..335] of string;
    ifound : integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.add(x, y: string): string;
var
  i, carry, tempsum : integer;
  sum : string;
begin
  sum := '';
  carry := 0;
  for I := 0 to max(length(x), length(y)) - 1 do
    begin
      if length(x) - i < 1 then
        begin
          // if x is smaller in length than y
          tempsum := StrToInt(y[length(y) - i]);
          tempsum := tempsum + carry;
          insert(IntToStr(tempsum mod 10), sum, 1);
          carry := tempsum div 10;
        end
      else
        begin
          if length(y) - i < 1 then
            begin
              // length of x > y
              tempsum := StrToInt(x[length(x) - i]);
              tempsum := tempsum + carry;
              insert(IntToStr(tempsum mod 10), sum, 1);
              carry := tempsum div 10;
            end
          else
            begin
              tempsum := StrToInt(y[length(y) - i]) + StrToInt(x[length(x)-i]);
              tempsum := tempsum + carry;
              insert(IntToStr(tempsum mod 10), sum, 1);
              carry := tempsum div 10;
            end;
        end;
    end;
  if (carry <> 0) then Insert(IntToStr(carry), sum, 1);
  Result := sum;
end;

procedure TForm1.bubblesort;
var
  i, j : integer;
  stemp : string;
begin
  for I := 1 to ifound - 1 do
      for j := 1 to ifound - i do
        begin        
          if length(arrvalid[j]) > length(arrvalid[j+1]) then
            begin
              stemp := arrvalid[j];
              arrvalid[j] := arrvalid[j+1];
              arrvalid[j+1] := stemp;
            end
          else 
            begin
              if length(arrvalid[j]) <> length(arrvalid[j+1]) then continue;
              if CompareStr(arrvalid[j], arrvalid[j+1]) > 0 then
              begin
                stemp := arrvalid[j];
                arrvalid[j] := arrvalid[j+1];
                arrvalid[j+1] := stemp;
              end;
            end;
        end;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  freq, start, stop : int64;
  i, n : integer;
begin
  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(start);
  n := SpinEdit1.Value;
  for I := 1 to 1 do
    begin
      RichEdit1.Clear;
      digitpower(n);
    end;
  QueryPerformanceCounter(stop);
  ShowMessage(floattostrf((stop-start)/(freq*1), ffgeneral,1000,10));
end;

procedure TForm1.digitpower(n: integer);
var
  pow : string;
  arrpowers : array[2..999] of string;
  I, j, maxsum, sum: Integer;
begin
  ifound := 0;
  maxsum := 0;
  // init the arrpowers array
  for I := 2 to 999 do arrpowers[i] := IntToStr(i);
  for I := 2 to 335 do arrvalid[i] := '0';
  for j := 1 to 300 do
    begin
      for I := 2 to 999 do
          begin
            pow := multiply(arrpowers[i], i);
            arrpowers[i] := pow;
            sum := getsum(pow);
            if sum = i then
              begin
                inc(ifound);
                maxsum := max(maxsum, sum);
                arrvalid[ifound] := pow;
              end;
            if ifound > n + 20 then break;
          end;
      if ifound > n + 20 then break;      
    end;
  bubblesort();
  for I := 1 to Min(n, ifound) do
      begin
        richedit1.Lines.Add(IntToStr(i) + ': ' + arrvalid[i] + #13);
      end;
  ShowMessage(IntToStr(maxsum));
end;

// function that removes leading zeroes
function TForm1.drain(s: string): string;
begin
  while length(s) > 0 do
    begin
      if s[1] = '0' then delete(s, 1, 1)
      else break;
    end;
  Result := s;
end;

// return sum of digits
function TForm1.getsum(s : string): integer;
var
  icount, i : integer;
begin
  icount := 0;
  for I := 1 to length(s) do
    begin
      icount := icount + StrToInt(s[i]);
    end;
  result := icount;
end;

// perform multiplication between a string and and integer
function TForm1.multiply(s: string; n: integer): string;
var
  i, j, temp, carry, mult, prod : integer;
  sum, tempsum : string;
begin
  sum := '0';
  for I := 0 to floor(log10(n)) do
      begin
        mult := n mod 10;
        n := n div 10;
        tempsum := '';
        carry := 0;
        for j := length(s) downto 1 do
          begin
            temp := StrToInt(s[j]+'');
            prod := temp * mult;
            prod := prod + carry;
            Insert(IntToStr(prod mod 10), tempsum, 1);
            carry := prod div 10;
          end;
        if (carry <> 0) then Insert(IntToStr(carry), tempsum, 1);
        for j := 1 to i do tempsum := tempsum + '0';
        sum := drain(add(sum, tempsum));
      end;
  result := sum;
end;

end.
