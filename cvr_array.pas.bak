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
  length := 0;
end;

procedure GActorArray.add(item: T);
begin
  inc(length);
  SetLength(arr, length);
  arr[length] := item;
end;

procedure GActorArray.destroyLast;
begin
  dec(length);
  SetLength(arr, length);
end;

procedure GActorArray.destroyAtIndex(index: Integer);
var
  i: Integer;
begin
  if((index <= length) and (index >= 0)) then
  begin
    dec(length);
    for i := index to length do
    begin
      arr[i] := arr[i+1];
    end;
    SetLength(arr, length);
  end;
end;

function GActorArray.getItemAtIndex(index: Integer): T;
begin
  if((index <= length) and (index >= 0)) then
  begin
    getItemAtIndex := arr[index];
    exit();
  end;
  getItemAtIndex := arr[0];
end;

function GActorArray.getLastItem: T;
begin
  getLastItem := arr[length];
end;

end.

