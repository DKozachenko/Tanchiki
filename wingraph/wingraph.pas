{$mode delphi}
// "WinGraph Unit", Copyright (c) 2003-2010 by Stefan Berinde
//   Version: 1.1
//
// Source code: Free Pascal 2.4 (http://www.freepascal.org) &
//              Delphi 7
//
// Unit dependences:
//   windows  (standard)
//   messages (standard, only for Delphi)
//
unit wingraph;
{$IFNDEF WIN32}
  {$FATAL This unit must be compiled under Win32}
{$ENDIF}

interface
uses windows {$IFNDEF FPC},messages {$ENDIF};

{$DEFINE 256_COLOR_NAMES} //<- switch for defining 256 color names
{DEFINE INIT_OPENGL}     //<- switch for OpenGL driver initialization
{DEFINE HIDE_CONSOLE}    //<- switch for hiding the parent console (if any)

{ Unit version }
const
   WinGraphVer = '1.1';

{ Error codes }
const
   grOk             = smallint (  0);
   grNoInitGraph    = smallint ( -1);
   grInvalidDriver  = smallint ( -2);
   grInvalidMode    = smallint ( -3);
   grNotWindow      = smallint ( -4);
   grInvalidFont    = smallint ( -5);
   grInvalidFontNum = smallint ( -6);
   grInvalidParam   = smallint ( -7);
   grNoPalette      = smallint ( -8);
   grNoOpenGL       = smallint ( -9);
   grError          = smallint (-10);

{ Graphics drivers }
const
   Detect    = smallint (0);
   D1bit     = smallint (1);
   D4bit     = smallint (2);
   D8bit     = smallint (3);
   NoPalette = smallint (9);
   HercMono  = D1bit;
   VGA       = D4bit;
   SVGA      = D8bit;

{ Graphics modes }
const
   m320x200   = smallint ( 1);
   m640x200   = smallint ( 2);
   m640x350   = smallint ( 3);
   m640x480   = smallint ( 4);
   m720x350   = smallint ( 5);
   m800x600   = smallint ( 6);
   m1024x768  = smallint ( 7);
   m1280x1024 = smallint ( 8);
   mDefault   = smallint (10);
   mMaximized = smallint (11);
   mFullScr   = smallint (12);
   mCustom    = smallint (13);
   HercMonoHi = m720x350;
   VGALo      = m640x200;
   VGAMed     = m640x350;
   VGAHi      = m640x480;

{ Update constants }
type Update_Diap = 0 .. 2;
const
   UpdateOff = word (0);
   UpdateOn  = word (1);
   UpdateNow = word (2);

{ OpenGL Drawing modes }
const
   DirectOn  = True;
   DirectOff = False;

{ Initialization exported routines }
procedure ClearDevice;
procedure CloseGraph;
 function CloseGraphRequest : Boolean;
procedure DetectGraph (out Driver, Mode : smallint);
 function GetDriverName : ShortString;
 function GetGraphMode : smallint;
 function GetMaxMode : smallint;
 function GetModeName (Mode : smallint) : ShortString;
procedure GetModeRange (Driver : smallint; out Width, Height : smallint);
procedure GraphDefaults;
 function GraphEnabled : Boolean;
 function GraphErrorMsg (ErrorCode : smallint) : ShortString;
 function GraphResult : smallint;
procedure InitGraph (var Driver, Mode : smallint; const Title : ShortString);
 function OpenGLEnabled : Boolean;
procedure RestoreCrtMode;
procedure SetGraphMode (Mode : smallint);
procedure SetOpenGLMode (Direct : Boolean);
procedure SetWindowSize (Width, Height: Word);
// procedure UpdateGraph (Bit : Word);
procedure UpdateGraph (Bit : Update_Diap);

type
   ViewPortType =
   record
      x1, y1, x2, y2 : smallint;
      Clip : Boolean;
   end;

   AnimatType =
   record
      bitHnd, maskHnd, bkgHnd : LongWord;
   end;

{ Clipping constants }
const
   ClipOn  = True;
   ClipOff = False;

{ Raster operation constants }
const
   CopyPut      = Word ( 0);
   XorPut       = Word ( 1);
   OrPut        = Word ( 2);
   AndPut       = Word ( 3);
   NotPut       = Word ( 4);
   NotOrPut     = Word ( 5);
   InvBitOrPut  = Word ( 6);
   InvScrAndPut = Word ( 7);
   TransPut     = Word ( 8);
   MaskPut      = Word ( 9);
   BkgPut       = Word (10);
   NormalPut    = CopyPut;

{ Drawing modes on screen }
const
   CopyMode      = smallint ( 0);
   XorMode       = smallint ( 1);
   OrMode        = smallint ( 2);
   AndMode       = smallint ( 3);
   NotMode       = smallint ( 4);
   NotScrMode    = smallint ( 5);
   NotXorMode    = smallint ( 6);
   NotOrMode     = smallint ( 7);
   NotAndMode    = smallint ( 8);
   InvColAndMode = smallint ( 9);
   InvColOrMode  = smallint (10);
   InvScrAndMode = smallint (11);
   InvScrOrMode  = smallint (12);
   BlackMode     = smallint (13);
   WhiteMode     = smallint (14);
   EmptyMode     = smallint (15);
   Transparent   = smallint (00);
   Opaque        = smallint (16);

{ Screen management exported routines }
procedure ClearViewPort;
procedure FreeAnim (var Anim : AnimatType);
procedure GetAnim (x1, y1, x2, y2 : smallint; Color : LongWord; out Anim : AnimatType);
procedure GetAspectRatio (out Xasp, Yasp : Word);
procedure GetImage (x1, y1, x2, y2: smallint; out Bitmap);
 function GetMaxX : smallint;
 function GetMaxY : smallint;
procedure GetViewSettings(out ViewPort : ViewPortType);
 function GetX : smallint;
 function GetY : smallint;
 function ImageSize (x1, y1, x2, y2 : smallint) : LongInt;
procedure PutAnim (x1, y1 : smallint; var Anim : AnimatType; Bit : Word);
procedure PutImage (x1, y1 : smallint; var Bitmap; Bit : Word);
procedure SetActivePage (Page : Word);
procedure SetAspectRatio (Xasp, Yasp : Word);
procedure SetViewPort (x1, y1, x2, y2 : smallint; Clip : Boolean);
procedure SetVisualPage (Page : Word);
procedure SetWriteMode (WriteMode : smallint);

{ Alphabetical color names }
{$IFDEF 256_COLOR_NAMES}
var
   AliceBlue, AlizarinCrimson, Amber, Amethyst, AntiqueWhite, Aquamarine, Asparagus,
   Azure,
   Beige, Bisque, Bistre, BitterLemon, Black, BlanchedAlmond, BlazeOrange, Blue,
   BlueViolet, BondiBlue, Brass, BrightGreen, BrightTurquoise, BrightViolet, Bronze,
   Brown, Buff, Burgundy, BurlyWood, BurntOrange, BurntSienna, BurntUmber,
   CadetBlue, CamouflageGreen, Cardinal, Carmine, Carrot, Casper, Celadon, Cerise,
   Cerulean, CeruleanBlue, Chartreuse, Chocolate, Cinnamon, Cobalt, Copper, Coral,
   Corn, CornflowerBlue, Cornsilk, Cream, Crimson, Cyan,
   DarkBlue, DarkBrown, DarkCerulean, DarkChestnut, DarkCoral, DarkCyan, DarkGoldenrod,
   DarkGray, DarkGreen, DarkIndigo, DarkKhaki, DarkMagenta, DarkOlive, DarkOliveGreen,
   DarkOrange, DarkOrchid, DarkPastelGreen, DarkPink, DarkRed, DarkSalmon, DarkScarlet,
   DarkSeaGreen, DarkSlateBlue, DarkSlateGray, DarkSpringGreen, DarkTan, DarkTangerine,
   DarkTeaGreen, DarkTerraCotta, DarkTurquoise, DarkViolet, DeepPink, DeepSkyBlue,
   Denim, DimGray, DodgerBlue,
   Emerald, Eggplant,
   FernGreen, FireBrick, Flax, FloralWhite, ForestGreen, Fractal, Fuchsia,
   Gainsboro, Gamboge, GhostWhite, Gold, Goldenrod, Gray, GrayAsparagus, GrayTeaGreen,
   Green, GreenYellow,
   Heliotrope, Honeydew, HotPink,
   IndianRed, Indigo, InternationalKleinBlue, InternationalOrange, Ivory,
   Jade,
   Khaki,
   Lavender, LavenderBlush, LawnGreen, Lemon, LemonChiffon, LightBlue, LightBrown,
   LightCoral, LightCyan, LightGoldenrodYellow, LightGray, LightGreen, LightMagenta,
   LightPink, LightRed, LightSalmon, LightSeaGreen, LightSkyBlue, LightSlateGray,
   LightSteelBlue, LightYellow, Lilac, Lime, LimeGreen, Linen,
   Magenta, Malachite, Maroon, Mauve, MediumAquamarine, MediumBlue, MediumOrchid,
   MediumPurple, MediumSeaGreen, MediumSlateBlue, MediumSpringGreen, MediumTurquoise,
   MediumVioletRed, MidnightBlue, MintCream, MistyRose, Moccasin, MoneyGreen, Monza,
   MossGreen, MountbattenPink, Mustard, NavajoWhite,
   Navy,
   Ochre, OldGold, OldLace, Olive, OliveDrab, Orange, OrangeRed, Orchid,
   PaleBrown, PaleCarmine, PaleChestnut, PaleCornflowerBlue, PaleGoldenrod, PaleGreen,
   PaleMagenta, PaleMauve, PalePink, PaleSandyBrown, PaleTurquoise, PaleVioletRed,
   PapayaWhip, PastelGreen, PastelPink, Peach, PeachOrange, PeachPuff, PeachYellow,
   Pear, Periwinkle, PersianBlue, Peru, PineGreen, Pink, PinkOrange, Plum, PowderBlue,
   PrussianBlue, Puce, Pumpkin, Purple,
   RawUmber, Red, Reef, RobinEggBlue, RosyBrown, RoyalBlue, Russet, Rust,
   SaddleBrown, Saffron, Salmon, SandyBrown, Sangria, Sapphire, Scarlet, SchoolBusYellow,
   SeaGreen, SeaShell, SelectiveYellow, Sepia, Sienna, Silver, SkyBlue, SlateBlue,
   SlateGray, Snow, SpringGreen, SteelBlue, SwampGreen,
   Taupe, Tangerine, Teal, TeaGreen, Tenne, TerraCotta, Thistle, Tomato, Turquoise,
   Ultramarine,
   Vermilion, Violet, VioletEggplant, Viridian,
   Wheat, White, WhiteSmoke, Wisteria,
   Yellow, YellowGreen,
   Zinnwaldite : LongWord;
{$ELSE}
var
   Black, Blue, Brown, Cyan, DarkGray, Green, LightBlue, LightCyan,
   LightGray, LightGreen, LightMagenta, LightRed, Magenta, Red, White,
   Yellow : LongWord;
{$ENDIF}

type
   PaletteType =
   record
      Size : Word;
      Colors : array[0 .. 255] of LongWord;
   end;

{ Color management exported routines }
 function GetBkColor : LongWord;
 function GetColor : LongWord;
procedure GetDefaultPalette (out Palette : PaletteType);
procedure GetNamesPalette (out Palette : PaletteType);
 function GetMaxColor : LongWord;
procedure GetPalette (out Palette : PaletteType);
 function GetPaletteSize : smallint;
 function GetPixel (x, y : smallint) : LongWord;
 function GetRGBColor(r, g, b : Word): LongWord;
procedure GetRGBComponents (Color : LongWord; out r, g, b : Word);
procedure GetSystemPalette (out Palette : PaletteType);
procedure SetAllPalette (var Palette);
procedure SetBkColor (Color : LongWord);
procedure SetColor (Color : LongWord);
procedure SetPalette (nrcolor, Color : Word);
procedure SetRGBPalette (nrcolor, r, g, b : Word);

type
   PointType =
   record
      x, y : LongInt;
   end;

   LineSettingsType =
   record
      linestyle, pattern, thickness : Word;
   end;

   ArcCoordsType =
   record
      x, y, xstart, ystart, xend, yend : smallint;
   end;

{ Drawing style for lines }
const
   SolidLn      = Word (0);
   DottedLn     = Word (1);
   DashDotLn    = Word (2);
   DashedLn     = Word (3);
   DashDotDotLn = Word (4);
   UserBitLn    = Word (5);
   NullLn       = Word (6);

{ Thick constants for lines }
const
   NormWidth   = Word (1);
   DoubleWidth = Word (2);
   TripleWidth = Word (3);
   QuadWidth   = Word (4);
   ThickWidth  = TripleWidth;

{ Drawing primitives exported routines }
procedure Arc (x, y : smallint; Start, Stop, Radius : Word);
procedure Circle (x, y : smallint; Radius : Word);
procedure DrawBezier (nrpoints : Word; var PolyPoints);
procedure DrawPoly (nrpoints : Word; var PolyPoints);
procedure Ellipse (x, y : smallint; Start, Stop, Xradius, Yradius : Word);
procedure GetArcCoords (out ArcCoords : ArcCoordsType);
procedure GetLineSettings (out LineInfo : LineSettingsType);
procedure Line (x1, y1, x2, y2 : smallint);
procedure LineRel (dx, dy : smallint);
procedure LineTo (x, y : smallint);
procedure MoveRel (dx, dy : smallint);
procedure MoveTo (x, y : smallint);
procedure PutPixel (x, y : smallint; Color : LongWord);
procedure Rectangle (x1, y1, x2, y2 : smallint);
procedure RotEllipse (x, y, rot : smallint; Xradius, Yradius : Word);
procedure SetLineStyle (LineStyle, Pattern, Thickness : Word);

type
   FillSettingsType =
   record
      Pattern : Word;
      Color : LongWord;
   end;
   FillPatternType = array [1 .. 8] of Byte;

{ Filling patterns }
const
   EmptyFill   = Word (0);
   SolidFill   = Word (1);
   LineFill    = Word (2);
   ColFill     = Word (3);
   HatchFill   = Word (4);
   SlashFill   = Word (5);
   BkSlashFill = Word (6);
   XHatchFill  = Word (7);
   UserFill    = Word (8);
   NoFill      = Word (9);

