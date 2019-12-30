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

var gd, gm, //Переменные для графа
xTank, yTank, hTank, vsTank, shTank, //Переменные танка
xEnemy, yEnemy, hEnemy, shEnemy, vsEnemy, dirEnemy,//Переменны для врагов
xStenaVert, yStenaVert, shStenaVert, vsStenaVert, //Переменные для 1-го типа стены
shStenaVertSmall, vsStenaVertSmall, //Переменные для 2-го типа стены
shBase, vsBase, xBase, yBase,  vsBlock, shBlock, //Переменные для базы и блока
shPula, vsPula, hPula, //Переменные для пули
shKursor, vsKursor, np, //Переменные для курсора
sh, vs, i, dirTank, //Другие переменные
SP1X, SP1Y, //Stop Point
kLevel, kLifes, kEnemies: integer; //Переменные счетчика
pTankForward, pTankBack, pTankLeft, pTankRight, //Картинки танка
enemyForward, enemyRight, enemyLeft, enemyBack, //Картинки врага
stenaVert, stenaVertSmall, stenaVertSmall2, stenaBlock, stenaGorizSmall, base, //Картинки разных стен, блока и базы
menuBg, warningText: pointer; //Фон в меню
ch:char; //Считыватель клавиши
put, kLifesStr, kEnemiesStr, kLevelStr: string; //Переменные строковые для счетчика
xPula, yPula, dirPula: array[1..n] of integer; animPula: array[1..n] of AnimatType; pulaLog: array[1..n] of boolean;
//Массивы для пуль
animKursor, helpText: AnimatType; //Переменные для анимации курсора и пункта Помощь
pixelCur, pixelCurPula: longint; //Считыватель следующего пикселя


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
    xTank := 250;
    yTank := getmaxy - 50 - vsTank;

    xEnemy := 300;
    yEnemy := 50;
    hEnemy := 1;
    dirEnemy := 2;

    shEnemy := 65;
    vsEnemy := 70;

    xStenaVert := 325;
    yStenaVert := 130;

    vsStenaVert := 266;
    shStenaVert := 66;

    shBlock := 71;
    vsBlock := 66;

    shStenaVertSmall := 66;
    vsStenaVertSmall := 217;

    shPula := 10;
    vsPula := 10;

    dirTank := 1;

    for i := 1 to n do
      begin
        xPula[i] := getmaxx;
        yPula[i] := getmaxy;
        PulaLog[i] := false;

        //dirPula[i] := dirTank;
      end;

    vsTank := 65;
    shTank := 65;

    xBase := 710;
    yBase := getmaxy - 50;

    shBase := 73;
    vsBase := 66;

    hTank := 5;
    hPula := 5;

    shKursor := 126;
    vsKursor := 54;
    np := 1;

    kLifes := 3;
    Str(kLifes, kLifesStr);

    kEnemies := 0;
    Str(kEnemies, kEnemiesStr);

    kLevel := 1;
    Str(kLevel, kLevelStr);
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

    enemyForward := loader('G:\pascal\game\images\enemyForward.bmp');
    //enemyForward := loader('C:\FPC\3.0.4\pascal\game\images\enemyForward.bmp');

    enemyLeft := loader('G:\pascal\game\images\enemyLeft.bmp');
    //enemyLeft := loader('C:\FPC\3.0.4\pascal\game\images\enemyLeft.bmp');

    enemyBack := loader('G:\pascal\game\images\enemyBack.bmp');
    //enemyBack := loader('C:\FPC\3.0.4\pascal\game\images\enemyBack.bmp');

    enemyRight := loader('G:\pascal\game\images\enemyRight.bmp');
    //enemyRight := loader('C:\FPC\3.0.4\pascal\game\images\enemyRight.bmp');

    //stenaVert := loader('C:\FPC\3.0.4\pascal\game\images\stenaVert.bmp');
    stenaVert := loader('G:\pascal\game\images\stenaVert.bmp');

    //stenaVertSmall := loader('C:\FPC\3.0.4\pascal\game\images\stenaVertSmall.bmp');
    stenaVertSmall := loader('G:\pascal\game\images\stenaVertSmall.bmp');

    //stenaVertSmall2 := loader('C:\FPC\3.0.4\pascal\game\images\stenaVertSmall2.bmp');
    stenaVertSmall2 := loader('G:\pascal\game\images\stenaVertSmall2.bmp');

    //stenaBlock := loader('C:\FPC\3.0.4\pascal\game\images\stenaBlock.bmp');
    stenaBlock := loader('G:\pascal\game\images\stenaBlock.bmp');

    //stenaGorizSmall := loader('C:\FPC\3.0.4\pascal\game\images\stenaGorizSmall.bmp');
    stenaGorizSmall := loader('G:\pascal\game\images\stenaGorizSmall.bmp');

    //base := loader('C:\FPC\3.0.4\pascal\game\images\base.bmp');
    base := loader('G:\pascal\game\images\base.bmp');

    //menuBg := loader('C:\FPC\3.0.4\pascal\game\images\menuBg2.bmp');
    menuBg := loader('G:\pascal\game\images\menuBg2.bmp');

    //warningText := loader('C:\FPC\3.0.4\pascal\game\images\warningText.bmp');
    warningText := loader('G:\pascal\game\images\warningText.bmp');

    //helpText := loader('C:\FPC\3.0.4\pascal\game\images\help.bmp');
    //helpText := loader('G:\pascal\game\images\help.bmp');

    //newAnim(shKursor, vsKursor, 'C:\FPC\3.0.4\pascal\game\images\menuKursor2.bmp', animKursor, black);
    newAnim(shKursor, vsKursor, 'G:\pascal\game\images\menuKursor2.bmp', animKursor, black);

    newAnim(492, 340, 'G:\pascal\game\images\help.bmp', helpText, white);
    //newAnim(492, 340, 'C:\FPC\3.0.4\pascal\game\images\help.bmp', helpText, white);

    for i := 1 to n do
      newAnim(shPula, vsPula, 'G:\pascal\game\images\pula.bmp', animPula[i], black);

    //for i := 1 to n do
      //newAnim(shPula, vsPula, 'C:\FPC\3.0.4\pascal\game\images\pula.bmp', animPula[i], black);

  end;

