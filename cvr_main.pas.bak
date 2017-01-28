unit cvr_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TFormMain }

  TFormMain = class(TForm)
    imgGame: TImage;
    pnlShop: TPanel;
    timerRender: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure timerRenderTimer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.timerRenderTimer(Sender: TObject);
var
  i,j: Integer;
begin
  imgGame.canvas.pen.color := RGBToColor(108, 122, 137);
  imgGame.canvas.brush.color := RGBToColor(108, 122, 137);
  imgGame.canvas.rectangle(0,0,1000,500);
  for i:=0 to 8 do
  begin
    for j:=0 to 4 do
    begin
      if(j mod 2 = 0) then
      begin
        imgGame.canvas.pen.color := RGBToColor(236,236,236);
        imgGame.canvas.brush.color := RGBToColor(236,236,236);
      end else
      begin
        imgGame.canvas.pen.color := RGBToColor(218, 223, 225);
        imgGame.canvas.brush.color := RGBToColor(218, 223, 225);
      end;
        imgGame.canvas.rectangle((i*100)+50,j*100,(i*100)+150,(j*100)+100);
    end;
  end;
  i := 0;
  j := 0;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
end;

end.

