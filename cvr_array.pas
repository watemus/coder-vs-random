unit cvr_array;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
type

  { GActorArray }

  generic GActorArray<T> = class
    public
      arr: array of T;
      length: Integer;
      constructor create();
      destructor destroy();
      procedure add(item: T);
      procedure destroyLast();
      procedure destroyAtIndex(index: Integer);
      function getItemAtIndex(index: Integer): T;
      function getLastItem(): T;
  end;

implementation

{ GActorArray }

constructor GActorArray.create;
begin

end;

destructor GActorArray.destroy;
begin

end;

procedure GActorArray.add(item: T);
begin

end;

procedure GActorArray.destroyLast;
begin

end;

procedure GActorArray.destroyAtIndex(index: Integer);
begin

end;

function GActorArray.getItemAtIndex(index: Integer): T;
begin

end;

function GActorArray.getLastItem: T;
begin

end;

end.

