unit cvr_evil;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, cvr_actor, forms;

type

  { TEvil }

  TEvil = class(TActor)
    public
      constructor create(f: TForm; py, px, size: Integer); override;
      procedure update(Sender: TObject); override;
  end;

implementation

{ TEvil }

constructor TEvil.create(f: TForm; py, px, size: Integer);
begin
  inherited create(f, py, px, size);
  MAX_HP := 5;
  hp := MAX_HP;
  speed := 1;
end;

procedure TEvil.update(Sender: TObject);
begin
  inherited update(Sender);
  translateVector(-1,0,speed);
  sizeX := hp;
end;

end.

