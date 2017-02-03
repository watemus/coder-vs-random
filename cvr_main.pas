unit cvr_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DOM, XMLRead, XMLWrite, XMLCfg, XMLUtils, XMLStreaming,
  cvr_map, cvr_actor;

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

  TFlatColor = record
    RED, GREEN, BLUE: Integer;
  end;

var
  FormMain: TFormMain;
  mousePosX, mousePosY: Integer;
  map: TMap;
  isRightMouseDown, isLeftMouseDown: Boolean;
  isRightMouseUp, isLeftMouseUp: Boolean;
  isMouseIn: Boolean;
  idCount: Integer;
const
  LYNCH: TFlatColor = (RED: 108; GREEN: 122; BLUE: 137);
  WHITE_SMOKE: TFlatColor = (RED: 236; GREEN: 236; BLUE: 236);
  PUMICE: TFlatColor = (RED: 210; GREEN: 215; BLUE: 211);
  CASCADE_: TFlatColor = (RED: 149; GREEN: 165; BLUE: 166);

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.timerRenderTimer(Sender: TObject);
var
  i: Integer;
  countActors: TActor;
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
  i := 0;
  imgGame.canvas.pen.color := RGBToColor(CASCADE_.RED, CASCADE_.GREEN, CASCADE_.BLUE);
  imgGame.canvas.brush.color := RGBToColor(CASCADE_.RED, CASCADE_.GREEN, CASCADE_.BLUE);
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
    imgGame.canvas.pen.color := RGBToColor(LYNCH.RED, LYNCH.GREEN, LYNCH.BLUE);
    imgGame.canvas.brush.color := RGBToColor(LYNCH.RED, LYNCH.GREEN, LYNCH.BLUE);
    imgGame.Canvas.Rectangle(
      mousePosX - (map.getCubeSize() div 2),
      map.getPixelByY(map.getYByPixel(mousePosY)),
      mousePosX + (map.getCubeSize() div 2),
      map.getPixelByY(map.getYByPixel(mousePosY)) + map.getCubeSize()
    );
  end;
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

