unit cvr_java;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, cvr_actor, Forms, ExtCtrls;
type

  { TJava }

  TJava = class(TActor)
    public
      workTimer: TTimer;
      isWorked: boolean;
      constructor create(f: TForm; py, px, size: Integer); override;
      procedure update(Sender: TObject); override;
      procedure work(Sender: TObject);
  end;

implementation

{ TJava }

constructor TJava.create(f: TForm; py, px, size: Integer);
begin
  inherited create(f, py, px, size);
  damage := 15;
  hp := 9;
  workTimer := TTimer.create(form);
  workTimer.interval := 5000;
  workTimer.OnTimer := @work;
  workTimer.enabled := true;
end;

procedure TJava.update(Sender: TObject);
begin
  inherited update(Sender);
end;

procedure TJava.work(Sender: TObject);
begin
  isWorked := true;
end;

end.

