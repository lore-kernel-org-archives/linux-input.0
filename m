From: littlebat <dashing.meng@gmail.com>
Subject: Re: Bug#679750: Lenovo G360: ALPS Touchpad Recognized as
 "PS/2 Generic Mouse"
Date: Thu, 5 Jul 2012 16:00:37 +0800
Message-ID: <20120705160037.5d375e3b.dashing.meng@gmail.com>
References: <20120705113057.1341fe76.dashing.meng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53315 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab2GEHnL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jul 2012 03:43:11 -0400
Received: by pbbrp8 with SMTP id rp8so12377344pbb.19
        for <linux-input@vger.kernel.org>; Thu, 05 Jul 2012 00:43:11 -0700 (PDT)
In-Reply-To: <20120705113057.1341fe76.dashing.meng@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: seth.forshee@canonical.com, 679750@bugs.debian.org, jrnieder@gmail.com

Very sorry, I post the wrong "xinput --list" information, it's my Asus
EEEPC. Here's the correct "xinput --list" information of my Lenovo G360=
:

 =E2=8E=A1 Virtual core pointer                    	id=3D2	[master
pointer  (3)] =E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer
id=3D4	[slave  pointer  (2)] =E2=8E=9C   =E2=86=B3  USB OPTICAL
MOUSE                      	id=3D11	[slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 PS/2 Generic Mouse                      	id=3D14
[slave  pointer  (2)] =E2=8E=A3 Virtual core keyboard
id=3D3	[master keyboard (2)] =E2=86=B3 Virtual core XTEST
keyboard             	id=3D5	[slave  keyboard (3)] =E2=86=B3 Power
Button                            	id=3D6	[slave  keyboard
(3)] =E2=86=B3 Video Bus                               	id=3D7
[slave  keyboard (3)] =E2=86=B3 Video Bus
id=3D8	[slave  keyboard (3)] =E2=86=B3 Power
Button                            	id=3D9	[slave  keyboard
(3)] =E2=86=B3 Sleep Button                            	id=3D10
[slave  keyboard (3)] =E2=86=B3 Lenovo EasyCamera
id=3D12	[slave  keyboard (3)] =E2=86=B3 AT Translated Set 2
keyboard            	id=3D13	[slave  keyboard (3)] =E2=86=B3
Ideapad extra buttons                   	id=3D15	[slave
keyboard (3)] =E2=86=B3 ACPI Virtual Keyboard Device
id=3D16	[slave  keyboard (3)]

On Thu, 5 Jul 2012 11:30:57 +0800
littlebat <dashing.meng@gmail.com> wrote:

> found 679750 linux-2.6/2.6.32-45 , linux-2.6/3.2.4-1 , linux/3.4.4-1
> quit
>=20
> Because send by web gmail.com has html content so failed send to
> linux-input@vger.kernel.org at first time, so send again.
>=20
> Hi,
> Dear kernel developers.
>=20
> According to the advice at " http://bugs.debian.org/679750 ", I repor=
t
> a kernel bug about ALPS touchpad to you.
>=20
> My lenovo G360 has an ALPS touchpad, show in Windows 7 Home Editition
> OEM in this laptop. Under Debian Squeeze in same laptop, the left and
> right key, single and double tap, tracking  of touchpad works well.
> But, there isn't touchpad tab in gnome mouse setting dialog, so I
> can't setup edge scrolling and disable touchpad on typing. xinput
> shows it is a "PS/2 Generic Mouse". Below is the detail information.
>=20
> System information:
>=20
> Debian Squeeze, tried kernel: 2.6.32-45, 3.2.4-1~bpo60+1,
> 3.4.4-1~experimental.1 And tried Ubuntu 12.04 LTS LiveCD, kernel: 3.2
> (has the same bug as in Debian)
>=20
> "synclient -l" shows:
>=20
> Couldn't find synaptics properties. No synaptics driver loaded?
>=20
> "xinput --list" shows:
> =C3=A2=C2=8E=C2=A1 Virtual core pointer                    	id=3D2
> [master pointer  (3)] =C3=A2=C2=8E=C2=9C   =C3=A2=C2=86=C2=B3 Virtual=
 core XTEST pointer
> id=3D4	[slave  pointer  (2)] =C3=A2=C2=8E=C2=9C   =C3=A2=C2=86=C2=B3 =
USB
> Mouse                               	id=3D10	[slave
> pointer  (2)] =C3=A2=C2=8E=C2=9C   =C3=A2=C2=86=C2=B3 ETPS/2 Elantech=
 Touchpad
> id=3D14	[slave  pointer  (2)] =C3=A2=C2=8E=C2=A3 Virtual core
> keyboard                   	id=3D3	[master keyboard (2)]
> =C3=A2=C2=86=C2=B3 Virtual core XTEST keyboard             	id=3D5	[s=
lave
> keyboard (3)] =C3=A2=C2=86=C2=B3 Power Button
> id=3D6	[slave  keyboard (3)] =C3=A2=C2=86=C2=B3 Video
> Bus                               	id=3D7	[slave  keyboard
> (3)] =C3=A2=C2=86=C2=B3 Power Button                            	id=3D=
8
> [slave  keyboard (3)] =C3=A2=C2=86=C2=B3 Sleep Button
> id=3D9	[slave  keyboard (3)] =C3=A2=C2=86=C2=B3
> Digital_Camera                          	id=3D11	[slave
> keyboard (3)] =C3=A2=C2=86=C2=B3 Asus EeePC extra buttons
> id=3D12	[slave  keyboard (3)] =C3=A2=C2=86=C2=B3 AT Translated Set 2
> keyboard            	id=3D13	[slave  keyboard (3)] =C3=A2=C2=86=C2=B3
> ACPI Virtual Keyboard Device            	id=3D15	[slave
> keyboard (3)]
>=20

> "cat /proc/bus/input/devices" shows (only post the section of "PS/2
> Generic Mouse"):
> I: Bus=3D0011 Vendor=3D0002 Product=3D0001 Version=3D0000
> N: Name=3D"PS/2 Generic Mouse"
> P: Phys=3Disa0060/serio4/input0
> S: Sysfs=3D/devices/platform/i8042/serio4/input/input9
> U: Uniq=3D
> H: Handlers=3Dmouse1 event9
> B: PROP=3D0
> B: EV=3D7
> B: KEY=3D70000 0 0 0 0
> B: REL=3D3
>=20
> Some related section in "/var/log/Xorg.0.log" is:
>=20
> [    30.929] (II) config/udev: Adding input device PS/2 Generic Mouse
> (/dev/input/event9)
> [    30.929] (**) PS/2 Generic Mouse: Applying InputClass "evdev
> pointer catchall"
> [    30.929] (II) Using input driver 'evdev' for 'PS/2 Generic Mouse'
> [    30.929] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so
> [    30.929] (**) PS/2 Generic Mouse: always reports core events
> [    30.929] (**) PS/2 Generic Mouse: Device: "/dev/input/event9"
> [    30.929] (--) PS/2 Generic Mouse: Found 3 mouse buttons
> [    30.929] (--) PS/2 Generic Mouse: Found relative axes
> [    30.929] (--) PS/2 Generic Mouse: Found x and y relative axes
> [    30.929] (II) PS/2 Generic Mouse: Configuring as mouse
> [    30.929] (**) PS/2 Generic Mouse: YAxisMapping: buttons 4 and 5
> [    30.929] (**) PS/2 Generic Mouse: EmulateWheelButton: 4,
> EmulateWheelInertia: 10, EmulateWheelTimeout: 200
> [    30.929] (**) Option "config_info"
> "udev:/sys/devices/platform/i8042/serio4/input/input9/event9"
> [    30.929] (II) XINPUT: Adding extended input device "PS/2 Generic
> Mouse" (type: MOUSE)
> [    30.929] (II) PS/2 Generic Mouse: initialized for relative axes.
> [    30.929] (**) PS/2 Generic Mouse: (accel) keeping acceleration
> scheme 1 [    30.929] (**) PS/2 Generic Mouse: (accel) acceleration
> profile 0 [    30.929] (**) PS/2 Generic Mouse: (accel) acceleration
> factor: 2.000 [    30.929] (**) PS/2 Generic Mouse: (accel)
> acceleration threshold: 4 [    30.930] (II) config/udev: Adding input
> device PS/2 Generic Mouse (/dev/input/mouse1)
>=20
> There is no touchpad or synaptics information in the
> "/var/log/Xorg.0.log"
>=20
> I have tried too many methods found on internet, such as:
>=20
> 1, add "psmouse.proto=3Dimps(or exps)" into kernel parameters;
>=20
> 2, add file "etc/X11/xorg.d/10-synaptics.conf", the content as below:
>=20
> Section "InputClass"
>     Identifier      "touchpad catchall"
>     Driver          "synaptics"
>     MatchIsTouchpad "on"
>     MatchDevicePath "/dev/input/event*"
>     Option          "SHMConfig" "on"
>     Option          "TapButton1" "1"
>     Option          "TapButton2" "2"
>     Option          "TapButton3" "3"
>     Option          "VertTwoFingerScroll" "on"
>     Option          "HorizTwoFingerScroll" "on"
> EndSection
>=20
> 3, Thanks to the help of "How to disable Alps touchpad while typing o=
r
> when using an external mouse in Linux" at:
> http://www.imega.cz/Linux-Alps-Touchpad-Dell-E6410/Linux-Alps-touchpa=
d-disable.php
> I resolved the problem of "disable touchpad on typing" by using a
> python script, but I can't make edge scrolling work yet.=20
>=20
> According to the advice of the page above, I downloaded
> linux-source-3.2, and applied patch at "
> https://patchwork.kernel.org/patch/118834/ ": patch name:
> Resend-Add-support-for-Intellimouse-Mode-in-ALPS-touchpad-on-Dell-E2-=
series-Laptops.patch,
> see attachment), I have not use cat *.patch | patch -p1, just copy th=
e
> modified code into linux-source-3.2 and recompile psmouse.ko. But no
> lucky, edge scrolling can't work.
>=20
> My DMI information:
>=20
> me@debian:/sys/class/dmi/id$ for file in *; do if [ -f "$file" -a -r
> "$file" ]; then echo $file: `cat $file` ; fi; done
> bios_date: 10/27/2011
> bios_vendor: LENOVO
> bios_version: 61CN06WW
> board_asset_tag:
> board_name: LL1
> board_vendor: Lenovo
> board_version: Rev 1.0
> chassis_asset_tag: No Asset Tag
> chassis_type: 10
> chassis_vendor: Lenovo
> chassis_version: Rev 1.0
> modalias:
> dmi:bvnLENOVO:bvr61CN06WW:bd10/27/2011:svnLENOVO:pnG360:pvrRev1.0:rvn=
Lenovo:rnLL1:rvrRev1.0:cvnLenovo:ct10:cvrRev1.0:
> product_name: G360 product_version: Rev 1.0
> sys_vendor: LENOVO
> uevent:
> MODALIAS=3Ddmi:bvnLENOVO:bvr61CN06WW:bd10/27/2011:svnLENOVO:pnG360:pv=
rRev1.0:rvnLenovo:rnLL1:rvrRev1.0:cvnLenovo:ct10:cvrRev1.0:
>=20
> Tell me If need more detail information.
>=20
> Thanks.
>=20
>=20
>=20
> --=20
> To unsubscribe, send mail to 679750-unsubscribe@bugs.debian.org.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
