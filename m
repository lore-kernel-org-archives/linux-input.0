From: Daniel Heckenberg <linux-input@bogusfront.org>
Subject: Re: [Problem] Samsung 700T1C Elan USB Touchpad not detected as touchpad
Date: Sun, 20 Jul 2014 17:37:43 +1000
Message-ID: <CA+uZGHqqaRSUYLHJotMnZ9+b6o2+H=vS_CGKrdAhpZ6-+Spd7g@mail.gmail.com>
References: <CA+uZGHrv5BWjNOe5HZHg_i_8_-bnsLVMHd9w0ovwDkHO=RYZBA@mail.gmail.com>
	<CA+uZGHo-D=6pE9scYE=-u9ksWk91hjj1gr3ztUqNB6Xs=nQ+dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33440 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbaGTHho convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 03:37:44 -0400
Received: by mail-qg0-f43.google.com with SMTP id a108so4549719qge.30
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2014 00:37:43 -0700 (PDT)
In-Reply-To: <CA+uZGHo-D=6pE9scYE=-u9ksWk91hjj1gr3ztUqNB6Xs=nQ+dw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

And some info from X:

xinput -list
=E2=8E=A1 Virtual core pointer                        id=3D2    [master=
 pointer  (3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer                  id=3D=
4    [slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 Wacom ISDv4 EC Pen stylus                   id=3D=
9    [slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 Atmel Atmel maXTouch Digitizer              id=3D=
10    [slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 USB Keyboard+SmartPad                       id=3D=
13    [slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 Wacom ISDv4 EC Pen eraser                   id=3D=
16    [slave  pointer  (2)]
=E2=8E=A3 Virtual core keyboard                       id=3D3    [master=
 keyboard (2)]
    =E2=86=B3 Virtual core XTEST keyboard                 id=3D5    [sl=
ave  keyboard (3)]
    =E2=86=B3 Power Button                                id=3D6    [sl=
ave  keyboard (3)]
    =E2=86=B3 Video Bus                                   id=3D7    [sl=
ave  keyboard (3)]
    =E2=86=B3 Power Button                                id=3D8    [sl=
ave  keyboard (3)]
    =E2=86=B3 WebCam SC-50AFL11C54N                       id=3D11    [s=
lave  keyboard (3)]
    =E2=86=B3 USB Keyboard+SmartPad                       id=3D12    [s=
lave  keyboard (3)]
    =E2=86=B3 WebCam SC-20HDM12347N                       id=3D14    [s=
lave  keyboard (3)]
    =E2=86=B3 AT Translated Set 2 keyboard                id=3D15    [s=
lave  keyboard (3)]

xinput list-props 13
Device 'USB Keyboard+SmartPad':
    Device Enabled (135):    1
    Coordinate Transformation Matrix (137):    1.000000, 0.000000,
0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
    Device Accel Profile (256):    0
    Device Accel Constant Deceleration (257):    1.000000
    Device Accel Adaptive Deceleration (258):    1.000000
    Device Accel Velocity Scaling (259):    10.000000
    Device Product ID (252):    1267, 1856
    Device Node (253):    "/dev/input/event13"
    Evdev Axis Inversion (291):    0, 0
    Evdev Axes Swap (293):    0
    Axis Labels (294):    "Rel X" (145), "Rel Y" (146), "Rel Horiz
Wheel" (312), "Rel Dial" (313), "Rel Vert Wheel" (314)
    Button Labels (295):    "Button Left" (138), "Button Middle"
(139), "Button Right" (140), "Button Wheel Up" (141), "Button Wheel
Down" (142), "Button Horiz Wheel Left" (143), "Button Horiz Wheel
Right" (144), "Button Side" (310), "Button Extra" (311), "Button
Unknown" (283), "Button Unknown" (283), "Button Unknown" (283),
"Button Unknown" (283)
    Evdev Middle Button Emulation (296):    0
    Evdev Middle Button Timeout (297):    50
    Evdev Third Button Emulation (298):    0
    Evdev Third Button Emulation Timeout (299):    1000
    Evdev Third Button Emulation Button (300):    3
    Evdev Third Button Emulation Threshold (301):    20
    Evdev Wheel Emulation (302):    0
    Evdev Wheel Emulation Axes (303):    0, 0, 4, 5
    Evdev Wheel Emulation Inertia (304):    10
    Evdev Wheel Emulation Timeout (305):    200
    Evdev Wheel Emulation Button (306):    4
    Evdev Drag Lock Buttons (307):    0

cat /var/log/Xorg.0.log
[     4.564]
X.Org X Server 1.15.1
Release Date: 2014-04-13
[     4.564] X Protocol Version 11, Revision 0
[     4.564] Build Operating System: Linux 3.2.0-37-generic x86_64 Ubun=
tu
[     4.564] Current Operating System: Linux carbon-u
3.16.0-031600rc5-generic #201407131735 SMP Sun Jul 13 21:36:15 UTC
2014 x86_64
[     4.564] Kernel command line:
BOOT_IMAGE=3D/boot/vmlinuz-3.16.0-031600rc5-generic
root=3DUUID=3D7872ed11-61d6-461f-a463-c8c0f9ba0d2a ro quiet splash
vt.handoff=3D7
[     4.564] Build Date: 16 April 2014  01:36:29PM
[     4.564] xorg-server 2:1.15.1-0ubuntu2 (For technical support
please see http://www.ubuntu.com/support)
[     4.564] Current version of pixman: 0.30.2
[     4.564]     Before reporting problems, check http://wiki.x.org
    to make sure that you have the latest version.
[     4.564] Markers: (--) probed, (**) from config file, (=3D=3D) defa=
ult setting,
    (++) from command line, (!!) notice, (II) informational,
    (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[     4.564] (=3D=3D) Log file: "/var/log/Xorg.0.log", Time: Sun Jul 20
11:10:29 2014
[     4.565] (=3D=3D) Using system config directory "/usr/share/X11/xor=
g.conf.d"
[     4.571] (=3D=3D) No Layout section.  Using the first Screen sectio=
n.
[     4.571] (=3D=3D) No screen section available. Using defaults.
[     4.571] (**) |-->Screen "Default Screen Section" (0)
[     4.571] (**) |   |-->Monitor "<default monitor>"
[     4.571] (=3D=3D) No monitor specified for screen "Default Screen S=
ection".
    Using a default monitor configuration.
[     4.571] (=3D=3D) Automatically adding devices
[     4.571] (=3D=3D) Automatically enabling devices
[     4.571] (=3D=3D) Automatically adding GPU devices
[     4.571] (WW) The directory "/usr/share/fonts/X11/cyrillic" does no=
t exist.
[     4.571]     Entry deleted from font path.
[     4.571] (WW) The directory "/usr/share/fonts/X11/100dpi/" does not=
 exist.
[     4.571]     Entry deleted from font path.
[     4.571] (WW) The directory "/usr/share/fonts/X11/75dpi/" does not =
exist.
[     4.571]     Entry deleted from font path.
[     4.571] (WW) The directory "/usr/share/fonts/X11/100dpi" does not =
exist.
[     4.571]     Entry deleted from font path.
[     4.571] (WW) The directory "/usr/share/fonts/X11/75dpi" does not e=
xist.
[     4.571]     Entry deleted from font path.
[     4.572] (=3D=3D) FontPath set to:
    /usr/share/fonts/X11/misc,
    /usr/share/fonts/X11/Type1,
    built-ins
[     4.572] (=3D=3D) ModulePath set to
"/usr/lib/x86_64-linux-gnu/xorg/extra-modules,/usr/lib/xorg/extra-modul=
es,/usr/lib/xorg/modules"
[     4.572] (II) The server relies on udev to provide the list of
input devices.
    If no devices become available, reconfigure udev or disable AutoAdd=
Devices.
[     4.572] (II) Loader magic: 0x7f6a76fafd60
[     4.572] (II) Module ABI versions:
[     4.572]     X.Org ANSI C Emulation: 0.4
[     4.572]     X.Org Video Driver: 15.0
[     4.572]     X.Org XInput driver : 20.0
[     4.572]     X.Org Server Extension : 8.0
[     4.572] (II) xfree86: Adding drm device (/dev/dri/card0)
[     4.573] (--) PCI:*(0:0:2:0) 8086:0166:144d:c0e1 rev 9, Mem @
0xf7800000/4194304, 0xe0000000/268435456, I/O @ 0x0000f000/64
[     4.573] Initializing built-in extension Generic Event Extension
[     4.573] Initializing built-in extension SHAPE
[     4.573] Initializing built-in extension MIT-SHM
[     4.573] Initializing built-in extension XInputExtension
[     4.573] Initializing built-in extension XTEST
[     4.573] Initializing built-in extension BIG-REQUESTS
[     4.573] Initializing built-in extension SYNC
[     4.573] Initializing built-in extension XKEYBOARD
[     4.573] Initializing built-in extension XC-MISC
[     4.573] Initializing built-in extension SECURITY
[     4.573] Initializing built-in extension XINERAMA
[     4.573] Initializing built-in extension XFIXES
[     4.573] Initializing built-in extension RENDER
[     4.573] Initializing built-in extension RANDR
[     4.573] Initializing built-in extension COMPOSITE
[     4.573] Initializing built-in extension DAMAGE
[     4.573] Initializing built-in extension MIT-SCREEN-SAVER
[     4.573] Initializing built-in extension DOUBLE-BUFFER
[     4.573] Initializing built-in extension RECORD
[     4.573] Initializing built-in extension DPMS
[     4.574] Initializing built-in extension Present
[     4.574] Initializing built-in extension DRI3
[     4.574] Initializing built-in extension X-Resource
[     4.574] Initializing built-in extension XVideo
[     4.574] Initializing built-in extension XVideo-MotionCompensation
[     4.574] Initializing built-in extension SELinux
[     4.574] Initializing built-in extension XFree86-VidModeExtension
[     4.574] Initializing built-in extension XFree86-DGA
[     4.574] Initializing built-in extension XFree86-DRI
[     4.574] Initializing built-in extension DRI2
[     4.574] (II) LoadModule: "glx"
[     4.575] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[     4.585] (II) Module glx: vendor=3D"X.Org Foundation"
[     4.585]     compiled for 1.15.1, module version =3D 1.0.0
[     4.585]     ABI class: X.Org Server Extension, version 8.0
[     4.585] (=3D=3D) AIGLX enabled
[     4.585] Loading extension GLX
[     4.585] (=3D=3D) Matched intel as autoconfigured driver 0
[     4.585] (=3D=3D) Matched intel as autoconfigured driver 1
[     4.585] (=3D=3D) Matched modesetting as autoconfigured driver 2
[     4.585] (=3D=3D) Matched fbdev as autoconfigured driver 3
[     4.585] (=3D=3D) Matched vesa as autoconfigured driver 4
[     4.585] (=3D=3D) Assigned the driver to the xf86ConfigLayout
[     4.585] (II) LoadModule: "intel"
[     4.589] (II) Loading /usr/lib/xorg/modules/drivers/intel_drv.so
[     4.591] (II) Module intel: vendor=3D"X.Org Foundation"
[     4.591]     compiled for 1.15.0, module version =3D 2.99.910
[     4.592]     Module class: X.Org Video Driver
[     4.592]     ABI class: X.Org Video Driver, version 15.0
[     4.592] (II) LoadModule: "modesetting"
[     4.592] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv=
=2Eso
[     4.593] (II) Module modesetting: vendor=3D"X.Org Foundation"
[     4.593]     compiled for 1.15.0, module version =3D 0.8.1
[     4.593]     Module class: X.Org Video Driver
[     4.593]     ABI class: X.Org Video Driver, version 15.0
[     4.593] (II) LoadModule: "fbdev"
[     4.593] (II) Loading /usr/lib/xorg/modules/drivers/fbdev_drv.so
[     4.593] (II) Module fbdev: vendor=3D"X.Org Foundation"
[     4.593]     compiled for 1.15.0, module version =3D 0.4.4
[     4.593]     Module class: X.Org Video Driver
[     4.593]     ABI class: X.Org Video Driver, version 15.0
[     4.594] (II) LoadModule: "vesa"
[     4.594] (II) Loading /usr/lib/xorg/modules/drivers/vesa_drv.so
[     4.594] (II) Module vesa: vendor=3D"X.Org Foundation"
[     4.594]     compiled for 1.15.0, module version =3D 2.3.3
[     4.594]     Module class: X.Org Video Driver
[     4.594]     ABI class: X.Org Video Driver, version 15.0
[     4.594] (II) intel: Driver for Intel(R) Integrated Graphics Chipse=
ts:
    i810, i810-dc100, i810e, i815, i830M, 845G, 854, 852GM/855GM, 865G,
    915G, E7221 (i915), 915GM, 945G, 945GM, 945GME, Pineview GM,
    Pineview G, 965G, G35, 965Q, 946GZ, 965GM, 965GME/GLE, G33, Q35, Q3=
3,
    GM45, 4 Series, G45/G43, Q45/Q43, G41, B43
[     4.595] (II) intel: Driver for Intel(R) HD Graphics: 2000-5000
[     4.595] (II) intel: Driver for Intel(R) Iris(TM) Graphics: 5100
[     4.595] (II) intel: Driver for Intel(R) Iris(TM) Pro Graphics: 520=
0
[     4.595] (II) modesetting: Driver for Modesetting Kernel Drivers: k=
ms
[     4.595] (II) FBDEV: driver for framebuffer: fbdev
[     4.595] (II) VESA: driver for VESA chipsets: vesa
[     4.595] (++) using VT number 7

[     4.596] (II) intel(0): SNA compiled: xserver-xorg-video-intel
2:2.99.910-0ubuntu1 (Timo Aaltonen <tjaalton@ubuntu.com>)
[     4.596] (WW) Falling back to old probe method for modesetting
[     4.597] (WW) Falling back to old probe method for fbdev
[     4.597] (II) Loading sub module "fbdevhw"
[     4.597] (II) LoadModule: "fbdevhw"
[     4.597] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[     4.597] (II) Module fbdevhw: vendor=3D"X.Org Foundation"
[     4.597]     compiled for 1.15.1, module version =3D 0.0.2
[     4.597]     ABI class: X.Org Video Driver, version 15.0
[     4.597] (WW) Falling back to old probe method for vesa
[     4.598] (--) intel(0): Integrated Graphics Chipset: Intel(R) HD
Graphics 4000
[     4.598] (--) intel(0): CPU: x86-64, sse2, sse3, ssse3, sse4.1, sse=
4.2, avx
[     4.598] (II) intel(0): Creating default Display subsection in
Screen section
    "Default Screen Section" for depth/fbbpp 24/32
[     4.598] (=3D=3D) intel(0): Depth 24, (--) framebuffer bpp 32
[     4.598] (=3D=3D) intel(0): RGB weight 888
[     4.598] (=3D=3D) intel(0): Default visual is TrueColor
[     4.598] (**) intel(0): Framebuffer tiled
[     4.598] (**) intel(0): Pixmaps tiled
[     4.598] (**) intel(0): "Tear free" disabled
[     4.598] (**) intel(0): Forcing per-crtc-pixmaps? no
[     4.599] (II) intel(0): Output eDP1 has no monitor section
[     4.599] (--) intel(0): found backlight control interface
intel_backlight (type 'raw')
[     4.599] (II) intel(0): Output VGA1 has no monitor section
[     4.599] (II) intel(0): Output HDMI1 has no monitor section
[     4.599] (II) intel(0): Output DP1 has no monitor section
[     4.599] (II) intel(0): Output VIRTUAL1 has no monitor section
[     4.599] (--) intel(0): Output eDP1 using initial mode 1920x1080 on=
 pipe 2
[     4.599] (=3D=3D) intel(0): DPI set to (96, 96)
[     4.599] (II) Loading sub module "dri2"
[     4.599] (II) LoadModule: "dri2"
[     4.599] (II) Module "dri2" already built-in
[     4.599] (II) UnloadModule: "modesetting"
[     4.599] (II) Unloading modesetting
[     4.599] (II) UnloadModule: "fbdev"
[     4.599] (II) Unloading fbdev
[     4.599] (II) UnloadSubModule: "fbdevhw"
[     4.599] (II) Unloading fbdevhw
[     4.599] (II) UnloadModule: "vesa"
[     4.599] (II) Unloading vesa
[     4.599] (=3D=3D) Depth 24 pixmap format is 32 bpp
[     4.603] (II) intel(0): SNA initialized with Ivybridge (gen7, gt2) =
backend
[     4.603] (=3D=3D) intel(0): Backing store enabled
[     4.603] (=3D=3D) intel(0): Silken mouse enabled
[     4.604] (II) intel(0): HW Cursor enabled
[     4.604] (II) intel(0): RandR 1.2 enabled, ignore the following
RandR disabled message.
[     4.604] (=3D=3D) intel(0): DPMS enabled
[     4.604] (II) intel(0): [DRI2] Setup complete
[     4.604] (II) intel(0): [DRI2]   DRI driver: i965
[     4.604] (II) intel(0): [DRI2]   VDPAU driver: i965
[     4.604] (II) intel(0): direct rendering: DRI2 Enabled
[     4.604] (=3D=3D) intel(0): hotplug detection: "enabled"
[     4.604] (--) RandR disabled
[     4.610] (II) SELinux: Disabled on system
[     4.622] (II) AIGLX: enabled GLX_MESA_copy_sub_buffer
[     4.622] (II) AIGLX: enabled GLX_ARB_create_context
[     4.622] (II) AIGLX: enabled GLX_ARB_create_context_profile
[     4.622] (II) AIGLX: enabled GLX_EXT_create_context_es2_profile
[     4.622] (II) AIGLX: enabled GLX_INTEL_swap_event
[     4.622] (II) AIGLX: enabled GLX_SGI_swap_control and GLX_MESA_swap=
_control
[     4.622] (II) AIGLX: enabled GLX_EXT_framebuffer_sRGB
[     4.622] (II) AIGLX: enabled GLX_ARB_fbconfig_float
[     4.622] (II) AIGLX: GLX_EXT_texture_from_pixmap backed by buffer o=
bjects
[     4.622] (II) AIGLX: enabled GLX_ARB_create_context_robustness
[     4.622] (II) AIGLX: Loaded and initialized i965
[     4.622] (II) GLX: Initialized DRI2 GL provider for screen 0
[     4.625] (II) intel(0): switch to mode 1920x1080@60.0 on eDP1
using pipe 2, position (0, 0), rotation normal, reflection none
[     4.644] (II) intel(0): Setting screen physical size to 508 x 285
[     4.654] (II) XKB: reuse xkmfile
/var/lib/xkb/server-B20D7FC79C7F597315E3E501AEF10E0D866E8E92.xkm
[     4.656] (II) config/udev: Adding input device Power Button
(/dev/input/event2)
[     4.656] (**) Power Button: Applying InputClass "evdev keyboard cat=
chall"
[     4.656] (II) LoadModule: "evdev"
[     4.657] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so
[     4.657] (II) Module evdev: vendor=3D"X.Org Foundation"
[     4.657]     compiled for 1.15.0, module version =3D 2.8.2
[     4.657]     Module class: X.Org XInput Driver
[     4.657]     ABI class: X.Org XInput driver, version 20.0
[     4.657] (II) Using input driver 'evdev' for 'Power Button'
[     4.657] (**) Power Button: always reports core events
[     4.657] (**) evdev: Power Button: Device: "/dev/input/event2"
[     4.658] (--) evdev: Power Button: Vendor 0 Product 0x1
[     4.658] (--) evdev: Power Button: Found keys
[     4.658] (II) evdev: Power Button: Configuring as keyboard
[     4.658] (**) Option "config_info"
"udev:/sys/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2/event2"
[     4.658] (II) XINPUT: Adding extended input device "Power Button"
(type: KEYBOARD, id 6)
[     4.658] (**) Option "xkb_rules" "evdev"
[     4.658] (**) Option "xkb_model" "pc105"
[     4.658] (**) Option "xkb_layout" "us"
[     4.658] (II) config/udev: Adding input device Video Bus (/dev/inpu=
t/event7)
[     4.658] (**) Video Bus: Applying InputClass "evdev keyboard catcha=
ll"
[     4.658] (II) Using input driver 'evdev' for 'Video Bus'
[     4.658] (**) Video Bus: always reports core events
[     4.658] (**) evdev: Video Bus: Device: "/dev/input/event7"
[     4.658] (--) evdev: Video Bus: Vendor 0 Product 0x6
[     4.658] (--) evdev: Video Bus: Found keys
[     4.658] (II) evdev: Video Bus: Configuring as keyboard
[     4.658] (**) Option "config_info"
"udev:/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input=
/input8/event7"
[     4.658] (II) XINPUT: Adding extended input device "Video Bus"
(type: KEYBOARD, id 7)
[     4.658] (**) Option "xkb_rules" "evdev"
[     4.658] (**) Option "xkb_model" "pc105"
[     4.658] (**) Option "xkb_layout" "us"
[     4.658] (II) config/udev: Adding input device Power Button
(/dev/input/event1)
[     4.658] (**) Power Button: Applying InputClass "evdev keyboard cat=
chall"
[     4.658] (II) Using input driver 'evdev' for 'Power Button'
[     4.658] (**) Power Button: always reports core events
[     4.658] (**) evdev: Power Button: Device: "/dev/input/event1"
[     4.659] (--) evdev: Power Button: Vendor 0 Product 0x1
[     4.659] (--) evdev: Power Button: Found keys
[     4.659] (II) evdev: Power Button: Configuring as keyboard
[     4.659] (**) Option "config_info"
"udev:/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1/even=
t1"
[     4.659] (II) XINPUT: Adding extended input device "Power Button"
(type: KEYBOARD, id 8)
[     4.659] (**) Option "xkb_rules" "evdev"
[     4.659] (**) Option "xkb_model" "pc105"
[     4.659] (**) Option "xkb_layout" "us"
[     4.659] (II) config/udev: Adding input device Lid Switch
(/dev/input/event0)
[     4.659] (II) No input driver specified, ignoring this device.
[     4.659] (II) This device may have been added with another device f=
ile.
[     4.659] (II) config/udev: Adding drm device (/dev/dri/card0)
[     4.659] (II) config/udev: Ignoring already known drm device
(/dev/dri/card0)
[     4.659] (II) config/udev: Adding input device Wacom ISDv4 EC Pen
(/dev/input/event11)
[     4.659] (**) Wacom ISDv4 EC Pen: Applying InputClass "evdev
tablet catchall"
[     4.659] (**) Wacom ISDv4 EC Pen: Applying InputClass "Wacom class"
[     4.659] (II) LoadModule: "wacom"
[     4.660] (II) Loading /usr/lib/xorg/modules/input/wacom_drv.so
[     4.660] (II) Module wacom: vendor=3D"X.Org Foundation"
[     4.660]     compiled for 1.15.0, module version =3D 0.23.0
[     4.660]     Module class: X.Org XInput Driver
[     4.660]     ABI class: X.Org XInput driver, version 20.0
[     4.660] (II) wacom: Driver for Wacom graphics tablets:
PenPartner, Graphire,
    Graphire2 4x5, Graphire2 5x7, Graphire3 4x5, Graphire3 6x8,
    Graphire4 4x5, Graphire4 6x8, BambooFun 4x5, BambooFun 6x8,
    Bamboo1 Medium, Graphire4 6x8 BlueTooth, CTL-460, CTH-461, CTL-660,
    CTL-461/S, Bamboo Touch, CTH-460/K, CTH-461/S, CTH-661/S1, CTH-461/=
L,
    CTH-661/L, Intuos 4x5, Intuos 6x8, Intuos 9x12, Intuos 12x12,
    Intuos 12x18, PTU600, PL400, PL500, PL600, PL600SX, PL550, PL800,
    PL700, PL510, PL710, DTI520, DTF720, DTF720a, DTF521, DTU1931,
    DTU2231, DTU1631, Intuos2 4x5, Intuos2 6x8, Intuos2 9x12,
    Intuos2 12x12, Intuos2 12x18, Intuos2 6x8 , Volito, PenStation,
    Volito2 4x5, Volito2 2x3, PenPartner2, Bamboo, Bamboo1, Bamboo1 4x6=
,
    Bamboo1 5x8, Intuos3 4x5, Intuos3 6x8, Intuos3 9x12, Intuos3 12x12,
    Intuos3 12x19, Intuos3 6x11, Intuos3 4x6, Intuos4 4x6, Intuos4 6x9,
    Intuos4 8x13, Intuos4 12x19, Intuos4 WL USB Endpoint,
    Intuos4 WL Bluetooth Endpoint, Intuos5 touch S, Intuos5 touch M,
    Intuos5 touch L, Intuos5 S, Intuos5 M, Intuos Pro S, Intuos Pro M,
    Intuos Pro L, Cintiq 21UX, Cintiq 20WSX, Cintiq 12WX, Cintiq 21UX2,
    Cintiq 24HD, Cintiq 22HD, Cintiq 24HD touch (EMR digitizer),
    Cintiq 13HD, DTK2241, DTH2242, Cintiq 22HDT, TabletPC 0x90,
    TabletPC 0x93, TabletPC 0x97, TabletPC 0x9A, CapPlus  0x9F,
    TabletPC 0xE2, TabletPC 0xE3, TabletPC 0xE5, TabletPC 0xE6,
    TabletPC 0xEC, TabletPC 0xED, TabletPC 0xEF, TabletPC 0x100,
    TabletPC 0x101, TabletPC 0x10D, TabletPC 0x4001, usb:172f:0024,
    usb:172f:0025, usb:172f:0026, usb:172f:0027, usb:172f:0028,
    usb:172f:0030, usb:172f:0031, usb:172f:0032, usb:172f:0033,
    usb:172f:0034, usb:172f:0035, usb:172f:0036, usb:172f:0037,
    usb:172f:0038, usb:172f:0039, usb:172f:0051, usb:172f:0052,
    usb:172f:0053, usb:172f:0054, usb:172f:0055, usb:172f:0056,
    usb:172f:0057, usb:172f:0058, usb:172f:0500, usb:172f:0501,
    usb:172f:0502, usb:172f:0503, usb:1b96:0001, usb:17ef:6004
[     4.661] (II) Using input driver 'wacom' for 'Wacom ISDv4 EC Pen'
[     4.661] (**) Wacom ISDv4 EC Pen: always reports core events
[     4.661] (**) Option "Device" "/dev/input/event11"
[     4.662] (II) Wacom ISDv4 EC Pen: type not specified, assuming 'sty=
lus'.
[     4.662] (II) Wacom ISDv4 EC Pen: other types will be automatically=
 added.
[     4.662] (--) Wacom ISDv4 EC Pen stylus: using pressure threshold
of 27 for button 1
[     4.662] (--) Wacom ISDv4 EC Pen stylus: Wacom USB TabletPC tablet
maxX=3D25632 maxY=3D14418 maxZ=3D1023 resX=3D99000 resY=3D99000  tilt=3D=
disabled
[     4.662] (II) Wacom ISDv4 EC Pen stylus: hotplugging dependent devi=
ces.
[     4.662] (EE) Wacom ISDv4 EC Pen stylus: Invalid type 'cursor' for
this device.
[     4.662] (EE) Wacom ISDv4 EC Pen stylus: Invalid type 'touch' for
this device.
[     4.662] (EE) Wacom ISDv4 EC Pen stylus: Invalid type 'pad' for thi=
s device.
[     4.662] (II) Wacom ISDv4 EC Pen stylus: hotplugging completed.
[     4.680] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3.2/3-3.2:1.0/inp=
ut/input12/event11"
[     4.680] (II) XINPUT: Adding extended input device "Wacom ISDv4 EC
Pen stylus" (type: STYLUS, id 9)
[     4.680] (**) Wacom ISDv4 EC Pen stylus: (accel) keeping
acceleration scheme 1
[     4.680] (**) Wacom ISDv4 EC Pen stylus: (accel) acceleration profi=
le 0
[     4.680] (**) Wacom ISDv4 EC Pen stylus: (accel) acceleration facto=
r: 2.000
[     4.680] (**) Wacom ISDv4 EC Pen stylus: (accel) acceleration thres=
hold: 4
[     4.680] (II) config/udev: Adding input device Wacom ISDv4 EC Pen
(/dev/input/mouse1)
[     4.680] (II) No input driver specified, ignoring this device.
[     4.681] (II) This device may have been added with another device f=
ile.
[     4.681] (II) config/udev: Adding input device Atmel Atmel
maXTouch Digitizer (/dev/input/event4)
[     4.681] (**) Atmel Atmel maXTouch Digitizer: Applying InputClass
"evdev touchscreen catchall"
[     4.681] (II) Using input driver 'evdev' for 'Atmel Atmel maXTouch
Digitizer'
[     4.681] (**) Atmel Atmel maXTouch Digitizer: always reports core e=
vents
[     4.681] (**) evdev: Atmel Atmel maXTouch Digitizer: Device:
"/dev/input/event4"
[     4.681] (II) evdev: Atmel Atmel maXTouch Digitizer: Using mtdev
for this device
[     4.681] (--) evdev: Atmel Atmel maXTouch Digitizer: Vendor 0x3eb
Product 0x8411
[     4.681] (--) evdev: Atmel Atmel maXTouch Digitizer: Found absolute=
 axes
[     4.681] (--) evdev: Atmel Atmel maXTouch Digitizer: Found
absolute multitouch axes
[     4.681] (II) evdev: Atmel Atmel maXTouch Digitizer: No buttons
found, faking one.
[     4.681] (--) evdev: Atmel Atmel maXTouch Digitizer: Found x and y
absolute axes
[     4.681] (--) evdev: Atmel Atmel maXTouch Digitizer: Found
absolute touchscreen
[     4.681] (II) evdev: Atmel Atmel maXTouch Digitizer: Configuring
as touchscreen
[     4.681] (**) evdev: Atmel Atmel maXTouch Digitizer: YAxisMapping:
buttons 4 and 5
[     4.681] (**) evdev: Atmel Atmel maXTouch Digitizer:
EmulateWheelButton: 4, EmulateWheelInertia: 10, EmulateWheelTimeout:
200
[     4.681] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:14.0/usb3/3-4/3-4:1.0/0003:03EB:8=
411.0002/input/input4/event4"
[     4.681] (II) XINPUT: Adding extended input device "Atmel Atmel
maXTouch Digitizer" (type: TOUCHSCREEN, id 10)
[     4.681] (II) evdev: Atmel Atmel maXTouch Digitizer: initialized
for absolute axes.
[     4.681] (**) Atmel Atmel maXTouch Digitizer: (accel) keeping
acceleration scheme 1
[     4.681] (**) Atmel Atmel maXTouch Digitizer: (accel) acceleration =
profile 0
[     4.681] (**) Atmel Atmel maXTouch Digitizer: (accel) acceleration
factor: 2.000
[     4.681] (**) Atmel Atmel maXTouch Digitizer: (accel) acceleration
threshold: 4
[     4.681] (II) config/udev: Adding input device Atmel Atmel
maXTouch Digitizer (/dev/input/mouse0)
[     4.681] (II) No input driver specified, ignoring this device.
[     4.681] (II) This device may have been added with another device f=
ile.
[     4.682] (II) config/udev: Adding input device WebCam
SC-50AFL11C54N (/dev/input/event5)
[     4.682] (**) WebCam SC-50AFL11C54N: Applying InputClass "evdev
keyboard catchall"
[     4.682] (II) Using input driver 'evdev' for 'WebCam SC-50AFL11C54N=
'
[     4.682] (**) WebCam SC-50AFL11C54N: always reports core events
[     4.682] (**) evdev: WebCam SC-50AFL11C54N: Device: "/dev/input/eve=
nt5"
[     4.682] (--) evdev: WebCam SC-50AFL11C54N: Vendor 0x2232 Product 0=
x1034
[     4.682] (--) evdev: WebCam SC-50AFL11C54N: Found keys
[     4.682] (II) evdev: WebCam SC-50AFL11C54N: Configuring as keyboard
[     4.682] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/inp=
ut/input6/event5"
[     4.682] (II) XINPUT: Adding extended input device "WebCam
SC-50AFL11C54N" (type: KEYBOARD, id 11)
[     4.682] (**) Option "xkb_rules" "evdev"
[     4.682] (**) Option "xkb_model" "pc105"
[     4.682] (**) Option "xkb_layout" "us"
[     4.682] (II) config/udev: Adding input device USB
Keyboard+SmartPad (/dev/input/event12)
[     4.682] (**) USB Keyboard+SmartPad: Applying InputClass "evdev
keyboard catchall"
[     4.682] (II) Using input driver 'evdev' for 'USB Keyboard+SmartPad=
'
[     4.682] (**) USB Keyboard+SmartPad: always reports core events
[     4.682] (**) evdev: USB Keyboard+SmartPad: Device: "/dev/input/eve=
nt12"
[     4.682] (--) evdev: USB Keyboard+SmartPad: Vendor 0x4f3 Product 0x=
740
[     4.682] (--) evdev: USB Keyboard+SmartPad: Found keys
[     4.682] (II) evdev: USB Keyboard+SmartPad: Configuring as keyboard
[     4.682] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3.1/1-1.3=
=2E1:1.0/0003:04F3:0740.0004/input/input13/event12"
[     4.682] (II) XINPUT: Adding extended input device "USB
Keyboard+SmartPad" (type: KEYBOARD, id 12)
[     4.682] (**) Option "xkb_rules" "evdev"
[     4.682] (**) Option "xkb_model" "pc105"
[     4.682] (**) Option "xkb_layout" "us"
[     4.683] (II) config/udev: Adding input device USB
Keyboard+SmartPad (/dev/input/event13)
[     4.683] (**) USB Keyboard+SmartPad: Applying InputClass "evdev
pointer catchall"
[     4.683] (**) USB Keyboard+SmartPad: Applying InputClass "evdev
keyboard catchall"
[     4.683] (II) Using input driver 'evdev' for 'USB Keyboard+SmartPad=
'
[     4.683] (**) USB Keyboard+SmartPad: always reports core events
[     4.683] (**) evdev: USB Keyboard+SmartPad: Device: "/dev/input/eve=
nt13"
[     4.683] (II) evdev: USB Keyboard+SmartPad: Using mtdev for this de=
vice
[     4.683] (--) evdev: USB Keyboard+SmartPad: Vendor 0x4f3 Product 0x=
740
[     4.683] (--) evdev: USB Keyboard+SmartPad: Found 9 mouse buttons
[     4.683] (--) evdev: USB Keyboard+SmartPad: Found scroll wheel(s)
[     4.683] (--) evdev: USB Keyboard+SmartPad: Found relative axes
[     4.683] (--) evdev: USB Keyboard+SmartPad: Found x and y relative =
axes
[     4.683] (--) evdev: USB Keyboard+SmartPad: Found absolute axes
[     4.683] (--) evdev: USB Keyboard+SmartPad: Found absolute multitou=
ch axes
[     4.683] (--) evdev: USB Keyboard+SmartPad: Found keys
[     4.683] (II) evdev: USB Keyboard+SmartPad: Configuring as mouse
[     4.683] (II) evdev: USB Keyboard+SmartPad: Configuring as keyboard
[     4.683] (II) evdev: USB Keyboard+SmartPad: Adding scrollwheel supp=
ort
[     4.683] (**) evdev: USB Keyboard+SmartPad: YAxisMapping: buttons 4=
 and 5
[     4.683] (**) evdev: USB Keyboard+SmartPad: EmulateWheelButton: 4,
EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[     4.683] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3.1/1-1.3=
=2E1:1.1/0003:04F3:0740.0005/input/input14/event13"
[     4.683] (II) XINPUT: Adding extended input device "USB
Keyboard+SmartPad" (type: KEYBOARD, id 13)
[     4.683] (**) Option "xkb_rules" "evdev"
[     4.683] (**) Option "xkb_model" "pc105"
[     4.683] (**) Option "xkb_layout" "us"
[     4.683] (II) evdev: USB Keyboard+SmartPad: initialized for relativ=
e axes.
[     4.683] (WW) evdev: USB Keyboard+SmartPad: ignoring absolute axes.
[     4.683] (**) USB Keyboard+SmartPad: (accel) keeping acceleration s=
cheme 1
[     4.683] (**) USB Keyboard+SmartPad: (accel) acceleration profile 0
[     4.683] (**) USB Keyboard+SmartPad: (accel) acceleration factor: 2=
=2E000
[     4.683] (**) USB Keyboard+SmartPad: (accel) acceleration threshold=
: 4
[     4.684] (II) config/udev: Adding input device USB
Keyboard+SmartPad (/dev/input/mouse2)
[     4.684] (II) No input driver specified, ignoring this device.
[     4.684] (II) This device may have been added with another device f=
ile.
[     4.684] (II) config/udev: Adding input device WebCam
SC-20HDM12347N (/dev/input/event6)
[     4.684] (**) WebCam SC-20HDM12347N: Applying InputClass "evdev
keyboard catchall"
[     4.684] (II) Using input driver 'evdev' for 'WebCam SC-20HDM12347N=
'
[     4.684] (**) WebCam SC-20HDM12347N: always reports core events
[     4.684] (**) evdev: WebCam SC-20HDM12347N: Device: "/dev/input/eve=
nt6"
[     4.684] (--) evdev: WebCam SC-20HDM12347N: Vendor 0x2232 Product 0=
x1036
[     4.684] (--) evdev: WebCam SC-20HDM12347N: Found keys
[     4.684] (II) evdev: WebCam SC-20HDM12347N: Configuring as keyboard
[     4.684] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/inp=
ut/input7/event6"
[     4.684] (II) XINPUT: Adding extended input device "WebCam
SC-20HDM12347N" (type: KEYBOARD, id 14)
[     4.684] (**) Option "xkb_rules" "evdev"
[     4.684] (**) Option "xkb_model" "pc105"
[     4.684] (**) Option "xkb_layout" "us"
[     4.684] (II) config/udev: Adding input device HDA Intel PCH
Headphone (/dev/input/event9)
[     4.684] (II) No input driver specified, ignoring this device.
[     4.684] (II) This device may have been added with another device f=
ile.
[     4.685] (II) config/udev: Adding input device HDA Intel PCH
HDMI/DP,pcm=3D3 (/dev/input/event10)
[     4.685] (II) No input driver specified, ignoring this device.
[     4.685] (II) This device may have been added with another device f=
ile.
[     4.685] (II) config/udev: Adding input device HDA Intel PCH Mic
(/dev/input/event8)
[     4.685] (II) No input driver specified, ignoring this device.
[     4.685] (II) This device may have been added with another device f=
ile.
[     4.685] (II) config/udev: Adding input device AT Translated Set 2
keyboard (/dev/input/event3)
[     4.685] (**) AT Translated Set 2 keyboard: Applying InputClass
"evdev keyboard catchall"
[     4.685] (II) Using input driver 'evdev' for 'AT Translated Set 2 k=
eyboard'
[     4.685] (**) AT Translated Set 2 keyboard: always reports core eve=
nts
[     4.685] (**) evdev: AT Translated Set 2 keyboard: Device:
"/dev/input/event3"
[     4.685] (--) evdev: AT Translated Set 2 keyboard: Vendor 0x1 Produ=
ct 0x1
[     4.685] (--) evdev: AT Translated Set 2 keyboard: Found keys
[     4.685] (II) evdev: AT Translated Set 2 keyboard: Configuring as k=
eyboard
[     4.685] (**) Option "config_info"
"udev:/sys/devices/platform/i8042/serio0/input/input3/event3"
[     4.685] (II) XINPUT: Adding extended input device "AT Translated
Set 2 keyboard" (type: KEYBOARD, id 15)
[     4.685] (**) Option "xkb_rules" "evdev"
[     4.685] (**) Option "xkb_model" "pc105"
[     4.685] (**) Option "xkb_layout" "us"
[     4.689] (**) Wacom ISDv4 EC Pen eraser: Applying InputClass
"evdev tablet catchall"
[     4.689] (**) Wacom ISDv4 EC Pen eraser: Applying InputClass "Wacom=
 class"
[     4.689] (II) Using input driver 'wacom' for 'Wacom ISDv4 EC Pen er=
aser'
[     4.689] (**) Wacom ISDv4 EC Pen eraser: always reports core events
[     4.689] (**) Option "Device" "/dev/input/event11"
[     4.689] (**) Option "Type" "eraser"
[     4.689] (--) Wacom ISDv4 EC Pen eraser: Wacom USB TabletPC tablet
maxX=3D25632 maxY=3D14418 maxZ=3D1023 resX=3D99000 resY=3D99000  tilt=3D=
disabled
[     4.696] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:14.0/usb3/3-3/3-3.2/3-3.2:1.0/inp=
ut/input12/event11"
[     4.696] (II) XINPUT: Adding extended input device "Wacom ISDv4 EC
Pen eraser" (type: ERASER, id 16)
[     4.696] (**) Wacom ISDv4 EC Pen eraser: (accel) keeping
acceleration scheme 1
[     4.696] (**) Wacom ISDv4 EC Pen eraser: (accel) acceleration profi=
le 0
[     4.696] (**) Wacom ISDv4 EC Pen eraser: (accel) acceleration facto=
r: 2.000
[     4.696] (**) Wacom ISDv4 EC Pen eraser: (accel) acceleration thres=
hold: 4
[     5.553] (II) intel(0): EDID vendor "AUO", prod id 12637
[     5.553] (II) intel(0): Printing DDC gathered Modelines:
[     5.553] (II) intel(0): Modeline "1920x1080"x0.0  141.41  1920
1978 2020 2108  1080 1088 1102 1118 -hsync -vsync (67.1 kHz eP)
[     6.096] (II) intel(0): switch to mode 1920x1080@60.0 on eDP1
using pipe 0, position (0, 0), rotation normal, reflection none
[    12.663] (II) XKB: reuse xkmfile
/var/lib/xkb/server-B20D7FC79C7F597315E3E501AEF10E0D866E8E92.xkm
[    12.936] (II) XKB: reuse xkmfile
/var/lib/xkb/server-B20D7FC79C7F597315E3E501AEF10E0D866E8E92.xkm
[    12.981] (II) XKB: reuse xkmfile
/var/lib/xkb/server-B20D7FC79C7F597315E3E501AEF10E0D866E8E92.xkm
[    14.082] (II) XKB: reuse xkmfile
/var/lib/xkb/server-34CEB476A3CB596DA76FD7010A029F76732EF824.xkm

cat /var/log/Xorg.0.log [excerpt when forcing synaptics driver]
[ 10517.611] (II) LoadModule: "synaptics"
[ 10517.611] (II) Loading /usr/lib/xorg/modules/input/synaptics_drv.so
[ 10517.611] (II) Module synaptics: vendor=3D"X.Org Foundation"
[ 10517.611] compiled for 1.15.0, module version =3D 1.7.4
[ 10517.611] Module class: X.Org XInput Driver
[ 10517.611] ABI class: X.Org XInput driver, version 20.0
[ 10517.611] (II) Using input driver 'synaptics' for 'USB Keyboard+Smar=
tPad'
[ 10517.611] (**) USB Keyboard+SmartPad: always reports core events
[ 10517.611] (**) Option "Protocol" "event"
[ 10517.611] (**) Option "Device" "/dev/input/event13"
[ 10517.611] (--) synaptics: USB Keyboard+SmartPad: Vendor 0x4f3 Produc=
t 0x740
[ 10517.611] (--) synaptics: USB Keyboard+SmartPad: invalid x-axis
range. defaulting to 1615 - 5685
[ 10517.611] (--) synaptics: USB Keyboard+SmartPad: invalid y-axis
range. defaulting to 1729 - 4171
[ 10517.611] (--) synaptics: USB Keyboard+SmartPad: invalid pressure
range. defaulting to 0 - 255
[ 10517.611] (--) synaptics: USB Keyboard+SmartPad: invalid finger
width range. defaulting to 0 - 15
[ 10517.611] (--) synaptics: USB Keyboard+SmartPad: no supported touchp=
ad found
[ 10517.611] (EE) synaptics: USB Keyboard+SmartPad: Unable to
query/initialize Synaptics hardware.
[ 10517.620] (EE) PreInit returned 11 for "USB Keyboard+SmartPad"
[ 10517.620] (II) UnloadModule: "synaptics"
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
