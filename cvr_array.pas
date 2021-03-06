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
      {function isCreateActorHere(x, y, size: Integer): boolean;}
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
  arr[length-1] := item;
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
    for i := index to length-1 do
    begin
      arr[i] := arr[i+1];
    end;
    SetLength(arr, length);
  end;
end;

function GActorArray.getItemAtIndex(index: Integer): T;
begin
  if((index < length) and (index >= 0)) then
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

{function GActorArray.isCreateActorHere(x, y, size: Integer): boolean;
var
  i: Integer;
begin
  for i := low(arr) to high(arr) do
  begin
    if (arr[i].isCreateActorHere(
       x,
       y,
       size
    ) and (i <> (length-1))) then
    begin
      isCreateActorHere := false;
      exit();
    end;
  end;
  isCreateActorHere := true;
end;}

end.

