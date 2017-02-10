unit cvr_cpp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, cvr_actor, cvr_array;

type

  { TPlus }

  TPlus = class(TActor)
    public
      spawnPosX: Integer;
      constructor create(f: TForm; py, px, size: Integer); override;
      procedure update(Sender: TObject); override;
  end;

  { TCpp }

  TCpp = class(TActor)
    public
      plus_ : TPlus;
      constructor create(f: TForm; py, px, size: Integer);
      procedure update(Sender: TObject); override;
  end;

implementation

{ TPlus }

constructor TPlus.create(f: TForm; py, px, size: Integer);
begin
  inherited create(f, py, px, size);
  spawnPosX := posX;
  damage := 2;
end;

procedure TPlus.update(Sender: TObject);
begin
  inherited update(Sender);
  translateVector(1,0,1);
  if(abs(posX) >= form.width)then
  begin
    posX := spawnPosX;
  end;
end;

{ TCpp }

constructor TCpp.create(f: TForm; py, px, size: Integer);
begin
  inherited create(f, py, px, size);
  plus_ := TPlus.create(f, py, px, size);
end;

procedure TCpp.update(Sender: TObject);
begin
  inherited update(Sender);
end;

end.

