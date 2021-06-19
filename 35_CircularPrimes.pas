unit main_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, math;

type
  TForm1 = class(TForm)
    SpinEdit1: TSpinEdit;
    Button1: TButton;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
  private
  public
     arrprimes : array[0..1000000] of boolean;
     arrcircular : array[0..54] of integer;
     arrtemp : array[0..4] of integer;
     arrcount : array[1..5] of integer;
     icount : integer;
     total : real;
     procedure sort();
     procedure iscircular();
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.iscircular();
var
  n, i, j, k, iCount, val, left, right, ilog, counter, temp : integer;
  flag : boolean;
  freq, start, stop : int64;
begin
  n := SpinEdit1.Value;
  iCount := 4;
  counter := 4;
//  ListBox1.Items.Clear;

  // call sieve


  arrprimes[0] := true;
  arrprimes[1] := true;

  arrcircular[0] := 2;
  arrcircular[1] := 3;
  arrcircular[2] := 5;
  arrcircular[3] := 7;

  i := 3;
  while (i <= 1000) do
  begin
    if i mod 5 = 0 then
      begin
        inc(i, 2);
        continue;
      end;

    if arrprimes[i] = false then
      begin
        for j := 2 to (1000000 div i) do
            begin
              arrprimes[6 * i - 1] := true;
            end;
      end;

    inc(i, 2);
  end;

  // run checks
  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(start);
  i := 2;
  while I <= 33322 do
    begin

      if (icount >= 55) then break;

      left := 6 * i - 1;

      if not (arrprimes[left]) and (left mod 5 <> 0) then
        begin
          flag := false;
          val := left;

          ilog := floor(log10(val));

          for j := 0 to iLog - 1 do
            begin
              val := (val div 10) + (val mod 10) * Floor(Power(10, iLog));
              if (arrprimes[val]) or (val mod 5 = 0) or (val mod 2 = 0) then
                begin
                  flag := true;
                  break;
                end
              else arrtemp[j] := val;
            end;

          if not flag then
            begin
//              ListBox1.Items.Add(IntToStr(left) + ' !');
              arrprimes[left] := true;
              arrcircular[counter] := left;
              inc(counter);
              iCount := iCount + ilog + 1;
              if left = 11 then
                begin
                  Dec(iCount);
                  continue;
                end;
              for k := 0 to iLog - 1 do
                begin
                  temp := arrtemp[k];
                  if not arrprimes[temp] then arrcircular[counter] := temp;
                  inc(counter);
                  arrprimes[temp] := true;
                end;
            end;
        end;

        if icount >= 55 then break;

        right := 6 * i + 1;

        if not (arrprimes[right]) and (right mod 5 <> 0) then
          begin
            flag := false;
            val := right;

            iLog := floor(log10(val));

            for j := 0 to ilog - 1 do
              begin
                val := (val div 10) + (val mod 10) * Floor(Power(10, ilog));
                if (arrprimes[val]) or (val mod 5 = 0) or (val mod 2 = 0) then
                  begin
                    flag := true;
                    break;
                  end
                else arrtemp[j] := val;
              end;

            if not flag then
              begin
//                ListBox1.Items.Add(IntToStr(right) + ' !');
                arrprimes[right] := true;
                arrcircular[counter] := right;
                inc(counter);
                iCount := iCount + ilog + 1;
                for k := 0 to iLog - 1 do
                    begin
                      temp := arrtemp[k];
                      if not arrprimes[temp] then arrcircular[counter] := temp;
                      inc(counter);
                      arrprimes[temp] := true;
                    end;
              end;
          end;

          case i of
            13: i := 17;
            56: i := 167;
            630: I := 1667;
            3323: i := 16667;
            else inc(i);
          end;
    end;

  QueryPerformanceCounter(stop);
  sort();
  total := total + ((stop-start) / freq);
////  ShowMessage(FloatToStr(total));
  ListBox1.Items.Add(IntToStr(arrcircular[n-1]) + ' ' + FloatToStrF((stop-start) / freq, ffnumber, 8, 8));

  // reset structures
  for I := 0 to 1000000 do arrprimes[i] := false;
  for I := 1 to 5 do arrcount[i] := 0;
  for I := 4 to 54 do arrcircular[i] := MaxInt;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  i : integer;
  total : real;
begin
  total := 0;
  for I := 1 to 1 do iscircular();
  ShowMessage(FloatToStrF(total, ffNumber, 8,8));
end;

procedure TForm1.sort;
var
  i, j, itemp, counter : integer;
begin
  for I := 0 to 53 do
    for j := 0 to 53 - i do
        begin
          if arrcircular[j] > arrcircular[j+1] then
            begin
              itemp := arrcircular[j+1];
              arrcircular[j+1] := arrcircular[j];
              arrcircular[j] := itemp;
            end;
        end;
end;

end.
