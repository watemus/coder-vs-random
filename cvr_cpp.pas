unit cvr_cpp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, cvr_actor, cvr_array;

type

  { TCpp }

  TCpp = class(TActor)
    public
      constructor create(f: TForm; py, px: Integer); override;
      procedure update(Sender: TObject); override;
  end;

implementation

{ TCpp }

constructor TCpp.create(f: TForm; py, px: Integer);
begin
  inherited create(f, py, px);
end;

procedure TCpp.update(Sender: TObject);
begin
  inherited update(Sender);
end;

end.