{ Bar3D constants }
const
   TopOn  = True;
   TopOff = False;

{ Flood mode constants }
const
   BorderFlood  = smallint (0);
   SurfaceFlood = smallint (1);

{ Filled drawings exported routines }
procedure Bar (x1, y1, x2, y2 : smallint);
procedure Bar3D (x1, y1, x2, y2 : smallint; Depth : Word; Top : Boolean);
procedure Chord(x, y : smallint; Start, Stop, Xradius, Yradius : Word);
procedure FillEllipse (x, y : smallint; Xradius, Yradius : Word);
procedure FillPoly (nrpoints : Word; var PolyPoints);
procedure FillRect (x1, y1, x2, y2 : smallint);
procedure FloodFill (x, y : smallint; Color : LongWord);
procedure GetFillPattern (out FillPattern : FillPatternType);
procedure GetFillSettings (out FillInfo : FillSettingsType);
procedure InvertRect (x1, y1, x2, y2 : smallint);
procedure PieSlice (x, y : smallint; Start, Stop, Radius : Word);
procedure RoundRect (x1, y1, x2, y2, r : smallint);
procedure Sector (x, y : smallint; Start, Stop, Xradius, Yradius : Word);
procedure SetFillPattern (FillPattern : FillPatternType; Color: LongWord);
procedure SetFillStyle (Pattern : Word; Color : LongWord);
procedure SetFloodMode (FloodMode : smallint);

type
   TextSettingsType =
   record
      Font, Direction, CharSize, Horiz, Vert : Word;
   end;

{ Justify constants for text }
const
   LeftText     = Word (0);
   CenterText   = Word (1);
   RightText    = Word (2);
   TopText      = Word (0);
   BottomText   = Word (1);
   BaselineText = Word (2);

{ Direction constants for text }
const
   HorizDir = Word ( 0);
   VertDir  = Word (90);

{ Font constants for text }
const
   CourierNewFont    = Word (0);
   MSSansSerifFont   = Word (1);
   TimesNewRomanFont = Word (2);
   ArialFont         = Word (3);
   DefaultFont       = CourierNewFont;

const
   ItalicFont    = Word ($1000);
   UnderlineFont = Word ($0100);
   BoldFont      = Word ($0010);

{ text and font handling exported routines }
procedure GetFontSettings (out FontName : ShortString;
   out Width, Height : Word; out TTfont : Boolean);
procedure GetTextSettings (out TextInfo : TextSettingsType);
 function InstallUserFont (const FontName : ShortString) : smallint;
procedure OutText (const TextString : ShortString);
procedure OutTextXY (x, y : smallint; const TextString : ShortString);
procedure SetTextJustify (Horiz, Vert : Word);
procedure SetTextStyle (Font, Direction, CharSize : Word);
procedure SetUserCharSize (nCharExtra, nBreakExtra, Dummy1, Dummy2 : Word);
 function TextHeight (const TextString : ShortString) : Word;
 function TextWidth (const TextString : ShortString) : Word;

{ Keyboard & mouse hook variables }
type
   {$IFNDEF FPC}
   WNDPROC = function (p1 : HWND; p2 : UINT; p3 : WPARAM; p4 : LPARAM) : LRESULT; stdcall;
   {$ENDIF}
   ProcHookType = WNDPROC;

var
   KeyboardHook, MouseHook: ProcHookType;

implementation

type
   TImage =
   packed record
      bmiFileHeader : BITMAPFILEHEADER;
      bmiInfoHeader : BITMAPINFOHEADER;
      bmiBits : array[0 .. 0] of Byte;
   end;

   TFontString = string[31];

const
   NrVideoPages = 4; { Number of available video pages }
   Rad = Pi / 180.0;
   NrMaxFonts = 15;
   MinCharSize = 8;

   DefaultVGAPalette : array[0 .. 255] of LongWord =
   (
      $000000,$A80000,$00A800,$A8A800,$0000A8,$A800A8,$0054A8,$A8A8A8,
      $545454,$FC8484,$54FC54,$FCFC54,$5454FC,$FC54FC,$54FCFC,$FCFCFC,
      $000000,$141414,$202020,$2C2C2C,$383838,$444444,$505050,$606060,
      $707070,$808080,$909090,$A0A0A0,$B4B4B4,$C8C8C8,$E0E0E0,$FCFCFC,
      $FC0000,$FC0040,$FC007C,$FC00BC,$FC00FC,$BC00FC,$7C00FC,$4000FC,
      $0000FC,$0040FC,$007CFC,$00BCFC,$00FCFC,$00FCBC,$00FC7C,$00FC40,
      $00FC00,$40FC00,$7CFC00,$BCFC00,$FCFC00,$FCBC00,$FC7C00,$FC4000,
      $FC7C7C,$FC7C9C,$FC7CBC,$FC7CDC,$FC7CFC,$DC7CFC,$BC7CFC,$9C7CFC,
      $7C7CFC,$FC9CFC,$7CBCFC,$7CDCFC,$7CFCFC,$7CFCDC,$7CFCBC,$7CFC9C,
      $7CFC7C,$9CFC7C,$BCFC7C,$DCFC7C,$FCFC7C,$FCDC7C,$FCBC7C,$FC9C7C,
      $FCB4B4,$FCB4C4,$FCB4D8,$FCB4E8,$FCB4FC,$E8B4FC,$D8B4FC,$C4B4FC,
      $B4B4FC,$B4C4FC,$B4D8FC,$B4E8FC,$B4FCFC,$B4FCE8,$B4FCD8,$B4FCC4,
      $B4FCB4,$C4FCB4,$D8FCB4,$E8FCB4,$FCFCB4,$FCE8B4,$FCD8B4,$FCC4B4,
      $700000,$70001C,$700038,$700054,$700070,$540070,$380070,$1C0070,
      $000070,$001C70,$003870,$005470,$007070,$007054,$007038,$00701C,
      $007000,$1C7000,$387000,$547000,$707000,$705400,$703800,$701C00,
      $703838,$703844,$703854,$703860,$703870,$603870,$543870,$443870,
      $383870,$384470,$385470,$386070,$387070,$387060,$387054,$387044,
      $387038,$447038,$547038,$607038,$707038,$706038,$705438,$704438,
      $705050,$705058,$705060,$705068,$705070,$685070,$605070,$585070,
      $505070,$505870,$506070,$506870,$507070,$507068,$507060,$507058,
      $507050,$587050,$607050,$687050,$707050,$706850,$706050,$705850,
      $400000,$400010,$400020,$400030,$400040,$300040,$200040,$100040,
      $000040,$001040,$002040,$003040,$004040,$004030,$004020,$004010,
      $004000,$104000,$204000,$304000,$404000,$403000,$402000,$401000,
      $402020,$402028,$402030,$402038,$402040,$382040,$302040,$282040,
      $202040,$202840,$203040,$203840,$204040,$204038,$204030,$204028,
      $204020,$284020,$304020,$384020,$404020,$403820,$403020,$402820,
      $402C2C,$402C30,$402C34,$402C3C,$402C40,$3C2C40,$342C40,$302C40,
      $2C3040,$2C3440,$2C3C40,$2C4040,$2C403C,$2C4034,$2C4030,$2C402C,
      $30402C,$34402C,$3C402C,$40402C,$403C2C,$40342C,$40302C,$000000,
      $000000,$000000,$000000,$000000,$000000,$000000,$000000,$000000
   );

   {$IFDEF 256_COLOR_NAMES}
   NrColorNames = 256;
   NamesPalette : array[0 .. NrColorNames - 1] of LongWord =
   (
      $FFF8F0,$3626E3,$00BFFF,$CC6699,$D7EBFA,$D4FF7F,$5BA07B,$FFFFF0,
      $DCF5F5,$C4E4FF,$1F2B3D,$0DE0CA,$000000,$CDEBFF,$0099FF,$FF0000,
      $E22B8A,$B69500,$42A6B5,$00FF66,$DEE808,$CD00CD,$327FCD,$2A2AA5,
      $82DCF0,$200090,$87B8DE,$0055CC,$5174E9,$24338A,$A09E5F,$6B8678,
      $3A1EC4,$180096,$2191ED,$D1BEAD,$AFE1AC,$6331DE,$A77B00,$BE522A,
      $00FF7F,$1E69D2,$003F7B,$AB4700,$3373B8,$507FFF,$5DECFB,$ED9564,
      $DCF8FF,$D0FDFF,$3C14DC,$FFFF00,$8B0000,$214365,$7E4508,$606998,
      $455BCD,$8B8B00,$0B86B8,$545454,$006400,$620031,$6BB7BD,$8B008B,
      $326855,$2F6B55,$008CFF,$CC3299,$3CC003,$8054E7,$00008B,$7A96E9,
      $190356,$8FBC8F,$8B3D48,$4F4F2F,$457217,$518191,$12A8FF,$ADDBBA,
      $5C4ECC,$D1CE00,$D30094,$9314FF,$FFBF00,$BD6015,$696969,$FF901E,
      $78C850,$660099,$42794F,$2222B2,$82DCEE,$F0FAFF,$228B22,$808080,
      $A100F4,$DCDCDC,$0F9BE4,$FFF8F8,$00D7FF,$20A5DA,$7E7E7E,$455946,
      $BADACA,$008000,$2FFFAD,$FF73DF,$F0FFF0,$B469FF,$5C5CCD,$82004B,
      $A72F00,$004FFF,$F0FFFF,$6BA800,$8CE6F0,$FAE6E6,$F5F0FF,$00FC7C,
      $10E9FD,$CDFAFF,$E6D8AD,$8CB4D2,$8080F0,$FFFFE0,$D2FAFA,$A8A8A8,
      $90EE90,$FF80FF,$C1B6FF,$8080FF,$7AA0FF,$AAB220,$FACE87,$998877,
      $DEC4B0,$E0FFFF,$C8A2C8,$00FF00,$32CD32,$E6F0FA,$FF00FF,$51DA0B,
      $000080,$FFB0E0,$AACD66,$CD0000,$D355BA,$DB7093,$71B33C,$EE687B,
      $9AFA00,$CCD148,$8515C7,$701919,$FAFFF5,$E1E4FF,$B5E4FF,$C0DCC0,
      $1E03C7,$ADDFAD,$8D7A99,$58DBFF,$ADDEFF,$800000,$2277CC,$3BB5CF,
      $E6F5FD,$008080,$238E6B,$00A5FF,$0045FF,$D670DA,$547698,$3540AF,
      $AFADDD,$EFCDAB,$AAE8EE,$98FB98,$E584F9,$666699,$DDDAFA,$ABBDDA,
      $EEEEAF,$9370DB,$D5EFFF,$77DD77,$DCD1FF,$B4E5FF,$99CCFF,$B9DAFF,
      $ADDFFA,$31E2D1,$FFCCCC,$FF0066,$3F85CD,$6F7901,$CBC0FF,$6699FF,
      $DDA0DD,$E6E0B0,$533100,$9988CC,$1875FF,$800080,$124A73,$0000FF,
      $A2FFC9,$CCCC00,$8F8FBC,$E16941,$1B4680,$0E41B7,$13458B,$30C4F4,
      $7280FA,$60A4F4,$0A0092,$672508,$0024FF,$00D8FF,$578B2E,$EEF5FF,
      $00BAFF,$144270,$2D52A0,$C0C0C0,$EBCE87,$CD5A6A,$908070,$FAFAFF,
      $7FFF00,$B48246,$8EB7AC,$7E98BC,$00CCFF,$808000,$C0F0D0,$0057CD,
      $5B72E2,$D8BFD8,$4763FF,$D0E040,$8F0A12,$004DFF,$EE82EE,$991199,
      $6D8240,$B3DEF5,$FFFFFF,$F5F5F5,$DCA0C9,$00FFFF,$32CD9A,$AFC2EB
   );
   {$ELSE}
   NrColorNames = 16;
   NamesPalette : array[0 .. NrColorNames - 1] of LongWord =
   (
      $000000,$A80000,$0054A8,$A8A800,$545454,$00A800,$FC8484,$FCFC54,
      $A8A8A8,$54FC54,$FC54FC,$5454FC,$A800A8,$0000A8,$FCFCFC,$54FCFC
   );
   {$ENDIF}

var
   grEnabled, palExist : Boolean;
   screenWidth, screenHeight : LongInt;
   grDriver, grMode, grResult : smallint;
   internColor : array[0 .. NrColorNames - 1] of ^LongWord;
   customWidth, customHeight : LongInt;
   windowWidth, windowHeight : LongInt;
   windowStyle : DWORD;
   bitPixel : Byte;
   maxColors, palSize : Word;
   grHandle,consHandle : HWND;
   grTitle : ShortString;
   grThread : THandle;
   maxX, maxY, origX, origY,
   actX, actY, aspX, aspY : LongInt;
   defAspectRatio : boolean;
   grWindow, grMemory, grTemp : HDC;
   grPalette, old_Palette : HPALETTE;
   grPen, old_Pen : HPEN;
   grBrush, old_Brush : HBRUSH;
   grFont, old_Font : HFONT;
   grPattern, old_Bitmap : HBITMAP;
   grBitmap : array[0 .. NrVideoPages - 1] of HBITMAP;
   colTable : array of RGBQUAD;
   protect_devices : TRTLCriticalSection;
   grDirect, grUpdate : Boolean;
   visualPage, activePage : Word;
   instFont : array[0 .. NrMaxFonts - 1] of TFontString;
   grClip : HRGN;
   frColor, bkColor : LongWord;
   lineSettings : LineSettingsType;
   fillSettings : FillSettingsType;
   textSettings : TextSettingsType;
   fillPattern : FillPatternType;
   viewPort : ViewPortType;
   lastArcCoords : ArcCoordsType;
   viewPortWidth, viewPortHeight: smallint;
   floodMode : UINT;
   oglEnabled, oglDirect : Boolean;
   {$IFDEF INIT_OPENGL}
   oglWindow, oglMemory : HGLRC;
   {$ENDIF}
   grCloseRequest : Boolean;
   globalTemp : LongInt; { used for some tricky techniques }

{ Internal routines }

function EnumFontFamProc (var lpelf : ENUMLOGFONT; var lpntm : NEWTEXTMETRIC;
                          FontType : LongInt; param : LPARAM) : LongInt; stdcall;
