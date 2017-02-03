unit cvr_evil;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, cvr_actor, forms;

type

  { TEvil }

  TEvil = class(TActor)
    public
      constructor create(f: TForm; py, px: Integer);
      procedure update(Sender: TObject); override;
  end;

implementation

{ TEvil }

constructor TEvil.create(f: TForm; py, px: Integer);
begin
  inherited create(f, py, px);
  speed := 1;
end;

procedure TEvil.update(Sender: TObject);
begin
  inherited update(Sender);
  translateVector(1,speed);
end;

end.