procedure Warning;
  begin
    //SetFillStyle(1, orange);
    //Bar(700, 200, 700 + 500, 200 + 320);
    //Cleardevice;
    PutImage(getmaxx div 2 - 250, 200, warningText^, 0);
    ReadKey();
  end;

procedure count;
  begin
    setcolor(orange);
    settextstyle(1, 0, 5);
    SetLineStyle(1, 0 ,5);
    outtextxy(45, 55, 'Game stats');

    setcolor(blue);
    settextstyle(1, 0, 4);
    outtextxy(45, 120, 'Lifes');
    outTextXY(200, 120, kLifesStr);

    outtextxy(45, 165, 'Enemies');
    outtextxy(200, 168, kEnemiesStr);

    outtextxy(45, 210, 'Level');
    outTextXY(200, 213, kLevelStr);

  end;

procedure Enemy(var xEnemy, yEnemy: integer; hEnemy: integer);
  begin
    SetFillStyle(1, black);
    //Bar(xEnemy, yEnemy, xEnemy + shEnemy, yEnemy + vsEnemy);
    UpdateGraph(UpdateOff);
    case dirEnemy of
      1:
        begin
          Bar(xEnemy, yEnemy, xEnemy + shEnemy, yEnemy + vsEnemy);
          yEnemy := yEnemy - hEnemy;
          if ((yEnemy <= 50) and (xEnemy = 250 + 2)) then //Левый угол
            dirEnemy := 2
          else if ((yEnemy <= 50) and (xEnemy = getmaxx - 50 - shEnemy)) then //Правый угол
            dirEnemy := 4
          else if (yEnemy <= 50) then  //Верхняя стена
            dirEnemy := 1+ random(5 - 1)
          else if ((xEnemy = xStenaVert + 720 + shBlock + shStenaVert) and (yEnemy = yStenaVert + vsStenaVert))
          then //5 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = 250 + 2) and (yEnemy = yStenaVert + vsStenaVert))
          then //10 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if (yEnemy > 50) then
            PutImage(xEnemy, yEnemy, enemyForward^, 1);

        end;
      2:
        begin
          Bar(xEnemy, yEnemy, xEnemy + vsEnemy, yEnemy + shEnemy);
          xEnemy := xEnemy + hEnemy;
          //PutImage(xEnemy, yEnemy, enemyRight^, 1);
          if ((xEnemy + vsEnemy = getmaxx - 45) and (yEnemy = 50)) then   //Верхний угол
            dirEnemy := 3
          else if ((xEnemy + vsEnemy >= getmaxx - 45) and (yEnemy = getmaxy - 50 - vsEnemy)) then  //Нижний угол
            dirEnemy := 1
          else if (xEnemy + vsEnemy >= getmaxx - 45) then  //Правая стена
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + shStenaVert) and (yEnemy = 50)) then //1 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 145 + shStenaVert) and (yEnemy = 50)) then //2 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 577 + shBlock - 70) and (yEnemy = 50)) then //3 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 720 + shBlock - 70) and (yEnemy = 50)) then //4 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 720 + shBlock + shStenaVert) and (yEnemy = yStenaVert + vsStenaVert))
          then //5 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 720 + shBlock - 70) and (yEnemy = yStenaVert + vsStenaVert + 75 +
          vsStenaVertSmall)) then //6 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 577 + shBlock - 70) and (yEnemy = yStenaVert + vsStenaVert + 75 +
          vsStenaVertSmall)) then //7 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 145 + shStenaVert) and (yEnemy = yStenaVert + vsStenaVert + 75 +
          vsStenaVertSmall)) then //8 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + shStenaVert) and (yEnemy = yStenaVert + vsStenaVert + 75 +
          vsStenaVertSmall)) then //9 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          //else if ((xEnemy = 250 + 2) and (yEnemy = yStenaVert + vsStenaVert))
          //then //10 Стоп-точка
            //dirEnemy := 1 + random(5 - 1)
          else if (xEnemy + vsEnemy < getmaxx - 50) then
            PutImage(xEnemy, yEnemy, enemyRight^, 1);

          //writeln(dirEnemy);
        end;
      3:
        begin
          Bar(xEnemy, yEnemy, xEnemy + shEnemy, yEnemy + vsEnemy);
          yEnemy := yEnemy + hEnemy;
          if ((yEnemy + vsEnemy >= getmaxy - 50) and (xEnemy = getmaxx -  50 - shEnemy)) then //Правый угол угол
            dirEnemy := 4
          else if ((yEnemy + vsEnemy >= getmaxy - 50) and (xEnemy = 250 + 2)) then //Левый угол
            dirEnemy := 2
          else if (yEnemy + vsEnemy >= getmaxy - 50) then //Нижняя стена
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 720 + shBlock + shStenaVert) and (yEnemy = yStenaVert + vsStenaVert))
          then //5 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = 250 + 2) and (yEnemy = yStenaVert + vsStenaVert))
          then //10 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if (yEnemy + vsEnemy < getmaxy - 50) then
            PutImage(xEnemy, yEnemy, enemyBack^, 1);
        end;
      4:
        begin
          Bar(xEnemy, yEnemy, xEnemy + vsEnemy, yEnemy + shEnemy);
          xEnemy := xEnemy - hEnemy;
          if ((xEnemy <= 250 + 2) and (yEnemy = getmaxy - 50 - vsEnemy)) then //Нижний угол
            dirEnemy := 1
          else if ((xEnemy <= 250 + 2) and (yEnemy = 50)) then //Верхний угол
            dirEnemy := 3
          else if (xEnemy <= 250 + 2) then //Левая стена
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + shStenaVert) and (yEnemy = 50)) then //1 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 145 + shStenaVert) and (yEnemy = 50)) then //2 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 577 + shBlock - 70) and (yEnemy = 50)) then //3 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 720 + shBlock - 70) and (yEnemy = 50)) then //4 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          //else if ((xEnemy = xStenaVert + 720 + shBlock + shStenaVert) and (yEnemy = yStenaVert + vsStenaVert))
          //then //5 Стоп-точка
            //dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 720 + shBlock - 70) and (yEnemy = yStenaVert + vsStenaVert + 75 +
          vsStenaVertSmall)) then //6 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 577 + shBlock - 70) and (yEnemy = yStenaVert + vsStenaVert + 75 +
          vsStenaVertSmall)) then //7 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + 145 + shStenaVert) and (yEnemy = yStenaVert + vsStenaVert + 75 +
          vsStenaVertSmall)) then //8 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = xStenaVert + shStenaVert) and (yEnemy = yStenaVert + vsStenaVert + 75 +
          vsStenaVertSmall)) then //9 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if ((xEnemy = 250 + 2) and (yEnemy = yStenaVert + vsStenaVert))
          then //10 Стоп-точка
            dirEnemy := 1 + random(5 - 1)
          else if (xEnemy > 250) then
            PutImage(xEnemy, yEnemy, enemyLeft^, 1);
        end;

    end;
    UpdateGraph(UpdateNow);
    Delay(10);


  end;

