unit cvr_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  {DOM, XMLRead, XMLWrite, XMLCfg, XMLUtils, XMLStreaming,}
  cvr_map, cvr_actor, cvr_evil, cvr_cpp, cvr_java, cvr_array;

type

  { TFormMain }

  TFlatColor = record
    RED, GREEN, BLUE: Integer;
  end;

  TFormMain = class(TForm)
    imgGame: TImage;
    lblPoints: TLabel;
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
    procedure renderEllipse(posY,posX,sizeY,sizeX: Integer; flatColor: TFlatColor);
    function buyActor(cost: Integer): boolean;
  private
    { private declarations }
  public
    { public declarations }
  end;

  _EvilArray_ = specialize GActorArray<TEvil>;
  _CppArray_ = specialize GActorArray<TCpp>;
  _JavaArray_ = specialize GActorArray<TJava>;

var
  FormMain: TFormMain;
  money : Integer;
  mousePosX, mousePosY: Integer;
  map: TMap;
  isRightMouseDown, isLeftMouseDown: Boolean;
  isRightMouseUp, isLeftMouseUp: Boolean;
  isMouseIn: Boolean;
  isSpawnEvil: Boolean;
  idCount: Integer;
  evilArray: _EvilArray_;
  cppArray: _CppArray_;
  javaArray: _JavaArray_;
const
  EVIL_SIZE: Integer = 5;
  LYNCH: TFlatColor = (RED: 108; GREEN: 122; BLUE: 137);
  WHITE_SMOKE: TFlatColor = (RED: 236; GREEN: 236; BLUE: 236);
  PUMICE: TFlatColor = (RED: 210; GREEN: 215; BLUE: 211);
  CASCADE_: TFlatColor = (RED: 149; GREEN: 165; BLUE: 166);
  JADE: TFlatColor = (RED: 0; GREEN: 177; BLUE: 106);
  CALIFORNIA: TFlatColor = (RED: 248; GREEN: 148; BLUE: 6);

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

procedure TFormMain.renderEllipse(posY, posX, sizeY, sizeX: Integer;
  flatColor: TFlatColor);
begin
  imgGame.canvas.pen.color := RGBToColor(flatColor.RED, flatColor.GREEN, flatColor.BLUE);
  imgGame.canvas.brush.color := RGBToColor(flatColor.RED, flatColor.GREEN, flatColor.BLUE);
  imgGame.Canvas.Ellipse(
      posX - (sizeX div 2),
      map.getPixelByY(posY) + (map.getCubeSize() div 2) + (sizeY div 2),
      posX + (sizeX div 2),
      map.getPixelByY(posY) + (map.getCubeSize() div 2) - (sizeY div 2)
    );
end;

function TFormMain.buyActor(cost: Integer): boolean;
begin
  if(money - cost >= 0)then
  begin
    money := money - cost;
    buyActor := true;
    exit();
  end;
  buyActor := false;
end;

procedure TFormMain.timerRenderTimer(Sender: TObject);
var
  i,j,k,l: Integer;
