[Setup]
AppName=Shuffle Pictures
AppVersion=1.0
DefaultDirName={pf}\Shuffle Pictures
DefaultGroupName=Shuffle Pictures
UninstallDisplayIcon={app}\ShufflePictures.exe
Compression=lzma2
SolidCompression=yes
OutputDir=userdocs:Shuffle Pictures
LicenseFile=license.txt

[Files]
Source: "Shuffle Pictures\*"; DestDir: "{app}"
Source: "Shuffle Pictures\bearer\*"; DestDir: "{app}\bearer"
Source: "Shuffle Pictures\iconengines\*"; DestDir: "{app}\iconengines"
Source: "Shuffle Pictures\imageformats\*"; DestDir: "{app}\imageformats"
Source: "Shuffle Pictures\platforms\*"; DestDir: "{app}\platforms"
Source: "Shuffle Pictures\Qt\labs\folderlistmodel\*"; DestDir: "{app}\Qt\labs\folderlistmodel\"
Source: "Shuffle Pictures\Qt\labs\settings\*"; DestDir: "{app}\Qt\labs\settings\"
Source: "Shuffle Pictures\QtQuick.2\*"; DestDir: "{app}\QtQuick.2"

Source: "Shuffle Pictures\QtQuick\Controls\*"; DestDir: "{app}\QtQuick\Controls"
Source: "Shuffle Pictures\QtQuick\Dialogs\*"; DestDir: "{app}\QtQuick\Dialogs"
Source: "Shuffle Pictures\QtQuick\Dialogs\Private\*"; DestDir: "{app}\QtQuick\Dialogs\Private"
Source: "Shuffle Pictures\QtQuick\Layouts\*"; DestDir: "{app}\QtQuick\Layouts\"
Source: "Shuffle Pictures\QtQuick\PrivateWidgets\*"; DestDir: "{app}\QtQuick\PrivateWidgets"
Source: "Shuffle Pictures\QtQuick\Window.2\*"; DestDir: "{app}\QtQuick\Window.2"

Source: "Readme.txt"; DestDir: "{app}"; Flags: isreadme

[Icons]
Name: "{group}\ShufflePictures"; Filename: "{app}\ShufflePictures.exe"; 
Name: "{commondesktop}\ShufflePictures.exe"; Filename: "{app}\ShufflePictures.exe";
