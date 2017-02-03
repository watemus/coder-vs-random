unit cvr_evil;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, cvr_actor, forms;

type

  { TEvil }

  TEvil = class(TActor)
    public
      constructor create(f: TForm);
      procedure update(Sender: TObject); override;
  end;

implementation

{ TEvil }

constructor TEvil.create(f: TForm);
begin
  inherited create(f);
  speed := 1;
end;

procedure TEvil.update(Sender: TObject);
begin
  inherited update(Sender);
  translateVector(1);
end;

end.
