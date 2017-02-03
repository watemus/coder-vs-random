unit cvr_map;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls;

type

  { Map }

  { TMap }

  TMap = class
    public
      imgGame: TImage;
      sizeY: Integer;
      function getPixelByY(y: Integer): Integer;
      function getYByPixel(y: Integer): Integer;
      function getCubeSize(): Integer;
      constructor create(y: Integer; ig: TImage);
  end;

implementation

{ Map }

{ Получить начальный пиксел по Y}
function TMap.getPixelByY(y: Integer): Integer;
begin
  getPixelByY := y * (imgGame.Height div sizeY);
end;
{ Получить Y по пикселу}
function TMap.getYByPixel(y: Integer): Integer;
begin
  getYByPixel := y div (imgGame.Height div sizeY);
end;
{ Получить сторону квадрата поля относительно их размеров }
function TMap.getCubeSize(): Integer;
begin
  getCubeSize := imgGame.Height div sizeY;
end;

constructor TMap.create(y: Integer; ig: TImage);
begin
  sizeY := y;
  imgGame := ig;
end;

end.

