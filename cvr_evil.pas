unit cvr_evil;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, cvr_actor, forms, ExtCtrls;

type

  { TEvil }

  TEvil = class(TActor)
    public
      damageTimer: TTimer;
      isDamaged: boolean;
      procedure timerDamageTimer(Sender: TObject);
      constructor create(f: TForm; py, px, size: Integer); override;
      procedure update(Sender: TObject); override;
  end;

implementation

{ TEvil }

procedure TEvil.timerDamageTimer(Sender: TObject);
begin
  isDamaged := true;
end;

constructor TEvil.create(f: TForm; py, px, size: Integer);
begin
  inherited create(f, py, px, size);
  MAX_HP := size;
  hp := MAX_HP;
  speed := 1;
  damage := 3;
  damageTimer := TTimer.create(form);
  damageTimer.interval := 5000;
  damageTimer.OnTimer := @timerDamageTimer;
  damageTimer.enabled := true;
end;

procedure TEvil.update(Sender: TObject);
begin
  inherited update(Sender);
  translateVector(-speed,0,speed);
  sizeX := hp;
end;

end.

