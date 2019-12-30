program ihts;

uses wingraph, wincrt, sysutils;

const left = #75;
up = #72;
right = #77;
down = #80;
esc = #27;
enter = #13;
probel = #32;

var xTank, yTank, hTank, gd, gm, i, vsTank, shTank, shKursor, vsKursor, sh, vs, np: integer;
pTankForward, pTankBack, pTankLeft, pTankRight : pointer;
ch:char;
put: string;
animKursor: AnimatType;


// Functions

function loader(filename: string): pointer;
var f:file; size: longint; p:pointer;
begin
assign(f, filename);
if FileExists(filename) then
        begin
        reset(f, 1);
        size := FileSize(f);
        GetMem(p, size);
        BlockRead(f, p^, size);
        Close(f);
        loader := p;
        end;
end;

//Procedures

procedure newAnim(sh, vs: integer; filename: string; var anim: AnimatType; col: longint);
  var p: pointer;
  begin
    p := loader(filename);
    cleardevice;
    SetFillStyle(1, col);
    Bar(0 ,0, getmaxx, getmaxy);
    PutImage(0, 0, p^, 0);
    GetAnim(0, 0, sh, vs, col, anim);
    FreeMem(p);
    cleardevice;
  end;

procedure initPict;
  begin
    pTankForward := loader('G:\pascal\game\images\tankForward.bmp');
    pTankBack := loader('G:\pascal\game\images\tankBack.bmp');
    pTankLeft := loader('G:\pascal\game\images\tankLeft.bmp');
    pTankRight := loader('G:\pascal\game\images\tankRight.bmp');

    newAnim(shKursor, vsKursor, 'G:\pascal\game\images\menuKursor.bmp', animKursor, black);
  end;

procedure UprTank(var xTank, yTank: integer; shTank, vsTank, hTank: integer);
  begin
    SetFillStyle(1, black);
    Bar(xTank, yTank, xTank + shTank, yTank + vsTank);

    ch := readkey();

    if ch = #0 then
      begin
        ch:= readkey();
          case ch of
            left :
              begin
                PutImage(xTank, yTank, pTankLeft^, 1);
                put := 'pTankLeft^';
                xTank := xTank - hTank;
              end;
            right:
              begin
                PutImage(xTank, yTank, pTankRight^, 1);
                put := 'pTankRight^';
                xTank := xTank + hTank;
              end;
            up:
              begin
                PutImage(xTank, yTank, pTankForward^, 1);
                put := 'pTankForward^';
                yTank := yTank - hTank;

              end;
            down:
              begin
                PutImage(xTank, yTank, pTankBack^, 1);
                put := 'pTankBack^';
                yTank := yTank + hTank;
              end;
          end;

        end;
  end;

procedure initData;
  begin
    xTank := 500;
    yTank := 500;


    vsTank := 65;
    shTank := 65;

    hTank := 5;

    shKursor := 126;
    vsKursor := 54;
    np := 1;
  end;

procedure game;
  begin
    initData;
    cleardevice;

    SetFillStyle(1, gray);
    Bar(0, 0, getmaxx, getmaxy);

    SetFillStyle(1, black);
    Bar(150, 30, getmaxx - 30, getmaxy - 30);

    PutImage(xTank, yTank, pTankForward^, 1);

    repeat
      if KeyPressed then UprTank(xTank, yTank, shTank, vsTank, hTank);
        //if proverka (x, y, x1, y1) then hy := -hy;
      Until ch = esc;
      readkey;

  end;

procedure Menu;
  begin
    cleardevice;
    putAnim(450, getmaxy div 2 - 85 + (np - 1) * 70, animKursor, TransPut);
    setcolor(orange);
    settextstyle(1, 0, 100);
    outtextxy(getmaxx div 2 - 110, getmaxy div 2 - 200, 'Menu');

    setcolor(blue);
    settextstyle(1, 0, 5);
    outtextxy(getmaxx div 2 - 50, getmaxy div 2 - 70, 'Game');
    outtextxy(getmaxx div 2 - 50, getmaxy div 2, 'Help');
    outtextxy(getmaxx div 2 - 50, getmaxy div 2 + 70, 'Quit');

    Setcolor(red);
    SetLineStyle(1, 0, 5);
    Rectangle(getmaxx div 3, getmaxy div 3 - 80, (getmaxx div 3) * 2, (getmaxy div 3) * 2);
      ch := readkey();
        if ch = #0 then
          begin
            putAnim(450, getmaxy div 2 - 85 + (np - 1) * 70, animKursor, BkgPut);
            ch := readkey();

              case ch of
                up: if np > 1 then np := np - 1;
                down: if np < 3 then np := np + 1;
              end;
          end else
            begin
              if ch = enter then
                case np of
                  1: game;
                  2: halt;
                  3: halt;
                end;
            end;
  end;


BEGIN
SetWindowSize(1300, 800);
gd := d8bit;
gm := mCustom;
InitGraph(gd, gm, 'Ball');
initData;
initPict;

Repeat
        Menu;
Until 1 = 2;
CloseGraph;
//Readln();

END.