procedure UprTank(var xTank, yTank: integer; shTank, vsTank, hTank: integer);
var colWay: boolean;
i: integer;
  begin
      ch := readkey();

          case ch of
            left :
              begin
                SetFillStyle(1, black);
                Bar(xTank, yTank, xTank + shTank, yTank + vsTank);

                if (dirTank <> 4) then
                  begin
                    PutImage(xTank, yTank, pTankLeft^, 1);
                    dirTank := 4;
                  end
                else
                begin
                  dirTank := 4;

                  colWay := false;

                  for i := 1 to vsTank + 1 do
                    begin
                      pixelCur := getpixel(xTank - 1, yTank + i);
                      if ((pixelCur = 4) or (pixelCur = 91) or (pixelCur = 42) or (pixelCur = 25)) then
                        colWay := true;
                    end;

                  if (colWay = false) then
                    xTank := xTank - hTank;

                  PutImage(xTank, yTank, pTankLeft^, 1);

                  put := 'pTankLeft^';
                end;



                //dirPula[i] := dirTank;

              end;

            right:
              begin
                SetFillStyle(1, black);
                Bar(xTank, yTank, xTank + shTank, yTank + vsTank);

                if (dirTank <> 2) then
                  begin
                    PutImage(xTank, yTank, pTankRight^, 1);
                    dirTank := 2;
                  end
                else
                  begin
                    dirTank := 2;
                //dirPula[i] := dirTank;

                    colWay := false;

                    for i := 1 to vsTank + 1 do
                      begin
                        pixelCur := getpixel(xTank + shTank + 1, yTank + i);
                          if ((pixelCur = 4) or (pixelCur = 91) or (pixelCur = 42) or (pixelCur = 25)) then
                            colWay := true;
                      end;

                     if not colWay then
                       xTank := xTank + hTank;

                     PutImage(xTank, yTank, pTankRight^, 1);

                     put := 'pTankRight^';
                  end;
              end;


            up:
              begin
                SetFillStyle(1, black);
                Bar(xTank, yTank, xTank + shTank, yTank + vsTank);

                if (dirTank <> 1) then
                  begin
                    PutImage(xTank, yTank, pTankForward^, 1);
                    dirTank := 1;
                  end
                else
                  begin
                    //yTank := yTank - hTank;

                    dirTank := 1;
                //dirPula := dirTank;

                    colWay := false;

                    for i := 1 to shTank + 1 do
                      begin
                        pixelCur := getpixel(xTank + i, yTank - 1); //xTank - 1, yTank + i
                          if ((pixelCur = 4) or (pixelCur = 91) or (pixelCur = 42) or (pixelCur = 25)) then
                            colWay := true;
                    end;

                   if not colWay then
                     yTank := yTank - hTank;

                   PutImage(xTank, yTank, pTankForward^, 1);

                    put := 'pTankForward^';
                  end;
              end;

            down:
              begin
                SetFillStyle(1, black);
                Bar(xTank, yTank, xTank + shTank, yTank + vsTank);

                if (dirTank <> 3) then
                  begin
                    PutImage(xTank, yTank, pTankBack^, 1);
                    dirTank := 3;
                  end
                else
                  begin
                    colWay := false;

                    for i := 1 to shTank + 1 do
                      begin
                        pixelCur := getpixel(xTank + i, yTank + vsTank + 1);
                          if ((pixelCur = 4) or (pixelCur = 91) or (pixelCur = 42) or (pixelCur = 25)) then
                            colWay := true;
                    end;

                    if not colWay then
                      yTank := yTank + hTank;

                    PutImage(xTank, yTank, pTankBack^, 1);
                    put := 'pTankBack^';
                  end;
               end;
             end;


  end;