begin
   { we got here if at least one font from the family font exists }
   globalTemp := 1;
   Result := 0;
end; { EnumFontFamProc }

procedure InstallDefaultFonts;
const
   NrDefFonts = 4; { the following fonts exist on any system }
   DefaultFont : array[0 .. NrDefFonts - 1] of TFontString =
   (
      'Courier New', 'MS Sans Serif', 'Times New Roman', 'Arial'
   );
var
   i : LongInt;
begin
   for i := 0 to NrMaxFonts - 1 do
   begin
      instFont[i] := '';
   end;
   for i := 0 to NrDefFonts - 1 do
   begin
      InstallUserFont (DefaultFont[i]);
      if (grResult <> grOK) then Break;
   end;
end; { InstallDefaultFonts }

procedure LineProc (x, y : LongInt; Param : LPARAM); stdcall;
begin
   param := param shr globalTemp;
   if ((Word (Param) and $0001) <> 0) then
   begin
      PutPixel (smallint (x), smallint (y), frColor);
   end;
   globalTemp := (globalTemp + 1) mod 16;
end; { LineProc }

procedure MapPaletteColors;
var i : LongInt;
// li : longint;
begin
// li := 0;
   for i := 0 to NrColorNames - 1 do
   begin
      internColor[i]^ := GetNearestPaletteIndex (grPalette, NamesPalette[i]);
      // inc(li);
   end;
end; { MapPaletteColors }

function MapColor (Color : LongWord) : LongWord;
begin
   if palExist then
      Result := PALETTEINDEX(color mod palSize)
   else
      Result := Color;
end; { MapColor }

{$IFDEF INIT_OPENGL}
procedure InitOpenGL;
var
   pfd : PIXELFORMATDESCRIPTOR;
   cpf : LongInt;
   cw : Word;
begin
   FillChar (pfd, SizeOf (pfd), 0);
   pfd.nSize := SizeOf (pfd);
   pfd.nVersion :=1;
   pfd.iPixelType := PFD_TYPE_RGBA;
   pfd.cDepthBits := 32;
   pfd.cColorBits := 24;
   pfd.iLayerType := PFD_MAIN_PLANE;
   pfd.dwFlags := PFD_SUPPORT_OPENGL or PFD_DRAW_TO_WINDOW or PFD_DOUBLEBUFFER;
   cw := Get8087CW;
   cpf := ChoosePixelFormat (grWindow, @pfd);
   SetPixelFormat (grWindow, cpf, @pfd);
   oglWindow := wglCreateContext (grWindow);
   pfd.cColorBits := bitPixel;
   pfd.dwFlags := PFD_SUPPORT_OPENGL or PFD_SUPPORT_GDI or PFD_DRAW_TO_BITMAP;
   cpf := ChoosePixelFormat (grMemory, @pfd);
   SetPixelFormat (grMemory, cpf, @pfd);
   oglMemory := wglCreateContext (grMemory);

   { FPU 8087 control word is restored (it was changed by wglCreateContext) }
   Set8087CW (cw);
   if (oglMemory <> 0) and (oglWindow <> 0) then
   begin
      oglEnabled := True;
      SetOpenGLMode(DirectOff);
   end
   else
   begin
      oglEnabled := False;
      oglDirect := DirectOff;
      grResult := grNoOpenGL;
   end;
end; { InitOpenGL }
{$ENDIF}

function ProcessMessages : smallint;
var
   mess : MSG;
begin
   while (LongInt (GetMessage (mess, 0, 0, 0)) = 1) do
   begin
      TranslateMessage (mess);
      DispatchMessage(mess);
   end;
   Result := mess.wParam;
end; { ProcessMessages }

procedure SetAbsoluteColors;
var i : LongInt;
begin
   for i := 0 to NrColorNames - 1 do
   begin
      internColor[i]^ := NamesPalette[i];
   end;
end; { SetAbsoluteColors }

procedure SetInternColors;
begin
   {$IFDEF 256_COLOR_NAMES}
   internColor[000] := @AliceBlue;
   internColor[001] := @AlizarinCrimson;
   internColor[002] := @Amber;
   internColor[003] := @Amethyst;
   internColor[004] := @AntiqueWhite;
   internColor[005] := @Aquamarine;
   internColor[006] := @Asparagus;
   internColor[007] := @Azure;
   internColor[008] := @Beige;
   internColor[009] := @Bisque;
   internColor[010] := @Bistre;
   internColor[011] := @BitterLemon;
   internColor[012] := @Black;
   internColor[013] := @BlanchedAlmond;
   internColor[014] := @BlazeOrange;
   internColor[015] := @Blue;
   internColor[016] := @BlueViolet;
   internColor[017] := @BondiBlue;
   internColor[018] := @Brass;
   internColor[019] := @BrightGreen;
   internColor[020] := @BrightTurquoise;
   internColor[021] := @BrightViolet;
   internColor[022] := @Bronze;
   internColor[023] := @Brown;
   internColor[024] := @Buff;
   internColor[025] := @Burgundy;
   internColor[026] := @BurlyWood;
   internColor[027] := @BurntOrange;
   internColor[028] := @BurntSienna;
   internColor[029] := @BurntUmber;
   internColor[030] := @CadetBlue;
   internColor[031] := @CamouflageGreen;
   internColor[032] := @Cardinal;
   internColor[033] := @Carmine;
   internColor[034] := @Carrot;
   internColor[035] := @Casper;
   internColor[036] := @Celadon;
   internColor[037] := @Cerise;
   internColor[038] := @Cerulean;
   internColor[039] := @CeruleanBlue;
   internColor[040] := @Chartreuse;
   internColor[041] := @Chocolate;
   internColor[042] := @Cinnamon;
   internColor[043] := @Cobalt;
   internColor[044] := @Copper;
   internColor[045] := @Coral;
   internColor[046] := @Corn;
   internColor[047] := @CornflowerBlue;
   internColor[048] := @Cornsilk;
   internColor[049] := @Cream;
   internColor[050] := @Crimson;
   internColor[051] := @Cyan;
   internColor[052] := @DarkBlue;
   internColor[053] := @DarkBrown;
   internColor[054] := @DarkCerulean;
   internColor[055] := @DarkChestnut;
   internColor[056] := @DarkCoral;
   internColor[057] := @DarkCyan;
   internColor[058] := @DarkGoldenrod;
   internColor[059] := @DarkGray;
   internColor[060] := @DarkGreen;
   internColor[061] := @DarkIndigo;
   internColor[062] := @DarkKhaki;
   internColor[063] := @DarkMagenta;
   internColor[064] := @DarkOlive;
   internColor[065] := @DarkOliveGreen;
   internColor[066] := @DarkOrange;
   internColor[067] := @DarkOrchid;
   internColor[068] := @DarkPastelGreen;
   internColor[069] := @DarkPink;
   internColor[070] := @DarkRed;
   internColor[071] := @DarkSalmon;
   internColor[072] := @DarkScarlet;
   internColor[073] := @DarkSeaGreen;
   internColor[074] := @DarkSlateBlue;
   internColor[075] := @DarkSlateGray;
   internColor[076] := @DarkSpringGreen;
   internColor[077] := @DarkTan;
   internColor[078] := @DarkTangerine;
   internColor[079] := @DarkTeaGreen;
   internColor[080] := @DarkTerraCotta;
   internColor[081] := @DarkTurquoise;
   internColor[082] := @DarkViolet;
   internColor[083] := @DeepPink;
   internColor[084] := @DeepSkyBlue;
   internColor[085] := @Denim;
   internColor[086] := @DimGray;
   internColor[087] := @DodgerBlue;
   internColor[088] := @Emerald;
   internColor[089] := @Eggplant;
   internColor[090] := @FernGreen;
   internColor[091] := @FireBrick;
   internColor[092] := @Flax;
   internColor[093] := @FloralWhite;
   internColor[094] := @ForestGreen;
   internColor[095] := @Fractal;
   internColor[096] := @Fuchsia;
   internColor[097] := @Gainsboro;
   internColor[098] := @Gamboge;
   internColor[099] := @GhostWhite;
   internColor[100] := @Gold;
   internColor[101] := @Goldenrod;
   internColor[102] := @Gray;
   internColor[103] := @GrayAsparagus;
   internColor[104] := @GrayTeaGreen;
   internColor[105] := @Green;
   internColor[106] := @GreenYellow;
   internColor[107] := @Heliotrope;
   internColor[108] := @Honeydew;
   internColor[109] := @HotPink;
   internColor[110] := @IndianRed;
   internColor[111] := @Indigo;
   internColor[112] := @InternationalKleinBlue;
   internColor[113] := @InternationalOrange;
   internColor[114] := @Ivory;
   internColor[115] := @Jade;
   internColor[116] := @Khaki;
   internColor[117] := @Lavender;
   internColor[118] := @LavenderBlush;
   internColor[119] := @LawnGreen;
   internColor[120] := @Lemon;
   internColor[121] := @LemonChiffon;
   internColor[122] := @LightBlue;
   internColor[123] := @LightBrown;
   internColor[124] := @LightCoral;
   internColor[125] := @LightCyan;
   internColor[126] := @LightGoldenrodYellow;
   internColor[127] := @LightGray;
   internColor[128] := @LightGreen;
   internColor[129] := @LightMagenta;
   internColor[130] := @LightPink;
   internColor[131] := @LightRed;
   internColor[132] := @LightSalmon;
   internColor[133] := @LightSeaGreen;
   internColor[134] := @LightSkyBlue;
   internColor[135] := @LightSlateGray;
   internColor[136] := @LightSteelBlue;
   internColor[137] := @LightYellow;
   internColor[138] := @Lilac;
   internColor[139] := @Lime;
   internColor[140] := @LimeGreen;
   internColor[141] := @Linen;
   internColor[142] := @Magenta;
   internColor[143] := @Malachite;
   internColor[144] := @Maroon;
   internColor[145] := @Mauve;
   internColor[146] := @MediumAquamarine;
   internColor[147] := @MediumBlue;
   internColor[148] := @MediumOrchid;
   internColor[149] := @MediumPurple;
   internColor[150] := @MediumSeaGreen;
   internColor[151] := @MediumSlateBlue;
   internColor[152] := @MediumSpringGreen;
   internColor[153] := @MediumTurquoise;
   internColor[154] := @MediumVioletRed;
   internColor[155] := @MidnightBlue;
   internColor[156] := @MintCream;
   internColor[157] := @MistyRose;
   internColor[158] := @Moccasin;
   internColor[159] := @MoneyGreen;
   internColor[160] := @Monza;
   internColor[161] := @MossGreen;
   internColor[162] := @MountbattenPink;
   internColor[163] := @Mustard;
   internColor[164] := @NavajoWhite;
   internColor[165] := @Navy;
   internColor[166] := @Ochre;
   internColor[167] := @OldGold;
   internColor[168] := @OldLace;
   internColor[169] := @Olive;
   internColor[170] := @OliveDrab;
   internColor[171] := @Orange;
   internColor[172] := @OrangeRed;
   internColor[173] := @Orchid;
   internColor[174] := @PaleBrown;
   internColor[175] := @PaleCarmine;
   internColor[176] := @PaleChestnut;
   internColor[177] := @PaleCornflowerBlue;
   internColor[178] := @PaleGoldenrod;
   internColor[179] := @PaleGreen;
   internColor[180] := @PaleMagenta;
   internColor[181] := @PaleMauve;
   internColor[182] := @PalePink;
   internColor[183] := @PaleSandyBrown;
   internColor[184] := @PaleTurquoise;
   internColor[185] := @PaleVioletRed;
   internColor[186] := @PapayaWhip;
   internColor[187] := @PastelGreen;
   internColor[188] := @PastelPink;
   internColor[189] := @Peach;
   internColor[190] := @PeachOrange;
   internColor[191] := @PeachPuff;
   internColor[192] := @PeachYellow;
   internColor[193] := @Pear;
   internColor[194] := @Periwinkle;
   internColor[195] := @PersianBlue;
   internColor[196] := @Peru;
   internColor[197] := @PineGreen;
   internColor[198] := @Pink;
   internColor[199] := @PinkOrange;
   internColor[200] := @Plum;
   internColor[201] := @PowderBlue;
   internColor[202] := @PrussianBlue;
   internColor[203] := @Puce;
   internColor[204] := @Pumpkin;
   internColor[205] := @Purple;
   internColor[206] := @RawUmber;
   internColor[207] := @Red;
   internColor[208] := @Reef;
   internColor[209] := @RobinEggBlue;
   internColor[210] := @RosyBrown;
   internColor[211] := @RoyalBlue;
   internColor[212] := @Russet;
   internColor[213] := @Rust;
   internColor[214] := @SaddleBrown;
   internColor[215] := @Saffron;
   internColor[216] := @Salmon;
   internColor[217] := @SandyBrown;
   internColor[218] := @Sangria;
   internColor[219] := @Sapphire;
   internColor[220] := @Scarlet;
   internColor[221] := @SchoolBusYellow;
   internColor[222] := @SeaGreen;
   internColor[223] := @SeaShell;
   internColor[224] := @SelectiveYellow;
   internColor[225] := @Sepia;
   internColor[226] := @Sienna;
   internColor[227] := @Silver;
   internColor[228] := @SkyBlue;
   internColor[229] := @SlateBlue;
   internColor[230] := @SlateGray;
   internColor[231] := @Snow;
   internColor[232] := @SpringGreen;
   internColor[233] := @SteelBlue;
   internColor[234] := @SwampGreen;
   internColor[235] := @Taupe;
   internColor[236] := @Tangerine;
   internColor[237] := @Teal;
   internColor[238] := @TeaGreen;
   internColor[239] := @Tenne;
   internColor[240] := @TerraCotta;
   internColor[241] := @Thistle;
   internColor[242] := @Tomato;
   internColor[243] := @Turquoise;
   internColor[244] := @Ultramarine;
   internColor[245] := @Vermilion;
   internColor[246] := @Violet;
   internColor[247] := @VioletEggplant;
   internColor[248] := @Viridian;
   internColor[249] := @Wheat;
   internColor[250] := @White;
   internColor[251] := @WhiteSmoke;
   internColor[252] := @Wisteria;
   internColor[253] := @Yellow;
   internColor[254] := @YellowGreen;
   internColor[255] := @Zinnwaldite;
   {$ELSE}
   internColor[00] := @Black;
   internColor[01] := @Blue;
   internColor[02] := @Brown;
   internColor[03] := @Cyan;
   internColor[04] := @DarkGray;
   internColor[05] := @Green;
   internColor[06] := @LightBlue;
   internColor[07] := @LightCyan;
   internColor[08] := @LightGray;
   internColor[09] := @LightGreen;
   internColor[10] := @LightMagenta;
   internColor[11] := @LightRed;
   internColor[12] := @Magenta;
   internColor[13] := @Red;
   internColor[14] := @White;
   internColor[15] := @Yellow;
   {$ENDIF}
