unit cvr_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DOM, XMLRead, XMLWrite, XMLCfg, XMLUtils, XMLStreaming,
  cvr_map, cvr_actor, cvr_evil, cvr_array;

type

  { TFormMain }

  TFlatColor = record
    RED, GREEN, BLUE: Integer;
  end;

  TFormMain = class(TForm)
    imgGame: TImage;
    pnlConsole: TListBox;
    pnlShop: TPanel;
    timerSpawner: TTimer;
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
    procedure timerSpawnerTimer(Sender: TObject);
    procedure renderField(sizeY: integer);
    procedure renderRect(posY,posX,sizeY,sizeX: Integer; flatColor: TFlatColor);
  private
    { private declarations }
  public
    { public declarations }
  end;

  _EvilArray_ = specialize GActorArray<TEvil>;

var
  FormMain: TFormMain;
  mousePosX, mousePosY: Integer;
  map: TMap;
  isRightMouseDown, isLeftMouseDown: Boolean;
  isRightMouseUp, isLeftMouseUp: Boolean;
  isMouseIn: Boolean;
  isSpawnEvil: Boolean;
  idCount: Integer;
  evilArray: _EvilArray_;
const
  EVIL_SIZE: Integer = 5;
  LYNCH: TFlatColor = (RED: 108; GREEN: 122; BLUE: 137);
  WHITE_SMOKE: TFlatColor = (RED: 236; GREEN: 236; BLUE: 236);
  PUMICE: TFlatColor = (RED: 210; GREEN: 215; BLUE: 211);
  CASCADE_: TFlatColor = (RED: 149; GREEN: 165; BLUE: 166);

implementation

{$R *.lfm}

{ TFormMain }
procedure TFormMain.renderField(sizeY: integer);
var
  i: Integer;
begin
  imgGame.canvas.pen.color := RGBToColor(LYNCH.RED, LYNCH.GREEN, LYNCH.BLUE);
  imgGame.canvas.brush.color := RGBToColor(LYNCH.RED, LYNCH.GREEN, LYNCH.BLUE);
  imgGame.canvas.rectangle(0,0,imgGame.width,imgGame.width);
  for i:=0 to map.sizeY-1 do
  begin
      if(i mod 2 = 0) then
      begin
        imgGame.canvas.pen.color := RGBToColor(WHITE_SMOKE.RED, WHITE_SMOKE.GREEN, WHITE_SMOKE.BLUE);
        imgGame.canvas.brush.color := RGBToColor(WHITE_SMOKE.RED, WHITE_SMOKE.GREEN, WHITE_SMOKE.BLUE);
      end else
      begin
        imgGame.canvas.pen.color := RGBToColor(PUMICE.RED, PUMICE.GREEN, PUMICE.BLUE);
        imgGame.canvas.brush.color := RGBToColor(PUMICE.RED, PUMICE.GREEN, PUMICE.BLUE);
      end;
      imgGame.canvas.rectangle(
        0,
        map.getPixelByY(i),
        imgGame.width,
        map.getPixelByY(i+1)
      );
  end;
end;

procedure TFormMain.renderRect(posY, posX, sizeY, sizeX: Integer;
  flatColor: TFlatColor);
begin
  imgGame.canvas.pen.color := RGBToColor(flatColor.RED, flatColor.GREEN, flatColor.BLUE);
  imgGame.canvas.brush.color := RGBToColor(flatColor.RED, flatColor.GREEN, flatColor.BLUE);
  imgGame.Canvas.Rectangle(
      posX - (sizeX div 2),
      map.getPixelByY(posY) + (map.getCubeSize() div 2) + (sizeY div 2),
      posX + (sizeX div 2),
      map.getPixelByY(posY) + (map.getCubeSize() div 2) - (sizeY div 2)
    );
end;

procedure TFormMain.timerRenderTimer(Sender: TObject);
var
  i,j,k: Integer;
begin
  renderField(map.sizeY);
  if (isMouseIn and
     (not (mousePosX > (imgGame.width - map.getCubeSize() div 2))
         and (mousePosX < (0 + map.getCubeSize() div 2))
     and  (mousePosY > (imgGame.height - map.getCubeSize() div 2))
         and (mousePosY < 0 + map.getCubeSize() div 2)))
     then
  begin
    renderRect(
      map.getYByPixel(mousePosY),
      mousePosX,
      map.getCubeSize(),
      map.getCubeSize(),
      CASCADE_
    );
  end;
  if(isLeftMouseDown)then
  begin
    renderRect(
      map.getYByPixel(mousePosY),
      mousePosX,
      map.getCubeSize(),
      map.getCubeSize(),
      LYNCH
    );
  end;
  if(isSpawnEvil)then
  begin
    EvilArray.add(TEvil.create(
      formmain,
      random(map.sizeY),
      0)
    );
    isSpawnEvil := false;
  end;
  for i:=low(EvilArray.arr) to high(EvilArray.arr) do
  begin
    for j:=0 to EVIL_SIZE-1 do
    begin
      for k:=0 to EVIL_SIZE-1 do
      begin
        imgGame.canvas.brush.color := RGBToColor(random(255), random(255), random(255));
        imgGame.canvas.pen.color := imgGame.canvas.brush.color;
        imgGame.canvas.rectangle(
          imgGame.Width - map.getCubeSize() + (map.getCubeSize() div EVIL_SIZE * j) - EvilArray.arr[i].posX,
          imgGame.Height - map.getCubeSize() + (map.getCubeSize() div EVIL_SIZE * k) - map.getPixelByY(EvilArray.arr[i].posY),
          imgGame.Width - map.getCubeSize() + (map.getCubeSize() div EVIL_SIZE * (j+1))- EvilArray.arr[i].posX,
          imgGame.Height - map.getCubeSize() + (map.getCubeSize() div EVIL_SIZE * (k+1)) - map.getPixelByY(EvilArray.arr[i].posY)
        );
      end;
    end;
  end;
end;

procedure TFormMain.timerSpawnerTimer(Sender: TObject);
begin
  isSpawnEvil := true;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  IdNode: TDOMNode;
  DocMain: TXMLDocument;
begin
  map := TMap.create(10,imgGame);
  SysUtils.CreateDir(ExtractFilePath(Application.ExeName)+'save');
  ReadXMLFile(DocMain, ExtractFilePath(Application.ExeName)+'main.xml');
  IdNode := DocMain.DocumentElement.FindNode('save_id_counter');
  idCount := StrToInt(IdNode.FirstChild.NodeValue);
  pnlConsole.items.add(IntToStr(idCount));
  DocMain.free;
  EvilArray := _EvilArray_.create;
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

