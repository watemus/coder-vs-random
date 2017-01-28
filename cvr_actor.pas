unit cvr_actor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls;

type

  { TActor }

  TActor = class
    public
      actorTimer: TTimer;
      procedure update();
  end;

implementation

{ TActor }

procedure TActor.update;
begin

end;

end.

