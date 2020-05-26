unit yuzupUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ComCtrls;

type

  { TyuzupForm }

  TyuzupForm = class(TForm)
    yuzupBitBtn: TBitBtn;
    directoryBitBtn: TBitBtn;
    latestreleaseLabel: TLabel;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    yuzupfolderEdit: TEdit;
    latesttitleLabel: TLabel;
    latestversionLabel: TLabel;
    Label6: TLabel;
    procedure AbortBitBtnClick(Sender: TObject);
    procedure directoryBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure yuzupBitBtnClick(Sender: TObject);
  private

  public

  end;

var
  yuzupForm: TyuzupForm;
  s: string;
  userhomepathVAR: Textfile;
  userhomepathSTR: string;
  yuzupfolder: string;
  yuzudownloadfolderSTR: string;
  latestfileScript: TextFile;
  latestversionSTR: string;
  latestversionVAR: TextFile;
  latestreleaseSTR: string;
  latestreleaseVAR: TextFile;
  currentversionSTR: string;
  currentversionVAR: TextFile;
  currentreleaseSTR: string;
  currentreleaseVAR: TextFile;
  yuzudownloadfolderValue: TextFile;
  yuzupdownloadfolderSTR: string;
  yuzupdownloadXZValue: TextFile;
  yuzupdownloadfolderXZ: string;
  yuzupdownloadFValue: TextFile;
  yuzupdownloadfolderF: string;
  yuzupdownloadValue: TextFile;
  updateyuzuScript: TextFile;

implementation

{$R *.lfm}

{ TyuzupForm }

procedure TyuzupForm.FormCreate(Sender: TObject);
begin
  //Centralize window
 Left:=(Screen.Width-Width)  div 2;
 Top:=(Screen.Height-Height) div 2;

 //Create temporary folder for yuzup
 RunCommand('bash -c ''mkdir -p /tmp/yuzup/''', s);

 //Create yuzup folder on home
 RunCommand('bash -c ''mkdir -p $HOME/yuzup/''', s);


 //Read file $HOME variable and store result in tmp folder text file
 RunCommand('bash -c ''echo $HOME >> /tmp/yuzup/userhomepath''', s);

 // Assign Text file to variable
 AssignFile(userhomepathVAR, '/tmp/yuzup/userhomepath'); //
 Reset(userhomepathVAR);
 Readln(userhomepathVAR,userhomepathSTR); //Assign Text file to String
 CloseFile(userhomepathVAR);

 //Stock folder
 yuzupfolder := userhomepathSTR+'/yuzup/';
 yuzupfolderEdit.text:=yuzupfolder;


 
// Check latest yuzu file
//Create script latestfileScript.sh with 2 lines, 1 - check latest file , 2- store the value in a text file
AssignFile(latestfileScript, '/tmp/yuzup/latestfileScript.sh');
Rewrite(latestfileScript);
Writeln(latestfileScript,'YUZU_FILE=$(curl --silent "https://api.github.com/repos/yuzu-emu/yuzu-mainline/releases/latest" | grep "linux-.*xz" | tail -1 | cut -c 32-142)'); //Store destination file in a Linux/Unix variable
Writeln(latestfileScript,'echo $YUZU_FILE > /tmp/yuzup/latestfile'); //Store latest yuzu URL on text file
Writeln(latestfileScript,'echo $YUZU_FILE | cut -c 72-74 > /tmp/yuzup/latestrelease'); //Store latest yuzu release on text file
Writeln(latestfileScript,'echo $YUZU_FILE | cut -c 87-94 > /tmp/yuzup/latestversion'); //Store latest yuzu version on text file
CloseFile(latestfileScript);

//execute custom script to create text files
RunCommand('bash -c ''sh /tmp/yuzup/latestfileScript.sh''', s);



// Assign Text file "latesversion" to variable "latestversionVAR"
      AssignFile(latestversionVAR, '/tmp/yuzup/latestversion'); //
      Reset(latestversionVAR);
      Readln(latestversionVAR,latestversionSTR); //Assign variable "latestversionVAR" to string "latestversionSTR"
      CloseFile(latestversionVAR);

      // Store string "latestversionSTR" in label "latestversionLavel"
      latestversionLabel.Caption := latestversionSTR;


 // Assign Text file "latesrelease" to variable "latestreleaseVAR"
      AssignFile(latestreleaseVAR, '/tmp/yuzup/latestrelease'); //
      Reset(latestreleaseVAR);
      Readln(latestreleaseVAR,latestreleaseSTR); //Assign variable "latestreleaseVAR" to string "latestreleaseSTR"
      CloseFile(latestreleaseVAR);