begin
  lblPoints.caption := 'Coffee points: ' + IntToStr(money);
  renderField(map.sizeY);
  if (isMouseIn) then
  begin
    renderRect(
      map.getYByPixel(mousePosY),
      mousePosX,
      map.getCubeSize(),
      map.getCubeSize(),
      CASCADE_
    );
  end;
  if(isLeftMouseDown or isRightMouseDown)then
  begin
    renderRect(
      map.getYByPixel(mousePosY),
      mousePosX,
      map.getCubeSize(),
      map.getCubeSize(),
      LYNCH
    );
  end;
  if(isLeftMouseUp)then
  begin
     {if(cppArray.isCreateActorHere(
       mousePosX,
       map.getYByPixel(mousePosY),
       map.getCubeSize()
     )) then
     begin}
       if(buyActor(15)) then
       begin
         CppArray.add(TCpp.create(
          formmain,
          map.getYByPixel(mousePosY),
          mousePosX,
          map.getCubeSize()
         ));
       end;
     {end;}
     isLeftMouseUp := false;
  end;
  if(isRightMouseUp) then
  begin
    if(buyActor(15)) then
    begin
      JavaArray.add(TJava.create(
        formmain,
        map.getYByPixel(mousePosY),
        mousePosX,
        map.getCubeSize()
      ));
    end;
    isRightMouseUp := false;
  end;
  if(isSpawnEvil)then
  begin
    EvilArray.add(TEvil.create(
      formmain,
      random(map.sizeY),
      formmain.width,
      EVIL_SIZE)
    );
    isSpawnEvil := false;
  end;
  for i:=low(EvilArray.arr) to high(EvilArray.arr) do
  begin
    for j:=0 to EvilArray.arr[i].sizeX-1 do
    begin
      for k:=0 to EVIL_SIZE-1 do
      begin
        imgGame.canvas.brush.color := RGBToColor(random(255), random(255), random(255));
        imgGame.canvas.pen.color := imgGame.canvas.brush.color;
        imgGame.canvas.rectangle(
          EvilArray.arr[i].posX - (map.getCubeSize() div EVIL_SIZE * j),
          map.getPixelByY(EvilArray.arr[i].posY) + (map.getCubeSize() div EVIL_SIZE * k),
          EvilArray.arr[i].posX - (map.getCubeSize() div EVIL_SIZE * (j+1)),
          map.getPixelByY(EvilArray.arr[i].posY) + (map.getCubeSize() div EVIL_SIZE * (k+1))
        );
        for l := low(CppArray.arr) to high(CppArray.arr) do
        begin
          if(((CppArray.arr[l].posX + map.getCubeSize - 1 = EvilArray.arr[i].posX)) or
          (CppArray.arr[l].posX + map.getCubeSize = EvilArray.arr[i].posX)) and
          (CppArray.arr[l].posY = EvilArray.arr[i].posY) then
          begin
            EvilArray.arr[i].speed := 0;
            if(EvilArray.arr[i].isDamaged) then
            begin
              CppArray.arr[l].addHp(-EvilArray.arr[i].damage);
              EvilArray.arr[i].isDamaged := false
            end;
          end else
          begin
            EvilArray.arr[i].speed := 1;
          end;
        end;
        for l := low(JavaArray.arr) to high(JavaArray.arr) do
        begin
          if(((JavaArray.arr[l].posX + map.getCubeSize - 1 = EvilArray.arr[i].posX)) or
          (JavaArray.arr[l].posX + map.getCubeSize = EvilArray.arr[i].posX)) and
          (javaArray.arr[l].posY = EvilArray.arr[i].posY) then
          begin
            EvilArray.arr[i].speed := 0;
            if(EvilArray.arr[i].isDamaged) then
            begin
              JavaArray.arr[l].addHp(-EvilArray.arr[i].damage);
              EvilArray.arr[i].isDamaged := false
            end;
          end;
        end;
      end;
    end;
    if(EvilArray.arr[i].isDie) then
    begin
      EvilArray.destroyAtIndex(i);
    end;
  end;
  for i := low(CppArray.arr) to high(CppArray.arr) do
  begin
    renderEllipse(
      CppArray.arr[i].posY,
      CppArray.arr[i].posX,
      map.getCubeSize(),
      map.getCubeSize(),
      JADE
    );
    renderRect(
      CppArray.arr[i].plus_.posY,
      CppArray.arr[i].plus_.posX,
      map.getCubeSize(),
      map.getCubeSize() div 2,
      JADE
    );
    renderRect(
      CppArray.arr[i].plus_.posY,
      CppArray.arr[i].plus_.posX,
      map.getCubeSize() div 2,
      map.getCubeSize(),
      JADE
    );
    for j := low(EvilArray.arr) to high(EvilArray.arr) do
    begin
      if(((CppArray.arr[i].plus_.posX = EvilArray.arr[j].posX)) or
          (CppArray.arr[i].plus_.posX + 1 = EvilArray.arr[j].posX)) and
         (CppArray.arr[i].plus_.posY = EvilArray.arr[j].posY) Then
      begin
        EvilArray.arr[j].addHp(-CppArray.arr[i].plus_.damage);
      end;
    end;
    if(CppArray.arr[i].isDie) then CppArray.destroyAtIndex(i);
  end;
  for i := low(JavaArray.arr) to high(JavaArray.arr) do
  begin
    renderRect(
      JavaArray.arr[i].posY,
      JavaArray.arr[i].posX,
      map.getCubeSize,
      map.getCubeSize,
      CALIFORNIA
    );
    if(JavaArray.arr[i].isWorked) then
    begin
      money:= money+ JavaArray.arr[i].damage;
      JavaArray.arr[i].isWorked := false;
    end;
    if(JavaArray.arr[i].isDie) then JavaArray.destroyAtIndex(i);
  end;
end;

procedure TFormMain.timerSpawnerTimer(Sender: TObject);
begin
  isSpawnEvil := true;
end;

procedure TFormMain.FormCreate(Sender: TObject);
{var
  IdNode: TDOMNode;
  DocMain: TXMLDocument;}
begin
  map := TMap.create(10,imgGame);
  money := 50;
  {SysUtils.CreateDir(ExtractFilePath(Application.ExeName)+'save');
  ReadXMLFile(DocMain, ExtractFilePath(Application.ExeName)+'main.xml');
  IdNode := DocMain.DocumentElement.FindNode('save_id_counter');
  idCount := StrToInt(IdNode.FirstChild.NodeValue);
  pnlConsole.items.add(IntToStr(idCount));
  DocMain.free;}
  EvilArray := _EvilArray_.create;
  CppArray := _CppArray_.create;
  JavaArray := _JavaArray_.create;
end;

procedure TFormMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  case key of
    192:
    begin
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

