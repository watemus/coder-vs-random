unit cvr_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  cvr_map;

type

  { TFormMain }

  TFormMain = class(TForm)
    imgGame: TImage;
    pnlConsole: TListBox;
    pnlShop: TPanel;
    timerRender: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgGameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgGameMouseEnter(Sender: TObject);
    procedure imgGameMouseLeave(Sender: TObject);
    procedure imgGameMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgGameMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure timerRenderTimer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormMain: TFormMain;
  mousePosX, mousePosY: Integer;
  map: TMap;
  isRightMouseDown, isLeftMouseDown: Boolean;
  isRightMouseUp, isLeftMouseUp: Boolean;
  isMouseIn: Boolean;

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.timerRenderTimer(Sender: TObject);
var
  i: Integer;
begin
  imgGame.canvas.pen.color := RGBToColor(108, 122, 137);
  imgGame.canvas.brush.color := RGBToColor(108, 122, 137);
  imgGame.canvas.rectangle(0,0,imgGame.width,imgGame.width);
  for i:=0 to map.sizeY-1 do
  begin
      if(i mod 2 = 0) then
      begin
        imgGame.canvas.pen.color := RGBToColor(236,236,236);
        imgGame.canvas.brush.color := RGBToColor(236,236,236);
      end else
      begin
        imgGame.canvas.pen.color := RGBToColor(218, 223, 225);
        imgGame.canvas.brush.color := RGBToColor(218, 223, 225);
      end;
      imgGame.canvas.rectangle(
        0,
        map.getPixelByY(i),
        imgGame.width,
        map.getPixelByY(i+1)
      );
  end;
  i := 0;
  imgGame.canvas.pen.color := RGBToColor(149, 165, 166);
  imgGame.canvas.brush.color := RGBToColor(149, 165, 166);
  if (isMouseIn) then
  begin
    imgGame.Canvas.Rectangle(
      mousePosX - (map.getCubeSize() div 2),
      map.getPixelByY(map.getYByPixel(mousePosY)),
      mousePosX + (map.getCubeSize() div 2),
      map.getPixelByY(map.getYByPixel(mousePosY)) + map.getCubeSize()
    );
  end;
  if(isLeftMouseDown)then
  begin
    imgGame.canvas.pen.color := RGBToColor(108, 122, 137);
    imgGame.canvas.brush.color := RGBToColor(108, 122, 137);
    imgGame.Canvas.Rectangle(
      mousePosX - (map.getCubeSize() div 2),
      map.getPixelByY(map.getYByPixel(mousePosY)),
      mousePosX + (map.getCubeSize() div 2),
      map.getPixelByY(map.getYByPixel(mousePosY)) + map.getCubeSize()
    );
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  map := TMap.create(5,imgGame);
  SysUtils.CreateDir(ExtractFilePath(Application.ExeName)+'save');
end;

procedure TFormMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  case key of
    192:
    begin
      pnlConsole.visible := not pnlConsole.visible;
      timerRender.enabled := not timerRender.enabled;
    end;
  end;
end;

procedure TFormMain.imgGameMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  case Button of
    mbLeft:
    begin
      isLeftMouseDown := true;
    end;
    mbRight:
    begin
      isRightMouseDown := true;
    end;
  end;
end;

procedure TFormMain.imgGameMouseEnter(Sender: TObject);
begin
  isMouseIn := true;
end;

procedure TFormMain.imgGameMouseLeave(Sender: TObject);
begin
  isMouseIn := false;
end;

procedure TFormMain.imgGameMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  mousePosY := Y;
  mousePosX := X;
end;

procedure TFormMain.imgGameMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  case Button of
    mbLeft:
    begin
      isLeftMouseDown := false;
      isLeftMouseUp := true;
    end;
    mbRight:
    begin
      isRightMouseDown := false;
      isRightMouseUp := true;
    end;
  end;
end;

end.

