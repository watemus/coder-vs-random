unit cvr_actor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Forms;

type

  { TActor }

  TActor = class
    public
      actorTimer: TTimer;
      constructor create(f: TForm); virtual;
      procedure update();
      function
  end;

implementation

{ TActor }

constructor TActor.create(f: TForm);
begin
  actorTimer := TTimer.create(f);
end;

procedure TActor.update;
begin

end;

end.