end; { SetInternColors }

procedure SetBitmaps_WinGraph;
var
   pbmi : PBITMAPINFO;
   pbits : Pointer;
   i, nr : LongInt;
begin
   if palExist then
      nr := maxColors
   else
      nr := 0;

   GetMem (pbmi, SizeOf (BITMAPINFOHEADER) + nr * SizeOf (RGBQUAD));
   with pbmi^.bmiHeader do
   begin
      biSize := SizeOf(BITMAPINFOHEADER);
      biWidth := maxX + 1;
      biHeight := maxY + 1;
      biPlanes := 1;
      biBitCount := bitPixel;
      biClrUsed := 0;
      biCompression := BI_RGB;
      biSizeImage := 0;
      biClrImportant := 0;
   end;

   for i := 0 to NrVideoPages - 1 do
   begin
      grBitmap[i] := CreateDIBSection (grWindow, pbmi^, DIB_RGB_COLORS, pbits, 0, 0);
   end;
   FreeMem (pbmi);
   SetLength (colTable, nr);
   if (nr > 0) then
   begin
      FillChar (colTable[0], nr * SizeOf (RGBQUAD), 0);
   end;
end; { SetBitmaps_WinGraph }

procedure SetPalette_WinGraph;
var plgpl : PLOGPALETTE;
begin
   GetMem (plgpl, SizeOf (TLOGPALETTE) + (maxColors - 1) * SizeOf (PALETTEENTRY));
   with plgpl^ do
   begin
      palVersion := $300;
      palNumEntries := maxColors;
      FillChar (palPalEntry, palNumEntries shl 2, 0);
   end;
   grPalette := CreatePalette (plgpl^);
   FreeMem (plgpl, SizeOf (TLOGPALETTE) + (maxColors - 1) * SizeOf (PALETTEENTRY));
end; { SetPalette_WinGraph }

procedure SetAttrib_WinGraph;
var
   dx_bor, dy_bor, dx, dy : LongInt;
begin
   dx_bor := 2 * GetSystemMetrics (SM_CXFIXEDFRAME);
   dy_bor := 2 * GetSystemMetrics (SM_CYFIXEDFRAME) + GetSystemMetrics (SM_CYCAPTION);
   case grMode of
      m320x200 :
      begin
         dx := 320; dy := 200;
      end;
      m640x200 :
      begin
         dx := 640; dy := 200;
      end;
      m640x350 :
      begin
         dx := 640; dy := 350;
      end;
      m640x480 :
      begin
         dx := 640; dy := 480;
      end;
      m720x350 :
      begin
         dx := 720; dy := 350;
      end;
      m800x600 :
      begin
         dx := 800; dy := 600;
      end;
      m1024x768 :
      begin
         dx := 1024; dy := 768;
      end;
      m1280x1024 :
      begin
         dx := 1280; dy := 1024;
      end;
      mDefault :
      begin
         dx := -dx_bor; dy := -dy_bor;
      end;
      mMaximized :
      begin
         dx := screenWidth - dx_bor; dy := screenHeight - dy_bor;
      end;
      mFullScr :
      begin
         dx := screenWidth; dy := screenHeight;
      end;
      mCustom :
      begin
         dx := customWidth; dy := customHeight;
      end;
      else
      begin
         dx := 65535; dy := 65535;
      end;
   end; { case }

   windowWidth := dx + dx_bor; windowHeight := dy + dy_bor;
   if (windowWidth <= screenWidth) and (windowHeight <= screenHeight) then
      windowStyle := WS_OVERLAPPED or WS_SYSMENU or WS_CAPTION or WS_MINIMIZEBOX
   else
      if (dx <= screenWidth) and (dy <= screenHeight) then
      begin
         windowWidth := dx; windowHeight := dy;
         windowStyle := DWORD (WS_POPUP);
      end
      else
      begin
         grResult := grInvalidMode;
         exit;
      end;

   case grDriver of
      D1bit :
         bitPixel := 1;
      D4bit :
         bitPixel := 4;
      D8bit :
         bitPixel := 8;
      NoPalette :
         bitPixel := Byte (GetDeviceCaps (GetDC (GetDesktopWindow), BITSPIXEL));
      else
      begin
         grResult := grInvalidDriver;
         exit;
      end;
   end;

   if (grDriver = NoPalette) then
      palExist := False
   else
   begin
      palExist := True;
      maxColors := 1 shl bitPixel;
   end;
end; { SetAttrib_WinGraph }

function WinGraphProc (grHandle : HWND; mess : UINT; wParam : WPARAM;
                       lParam : LPARAM) : LRESULT; stdcall;
var
   grRect : TRect;
   strPaint : PAINTSTRUCT;
   old_hbmp : HBITMAP;
   i : LongInt;
begin
   Result := 0;
   case mess of
      WM_CREATE:
      begin
         GetClientRect (grHandle, grRect);
         maxX := grRect.right - 1; maxY := grRect.bottom - 1;
         grWindow := GetDC (grHandle);
         grMemory := CreateCompatibleDC (0);
         grTemp := CreateCompatibleDC (0);
         old_Palette := GetCurrentObject (grWindow, OBJ_PAL);
         old_Pen := GetCurrentObject (grWindow, OBJ_PEN);
         old_Brush := GetCurrentObject (grWindow, OBJ_BRUSH);
         old_Font := GetCurrentObject (grWindow, OBJ_FONT);
         old_Bitmap := GetCurrentObject (grMemory, OBJ_BITMAP);
         if palExist then
         begin
            SetPalette_WinGraph;
            SelectPalette (grWindow, grPalette, True);
            SelectPalette (grMemory, grPalette, True);
            SelectPalette (grTemp, grPalette, True);
         end;

         SetBitmaps_WinGraph;
         InitializeCriticalSection (protect_devices);
         if Assigned(MouseHook) then
         begin
            MouseHook (grHandle, mess, wParam, lParam);
         end;
         if Assigned (KeyboardHook) then
         begin
            KeyboardHook (grHandle, mess, wParam, lParam);
         end;
         grEnabled := True;
      end; { WM_CREATE }

      WM_ERASEBKGND:
      begin
         if grEnabled then
         begin { trick to reduce flickering }
            Result := 1;
            exit;
         end;
      end; { WM_ERASEBKGND }

      WM_PAINT :
      begin
         if GetUpdateRect (grHandle, grRect, False) then
         begin
            with grRect do
            begin
               EnterCriticalSection (protect_devices);
               if (grClip <> 0) then
               begin
                  SelectClipRgn (grWindow, 0);
               end;

               BeginPaint (grHandle, strPaint);
               if (activePage = visualPage) then
               begin
                  BitBlt (grWindow, left, top, right - left + 1, bottom - top + 1,
                          grMemory, left, top, SRCCOPY)
               end
               else
               begin
                  old_hbmp := SelectObject (grMemory, grBitmap[visualPage]);
                  BitBlt (grWindow, left, top, right - left + 1, bottom - top + 1,
                          grMemory, left, top, SRCCOPY);
                  SelectObject (grMemory, old_hbmp);
               end;
               EndPaint (grHandle, strPaint);

               if (grClip <> 0) then
               begin
                  SelectClipRgn(grWindow,grClip);
               end;
               LeaveCriticalSection(protect_devices);
            end; { with }
            exit;
         end; { if }
      end; { WM_PAINT }

      WM_CHAR,
      WM_KEYDOWN,
      WM_SYSKEYDOWN :
      begin
         if Assigned (KeyboardHook) then
         begin
            Result := KeyboardHook (grHandle, mess, wParam, lParam);
            exit;
         end;
      end;

      WM_SYSCHAR :
         exit; { this message is inserted to avoid keyboard beep }

      WM_MOUSEWHEEL,
      WM_MOUSEMOVE,
      WM_LBUTTONDOWN,
      WM_RBUTTONDOWN,
      WM_MBUTTONDOWN,
      WM_LBUTTONUP,
      WM_RBUTTONUP,
      WM_MBUTTONUP :
      begin
         if Assigned (MouseHook) then
         begin
            Result := MouseHook (grHandle, mess, wParam, lParam);
         end;
         exit;
      end;

      WM_CLOSE :
      begin
         grCloseRequest := True;
         if Assigned (KeyboardHook) then
         begin
            Result := KeyboardHook (grHandle, mess, wParam, lParam);
         end;
         exit;
      end; { WM_CLOSE }

      WM_DESTROY :
      begin
         if Assigned (MouseHook) then
         begin
            MouseHook (grHandle, mess, wParam, lParam);
         end;
         if Assigned (KeyboardHook) then
         begin
            KeyboardHook (grHandle, mess, wParam, lParam);
         end;
         DeleteCriticalSection (protect_devices);
         DeleteObject (grPattern);
         SelectObject (grMemory, old_Bitmap);
         for i := 0 to NrVideoPages - 1 do
         begin
            DeleteObject (grBitmap[i]);
         end;
         SetLength (colTable, 0);
         if palExist then
         begin
            SelectPalette (grWindow, old_Palette, True);
            SelectPalette (grMemory, old_Palette, True);
            SelectPalette (grTemp, old_Palette, True);
            DeleteObject (grPalette);
            palExist := False;
         end;
         SelectObject (grWindow, old_Font);
         SelectObject (grMemory, old_Font);
         DeleteObject (grFont);
         SelectObject (grWindow, old_Brush);
         SelectObject (grMemory, old_Brush);
         DeleteObject (grBrush);
         SelectObject (grWindow, old_Pen);
         SelectObject (grMemory, old_Pen);
         DeleteObject (grPen);
         SetViewPort (0, 0, maxX, maxY, ClipOff);
         DeleteDC (grMemory);
         DeleteDC (grTemp);
         PostQuitMessage (grOK);
         exit;
      end; { WM_DESTROY }

      WM_USER :
      begin
         DestroyWindow (grHandle);
         exit;
      end;
   end; { case }
   Result := DefWindowProc (grHandle, mess, wParam, lParam);
end; { WinGraphProc }

function Create_WinGraph (Param : Pointer) : DWORD; stdcall;
type
   TstrWindow =
   record
      lpClassName : LPCTSTR;
      lpWindowName: LPCTSTR;
      dwStyle : DWORD;
      x : LongInt;
      y : LongInt;
      nWidth : LongInt;
      nHeight : LongInt;
      hWndParent : HWND;
      hMenu : HMENU;
      hInstance : THandle;
      lpParam : Pointer;
   end;

const
   className = 'WinGraphClass';

var
   lpWndClass : WNDCLASS;
   strWindow : TstrWindow;
begin
   Result := 0;
   with lpWndClass do
   begin
      style := CS_OWNDC or CS_BYTEALIGNCLIENT;
      lpfnWndProc := @WinGraphProc;
      cbClsExtra := 0;
      cbWndExtra := 0;
      hInstance := system.MainInstance;
      hIcon := LoadIcon (hInstance, 'GrIcon');
      hCursor := LoadCursor (0, IDC_ARROW);
      hbrBackground := COLOR_MENU + 1;
      lpszMenuName := nil;
      lpszClassName := className;
   end;
   if (RegisterClass (lpWndClass) = 0) then
   begin
      grResult := grNotWindow;
      exit;
   end;

   with strWindow do
   begin
      lpClassName := className;
      lpWindowName := PChar (AnsiString (Param));
      dwStyle := windowStyle;
      if (windowWidth <> 0) then
      begin
         x := (screenWidth - windowWidth) div 2;
         y := (screenHeight - windowHeight) div 2;
         nWidth := windowWidth;
         nHeight := windowHeight;
      end
      else
      begin
         x := LongInt (CW_USEDEFAULT);
         y := LongInt (CW_USEDEFAULT);
         nWidth := LongInt (CW_USEDEFAULT);
         nHeight := LongInt (CW_USEDEFAULT);
      end;
      hWndParent := 0;
      hMenu := 0;
      hInstance := system.MainInstance;
      lpParam := nil;
      grHandle := CreateWindow (lpClassName, lpWindowName, dwStyle,
                                x, y, nWidth, nHeight, hWndParent,
                                hMenu, hInstance, lpParam);
   end; { with }

   if (grHandle = 0) then
   begin
      grResult := grNotWindow;
      exit;
   end;
   grResult := ProcessMessages;
   UnregisterClass (className, system.MainInstance);
end; { Create_WinGraph }

{initialization routines}

procedure ClearDevice;
var old_ViewPort : ViewPortType;
begin
   old_ViewPort := viewPort;
   SetViewPort (0, 0, maxX, maxY, ClipOff);
   ClearViewPort;
   with old_ViewPort do
   begin
      SetViewPort (x1, y1, x2, y2, clip);
   end;
end; { ClearDevice }