procedure poletPuli(var xPula, yPula: integer; hPula:integer; animPula: AnimatType);
  begin
    PutAnim(xPula,yPula,animPula,BkgPut);

    case dirPula[i] of
      1:
        begin
          yPula := yPula - hPula;
          PixelCurPula := getPixel(xPula, yPula - 1);
          if ((pixelCurPula = 42) or (pixelCurPula = 91) or (pixelCurPula = 4)) then
            begin
              SetColor(black);
              SetFillStyle(1, black);
              //Circle(xPula + 5, yPula, 10);
              //FloodFill(xPula + 5, yPula, black);
              FillEllipse(xPula + 5, yPula, 10, 10);

              pulaLog[i] := false;
              xPula := getmaxx;
              yPula := getmaxy;

            end;
         end;
      2:
        begin
          xPula := xPula + hPula;
          PixelCurPula := getPixel(xPula + shPula + 1, yPula);
          //writeln(pixelCurPula);
          if ((pixelCurPula = 42) or (pixelCurPula = 91) or (pixelCurPula = 4)) then
            begin
              SetColor(black);
              SetFillStyle(1, black);
              //Circle(xPula + 5, yPula, 10);
              //FloodFill(xPula + 5, yPula, black);
              FillEllipse(xPula + 5, yPula, 10, 10);
              pulaLog[i] := false;
              xPula := getmaxx;
              yPula := getmaxy;

            end
          else if (((pixelCurPula = 21) or (pixelCurPula = 22) or (pixelCurPula = 23) or (pixelCurPula = 24)
          or (pixelCurPula = 25) or (pixelCurPula = 26) or (pixelCurPula = 27) or (pixelCurPula = 28)
          or (pixelCurPula = 29) or (pixelCurPula = 30) or (pixelCurPula = 18)) and ((dirEnemy = 1) or (dirEnemy = 3)))
          then
           begin
            //SetFillStyle(1, black);
            //Bar(xPula, yPula, xPula + shEnemy, yPula + vsEnemy);

            kLifes := kLifes + 1;
            Str(kLifes, kLifesStr);
            Count;
            writeln(kLifes);
            //ReadKey;

           end;
        end;
      3:
        begin
          yPula := yPula + hPula;
          PixelCurPula := getPixel(xPula, yPula + vsTank + 1);
          if ((pixelCurPula = 42) or (pixelCurPula = 91) or (pixelCurPula = 4)) then
            begin
              SetColor(black);
              SetFillStyle(1, black);
              //Circle(xPula + 5, yPula, 10);
              //FloodFill(xPula + 5, yPula, black);
              FillEllipse(xPula + 5, yPula, 10, 10);
              pulaLog[i] := false;
              xPula := getmaxx;
              yPula := getmaxy;

            end;
        end;
      4:
        begin
          xPula := xPula - hPula;
          PixelCurPula := getPixel(xPula, yPula - 1);
          if ((pixelCurPula = 42) or (pixelCurPula = 91) or (pixelCurPula = 4)) then
            begin
              SetColor(black);
              SetFillStyle(1, black);
             // Circle(xPula + 5, yPula, 10);
              //FloodFill(xPula + 5, yPula, black);
              FillEllipse(xPula + 5, yPula, 10, 10);
              pulaLog[i] := false;
              xPula := getmaxx;
              yPula := getmaxy;

            end;
        end;
    end;



    if ((yPula <= 50) or (yPula > getmaxy - 50) or (xPula < 250) or (xPula > getmaxx - 45)) then
      pulaLog[i] := false
    else {if (not PulaLog[i]) then  }
      PutAnim(xPula,yPula,animPula,TransPut);

    UpdateGraph(updatenow);
  //  delay(1);
