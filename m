From: littlebat <dashing.meng@gmail.com>
Subject: Bug#679750: Lenovo G360: ALPS Touchpad Recognized as "PS/2 Generic
	Mouse"
Date: Thu, 5 Jul 2012 10:58:34 +0800
Message-ID: <CAAT31jY5_P13xjybsYFm3oix0pjbbzRihCrjecQ+cXkrHhnrCQ@mail.gmail.com>
Reply-To: littlebat <dashing.meng@gmail.com>, 679750@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=20cf307d0386d2e6e204c40c5221
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.679750.B679750.134145712219256@bugs.debian.org>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: linux-input@vger.kernel.org
Cc: seth.forshee@canonical.com, 679750@bugs.debian.org, jrnieder@gmail.com
List-Id: linux-input@vger.kernel.org

--20cf307d0386d2e6e204c40c5221
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

found 679750 linux-2.6/2.6.32-45 , linux-2.6/3.2.4-1 , linux/3.4.4-1
quit

Hi,
Dear kernel developers.

According to the advice at " http://bugs.debian.org/679750 ", I report a
kernel bug about ALPS touchpad to you.

My lenovo G360 has an ALPS touchpad, show in Windows 7 Home Editition
OEM in this laptop. Under Debian Squeeze or Ubuntu 12.04 LTS LiveCD in same
laptop, the left and
right key, single and double tap, tracking  of touchpad works well.
But, there isn't touchpad tab in gnome mouse setting dialog, so I
can't setup edge scrolling and disable touchpad on typing. xinput
shows it is a "PS/2 Generic Mouse". Below is the detail information.

System information:

Debian Squeeze, tried kernel: 2.6.32-45, 3.2.4-1~bpo60+1,
3.4.4-1~experimental.1
And tried Ubuntu 12.04 LTS LiveCD, kernel: 3.2 (has the same bug as in
Debian)

The below information come from Debian Squeeze with 3.2.4-1~bpo60+1 kernel.
The other kerneld and sytem tried above should has the same result.

"synclient -l" shows:

Couldn't find synaptics properties. No synaptics driver loaded?