procedure CloseGraph;
var exitcode: DWORD;
begin
   grResult := grOK;
   if not(grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   grEnabled := False;

   {$IFDEF INIT_OPENGL}
   wglMakeCurrent (0, 0);
   wglDeleteContext (oglWindow);
   wglDeleteContext (oglMemory);
   {$ENDIF}

   PostMessage (grHandle, WM_USER, 0, 0); { trick for main thread to close the window }
   repeat
      Sleep (10);
      GetExitCodeThread (grThread, exitcode);
   until (exitcode <> STILL_ACTIVE); { wait for thread to destroy the window }
   CloseHandle (grThread);
   if (consHandle <> 0) then
   begin
      ShowWindow (consHandle, SW_SHOW);
      SetForegroundWindow (consHandle);
   end;
end; { CloseGraph }

function CloseGraphRequest : Boolean;
begin
   Result := grCloseRequest;
end; { CloseGraphRequest }

procedure DetectGraph (out Driver, Mode : smallint);
begin
   Driver := NoPalette; Mode := mDefault;
end; { DetectGraph }

function GetDriverName : ShortString;
begin
   case grDriver of
      D1bit :
         Result:='D1bit - 2 colors';
      D4bit :
         Result:='D4bit - 16 colors';
      D8bit :
         Result:='D8bit - 256 colors';
      NoPalette :
         Result := 'NoPalette - all colors';
      else
         Result := 'no graphics driver';
   end;
end; { GetDriverName }

function GetGraphMode : smallint;
begin
   if (grDriver >= 0) then
      Result := grMode
   else
      Result := -1;
end; { GetGraphMode }

function GetMaxMode : smallint;
begin
   Result := mFullScr;
end; { GetMaxMode }

function GetModeName (Mode : smallint) : ShortString;
begin
   case Mode of
      m320x200 :
         Result:='320 x 200';
      m640x200 :
         Result:='640 x 200';
      m640x350 :
         Result:='640 x 350';
      m640x480 :
         Result:='640 x 480';
      m720x350 :
         Result:='720 x 350';
      m800x600 :
         Result:='800 x 600';
      m1024x768 :
         Result:='1024 x 768';
      m1280x1024:
         Result:='1280 x 1024';
      mDefault :
         Result:='Windows default';
      mMaximized:
         Result:='Maximized';
      mFullScr :
         Result:='Full screen';
      mCustom :
         Result:='Custom';
      else
      begin
         Result:='invalid graphics mode';
         exit;
      end
   end;
   Result := Result + ' (VESA)';
end; { GetModeName }

procedure GetModeRange (Driver : smallint; out Width, Height : smallint);
begin
   Width := smallint (screenWidth); Height := smallint (screenHeight);
end; { GetModeRange }

procedure GraphDefaults;
var
   Palette : PaletteType;
   Pattern : FillPatternType;
begin
   if palExist then
   begin
      GetDefaultPalette (Palette);
      SetAllPalette (Palette);
   end
   else
      SetAbsoluteColors;

   with lineSettings do
   begin
      linestyle := SolidLn;
      pattern := 0;
      thickness := NormWidth;
   end;

   SetColor (White);
   SetBkColor (Black);
   FillChar (Pattern, 8, $FF);
   SetFillPattern (Pattern, White);
   SetFillStyle (SolidFill, White);
   SetTextStyle (DefaultFont, HorizDir, 16);
   SetTextJustify (LeftText, TopText);
   SetUserCharSize (0, 0, 0, 0);
   SetViewPort (0, 0, maxX, maxY, ClipOff);
   SetWriteMode (CopyMode or Transparent);
   SetAspectRatio (10000, 10000);
   floodMode := BorderFlood;
end; { GraphDefaults }

function GraphEnabled : Boolean;
begin
   Result := grEnabled;
end; { GraphEnabled }

function GraphErrorMsg (ErrorCode : smallint) : ShortString;
begin
   case ErrorCode of
      grOk :
      begin
         Result := '';
         exit;
      end;
      grInvalidDriver :
         Result := 'Invalid graphics driver';
      grInvalidMode :
         Result := 'Invalid graphics mode';
      grNotWindow :
         Result := 'Creation of graphics window failed';
      grNoInitGraph :
         Result := 'Graphics window not initialized. Use InitGraph';
      grInvalidFont :
         Result:='Invalid font selection';
      grInvalidFontNum :
         Result := 'Invalid font number';
      grInvalidParam :
         Result := 'Invalid parameter value';
      grNoPalette :
         Result := 'No palette available. Change graphics driver';
      grNoOpenGL :
         Result := 'OpenGL driver not initialized';
      grError :
         Result := 'General graphics error';
      else
         Result := 'Unrecognized error code';
   end;
   Result := 'Error: ' + Result;
end; { GraphErrorMsg }

function GraphResult : smallint;
begin
   Result := grResult; grResult := grOk;
end; { GraphResult }

procedure InitGraph (var Driver, Mode : smallint;
                     const Title : ShortString); { <- main entry point }
var
   consTitle: ShortString;
   idThread : DWORD;
begin
   grResult := grOK;
   if grEnabled then
   begin
      grResult := grError;
      exit;
   end;

   if (Driver = Detect) then
   begin
      DetectGraph (grDriver, grMode);
      Driver := grDriver; Mode := grMode;
   end
   else
   begin
      grDriver := Driver; grMode := Mode;
   end;

   SetAttrib_WinGraph;
   if (grResult <> grOK) then
   begin
      exit;
   end;
   consHandle := 0;

   {$IFDEF HIDE_CONSOLE}
   if (GetConsoleTitle (@consTitle[1], 255) <> 0) then
   begin
      { on NT-based systems GetConsoleWindow can be invoked }
      consHandle := FindWindow (nil, @consTitle[1]);
   end;
   {$ENDIF}

   if (Title <> '') then
      grTitle := Title
   else
      grTitle := 'WinGraph ' + WinGraphVer;

   grThread := CreateThread (nil, 0, @Create_WinGraph, @grTitle[1], 0, idThread);

   { window gets more responsive }
   SetThreadPriority (grThread, THREAD_PRIORITY_ABOVE_NORMAL);
   repeat
      Sleep (10);
   until grEnabled or (grResult <> grOK); { wait for thread to create the window }

   if (grResult = grOK) then
   begin
      visualPage := 0;
      grUpdate := True;
      SetActivePage (0);
      InstallDefaultFonts;
      if (grResult <> grOK) then
      begin
         exit;
      end;
      grClip := 0;
      grPattern := 0;
      GraphDefaults;

      {$IFDEF INIT_OPENGL}
      InitOpenGL;
      {$ELSE}
      oglEnabled := False; oglDirect := DirectOff;
      {$ENDIF}
      if (consHandle <> 0) then
      begin
         ShowWindow (consHandle, SW_HIDE);
      end;
      ShowWindow (grHandle, CMDSHOW);
      ShowWindow (grHandle, SW_SHOWNORMAL);
      SetForegroundWindow (grHandle);
      grCloseRequest := False;
   end;
end; { InitGraph }

function OpenGLEnabled : Boolean;
begin
   Result := oglEnabled;
end; { OpenGLEnabled }

procedure RestoreCrtMode;
begin
   CloseGraph;
end; { RestoreCrtMode }

procedure SetGraphMode (Mode : smallint);
begin
   if (grDriver >= 0) then
      InitGraph (grDriver, Mode, grTitle)
   else
      grResult := grError;
end; { SetGraphMode }

procedure SetOpenGLMode (Direct : Boolean);
var
   old_ViewPort : ViewPortType;
begin
   if not (oglEnabled) then
   begin
      grResult := grNoOpenGL;
      exit;
   end;

   {$IFDEF INIT_OPENGL}
   oglDirect := Direct;
   EnterCriticalSection (protect_devices);
   old_ViewPort := viewPort;
   SetViewPort (0, 0, maxX, maxY, ClipOff); { otherwise OpenGL setting fails }
   if direct then
      wglMakeCurrent (grWindow, oglWindow)
   else
      wglMakeCurrent (grMemory, oglMemory);

   with old_ViewPort do
   begin
      SetViewPort (x1, y1, x2, y2, clip);
   end;
   LeaveCriticalSection (protect_devices);
   {$ENDIF}
end; { SetOpenGLMode }

procedure SetWindowSize (Width, Height : Word);
begin
   customWidth := Width;
   customHeight := Height;
end; { SetWindowSize }

// procedure UpdateGraph (Bit : Word);
procedure UpdateGraph (Bit : Update_Diap);
begin
   case Bit of
      UpdateOff :
         if grUpdate then
         begin
            grUpdate := False;
            grDirect := False;
         end;
      UpdateOn :
         if not(grUpdate) then
         begin
            grUpdate := True;
            SetVisualPage (visualPage);
         end;
      UpdateNow :
         if oglDirect then
            SwapBuffers (grWindow)
         else
            SetVisualPage (visualPage);
   end; { case }
end; { UpdateGraph }

{ Screen management routines }

procedure ClearViewPort;
var old_FillSettings : FillSettingsType;
begin
   MoveTo (0, 0);
   if (grResult <> grOK) then
      exit;

   old_FillSettings := fillSettings;
   SetFillStyle (SolidFill, bkColor);
   Bar (0, 0, viewPortWidth, viewPortHeight);
   with old_FillSettings do
   begin
      SetFillStyle (pattern, color);
   end;
end; { ClearViewPort }

procedure FreeAnim (var Anim : AnimatType);
begin
   EnterCriticalSection (protect_devices);
   with anim do
   begin
      if (bitHnd <> 0) then
      begin
         DeleteObject (bitHnd);
         DeleteObject (maskHnd);
         DeleteObject (bkgHnd);
         bitHnd := 0;
      end;
   end;
   LeaveCriticalSection (protect_devices);
end; { FreeAnim }

procedure GetAnim (x1, y1, x2, y2 : smallint;
                   Color : LongWord; out Anim : AnimatType);
var
   bmWidth, bmHeight : LongInt;
   dc : HDC;
   rc : TRect;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;

   if (x1 > x2) or (y1 > y2) then
   begin
      grResult := grInvalidParam;
      exit;
   end;
   Inc (x2); Inc (y2);

   with Anim do
   begin
      bmWidth := x2 - x1; bmHeight := y2 - y1;
      bitHnd := CreateCompatibleBitmap (grMemory, bmWidth, bmHeight);
      maskHnd := CreateBitmap (bmWidth, bmHeight, 1, 1, nil);
      bkgHnd := CreateCompatibleBitmap (grMemory, bmWidth, bmHeight);
      EnterCriticalSection (protect_devices);
      SelectObject (grTemp, bitHnd);
      BitBlt (grTemp, 0, 0, bmWidth, bmHeight, grMemory, x1 + origX, y1 + origY, SRCCOPY);
      dc := CreateCompatibleDC (0);
      SelectObject (dc, maskHnd);
      windows.SetBkColor (grTemp, MapColor (color)); { <- trick to set transparency }
      BitBlt (dc, 0, 0, bmWidth, bmHeight, grTemp, 0, 0, SRCCOPY);
      BitBlt (grTemp, 0, 0, bmWidth, bmHeight, dc, 0, 0, SRCINVERT);
      SetRect (rc, 0, 0, bmWidth, bmHeight);
      windows.InvertRect (dc, rc);
      SelectObject (dc, old_Bitmap);
      DeleteDC (dc);
      SelectObject (grTemp, old_Bitmap);
      LeaveCriticalSection (protect_devices);
   end;
end; { GetAnim }

procedure GetAspectRatio (out Xasp, Yasp : Word);
begin
   Xasp := aspX; Yasp := aspY;
end; { GetAspectRatio }

procedure GetImage (x1, y1, x2, y2 : smallint; out Bitmap);
var
   hbmp : HBITMAP;
   img : TImage absolute Bitmap;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;

   if (x1 > x2) or (y1 > y2) then
   begin
      grResult := grInvalidParam;
      exit;
   end;

   with img.bmiFileHeader, img.bmiInfoHeader do
   begin
      bfType := $4D42;
      bfOffBits := SizeOf (BITMAPFILEHEADER) + SizeOf (BITMAPINFOHEADER);
      bfSize := ImageSize (x1, y1, x2, y2);
      bfReserved1 := 0; bfReserved2 := 0;
      Inc (x2); Inc (y2);
      biSize := SizeOf (BITMAPINFOHEADER);
      biWidth := x2 - x1;
      biHeight := y2 - y1;
      biPlanes := 1;
      biBitCount := 24; { hardcoded 24-bit bitmap format }
      biClrUsed := 0;
      biCompression := BI_RGB;
      biSizeImage := 0;
      biClrImportant := 0;
      hbmp := CreateCompatibleBitmap (grMemory, x2 - x1, y2 - y1);
      EnterCriticalSection (protect_devices);
      SelectObject (grTemp, hbmp);
      BitBlt (grTemp, 0, 0, x2 - x1, y2 - y1, grMemory, x1 + origX, y1 + origY, SRCCOPY);
      SelectObject (grTemp, old_Bitmap);
      GetDIBits (grWindow, hbmp, 0, biHeight, @img.bmiBits,
                 PBITMAPINFO(@img.bmiInfoHeader)^, DIB_RGB_COLORS);
      LeaveCriticalSection (protect_devices);
   end;
   DeleteObject(hbmp);
end; { GetImage }

function GetMaxX : smallint;
begin
   Result := maxX;
end; { GetMaxX }

function GetMaxY : smallint;
begin
   Result := maxY;
end; { GetMaxY }

procedure GetViewSettings (out ViewPort : ViewPortType);
begin
   ViewPort := wingraph.viewPort;
end; { GetViewSettings }

function GetX : smallint;
begin
   Result := actX;
end; { GetX }

function GetY : smallint;
begin
   Result := actY;
end; { GetY }

function ImageSize (x1, y1, x2, y2: smallint) : LongInt;
var
   aux : Single;
   rowsize : LongInt;
begin
   grResult := grOK;
   if (x1 > x2) or (y1 > y2) then
   begin
      grResult := grInvalidParam;
      Result := 0;
      exit;
   end;
   Inc (x2); Inc (y2);
   aux := 0.75 * (x2 - x1);
   rowsize := Trunc (aux);
   if (rowsize <> aux) then
      Inc (rowsize);
   Result := SizeOf (BITMAPFILEHEADER) + SizeOf (BITMAPINFOHEADER) +
      rowsize * (y2 - y1) * 4; { hardcoded 24-bit bitmap format }
end; { ImageSize }

procedure PutAnim (x1, y1 : smallint; var Anim : AnimatType; Bit : Word);
var
   bm : BITMAP;
   rop : DWORD;

   procedure PutBit (rop : DWORD);
   begin
      with bm, anim do
      begin
         SelectObject (grTemp, bitHnd);
         if grDirect then
         begin
	    BitBlt (grWindow, x1, y1, bmWidth, bmHeight, grTemp, 0, 0, rop);
	 end;
	 BitBlt (grMemory, x1, y1, bmWidth, bmHeight, grTemp, 0, 0, rop);
      end;
   end; { PutBit }

   procedure PutMask (rop : DWORD);
   var old_color, old_bkcolor : COLORREF;
   begin
      with bm, anim do
      begin
         SelectObject (grTemp, maskHnd);
         old_color := SetTextColor (grMemory, $02FFFFFF);
         old_bkcolor := windows.SetBkColor (grMemory, $02000000);
         BitBlt (grMemory, x1, y1, bmWidth, bmHeight, grTemp, 0, 0, rop);
         SetTextColor (grMemory, old_color);
         windows.SetBkColor (grMemory, old_bkcolor);
         if grDirect then
         begin
	    SetTextColor (grWindow, $02FFFFFF);
	    windows.SetBkColor (grWindow, $02000000);
	    BitBlt (grWindow, x1, y1, bmWidth, bmHeight, grTemp, 0, 0, rop);
	    SetTextColor (grWindow, old_color);
	    windows.SetBkColor (grWindow, old_bkcolor);
	 end;
      end;
   end; { PutMask }

   procedure GetBkg;
   begin
      with bm do
         BitBlt (grTemp, 0, 0, bmWidth, bmHeight, grMemory, x1, y1, SRCCOPY);
   end; { GetBkg }

begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   Inc (x1, origX); Inc (y1, origY);
   case bit of
      CopyPut :
         rop := SRCCOPY;
      XorPut :
         rop := SRCINVERT;
      OrPut :
         rop := SRCPAINT;
      AndPut :
         rop := SRCAND;
      NotPut :
         rop := NOTSRCCOPY;
      NotOrPut :
         rop := NOTSRCERASE;
      InvBitOrPut :
         rop := MERGEPAINT;
      InvScrAndPut :
         rop := SRCERASE;
      TransPut, MaskPut, BkgPut :
         rop := 0;
      else
      begin
         grResult := grInvalidParam;
         exit;
      end;
   end; { case }

   with bm, anim do
   begin
      if (bitHnd = 0) then
      begin
         grResult := grInvalidParam;
         exit;
      end;
      GetObject (bitHnd, SizeOf (BITMAP), @bm);
      EnterCriticalSection (protect_devices);
      SelectObject (grTemp, bkgHnd);
      case bit of
         BkgPut :
         begin
            if grDirect then
               BitBlt (grWindow, x1, y1, bmWidth, bmHeight,
                       grTemp, 0, 0, SRCCOPY);
            BitBlt (grMemory, x1, y1, bmWidth, bmHeight, grTemp, 0, 0, SRCCOPY);
         end;
         TransPut :
         begin
            GetBkg;
            PutMask (SRCAND);
            PutBit (SRCPAINT);
         end;
         MaskPut :
         begin
            GetBkg;
            PutMask(SRCCOPY);
         end;
         else
         begin
            GetBkg;
            PutBit(rop);
         end;
      end; { case }
      SelectObject (grTemp, old_Bitmap);
      LeaveCriticalSection (protect_devices);
   end; { with }
end; { PutAnim }

procedure PutImage (x1, y1 : smallint; var bitmap; bit : word);
var
   hbmp : HBITMAP;
   img : TImage absolute bitmap;
   rop : DWORD;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   Inc (x1, origX); Inc (y1, origY);
   case bit of
      CopyPut :
         rop := SRCCOPY;
      XorPut :
         rop := SRCINVERT;
      OrPut :
         rop := SRCPAINT;
      AndPut :
         rop := SRCAND;
      NotPut :
         rop := NOTSRCCOPY;
      NotOrPut :
         rop := NOTSRCERASE;
      InvBitOrPut :
         rop := MERGEPAINT;
      InvScrAndPut :
         rop := SRCERASE;
      else
      begin
         grResult := grInvalidParam;
         exit;
      end;
   end; { case }

   with img.bmiInfoHeader do
   begin
      hbmp := CreateCompatibleBitmap (grMemory, biWidth, biHeight);
      EnterCriticalSection (protect_devices);
      SetDIBits (grWindow, hbmp, 0, biHeight, @img.bmiBits,
                 PBITMAPINFO (@img.bmiInfoHeader)^, DIB_RGB_COLORS);
      SelectObject (grTemp, hbmp);
      if grDirect then
         BitBlt (grWindow, x1, y1, biWidth, biHeight, grTemp, 0, 0, rop);
      BitBlt (grMemory, x1, y1, biWidth, biHeight, grTemp, 0, 0, rop);
      SelectObject (grTemp, old_Bitmap);
      LeaveCriticalSection (protect_devices);
   end;
   DeleteObject (hbmp);
end; { PutImage }

procedure SetActivePage (page : word);
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   if (page >= NrVideoPages) then
      page := 0;

   activePage := page;
   EnterCriticalSection (protect_devices);
   SelectObject (grMemory, grBitmap[activePage]);
   LeaveCriticalSection (protect_devices);
   if palExist then
      SetDIBColorTable (grMemory, 0, maxColors, colTable[0]);
   grDirect := (activePage = visualPage) and grUpdate;
end; { SetActivePage }

procedure SetAspectRatio (xasp, yasp : word);
begin
   aspX := xasp; aspY := yasp;
   defAspectRatio := (xasp = 10000) and (yasp = 10000);
end; { SetAspectRatio }

procedure SetViewPort (x1, y1, x2, y2 : smallint; clip : boolean);
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   if (x1 > x2) or (y1 > y2) then
   begin
      grResult := grInvalidParam;
      exit;
   end;

   viewPort.x1 := x1; viewPort.y1 := y1;
   viewPort.x2 := x2; viewPort.y2 := y2;
   viewPort.clip := clip;
   viewPortWidth := x2 - x1; viewPortHeight := y2 - y1;
   origX := x1; origY := y1;
   MoveTo (0, 0);
   EnterCriticalSection (protect_devices);
   if (grClip <> 0) then
   begin
      SelectClipRgn (grWindow, 0);
      SelectClipRgn (grMemory, 0);
      DeleteObject (grClip);
      grClip := 0;
   end;
   if clip then
   begin
      grClip := CreateRectRgn (x1, y1, x2 + 1, y2 + 1);
      SelectClipRgn (grWindow, grClip);
      SelectClipRgn (grMemory, grClip);
   end;
   LeaveCriticalSection (protect_devices);
end; { SetViewPort }

procedure SetVisualPage (page : word);
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;

   if (page >= NrVideoPages) then
      page := 0;
   visualPage := page;
   grDirect := (activePage = visualPage) and grUpdate;
   InvalidateRect (grHandle, nil, false);
end; { SetVisualPage }

procedure SetWriteMode (writemode : smallint);
var fnDrawMode, iBkMode : longint;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   fnDrawMode := writemode mod $10;
   iBkMode := (writemode div $10) shl 4;
   case fnDrawMode of
      CopyMode :
         fnDrawMode := R2_COPYPEN;
      XorMode :
         fnDrawMode := R2_XORPEN;
      OrMode :
         fnDrawMode := R2_MERGEPEN;
      AndMode :
         fnDrawMode := R2_MASKPEN;
      NotMode :
         fnDrawMode := R2_NOTCOPYPEN;
      NotScrMode :
         fnDrawMode := R2_NOT;
      NotXorMode :
         fnDrawMode := R2_NOTXORPEN;
      NotOrMode :
         fnDrawMode := R2_NOTMERGEPEN;
      NotAndMode :
         fnDrawMode := R2_NOTMASKPEN;
      InvColAndMode :
         fnDrawMode := R2_MASKNOTPEN;
      InvColOrMode :
         fnDrawMode := R2_MERGENOTPEN;
      InvScrAndMode:
         fnDrawMode := R2_MASKPENNOT;
      InvScrOrMode :
         fnDrawMode := R2_MERGEPENNOT;
      BlackMode :
         fnDrawMode := R2_BLACK;
      WhiteMode :
         fnDrawMode := R2_WHITE;
      EmptyMode :
         fnDrawMode := R2_NOP;
      else
      begin
         grResult := grInvalidParam;
         exit;
      end;
   end; { case }

   case iBkMode of
      Transparent :
         iBkMode := windows.TRANSPARENT;
      Opaque :
         iBkMode := windows.OPAQUE;
      else
      begin
         grResult := grInvalidParam;
         exit;
      end;
   end; { case }
   SetROP2 (grWindow, fnDrawMode); SetBkMode (grWindow, iBkMode);
   SetROP2 (grMemory, fnDrawMode); SetBkMode (grMemory, iBkMode);
end; { SetWriteMode }

{color management routines}

function GetBkColor : longword;
begin
   Result := bkColor;
end; { GetBkColor }

function GetColor : longword;
begin
   Result := frColor;
end; { GetColor }

procedure GetDefaultPalette (out palette : PaletteType);
begin
   with palette do
   begin
      if palExist then
         size := maxColors
      else
         size := 256;
      Move (DefaultVGAPalette, colors, size * SizeOf (longword));
      if (grDriver = D1bit) then
      begin
         colors[0] := $000000;
         colors[1] := $FFFFFF;
      end;
   end;
end; { GetDefaultPalette }

procedure GetNamesPalette (out palette : PaletteType);
begin
   with palette do
   begin
      if palExist then
         size := maxColors
      else
         size := 256;

      if (size > NrColorNames) then
         size := NrColorNames;
      Move (NamesPalette, colors, size * SizeOf (longword));
      if (grDriver = D1bit) then
      begin
         colors[0] := $000000;
         colors[1] := $FFFFFF;
      end;
   end;
end; { GetNamesPalette }

function GetMaxColor : longword;
begin
   if palExist then
      Result := palSize - 1
   else
      Result := $FFFFFF;
end; { GetMaxColor }

procedure GetPalette (out palette : PaletteType);
var
   pe : array of PALETTEENTRY;
   i : longint;
begin
   grResult := grOK;
   if not(grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;

   if palExist then
   begin
      with palette do
      begin
         size := palSize;
         SetLength (pe, size);
         GetPaletteEntries (grPalette, 0, size, pe[0]);
         for i := 0 to size - 1 do
         with pe[i] do
         begin
	    colors[i] := RGB (peRed, peGreen, peBlue);
	 end;
	 SetLength (pe, 0);
      end;
   end
   else
      grResult := grNoPalette;
end; { GetPalette }

function GetPaletteSize : smallint;
begin
   if palExist then
      Result := palSize
   else
      Result := -1;
end; { GetPaletteSize }

function GetPixel (x, y : smallint) : longword;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      Result := 0;
      exit;
   end;
   EnterCriticalSection (protect_devices);
   Result := windows.GetPixel (grMemory, x + origX, y + origY);
   LeaveCriticalSection (protect_devices);
   if palExist then
      Result := GetNearestPaletteIndex (grPalette, Result);
end; { GetPixel }

function GetRGBColor (r, g, b : word) : longword;
begin
   Result := RGB (r, g, b);
   if palExist then
      Result := GetNearestPaletteIndex (grPalette, Result);
end; { GetRGBColor }

procedure GetRGBComponents (color : longword; out r, g, b : word);
var pe : PALETTEENTRY;
begin
   if palExist then
   begin
      with pe do
      begin
         GetPaletteEntries (grPalette, color mod palSize, 1, pe);
         r := peRed; g := peGreen; b := peBlue;
      end
   end
   else
   begin
      r := GetRValue (color);
      g := GetGValue (color);
      b := GetBValue (color);
   end;
end; { GetRGBComponents }

procedure GetSystemPalette (out palette : PaletteType);
var
   pe : array of PALETTEENTRY;
   i : longint;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;

   with palette do
   begin
      if palExist then
         size := maxColors
      else
         size := 256;
      SetLength (pe, size);
      GetSystemPaletteEntries (grWindow, 0, size, pe[0]);
      for i := 0 to size - 1 do
         with pe[i] do
         begin
	    colors[i] := RGB (peRed, peGreen, peBlue);
	 end;
	
      SetLength (pe, 0);
      if (grDriver = D1bit) then
      begin
         colors[0] := $000000;
         colors[1] := $FFFFFF;
      end;
   end; { with }
end; { GetSystemPalette }

procedure SetAllPalette (var palette);
var
   pe : array of PALETTEENTRY;
   i : longint;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   if not (palExist) then
   begin
      grResult := grNoPalette;
      exit;
   end;

   with PaletteType(palette) do
   begin
      if (size > maxColors) then
      begin
         grResult := grInvalidParam;
         exit;
      end;
      SetLength (pe, size);
      for i := 0 to size - 1 do
         with pe[i],colTable[i] do
         begin
            peRed := GetRValue (colors[i]);
            peGreen := GetGValue (colors[i]);
            peBlue := GetBValue (colors[i]);
            peFlags := 0;
            rgbRed := peRed;
            rgbGreen := peGreen;
            rgbBlue := peBlue;
            rgbReserved := 0;
         end;

      for i := size to maxColors - 1 do
         with pe[0], colTable[i] do
         begin // all non-used bitmap palette entries equals the first entry
            rgbRed := peRed;
            rgbGreen := peGreen;
            rgbBlue := peBlue;
            rgbReserved := 0;
         end;

      EnterCriticalSection (protect_devices);
      ResizePalette (grPalette, size);
      SetPaletteEntries (grPalette, 0, size, pe[0]);
      SetDIBColorTable (grMemory, 0, maxColors, colTable[0]);
      MapPaletteColors;
      RealizePalette (grWindow);
      RealizePalette (grMemory);
      RealizePalette (grTemp);
      LeaveCriticalSection (protect_devices);
      InvalidateRect (grHandle, nil, false);
      palSize := size;
      SetLength(pe, 0);
   end; { with }
end; { SetAllPalette }

procedure SetBkColor (color : longword);
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   bkColor := color;
   color := MapColor (color);
   windows.SetBkColor (grWindow, color);
   windows.SetBkColor (grMemory, color);
end; { SetBkColor }

procedure SetColor (color : longword);
begin
   frColor := color;
   with lineSettings do
   begin
      SetLineStyle (linestyle, pattern, thickness);
   end;
   if (grResult <> grOK) then exit;
   color := MapColor (color);
   SetTextColor (grWindow, color);
   SetTextColor (grMemory, color);
end; { SetColor }

procedure SetPalette (nrcolor, color : word);
var col : longword;
begin
   grResult := grOK;
   if not (palExist) then
   begin
      grResult := grNoPalette;
      exit;
   end;

   if (color >= 256) then
   begin
      grResult := grInvalidParam;
      exit;
   end;
   col := DefaultVGAPalette[color];
   SetRGBPalette (nrcolor, GetRValue (col), GetGValue (col), GetBValue (col));
end; { SetPalette }

procedure SetRGBPalette (nrcolor, r, g, b : word);
var pe : PALETTEENTRY;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   if not (palExist) then
   begin
      grResult := grNoPalette;
      exit;
   end;
   if (nrcolor >= palSize) then
   begin
      grResult := grInvalidParam;
      exit;
   end;

   with pe, colTable[nrcolor] do
   begin
      peRed := LOBYTE (r);
      peGreen := LOBYTE (g);
      peBlue := LOBYTE(b);
      peFlags := 0;
      rgbRed := peRed;
      rgbGreen := peGreen;
      rgbBlue := peBlue;
      rgbReserved := 0;
   end;
   EnterCriticalSection (protect_devices);
   SetPaletteEntries (grPalette, nrcolor, 1, pe);
   SetDIBColorTable (grMemory, nrcolor, 1, colTable[nrcolor]);
   RealizePalette (grWindow);
   RealizePalette (grMemory);
   RealizePalette (grTemp);
   LeaveCriticalSection (protect_devices);
   InvalidateRect (grHandle, nil, false);
end; { SetRGBPalette }

{ Drawing primitives routines }

procedure Arc (x, y : smallint; start, stop, radius : word);
begin
   Ellipse (x, y, start, stop, radius, radius);
end; { Arc }

procedure Circle (x, y : smallint; radius : word);
begin
   Ellipse (x, y, 0, 360, radius, radius);
end; { Circle }

procedure DrawBezier (nrpoints : word; var polypoints);
var
   size, i: longint;
   points : array of TPoint;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   SetLength (points, nrpoints);
   size := nrpoints * SizeOf (PointType);
   Move (polypoints, points[0], size);
   for i := 0 to nrpoints - 1 do
   begin
      with points[i] do
      begin
         Inc (x, origX); Inc (y, origY);
      end;
   end;

   if (nrpoints >= 4) then
   begin
      EnterCriticalSection (protect_devices);
      if grDirect then
      begin
         PolyBezier (grWindow, points[0], nrpoints);
      end;
      PolyBezier (grMemory, points[0], nrpoints);
      LeaveCriticalSection (protect_devices);
   end
   else
      grResult := grInvalidParam;

   SetLength (points, 0);
end; { DrawBezier }

procedure DrawPoly (nrpoints : word; var polypoints);
var
   size, i : longint;
   points : array of TPoint;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;

   if (nrpoints < 2) then
   begin
      grResult := grInvalidParam;
      exit;
   end;
   SetLength (points, nrpoints);
   size := nrpoints * SizeOf (PointType);
   Move (polypoints, points[0], size);
   for i := 0 to nrpoints - 1 do
      with points[i] do
      begin
         Inc (x, origX); Inc (y, origY);
      end;

   EnterCriticalSection (protect_devices);
   if grDirect then
   begin
      Polyline (grWindow, points[0], nrpoints);
   end;
   Polyline (grMemory, points[0], nrpoints);
   LeaveCriticalSection (protect_devices);
   SetLength (points, 0);
end; { DrawPoly }

procedure Ellipse (x, y : smallint; start, stop, xradius, yradius : word);
var
   nXStartArc, nYStartArc, nXEndArc, nYEndArc : longint;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   lastArcCoords.x := x; lastArcCoords.y := y;
   Inc (x, origX); Inc (y, origY);
   nXStartArc := Round (xradius * Cos (start * Rad));
   nXEndArc := Round (xradius * Cos (stop * Rad));
   nYStartArc := Round (yradius * Sin (start * Rad));
   nYEndArc := Round (yradius * Sin (stop * Rad));
   if not (defAspectRatio) then
   begin
      xradius := 10000 * xradius div aspX;
      yradius := 10000 * yradius div aspY;
   end;
   EnterCriticalSection (protect_devices);
   if grDirect then
   begin
      windows.Arc (grWindow, x - xradius, y - yradius,
                   x + xradius + 1, y + yradius + 1,
                   x + nXStartArc, y - nYStartArc, x + nXEndArc, y - nYEndArc);
   end;
   windows.Arc (grMemory, x - xradius, y - yradius,
                x + xradius + 1, y + yradius + 1,
                x + nXStartArc, y - nYStartArc, x + nXEndArc, y - nYEndArc);
   LeaveCriticalSection (protect_devices);
   with lastArcCoords do
   begin
      xstart := x + nXStartArc; ystart := y - nYStartArc;
      xend := x + nXEndArc; yend := y - nYEndArc;
   end;
end; { Ellipse }

procedure GetArcCoords(out arccoords:ArcCoordsType);
begin
  arccoords:=lastArcCoords;
end;

procedure GetLineSettings (out lineinfo : LineSettingsType);
begin
   lineinfo := lineSettings;
end; { GetLineSettings }

procedure Line (x1, y1, x2, y2 : smallint);
begin
   MoveTo (x1, y1);
   LineTo (x2, y2);
end; { Line }

procedure LineRel (dx, dy : smallint);
begin
   LineTo (actX + dx, actY + dy);
end; { LineRel }

procedure LineTo (x, y : smallint);
var x0, y0 : smallint;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   x0 := x; y0 := y;
   Inc(x, origX); Inc (y, origY);
   with lineSettings do
   begin
      if (linestyle <> UserBitLn) then
      begin
         EnterCriticalSection (protect_devices);
         if grDirect then
         begin
            windows.LineTo (grWindow, x, y);
         end;
         windows.LineTo (grMemory, x, y);
         LeaveCriticalSection (protect_devices);
         if (thickness = NormWidth) then
         begin
            PutPixel (x0, y0, frColor);
         end;
      end
      else
      begin
         EnterCriticalSection (protect_devices);
         globalTemp := 0;
         LineDDA (actX, actY, x0, y0, @LineProc, pattern);
         LeaveCriticalSection (protect_devices);
      end;
      MoveTo(x0,y0);
   end; { with }
end; { LineTo }

procedure MoveRel (dx, dy : smallint);
begin
   Inc (actX, dx); Inc (actY, dy);
   MoveTo (actX, actY);
end; { MoveRel }

procedure MoveTo (x, y : smallint);
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   actX := x; actY := y;
   Inc (x, origX); Inc (y, origY);
   MoveToEx (grWindow, x, y, nil);
   MoveToEx (grMemory, x, y, nil);
end; { MoveTo }

procedure PutPixel (x, y : smallint; color : longword);
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   Inc (x, origX); Inc (y, origY);
   color := MapColor (color);
   EnterCriticalSection (protect_devices);
   if grDirect then
   begin
      SetPixelV (grWindow, x, y, color);
   end;
   SetPixelV (grMemory, x, y, color);
   LeaveCriticalSection (protect_devices);
end; { PutPixel }

procedure Rectangle (x1, y1, x2, y2 : smallint);
var
   pt : array[1 .. 5] of TPoint;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;

   if (x1 > x2) or (y1 > y2) then
   begin
      grResult := grInvalidParam;
      exit;
   end;

   Inc (x1, origX); Inc (y1, origY);
   Inc (x2, origX); Inc (y2, origY);
   if (x1 <> x2) or (y1 <> y2) then
   begin
      pt[1].x := x1; pt[1].y := y1;
      pt[2].x := x2; pt[2].y := y1;
      pt[3].x := x2; pt[3].y := y2;
      pt[4].x := x1; pt[4].y := y2;
      pt[5].x := x1; pt[5].y := y1;
      EnterCriticalSection (protect_devices);
      if grDirect then
      begin
         Polyline (grWindow, pt, 5);
      end;
      Polyline (grMemory, pt, 5);
      LeaveCriticalSection(protect_devices);
   end
   else
      PutPixel(x1,y1,frColor);
end; { Rectangle }

procedure RotEllipse (x, y, rot : smallint; xradius, yradius : word);
var
   pt : array[1 .. 7] of TPoint;
   cosrot, sinrot : double;
   x1, y1, i : longint;
begin
   xradius := Round (1.3333 * xradius);
   cosrot := Cos (rot * Rad); sinrot := Sin (rot * Rad);
   pt[1].x := 0;        pt[1].y := -yradius;
   pt[2].x := xradius;  pt[2].y := -yradius;
   pt[3].x := xradius;  pt[3].y := yradius;
   pt[4].x := 0;        pt[4].y := yradius;
   pt[5].x := -xradius; pt[5].y := yradius;
   pt[6].x := -xradius; pt[6].y := -yradius;
   pt[7].x := 0;        pt[7].y := -yradius;
   for i := 1 to 7 do
   begin
      x1 := pt[i].x; y1 := pt[i].y; //perform rotation
      pt[i].x := x + Round ( x1 * cosrot + y1 * sinrot);
      pt[i].y := y + Round (-x1 * sinrot + y1 * cosrot);
   end;
   DrawBezier (7, pt);
end; { RotEllipse }

procedure SetLineStyle (linestyle, pattern, thickness : word);
var
   lgpn : LOGPEN;
   lstyle : word;
   old : HPEN;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   case linestyle of
      SolidLn :
         lstyle := PS_SOLID;
      DashedLn :
         lstyle := PS_DASH;
      DottedLn :
         lstyle := PS_DOT;
      DashDotLn :
         lstyle := PS_DASHDOT;
      DashDotDotLn :
         lstyle := PS_DASHDOTDOT;
      UserBitLn, NullLn :
         lstyle := PS_NULL;
      else
      begin
         grResult := grInvalidParam;
         exit;
      end;
   end; { case }
   lineSettings.linestyle := linestyle;
   lineSettings.pattern := pattern;
   lineSettings.thickness := thickness;
   with lgpn do
   begin
      lopnStyle := lstyle;
      lopnWidth.x := thickness;
      lopnColor := MapColor(frColor);
   end;
   EnterCriticalSection (protect_devices);

   { on NT-based systems can be improved with ExtCreatePen }
   grPen := CreatePenIndirect (lgpn);
   old := SelectObject (grWindow, grPen);
   SelectObject(grMemory, grPen);
   if (old <> old_Pen) then
      DeleteObject (old);
   LeaveCriticalSection (protect_devices);
end; { SetLineStyle }

{ Filled drawings routines }

procedure Bar (x1, y1, x2, y2 : smallint);
var
   rc : TRect;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   if (x1 > x2) or (y1 > y2) then
   begin
      grResult := grInvalidParam;
      exit;
   end;
   Inc (x1, origX); Inc (y1, origY);
   Inc (x2, origX); Inc (y2, origY);
   SetRect (rc, x1, y1, x2 + 1, y2 + 1);
   EnterCriticalSection (protect_devices);
   if grDirect then
   begin
      windows.FillRect (grWindow, rc, grBrush);
   end;
   windows.FillRect (grMemory, rc, grBrush);
   LeaveCriticalSection (protect_devices);
end; { Bar }

procedure Bar3D (x1, y1, x2, y2 : smallint; depth : word; top : boolean);
var pt : array[1 .. 4] of TPoint;
begin
   FillRect (x1, y1, x2, y2);
   if (grResult <> grOK) then exit;
   Inc (x1, origX); Inc (y1, origY);
   Inc (x2, origX); Inc (y2, origY);
   EnterCriticalSection (protect_devices);
   if top then
   begin
      pt[1].x := x1;         pt[1].y := y1;
      pt[2].x := x1 + depth; pt[2].y := y1 - depth;
      pt[3].x := x2 + depth; pt[3].y := y1 - depth;
      pt[4].x := x2;         pt[4].y := y1;
      if grDirect then
      begin
         Polyline (grWindow, pt, 4);
      end;
      Polyline (grMemory, pt, 4);
   end;
   if (depth <> 0) then
   begin
      pt[1].x := x2 + depth; pt[1].y := y1 - depth;
      pt[2].x := x2 + depth; pt[2].y := y2 - depth;
      pt[3].x := x2;         pt[3].y := y2;
      if grDirect then
      begin
         Polyline (grWindow, pt, 3);
      end;
      Polyline (grMemory, pt, 3);
   end;
   LeaveCriticalSection (protect_devices);
end; { Bar3D }

procedure Chord (x, y : smallint; start, stop, xradius, yradius : word);
var
   nXRadial1, nYRadial1, nXRadial2, nYRadial2 : longint;
begin
   grResult := grOK;
   if not(grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   Inc (x, origX); Inc (y, origY);
   nXRadial1 := Round (xradius * Cos (start * Rad));
   nXRadial2 := Round (xradius * Cos (stop * Rad));
   nYRadial1 := Round (yradius * Sin (start * Rad));
   nYRadial2 := Round (yradius * Sin (stop * Rad));
   if not (defAspectRatio) then
   begin
      xradius := 10000 * xradius div aspX;
      yradius := 10000 * yradius div aspY;
   end;
   EnterCriticalSection (protect_devices);
   if grDirect then
   begin
      windows.Chord (grWindow, x - xradius, y - yradius,
                     x + xradius + 1, y + yradius + 1,
                     x + nXRadial1, y - nYRadial1, x + nXRadial2, y - nYRadial2);
   end;
   windows.Chord (grMemory, x - xradius, y - yradius,
                  x + xradius + 1, y + yradius + 1,
                  x + nXRadial1, y - nYRadial1, x + nXRadial2, y - nYRadial2);
   LeaveCriticalSection (protect_devices);
end; { Chord }

procedure FillEllipse (x, y : smallint; xradius, yradius : word);
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   Inc (x, origX); Inc (y, origY);
   if not (defAspectRatio) then
   begin
      xradius := 10000 * xradius div aspX;
      yradius := 10000 * yradius div aspY;
   end;
   EnterCriticalSection (protect_devices);
   if grDirect then
   begin
      windows.Ellipse (grWindow, x - xradius, y - yradius,
                       x + xradius + 1, y + yradius + 1);
   end;
   windows.Ellipse (grMemory, x - xradius, y - yradius,
                    x + xradius + 1, y + yradius + 1);
   LeaveCriticalSection (protect_devices);
end; { FillEllipse }

procedure FillPoly (nrpoints : word; var polypoints);
var
   size, i : longint;
   points : array of TPoint;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   SetLength (points, nrpoints);
   size := nrpoints * SizeOf (PointType);
   Move (polypoints, points[0], size);
   for i := 0 to nrpoints - 1 do
      with points[i] do
      begin
         Inc (x, origX); Inc (y, origY);
      end;

   if (nrpoints >= 2) then
   begin
      EnterCriticalSection (protect_devices);
      if grDirect then
      begin
         Polygon (grWindow, points[0], nrpoints);
      end;
      Polygon (grMemory, points[0], nrpoints);
      LeaveCriticalSection (protect_devices);
   end
   else
      grResult := grInvalidParam;
   SetLength (points, 0);
end; { FillPoly }

procedure FillRect (x1, y1, x2, y2 : smallint);
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   if (x1 > x2) or (y1 > y2) then
   begin
      grResult := grInvalidParam;
      exit;
   end;
   Inc (x1, origX); Inc (y1, origY);
   Inc (x2, origX + 1); Inc (y2, origY + 1);
   EnterCriticalSection (protect_devices);
   if grDirect then
   begin
      windows.Rectangle (grWindow, x1, y1, x2, y2);
   end;
   windows.Rectangle (grMemory, x1, y1, x2, y2);
   LeaveCriticalSection (protect_devices);
end; { FillRect }

procedure FloodFill (x, y : smallint; color : longword);
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   Inc (x, origX); Inc (y, origY);
   color := MapColor (color);
   EnterCriticalSection (protect_devices);
   if grDirect then
   begin
      ExtFloodFill (grWindow, x, y, color, floodMode);
   end;
   ExtFloodFill (grMemory, x, y, color, floodMode);
   LeaveCriticalSection (protect_devices);
end; { FloodFill }

procedure GetFillPattern (out fillpattern : FillPatternType);
begin
   fillpattern := wingraph.fillPattern;
end; { GetFillPattern }

procedure GetFillSettings (out fillinfo : FillSettingsType);
begin
   fillinfo := fillSettings;
end; { GetFillSettings }

procedure InvertRect (x1, y1, x2, y2 : smallint);
var rc : TRect;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   if (x1 > x2) or (y1 > y2) then
   begin
      grResult := grINvalidParam;
      exit;
   end;
   Inc (x1, origX); Inc (y1, origY);
   Inc (x2, origX); Inc (y2, origY);
   SetRect (rc, x1, y1, x2 + 1, y2 + 1);
   EnterCriticalSection (protect_devices);
   if grDirect then
   begin
      windows.InvertRect (grWindow, rc);
   end;
   windows.InvertRect (grMemory, rc);
   LeaveCriticalSection (protect_devices);
end; { InvertRect }

procedure PieSlice (x, y : smallint; start, stop, radius : word);
begin
   Sector (x, y, start, stop, radius, radius);
end; { PieSlice }

procedure RoundRect (x1, y1, x2, y2, r : smallint);
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   if (x1 > x2) or (y1 > y2) then
   begin
      grResult := grInvalidParam;
      exit;
   end;
   Inc (x1, origX); Inc (y1, origY);
   Inc (x2, origX); Inc (y2, origY);
   EnterCriticalSection (protect_devices);
   if grDirect then
   begin
      windows.RoundRect (grWindow, x1, y1, x2 + 1, y2 + 1, r, r);
   end;
   windows.RoundRect (grMemory, x1, y1, x2 + 1, y2 + 1, r, r);
   LeaveCriticalSection (protect_devices);
end; { RoundRect }

procedure Sector (x, y : smallint; start, stop, xradius, yradius : word);
var
   nXRadial1, nYRadial1, nXRadial2, nYRadial2 : longint;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   Inc (x, origX); Inc (y, origY);
   nXRadial1 := Round (xradius * Cos (start * Rad));
   nXRadial2 := Round (xradius * Cos (stop * Rad));
   nYRadial1 := Round (yradius * Sin (start * Rad));
   nYRadial2 := Round (yradius * Sin (stop * Rad));
   if not (defAspectRatio) then
   begin
      xradius := 10000 * xradius div aspX;
      yradius := 10000 * yradius div aspY;
   end;
   EnterCriticalSection (protect_devices);
   if grDirect then
   begin
      Pie (grWindow, x - xradius, y - yradius,
           x + xradius + 1, y + yradius + 1,
           x + nXRadial1, y - nYRadial1, x + nXRadial2, y - nYRadial2);
   end;
   Pie (grMemory, x - xradius, y - yradius,
        x + xradius + 1, y + yradius + 1,
        x + nXRadial1, y - nYRadial1, x + nXRadial2, y - nYRadial2);
   LeaveCriticalSection (protect_devices);
end; { Sector }

procedure SetFillPattern (fillpattern : FillPatternType; color : longword);
var
   i, j : longint;
   col0, col1 : COLORREF;
   b : byte;
begin
   grResult := grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   wingraph.fillPattern := fillpattern;
   col1 := MapColor (color); col0 := MapColor (bkColor);
   EnterCriticalSection (protect_devices);
   if (grPattern <> 0) then
   begin
      DeleteObject (grPattern);
   end;
   grPattern := CreateCompatibleBitmap (grMemory, 8, 8);
   SelectObject (grTemp, grPattern);
   for i := 0 to 7 do
   begin
      b := fillpattern[i + 1];
      for j := 7 downto 0 do
      begin
         if (b and $01 <> 0) then
            SetPixelV (grTemp, j, i, col1)
         else
            SetPixelV (grTemp, j, i, col0);
         b := b shr 1;
      end;
   end;
   SelectObject (grTemp, old_Bitmap);
   LeaveCriticalSection (protect_devices);
   SetFillStyle (UserFill, color);
end; { SetFillPattern }

procedure SetFillStyle (pattern : word; color : longword);
var
   lplb : LOGBRUSH;
   old : HBRUSH;
begin
   grResult:=grOK;
   if not (grEnabled) then
   begin
      grResult := grNoInitGraph;
      exit;
   end;
   with lplb do
   begin
      lbStyle := BS_HATCHED;
      lbHatch := 0;
      case pattern of
         SolidFill : lbStyle:=BS_SOLID;
         EmptyFill :
         begin
            lbStyle:=BS_SOLID;
            color:=bkColor;
         end;
         LineFill :
            lbHatch := HS_HORIZONTAL;
         ColFill :
            lbHatch := HS_VERTICAL;
         HatchFill :
            lbHatch := HS_CROSS;
         SlashFill :
            lbHatch := HS_BDIAGONAL;
         BkSlashFill :
            lbHatch := HS_FDIAGONAL;
         XHatchFill :
            lbHatch := HS_DIAGCROSS;
         UserFill :
         begin
            lbStyle := BS_PATTERN;

            { Delphi needs this typecast }
            lbHatch := {$IFNDEF FPC}longint{$ENDIF} (grPattern);
         end;
         NoFill :
            lbStyle := BS_NULL;
         else
         begin
            grResult := grInvalidParam;
            exit;
         end;
      end; { case }
      lbColor := MapColor (color);
   end;
   fillSettings.pattern := pattern;
   fillSettings.color := color;
   EnterCriticalSection (protect_devices);
   grBrush := CreateBrushIndirect (lplb);
   old := SelectObject (grWindow, grBrush);
   SelectObject (grMemory, grBrush);
   if (old <> old_Brush) then
   begin
      DeleteObject(old);
   end;
   LeaveCriticalSection (protect_devices);
end; { SetFillStyle }

procedure SetFloodMode(floodmode:smallint);
begin
   case floodmode of
      BorderFlood :
         wingraph.floodMode:=FLOODFILLBORDER;
      SurfaceFlood:
         wingraph.floodMode:=FLOODFILLSURFACE;
   end;
end;

{text and font handling routines}

procedure GetFontSettings(out fontname : shortstring;
                          out width, height : word;
                          out ttfont : boolean);
var
   lptm: TEXTMETRIC;
   len : longint;
begin
   len:=GetTextFace(grWindow,255,nil);
   fontname[0]:=Chr(len-1);
   GetTextFace(grWindow,255,@fontname[1]);
   GetTextMetrics(grWindow,lptm);
   with lptm do
   begin
      width:=tmMaxCharWidth; height:=tmHeight;
      ttfont:=((tmPitchAndFamily and TMPF_TRUETYPE) <> 0);
   end;
end;

procedure GetTextSettings(out textinfo:TextSettingsType);
begin
   textinfo:=textSettings;
end;

function InstallUserFont(const fontname:shortstring): smallint;
var
   i      : smallint;
   famName: pchar;
begin
   Result:=-1;
   grResult:=grOK;
   if not(grEnabled) then
   begin
      grResult:=grNoInitGraph;
      Exit;
   end;
   famName:=pchar(ansistring(fontname));
   EnterCriticalSection(protect_devices);
   globalTemp:=0;
   EnumFontFamilies(grWindow,famName,@EnumFontFamProc,0);
   if (globalTemp = 1) then
      for i:=0 to NrMaxFonts-1 do if (instFont[i] = '') then
      begin
         instFont[i]:=fontname+#0;
         Result:=i;
         Break;
      end;
   LeaveCriticalSection(protect_devices);
   if (Result = -1) then grResult:=grInvalidFont;
end;

procedure OutText(const textstring:shortstring);
var
   lpPoint: TPoint;
   len    : longint;
begin
   grResult:=grOK;
   if not(grEnabled) then
   begin
      grResult:=grNoInitGraph;
      Exit;
   end;
   len:=Length(textstring);
   EnterCriticalSection(protect_devices);
   if grDirect then
      TextOut(grWindow,0,0,@textstring[1],len);
   TextOut(grMemory,0,0,@textstring[1],len);
   LeaveCriticalSection(protect_devices);
   GetCurrentPositionEx(grMemory,@lpPoint);
   MoveTo(lpPoint.x-origX,lpPoint.y-origY);
end;

procedure OutTextXY(x,y:smallint; const textstring:shortstring);
begin
  MoveTo(x,y);
  OutText(textstring);
end;

procedure SetTextJustify(horiz,vert:word);
var
   htext,vtext: longword;
begin
   grResult:=grOK;
   if not(grEnabled) then
   begin
      grResult:=grNoInitGraph;
      Exit;
   end;
   case horiz of
      LeftText  : htext:=TA_LEFT;
      CenterText: htext:=TA_CENTER;
      RightText : htext:=TA_RIGHT;
   else
      grResult:=grInvalidParam;
      Exit;
   end;

   case vert of
      TopText     : vtext:=TA_TOP;
      BottomText  : vtext:=TA_BOTTOM;
      BaselineText: vtext:=TA_BASELINE;
   else
      grResult:=grInvalidParam;
      Exit;
   end;
   textSettings.horiz:=horiz; textSettings.vert:=vert;
   SetTextAlign(grWindow,htext or vtext or TA_UPDATECP);
   SetTextAlign(grMemory,htext or vtext or TA_UPDATECP);
end;

procedure SetTextStyle(font,direction,charsize:word);
var
   loByte,hiByte: byte;
   nrfont       : byte;
   fontname     : TFontString;
   lplf         : LOGFONT;
   old          : HFONT;
begin
   grResult:=grOK;
   if not(grEnabled) then
   begin
      grResult:=grNoInitGraph;
      Exit;
   end;
   loByte:=Lo(font); hiByte:=Hi(font);
   nrfont:=loByte mod $10;
   if (nrfont in [0..NrMaxFonts-1]) then
      fontname:=instFont[nrfont]
   else
      fontname:='';

   if (fontname <> '') then
   begin
      textSettings.font:=font;
      textSettings.direction:=direction;
      textSettings.charsize:=charsize;
      if (charsize <= 5) then
         charsize:=charsize*MinCharSize;

      with lplf do
      begin
         lfHeight:=charsize;
         lfWidth:=0;
         lfEscapement:=10*direction;
         lfOrientation:=10*direction;
         lfWeight:=(FW_BOLD-FW_NORMAL)*(loByte div $10)+FW_NORMAL;
         lfItalic:=hiByte div $10;
         lfUnderline:=hiByte mod $10;
         lfStrikeOut:=0;
         lfCharSet:=DEFAULT_CHARSET;
         lfOutPrecision:=OUT_DEFAULT_PRECIS;
         lfClipPrecision:=CLIP_DEFAULT_PRECIS;
         lfQuality:=DEFAULT_QUALITY;
         lfPitchAndFamily:=DEFAULT_PITCH or FF_DONTCARE;
         {$IFDEF FPC}
            lfFaceName:=fontname;
         {$ELSE}
            Move(fontname[1],lfFaceName[0],Length(fontname));
         {$ENDIF}
      end;
      EnterCriticalSection(protect_devices);
      grFont:=CreateFontIndirect(lplf);
      old:=SelectObject(grWindow,grFont); SelectObject(grMemory,grFont);
      if (old <> old_Font) then
         DeleteObject(old);
      LeaveCriticalSection(protect_devices);
   end
   else
      grResult:=grInvalidFontNum;
end;

procedure SetUserCharSize(nCharExtra,nBreakExtra,dummy1,dummy2:word);
begin
   grResult:=grOK;
   if not(grEnabled) then
   begin
      grResult:=grNoInitGraph;
      Exit;
   end;
   SetTextCharacterExtra(grWindow,nCharExtra);
   SetTextCharacterExtra(grMemory,nCharExtra);
   SetTextJustification(grWindow,nBreakExtra,1);
   SetTextJustification(grMemory,nBreakExtra,1);
end;

function TextHeight(const textstring:shortstring): word;
var
   lpSize: TSize;
   len   : longint;
begin
   grResult:=grOK;
   if not(grEnabled) then
   begin
      grResult:=grNoInitGraph;
      Result:=0;
      Exit;
   end;
   len:=Length(textstring);
   GetTextExtentPoint32(grMemory,@textstring[1],len,lpSize);
   Result:=word(lpSize.cy);
end;

function TextWidth(const textstring:shortstring): word;
var
   lpSize: TSize;
   len   : longint;
begin
   grResult:=grOK;
   if not(grEnabled) then
   begin
      grResult:=grNoInitGraph;
      Result:=0;
      Exit;
   end;
   len:=Length(textstring);
   GetTextExtentPoint32(grMemory,@textstring[1],len,lpSize);
   Result:=word(lpSize.cx);
end;

initialization
   grEnabled:=false; palExist:=false; grDriver:=-1;
   KeyboardHook:=nil; MouseHook:=nil;
   screenWidth:=GetSystemMetrics(SM_CXSCREEN);
   screenHeight:=GetSystemMetrics(SM_CYSCREEN);
   SetInternColors;

finalization
   if grEnabled then
      CloseGraph;
end.