end;


procedure gamePole;
  begin
    SetFillStyle(1, gray);
    Bar(0, 0, getmaxx, getmaxy);

    SetFillStyle(1, black);
    Bar(250, 50, getmaxx - 47, getmaxy - 50);

    //Первый ряд

    PutImage(xStenaVert, yStenaVert, StenaVert^, 1);
    PutImage(xStenaVert + 145, yStenaVert, StenaVert^, 1);

    PutImage(xStenaVert + 290, yStenaVert, stenaVertSmall^, 1);
    PutImage(xStenaVert + 290 + 66, yStenaVert + 120, stenaBlock^, 1);
    PutImage(xStenaVert + 290 + 66 + 71, yStenaVert + 120, stenaBlock^, 1);
    PutImage(xStenaVert + 66 + 432, yStenaVert, stenaVertSmall^, 1);

    PutImage(xStenaVert + 577 + shBlock, yStenaVert, StenaVert^, 1);
    PutImage(xStenaVert + 722 + shBlock, yStenaVert, StenaVert^, 1);

    //Второй ряд

    PutImage(xStenaVert, yStenaVert + vsStenaVert + 75, stenaVertSmall2^, 1);
    PutImage(xStenaVert + 145, yStenaVert + vsStenaVert + 75, stenaVertSmall2^, 1);

    PutImage(xStenaVert + 290, yStenaVert + vsStenaVertSmall + 80, stenaGorizSmall^, 1);
    PutImage(xStenaVert + 290 + 66, yStenaVert + vsStenaVertSmall + 180, stenaBlock^, 1);
    PutImage(xStenaVert + 290 + 66 + shBlock, yStenaVert + vsStenaVertSmall + 180, stenaBlock^, 1);
    PutImage(xStenaVert + 66 + 432, yStenaVert + vsStenaVertSmall + 80, stenaGorizSmall^, 1);

    PutImage(xStenaVert + 577 + shBlock, yStenaVert + vsStenaVert + 75, stenaVertSmall2^, 1);
    PutImage(xStenaVert + 722 + shBlock, yStenaVert + vsStenaVert + 75, stenaVertSmall2^, 1);

    //Отрисовываю базу
    PutImage(xBase - 71, yBase - 66, stenaGorizSmall^, 1);
    PutImage(xBase - 71, yBase - 66 * 2, stenaGorizSmall^, 1);
    PutImage(xBase, yBase - 66 * 2, stenaGorizSmall^, 1);
    PutImage(xBase + 71, yBase - 66 * 2, stenaGorizSmall^, 1);
    PutImage(xBase + 71, yBase - 66, stenaGorizSmall^, 1);
    PutImage(xBase, yBase - vsBase, base^, 1);

    count;


  end;