"xinput --list" shows:

 =E2=8E=A1 Virtual core pointer                        id=3D2    [master po=
inter  (3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer                  id=3D4   =
 [slave  pointer
(2)]
=E2=8E=9C   =E2=86=B3  USB OPTICAL MOUSE                          id=3D11  =
  [slave  pointer
(2)]
=E2=8E=9C   =E2=86=B3 PS/2 Generic Mouse                          id=3D14  =
  [slave  pointer
(2)]
=E2=8E=A3 Virtual core keyboard                       id=3D3    [master key=
board (2)]
    =E2=86=B3 Virtual core XTEST keyboard                 id=3D5    [slave =
 keyboard
(3)]
    =E2=86=B3 Power Button                                id=3D6    [slave =
 keyboard
(3)]
    =E2=86=B3 Video Bus                                   id=3D7    [slave =
 keyboard
(3)]
    =E2=86=B3 Video Bus                                   id=3D8    [slave =
 keyboard
(3)]
    =E2=86=B3 Power Button                                id=3D9    [slave =
 keyboard
(3)]
    =E2=86=B3 Sleep Button                                id=3D10    [slave=
  keyboard
(3)]
    =E2=86=B3 Lenovo EasyCamera                           id=3D12    [slave=
  keyboard
(3)]
    =E2=86=B3 AT Translated Set 2 keyboard                id=3D13    [slave=
  keyboard
(3)]
    =E2=86=B3 Ideapad extra buttons                       id=3D15    [slave=
  keyboard
(3)]
    =E2=86=B3 ACPI Virtual Keyboard Device                id=3D16    [slave=
  keyboard
(3)]


"cat /proc/bus/input/devices" shows (only post the section of "PS/2 Generic
Mouse"):
I: Bus=3D0011 Vendor=3D0002 Product=3D0001 Version=3D0000
N: Name=3D"PS/2 Generic Mouse"
P: Phys=3Disa0060/serio4/input0
S: Sysfs=3D/devices/platform/i8042/serio4/input/input9
U: Uniq=3D
H: Handlers=3Dmouse1 event9
B: PROP=3D0
B: EV=3D7
B: KEY=3D70000 0 0 0 0
B: REL=3D3

Some related section in "/var/log/Xorg.0.log" is:

[    30.929] (II) config/udev: Adding input device PS/2 Generic Mouse
(/dev/input/event9)
[    30.929] (**) PS/2 Generic Mouse: Applying InputClass "evdev pointer
catchall"
[    30.929] (II) Using input driver 'evdev' for 'PS/2 Generic Mouse'
[    30.929] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so
[    30.929] (**) PS/2 Generic Mouse: always reports core events
[    30.929] (**) PS/2 Generic Mouse: Device: "/dev/input/event9"
[    30.929] (--) PS/2 Generic Mouse: Found 3 mouse buttons
[    30.929] (--) PS/2 Generic Mouse: Found relative axes
[    30.929] (--) PS/2 Generic Mouse: Found x and y relative axes
[    30.929] (II) PS/2 Generic Mouse: Configuring as mouse
[    30.929] (**) PS/2 Generic Mouse: YAxisMapping: buttons 4 and 5
[    30.929] (**) PS/2 Generic Mouse: EmulateWheelButton: 4,
EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[    30.929] (**) Option "config_info"
"udev:/sys/devices/platform/i8042/serio4/input/input9/event9"
[    30.929] (II) XINPUT: Adding extended input device "PS/2 Generic Mouse"
(type: MOUSE)
[    30.929] (II) PS/2 Generic Mouse: initialized for relative axes.
[    30.929] (**) PS/2 Generic Mouse: (accel) keeping acceleration scheme 1
[    30.929] (**) PS/2 Generic Mouse: (accel) acceleration profile 0
[    30.929] (**) PS/2 Generic Mouse: (accel) acceleration factor: 2.000
[    30.929] (**) PS/2 Generic Mouse: (accel) acceleration threshold: 4
[    30.930] (II) config/udev: Adding input device PS/2 Generic Mouse
(/dev/input/mouse1)

There is no touchpad or synaptics information in the "/var/log/Xorg.0.log"

I have tried too many methods found on internet, such as:

1, add "psmouse.proto=3Dimps(or exps)" into kernel parameters;

2, add file "etc/X11/xorg.d/10-synaptics.conf", the content as below:

Section "InputClass"
    Identifier      "touchpad catchall"
    Driver          "synaptics"
    MatchIsTouchpad "on"
    MatchDevicePath "/dev/input/event*"
    Option          "SHMConfig" "on"
    Option          "TapButton1" "1"
    Option          "TapButton2" "2"
    Option          "TapButton3" "3"
    Option          "VertTwoFingerScroll" "on"
    Option          "HorizTwoFingerScroll" "on"
EndSection

3, Thanks to the help of "How to disable Alps touchpad while typing or when
using an external mouse in Linux" at:
http://www.imega.cz/Linux-Alps-Touchpad-Dell-E6410/Linux-Alps-touchpad-disa=
ble.php
I resolved the problem of "disable touchpad on typing" by using a python
script, but I can't make edge scrolling work yet.

According to the advice of the page above, I downloaded linux-source-3.2,
and applied patch at " https://patchwork.kernel.org/patch/118834/ "), I
have not use cat *.patch | patch -p1, just copy the modified code into
linux-source-3.2 and recompile psmouse.ko. But no lucky, edge scrolling
can't work.

4, etc..

My DMI information:

me@debian:/sys/class/dmi/id$ for file in *; do if [ -f "$file" -a -r
"$file" ]; then echo $file: `cat $file` ; fi; done
bios_date: 10/27/2011
bios_vendor: LENOVO
bios_version: 61CN06WW
board_asset_tag:
board_name: LL1
board_vendor: Lenovo
board_version: Rev 1.0
chassis_asset_tag: No Asset Tag
chassis_type: 10
chassis_vendor: Lenovo
chassis_version: Rev 1.0
modalias:
dmi:bvnLENOVO:bvr61CN06WW:bd10/27/2011:svnLENOVO:pnG360:pvrRev1.0:rvnLenovo=
:rnLL1:rvrRev1.0:cvnLenovo:ct10:cvrRev1.0:
product_name: G360
product_version: Rev 1.0
sys_vendor: LENOVO
uevent:
MODALIAS=3Ddmi:bvnLENOVO:bvr61CN06WW:bd10/27/2011:svnLENOVO:pnG360:pvrRev1.=
0:rvnLenovo:rnLL1:rvrRev1.0:cvnLenovo:ct10:cvrRev1.0:

Tell me If need more detail information.

Thanks.

--20cf307d0386d2e6e204c40c5221
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

found 679750 linux-2.6/2.6.32-45 , linux-2.6/3.2.4-1 , linux/3.4.4-1<br>qui=
t<br><br>Hi,<br>Dear kernel developers.<br><br>According to the advice at &=
quot; <a href=3D"http://bugs.debian.org/679750">http://bugs.debian.org/6797=
50</a> &quot;, I report a kernel bug about ALPS touchpad to you.<br>
<br>My lenovo G360 has an ALPS touchpad, show in Windows 7 Home Editition<b=
r>OEM in this laptop. Under Debian Squeeze or Ubuntu 12.04 LTS LiveCD in sa=
me laptop, the left and<br>right key, single and double tap, tracking=C2=A0=
 of touchpad works well.<br>
But, there isn&#39;t touchpad tab in gnome mouse setting dialog, so I<br>ca=
n&#39;t setup edge scrolling and disable touchpad on typing. xinput<br>show=
s it is a &quot;PS/2 Generic Mouse&quot;. Below is the detail information.<=
br>
<br>System information:<br><br>Debian Squeeze, tried kernel: 2.6.32-45, 3.2=
.4-1~bpo60+1, 3.4.4-1~experimental.1<br>And tried Ubuntu 12.04 LTS LiveCD, =
kernel: 3.2 (has the same bug as in Debian)<br><br>The below information co=
me from Debian Squeeze with 3.2.4-1~bpo60+1 kernel. The other kerneld and s=
ytem tried above should has the same result.<br>
<br>&quot;synclient -l&quot; shows:<br><br>Couldn&#39;t find synaptics prop=
erties. No synaptics driver loaded?<br><br>&quot;xinput --list&quot; shows:=
<br><br>=C2=A0=E2=8E=A1 Virtual core pointer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 id=3D2=C2=A0=C2=A0=C2=A0 [master pointer=C2=A0=
 (3)]<br>
=E2=8E=9C=C2=A0=C2=A0 =E2=86=B3 Virtual core XTEST pointer=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 id=3D4=C2=A0=C2=A0=C2=A0 [slave=C2=A0 pointer=C2=A0 (2)]<br>=E2=
=8E=9C=C2=A0=C2=A0 =E2=86=B3=C2=A0 USB OPTICAL MOUSE=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 id=3D11=C2=A0=C2=A0=C2=A0=
 [slave=C2=A0 pointer=C2=A0 (2)]<br>=E2=8E=9C=C2=A0=C2=A0 =E2=86=B3 PS/2 Ge=
neric Mouse=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 id=3D14=C2=A0=C2=A0=C2=A0 [slave=C2=A0 pointer=C2=A0 (2)]<br>
=E2=8E=A3 Virtual core keyboard=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 id=3D3=C2=A0=C2=A0=C2=A0 [master keyboard (2)]<br>=C2=A0=C2=A0=
=C2=A0 =E2=86=B3 Virtual core XTEST keyboard=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 id=3D5=C2=A0=
=C2=A0=C2=A0 [slave=C2=A0 keyboard (3)]<br>=C2=A0=C2=A0=C2=A0 =E2=86=B3 Pow=
er Button=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 id=3D6=C2=A0=C2=A0=C2=A0 [slave=C2=
=A0 keyboard (3)]<br>
=C2=A0=C2=A0=C2=A0 =E2=86=B3 Video Bus=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 id=3D7=C2=A0=C2=A0=C2=A0 [slave=C2=A0 keyboard (3)]<br>=C2=
=A0=C2=A0=C2=A0 =E2=86=B3 Video Bus=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 id=3D8=C2=A0=C2=A0=C2=A0 [slave=C2=A0 keyboard (3)]<br>=C2=A0=
=C2=A0=C2=A0 =E2=86=B3 Power Button=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 id=3D9=
=C2=A0=C2=A0=C2=A0 [slave=C2=A0 keyboard (3)]<br>
=C2=A0=C2=A0=C2=A0 =E2=86=B3 Sleep Button=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 i=
d=3D10=C2=A0=C2=A0=C2=A0 [slave=C2=A0 keyboard (3)]<br>=C2=A0=C2=A0=C2=A0 =
=E2=86=B3 Lenovo EasyCamera=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 id=3D12=C2=A0=C2=A0=C2=A0 [slave=C2=A0 keyboar=
d (3)]<br>=C2=A0=C2=A0=C2=A0 =E2=86=B3 AT Translated Set 2 keyboard=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 id=3D13=C2=A0=C2=A0=C2=A0 [slave=C2=A0 keyboard (3)]<br>
=C2=A0=C2=A0=C2=A0 =E2=86=B3 Ideapad extra buttons=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 id=3D15=C2=A0=C2=A0=C2=A0 [slave=C2=A0 keyboar=
d (3)]<br>=C2=A0=C2=A0=C2=A0 =E2=86=B3 ACPI Virtual Keyboard Device=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 id=3D16=C2=A0=C2=A0=C2=A0 [slave=C2=A0 keyboard (3)]<br><br><br>&quo=
t;cat /proc/bus/input/devices&quot; shows (only post the section of &quot;P=
S/2 Generic<br>
Mouse&quot;):<br>I: Bus=3D0011 Vendor=3D0002 Product=3D0001 Version=3D0000<=
br>N: Name=3D&quot;PS/2 Generic Mouse&quot;<br>P: Phys=3Disa0060/serio4/inp=
ut0<br>S: Sysfs=3D/devices/platform/i8042/serio4/input/input9<br>U: Uniq=3D=
<br>H: Handlers=3Dmouse1 event9<br>
B: PROP=3D0<br>B: EV=3D7<br>B: KEY=3D70000 0 0 0 0<br>B: REL=3D3<br><br>Som=
e related section in &quot;/var/log/Xorg.0.log&quot; is:<br><br>[=C2=A0=C2=
=A0=C2=A0 30.929] (II) config/udev: Adding input device PS/2 Generic Mouse<=
br>(/dev/input/event9)<br>
[=C2=A0=C2=A0=C2=A0 30.929] (**) PS/2 Generic Mouse: Applying InputClass &q=
uot;evdev pointer<br>catchall&quot;<br>[=C2=A0=C2=A0=C2=A0 30.929] (II) Usi=
ng input driver &#39;evdev&#39; for &#39;PS/2 Generic Mouse&#39;<br>[=C2=A0=
=C2=A0=C2=A0 30.929] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so<=
br>
[=C2=A0=C2=A0=C2=A0 30.929] (**) PS/2 Generic Mouse: always reports core ev=
ents<br>[=C2=A0=C2=A0=C2=A0 30.929] (**) PS/2 Generic Mouse: Device: &quot;=
/dev/input/event9&quot;<br>[=C2=A0=C2=A0=C2=A0 30.929] (--) PS/2 Generic Mo=
use: Found 3 mouse buttons<br>[=C2=A0=C2=A0=C2=A0 30.929] (--) PS/2 Generic=
 Mouse: Found relative axes<br>
[=C2=A0=C2=A0=C2=A0 30.929] (--) PS/2 Generic Mouse: Found x and y relative=
 axes<br>[=C2=A0=C2=A0=C2=A0 30.929] (II) PS/2 Generic Mouse: Configuring a=
s mouse<br>[=C2=A0=C2=A0=C2=A0 30.929] (**) PS/2 Generic Mouse: YAxisMappin=
g: buttons 4 and 5<br>[=C2=A0=C2=A0=C2=A0 30.929] (**) PS/2 Generic Mouse: =
EmulateWheelButton: 4,<br>
EmulateWheelInertia: 10, EmulateWheelTimeout: 200<br>[=C2=A0=C2=A0=C2=A0 30=
.929] (**) Option &quot;config_info&quot;<br>&quot;udev:/sys/devices/platfo=
rm/i8042/serio4/input/input9/event9&quot;<br>[=C2=A0=C2=A0=C2=A0 30.929] (I=
I) XINPUT: Adding extended input device &quot;PS/2 Generic Mouse&quot;<br>
(type: MOUSE)<br>[=C2=A0=C2=A0=C2=A0 30.929] (II) PS/2 Generic Mouse: initi=
alized for relative axes.<br>[=C2=A0=C2=A0=C2=A0 30.929] (**) PS/2 Generic =
Mouse: (accel) keeping acceleration scheme 1<br>[=C2=A0=C2=A0=C2=A0 30.929]=
 (**) PS/2 Generic Mouse: (accel) acceleration profile 0<br>
[=C2=A0=C2=A0=C2=A0 30.929] (**) PS/2 Generic Mouse: (accel) acceleration f=
actor: 2.000<br>[=C2=A0=C2=A0=C2=A0 30.929] (**) PS/2 Generic Mouse: (accel=
) acceleration threshold: 4<br>[=C2=A0=C2=A0=C2=A0 30.930] (II) config/udev=
: Adding input device PS/2 Generic Mouse<br>
(/dev/input/mouse1)<br><br>There is no touchpad or synaptics information in=
 the &quot;/var/log/Xorg.0.log&quot;<br><br>I have tried too many methods f=
ound on internet, such as:<br><br>1, add &quot;psmouse.proto=3Dimps(or exps=
)&quot; into kernel parameters;<br>
<br>2, add file &quot;etc/X11/xorg.d/10-synaptics.conf&quot;, the content a=
s below:<br><br>Section &quot;InputClass&quot;<br>=C2=A0=C2=A0=C2=A0 Identi=
fier=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;touchpad catchall&quot;<br>=C2=A0=
=C2=A0=C2=A0 Driver=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &=
quot;synaptics&quot;<br>
=C2=A0=C2=A0=C2=A0 MatchIsTouchpad &quot;on&quot;<br>=C2=A0=C2=A0=C2=A0 Mat=
chDevicePath &quot;/dev/input/event*&quot;<br>=C2=A0=C2=A0=C2=A0 Option=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;SHMConfig&quot; &=
quot;on&quot;<br>=C2=A0=C2=A0=C2=A0 Option=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &quot;TapButton1&quot; &quot;1&quot;<br>=C2=A0=C2=A0=
=C2=A0 Option=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;T=
apButton2&quot; &quot;2&quot;<br>
=C2=A0=C2=A0=C2=A0 Option=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 &quot;TapButton3&quot; &quot;3&quot;<br>=C2=A0=C2=A0=C2=A0 Option=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;VertTwoFingerScro=
ll&quot; &quot;on&quot;<br>=C2=A0=C2=A0=C2=A0 Option=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;HorizTwoFingerScroll&quot; &quot;on=
&quot;<br>EndSection<br><br>3, Thanks to the help of &quot;How to disable A=
lps touchpad while typing or when using an external mouse in Linux&quot; at=
: <a href=3D"http://www.imega.cz/Linux-Alps-Touchpad-Dell-E6410/Linux-Alps-=
touchpad-disable.php">http://www.imega.cz/Linux-Alps-Touchpad-Dell-E6410/Li=
nux-Alps-touchpad-disable.php</a><br>
I resolved the problem of &quot;disable touchpad on typing&quot; by using a=
 python script, but I can&#39;t make edge scrolling work yet. <br><br>Accor=
ding to the advice of the page above, I downloaded linux-source-3.2, and ap=
plied patch at &quot; <a href=3D"https://patchwork.kernel.org/patch/118834/=
">https://patchwork.kernel.org/patch/118834/</a> &quot;), I have not use ca=
t *.patch | patch -p1, just copy the modified code into linux-source-3.2 an=
d recompile psmouse.ko. But no lucky, edge scrolling can&#39;t work.<br>
<br>4, etc..<br><br>My DMI information:<br><br>me@debian:/sys/class/dmi/id$=
 for file in *; do if [ -f &quot;$file&quot; -a -r<br>&quot;$file&quot; ]; =
then echo $file: `cat $file` ; fi; done<br>bios_date: 10/27/2011<br>bios_ve=
ndor: LENOVO<br>
bios_version: 61CN06WW<br>board_asset_tag:<br>board_name: LL1<br>board_vend=
or: Lenovo<br>board_version: Rev 1.0<br>chassis_asset_tag: No Asset Tag<br>=
chassis_type: 10<br>chassis_vendor: Lenovo<br>chassis_version: Rev 1.0<br>
modalias: dmi:bvnLENOVO:bvr61CN06WW:bd10/27/2011:svnLENOVO:pnG360:pvrRev1.0=
:rvnLenovo:rnLL1:rvrRev1.0:cvnLenovo:ct10:cvrRev1.0:<br>product_name: G360<=
br>product_version: Rev 1.0<br>sys_vendor: LENOVO<br>uevent: MODALIAS=3Ddmi=
:bvnLENOVO:bvr61CN06WW:bd10/27/2011:svnLENOVO:pnG360:pvrRev1.0:rvnLenovo:rn=
LL1:rvrRev1.0:cvnLenovo:ct10:cvrRev1.0:<br>
<br>Tell me If need more detail information.<br><br>Thanks.<br>

--20cf307d0386d2e6e204c40c5221--