// Store string "latestversionSTR" in label "latestversionLabel"
      latestreleaseLabel.Caption := latestreleaseSTR;





end;

procedure TyuzupForm.yuzupBitBtnClick(Sender: TObject);
begin
  // Update Yuzu

   //check download directory set by user
   yuzupdownloadfolderSTR := yuzupfolderEdit.text;

   // Assign custom download folder to file
   AssignFile(yuzupdownloadValue, '/tmp/yuzup/yuzupdownloadfolder');
   Rewrite(yuzupdownloadValue);
   Writeln(yuzupdownloadValue,yuzupdownloadfolderSTR);
   CloseFile(yuzupdownloadValue);



   //auxiliary variable to indicate .xz files inside the folder
   yuzupdownloadfolderXZ := yuzupdownloadfolderSTR+'*.xz' ;

   // Assign auxiliary variable to to file
   AssignFile(yuzupdownloadXZValue, '/tmp/yuzup/yuzupdownloadfolderXZ');
   Rewrite(yuzupdownloadXZValue);
   Writeln(yuzupdownloadXZValue,yuzupdownloadfolderXZ);
   CloseFile(yuzupdownloadXZValue);



   //auxiliary variable to indicate all files inside the folder
   yuzupdownloadfolderF := yuzupdownloadfolderSTR+'*' ;

   // Assign auxiliary variable to to file
   AssignFile(yuzupdownloadFValue, '/tmp/yuzup/yuzupdownloadfolderF');
   Rewrite(yuzupdownloadFValue);
   Writeln(yuzupdownloadFValue,yuzupdownloadfolderF);
   CloseFile(yuzupdownloadFValue);



//Create script updateyuzuScript.sh with 2 lines, 1 - check latest file , 2- store the value in a text file
AssignFile(updateyuzuScript, '/tmp/yuzup/updateyuzuScript.sh');
Rewrite(updateyuzuScript);
Writeln(updateyuzuScript,'YUZU_FILE=$(cat /tmp/yuzup/latestfile)'); //Store latest yuzu URL on linux variable
Writeln(updateyuzuScript,'YUZUP_FOLDER=$(cat /tmp/yuzup/yuzupdownloadfolder)'); //Store yuzup Download folder on linux variable
Writeln(updateyuzuScript,'YUZUP_FOLDER_XZ=$(cat /tmp/yuzup/yuzupdownloadfolderXZ)'); //Store auxiliary variable for yuzup Download folder files on linux variable
Writeln(updateyuzuScript,'YUZUP_FOLDER_F=$(cat /tmp/yuzup/yuzupdownloadfolderF)'); //Store auxiliary variable to reference all files on the folder
Writeln(updateyuzuScript,'rm -r $YUZUP_FOLDER_F'); //erase current files on the folder
Writeln(updateyuzuScript,'xterm -fg white -bg black -hold -e "wget $YUZU_FILE -P $YUZUP_FOLDER -q --show-progress && tar -xf $YUZUP_FOLDER_XZ -C $YUZUP_FOLDER && rm -r $YUZUP_FOLDER_XZ && killall xterm"'); //Download latest yuzu file to yuzup folder and extract it inside the yuzup folder using the aux var. Delete file and close xterm
Writeln(updateyuzuScript,'mv /tmp/yuzup/latestrelease /tmp/yuzup/currentrelease && mv /tmp/yuzup/currentrelease $YUZUP_FOLDER '); //record current release on yuzup folder
Writeln(updateyuzuScript,'mv /tmp/yuzup/latestversion /tmp/yuzup/currentversion && mv /tmp/yuzup/currentversion $YUZUP_FOLDER '); //record current version on yuzup folder
Writeln(updateyuzuScript,'$YUZUP_FOLDER/yuzu*/yuzu'); //execute latest build
CloseFile(updateyuzuScript);

//execute custom script to create text files
RunCommand('bash -c ''sh /tmp/yuzup/updateyuzuScript.sh''', s);



end;

procedure TyuzupForm.directoryBitBtnClick(Sender: TObject);
begin
  if selectdirectoryDialog1.Execute then
  yuzupfolderEdit.text:= SelectDirectoryDialog1.FileName;
end;

procedure TyuzupForm.AbortBitBtnClick(Sender: TObject);
begin
  RunCommand('bash -c ''killall xterm''', s);
end;



end.