procedure game;
  begin
    initData;
    cleardevice;

    //gamePole;
    //PutImage(xEnemy, yEnemy, enemyRight^, 1);
    //PutImage(xTank, yTank, pTankForward^, 1);

    Warning;
    gamePole;
    PutImage(xEnemy, yEnemy, enemyRight^, 1);
    PutImage(xTank, yTank, pTankForward^, 1);

    repeat
        //UpdateGraph(UpdateOff);
        Enemy(xEnemy, yEnemy, hEnemy);
        if KeyPressed then begin
          ch := readkey;
          if ch = #0 then UprTank(xTank, yTank, shTank, vsTank, hTank)
          else if ch = probel then
            for i:= 1 to n do
              begin
                if (PulaLog[i] = false) then
                  begin
                    //Каждой пули прописываю собственное направление в зависимости от направления танка
                    dirPula[i] := dirTank;
                    case dirPula[i] of
                      1:
                        begin
                          xPula[i] := xTank + shTank div 2 - 4;
                          yPula[i] := yTank;


                          //yPula[i] := yPula[i] - hPula;
                        end;

                      2:
                        begin
                          yPula[i] := yTank + vsTank div 2 - 4;
                          xPula[i] := xTank + shTank;

                          //xPula[i] := xPula[i] + hPula;
                        end;

                      3:
                        begin
                          xPula[i] := xTank + shTank div 2 - 4;
                          yPula[i] := yTank + vsTank;

                          //yPula[i] := yPula[i] + hPula;
                        end;
                      4:
                        begin
                          yPula[i] := yTank + vsTank div 2 - 4;
                          xPula[i] := xTank;

                          //xPula[i] := xPula[i] - hPula;
                        end;
                    end;

                    PutAnim(xPula[i], yPula[i], animPula[i], TransPut);
                    PulaLog[i] := true;
                    break;
                  end;
              end;
          end;

          for i:= 1 to n do
              if (PulaLog[i]) then
              begin
                poletPuli(xPula[i], yPula[i], hPula, animPula[i]);
                //delay(1);
              end;
              //for i := 1 to n do
                //if (PulaLog[i]) then
                 // begin
                    //delay(1);
                    //break;
                  //end;

      //UpdateGraph(UpdateNow);
      Until ch = esc;
  end;

procedure Help;
  begin
    cleardevice;
    //SetFillStyle(1, green);
    //Bar(0, 0, getmaxx, getmaxy);
    PutImage(0, 0, menuBg^, 1);
    //PutImage(getmaxx div 2 - 246, getmaxy div 2 - 170, helpText^, 1);
    putAnim(getmaxx div 2 - 246, getmaxy div 2 - 170, helpText, TransPut);
    ReadKey;
  end;

procedure Menu;
  begin
    UpdateGraph(UpdateOff);
    cleardevice;

    PutImage(0, 0, menuBg^, 1);

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
    UpdateGraph(UpdateOn);
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
                  2: Help;
                  3: halt;
                end;
            end;
  end;


BEGIN
//clrscr;
Randomize;
SetWindowSize(1300, 800);
gd := d8bit;
//gd := nopalette;
//gd := 9;
//gm := 11;
gm := mCustom;
InitGraph(gd, gm, 'Tank');
initData;
initPict;

Repeat
        Menu;
Until 1 = 2;
CloseGraph;
//Readln();

END.
