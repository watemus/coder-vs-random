unit cvr_actor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Forms;

type

  { TActor }

  TActor = class
    public
      form: TForm;
      posX, posY: Integer;
      toX: Integer;
      speed: Integer;
      actorTimer: TTimer;
      constructor create(f: TForm;  py, px: Integer); virtual;
      procedure update(Sender: TObject); virtual;
      procedure translate(x,s: Integer); virtual;
      procedure translateVector(x,s: Integer); virtual;
  end;

implementation

{ TActor }

constructor TActor.create(f: TForm; py, px: Integer);
begin
  form := f;
  posX := px;
  posY := py;
  actorTimer := TTimer.create(form);
  actorTimer.Interval := 10;
  actorTimer.OnTimer := @update;
end;

procedure TActor.update(Sender: TObject);
begin
  if(not (toX = posX)) then
  begin
    posX := posX + speed;
  end
end;

{ Перемещение актора по вектору(posX + x) с определенной скоростью(s) }
procedure TActor.translateVector(x, s: Integer);
begin
  toX := posX + x;
  speed := s;
end;
{ Перемещение актора в точку(x) с определенной скоростью(s) }
procedure TActor.translate(x, s: Integer);
begin
  toX := x;
  speed := s;
end;

end.

