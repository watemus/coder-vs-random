unit cvr_actor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Forms;

type

  { TActor }

  TActor = class
    private
      hp: Integer;
    public
      form: TForm;
      posX, posY: Integer;
      toX: Integer;
      toY: Integer;
      speed: Integer;
      actorTimer: TTimer;
      MAX_HP: Integer;
      isDie: boolean;
      sizeX : Integer;
      damage: Integer;
      constructor create(f: TForm;  py, px, size: Integer); virtual;
      procedure update(Sender: TObject); virtual;
      procedure translate(x,y,s: Integer); virtual;
      procedure translateVector(x,y,s: Integer); virtual;
      function isCreateActorHere(x,y,size: Integer): boolean;
      function getHp(): integer;
      procedure addHp(hp_: Integer);
      procedure setHp(hp_: Integer);
  end;

implementation

{ TActor }

constructor TActor.create(f: TForm; py, px, size: Integer);
begin
  form := f;
  posX := px;
  posY := py;
  sizeX := size;
  actorTimer := TTimer.create(form);
  actorTimer.Interval := 10;
  actorTimer.OnTimer := @update;
  hp := MAX_HP;
  isDie := false;
end;

procedure TActor.update(Sender: TObject);
begin
  if(toX > posX) then
  begin
    if(toX < posX + speed) then
    begin
      speed := toX - posX;
    end;
    posX := posX + speed;
  end else
  if(toX < posX) then
  begin
    if(toX > posX - speed) then
    begin
      speed := posX - toX;
    end;
    posX := posX - speed;
  end;
  if(toY > posY) then
  begin
    if(toY < posY + speed) then
    begin
      speed := toY - posY;
    end;
    posY := posY + speed;
  end else
  if(toY < posY) then
  begin
    if(toY > posY - speed) then
    begin
      speed := posY - toY;
    end;
    posY := posY - speed;
  end;
end;

{ Перемещение актора по вектору(posX + x) с определенной скоростью(s) }
procedure TActor.translateVector(x, y, s: Integer);
begin
  toX := posX + x;
  toY := posY + y;
  speed := s;
end;

function TActor.isCreateActorHere(x, y, size: Integer): boolean;
begin
  if((y = posY) and (abs(posX - x) < ((sizeX div 2) + (size div 2)))) then
  begin
    isCreateActorHere := true;
    writeln(1);
  end else
  begin
    isCreateActorHere := false;
  end;
end;

function TActor.getHp: integer;
begin
  getHp := hp;
end;

procedure TActor.addHp(hp_: Integer);
begin
  hp := hp + hp_;
  if(self.hp > MAX_HP) then
  begin
    self.hp := MAX_HP;
  end else
  if(self.hp <= 0) then
  begin
    isDie := true;
  end;
end;

procedure TActor.setHp(hp_: Integer);
begin
  hp := hp_;
  if(self.hp > MAX_HP) then
  begin
    self.hp := MAX_HP;
  end else
  if(self.hp <= 0) then
  begin
    isDie := true;
  end;
end;

{ Перемещение актора в точку(x) с определенной скоростью(s) }
procedure TActor.translate(x, y, s: Integer);
begin
  toX := x;
  toY := y;
  speed := s;
end;

end.

