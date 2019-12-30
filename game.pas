program ihts;

uses wingraph, wincrt, sysutils;

const left = #75;
up = #72;
right = #77;
down = #80;
esc = #27;
enter = #13;
probel = #32;

n = 15;

var gd, gm,
xTank, yTank, hTank, vsTank, shTank, shStenaVert, vsStenaVert,
shKursor, vsKursor, np,
xStenaVert, yStenaVert,
shPula, vsPula, hPula,
sh, vs, i: integer;
pTankForward, pTankBack, pTankLeft, pTankRight,
stenaVert, stenaKrug: pointer;
ch:char;
put: string;
xPula, yPula: array[1..n] of integer; animPula: array[1..n] of AnimatType; pulaLog: array[1..n] of boolean;
animKursor: AnimatType;
pixelCur: longint;


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

procedure initData;
  begin
    xTank := 500;
    yTank := 500;

    xStenaVert := (getmaxx - 30 - 400) div 3;
    yStenaVert := (getmaxy - 30 - 30) div 7;

    vsStenaVert := 298;
    shStenaVert := 66;

    shPula := 10;
    vsPula := 10;

    for i := 1 to n do
      begin
        xPula[i] := getmaxx;
        yPula[i] := getmaxy;
        PulaLog[i] := false;
      end;

    vsTank := 65;
    shTank := 65;

    hTank := 5;
    hPula := 5;

    shKursor := 126;
    vsKursor := 54;
    np := 1;
  end;

procedure initPict;
  begin
    pTankForward := loader('G:\pascal\game\images\tankForward.bmp');
    //pTankForward := loader('C:\FPC\3.0.4\pascal\game\images\tankForward.bmp');

    pTankBack := loader('G:\pascal\game\images\tankBack.bmp');
    //pTankBack := loader('C:\FPC\3.0.4\pascal\game\images\tankBack.bmp');

    pTankLeft := loader('G:\pascal\game\images\tankLeft.bmp');
    //pTankLeft := loader('C:\FPC\3.0.4\pascal\game\images\tankLeft.bmp');

    pTankRight := loader('G:\pascal\game\images\tankRight.bmp');
    //pTankRight := loader('C:\FPC\3.0.4\pascal\game\images\tankRight.bmp');

    //stenaVert := loader('C:\FPC\3.0.4\pascal\game\images\stenaVert.bmp');
    stenaVert := loader('G:\pascal\game\images\stenaVert.bmp');

    //stenaVert := loader('C:\FPC\3.0.4\pascal\game\images\stenaVert.bmp');
    stenaKrug := loader('G:\pascal\game\images\stenaKrug.bmp');

    //newAnim(shKursor, vsKursor, 'C:\FPC\3.0.4\pascal\game\images\menuKursor.bmp', animKursor, black);
    newAnim(shKursor, vsKursor, 'G:\pascal\game\images\menuKursor.bmp', animKursor, black);

    for i := 1 to n do
      newAnim(shPula, vsPula, 'G:\pascal\game\images\pula.bmp', animPula[i], black);
  end;

procedure UprTank(var xTank, yTank: integer; shTank, vsTank, hTank: integer);
  begin
      ch := readkey();

          case ch of
            left :
              begin
                SetFillStyle(1, black);
                Bar(xTank, yTank, xTank + shTank, yTank + vsTank);

                xTank := xTank - hTank;

                pixelCur := getpixel(xTank - 1, yTank);

                if (pixelCur = 25) then
                  xTank := 200
                else if (pixelCur = 42) then
                  xTank := xTank + 1;



                PutImage(xTank, yTank, pTankLeft^, 1);
                put := 'pTankLeft^';
              end;

            right:
              begin
                SetFillStyle(1, black);
                Bar(xTank, yTank, xTank + shTank, yTank + vsTank);

                xTank := xTank + hTank;

                pixelCur := getpixel(xTank + shTank + 1, yTank);

                if (pixelCur = 25) then
                  xTank := getmaxx - 30 - shTank;

                PutImage(xTank, yTank, pTankRight^, 1);
                put := 'pTankRight^';

              end;


            up:
              begin
                SetFillStyle(1, black);
                Bar(xTank, yTank, xTank + shTank, yTank + vsTank);

                yTank := yTank - hTank;

                pixelCur := getpixel(xTank, yTank - 1);

                if (pixelCur = 25) then
                  yTank := 30;

                PutImage(xTank, yTank, pTankForward^, 1);
                put := 'pTankForward^';

              end;

            down:
              begin
                SetFillStyle(1, black);
                Bar(xTank, yTank, xTank + shTank, yTank + vsTank);

                yTank := yTank + hTank;

                pixelCur := getpixel(xTank, yTank + shTank + 1);

                if (pixelCur = 25) then
                  yTank := getmaxy - 30 - vsTank;

                PutImage(xTank, yTank, pTankBack^, 1);
                put := 'pTankBack^';

              end;
          end;


  end;

procedure poletPuli(var xPula,yPula: integer; hPula:integer; animPula: AnimatType);
  begin
    PutAnim(xPula,yPula,animPula,BkgPut);

    yPula := yPula - hPula;

    if (yPula <= 0) then
      pulaLog[i] := false
    else
      PutAnim(xPula,yPula,animPula,TransPut);

    UpdateGraph(updatenow);
  //  delay(1);
end;


procedure gamePole;
  begin
    SetFillStyle(1, gray);
    Bar(0, 0, getmaxx, getmaxy);

    SetFillStyle(1, black);
    Bar(200, 30, getmaxx - 30, getmaxy - 30);


    PutImage(xStenaVert, yStenaVert, StenaVert^, 1);
    PutImage(xStenaVert + 150, yStenaVert, StenaVert^, 1);
    PutImage(xStenaVert + 300, yStenaVert, StenaVert^, 1);
    PutImage(xStenaVert + 425, yStenaVert, StenaKrug^, 1);
    PutImage(xStenaVert + 700, yStenaVert, StenaVert^, 1);
    PutImage(xStenaVert + 850, yStenaVert, StenaVert^, 1);

    PutImage(xTank, yTank, pTankForward^, 1);
  end;

procedure game;
  begin
    initData;
    cleardevice;

    gamePole;

    repeat
      if KeyPressed then begin
        ch := readkey;
        if ch = #0 then UprTank(xTank, yTank, shTank, vsTank, hTank)
        else if ch = probel then
          for i:= 1 to n do
            begin
              if (PulaLog[i] = false) then
                begin
                  xPula[i] := xTank + shTank div 2 - 4;
                  yPula[i] := yTank;
                  PutAnim(xPula[i], yPula[i], animPula[i], TransPut);
                  PulaLog[i] := true;
                  break;
                end;
            end;
        end;

        for i:= 1 to n do
          if (PulaLog[i]) then
            poletPuli(xPula[i], yPula[i], hPula, animPula[i]);
          for i:= 1 to n do
            if (PulaLog[i]) then
              begin
                delay(1);
                break;
              end;
      Until ch = esc;
  end;

procedure Menu;
  begin
    cleardevice;

    // Курсор
    putAnim(450, getmaxy div 2 - 85 + (np - 1) * 70, animKursor, TransPut);
    setcolor(orange);
    settextstyle(1, 0, 100);
    outtextxy(getmaxx div 2 - 110, getmaxy div 2 - 200, 'Menu');

    // Вывод названий пунктов меню
    setcolor(blue);
    settextstyle(1, 0, 5);
    outtextxy(getmaxx div 2 - 50, getmaxy div 2 - 70, 'Game');
    outtextxy(getmaxx div 2 - 50, getmaxy div 2, 'Help');
    outtextxy(getmaxx div 2 - 50, getmaxy div 2 + 70, 'Quit');

    // Рамка
    Setcolor(red);
    SetLineStyle(1, 0, 5);

    Rectangle(getmaxx div 4, getmaxy div 3 - 80, (getmaxx div 4) * 3, (getmaxy div 3) * 2);
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
//gd := 9;
//gm := 11;
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
