From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.29-rc0
Date: Tue, 6 Jan 2009 02:06:08 -0800
Message-ID: <200901060206.09310.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:50718 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZAFKGj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2009 05:06:39 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem.

Changelog:
---------

Adrian McMenamin (1):
      Input: add support for Maple controller as a joystick

Dmitry Torokhov (1):
      Input: libps2 - handle 0xfc responses from devices

Dominic Curran (1):
      Input: gpio-keys - add flag to allow auto repeat

Eric Miao (1):
      Input: add da9034 touchscreen support

Harvey Harrison (1):
      Input: ads7846 - strict_strtoul takes unsigned long

Helge Deller (1):
      Input: HIL drivers - add MODULE_ALIAS()

Jaya Kumar (1):
      Input: add support for Wacom W8001 penabled serial touchscreen

Jiri Kosina (1):
      Input: i8042 - add Dell Vostro 1510 to nomux list

John Linn (1):
      Input: xilinx_ps2 - various cleanups

Julia Lawall (1):
      Input: gtco - use USB endpoint API

Kay Sievers (1):
      Input: struct device - replace bus_id with dev_name(), dev_set_na=
me()

Kwangwoo Lee (1):
      Input: add tsc2007 based touchscreen driver

Matthew Garrett (1):
      Input: atkbd - broaden the Dell DMI signatures

Mike Frysinger (1):
      Input: map_to_7segment.h - convert to __inline__ for userspace

Nuno Lucas (1):
      Input: usbtouchscreen - fix TSC-10 DM USB controllers without EEP=
ROM

Ozan =C3=87a=C4=9Flayan (1):
      Input: i8042 - add Gigabyte M912 netbook to noloop exception tabl=
e

Paul Fox (1):
      Input: psmouse - add module parameters to control OLPC touchpad d=
elays

Peter Hutterer (1):
      Input: synaptics - report multi-taps only if supported by the dev=
ice

Peter Popovec (1):
      Input: add joystick driver for Walkera WK-0701 RC transmitter

Peter Ujfalusi (2):
      Input: omap-keypad - interrupt disable fix
      Input: omap-keypad - allow more than 6 rows

Philip Langdale (1):
      Input: refactor evdev 32bit compat to be shareable with uinput

Rikard Ljungstrand (1):
      Input: atkbd - add keyboard quirk for HP Pavilion ZV6100 laptop

Roel Kluin (1):
      Input: make some variables and functions static

Stelian Pop (1):
      Input: appletouch - driver refactoring

Stuart Hopkins (1):
      Input: atkbd - Samsung NC10 key repeat fix

Yong Yao (2):
      Input: add support for trackball on pxa930 and pxa935
      Input: add support for enhanced rotary controller on pxa930 and p=
xa935

Zoltan Devai (1):
      Input: pcspkr - fix PIT lockup on some chipsets


Diffstat:
--------

 Documentation/input/walkera0701.txt             |  109 +++++++
 arch/arm/mach-pxa/include/mach/pxa930_rotary.h  |   20 ++
 arch/arm/mach-pxa/include/mach/pxa930_trkball.h |   10 +
 drivers/input/Makefile                          |    2 +-
 drivers/input/evbug.c                           |    6 +-
 drivers/input/evdev.c                           |  199 +-----------
 drivers/input/gameport/gameport.c               |    3 +-
 drivers/input/gameport/ns558.c                  |    2 +-
 drivers/input/input-compat.c                    |  135 ++++++++
 drivers/input/input-compat.h                    |   94 ++++++
 drivers/input/input.c                           |    4 +-
 drivers/input/joydev.c                          |    2 +-
 drivers/input/joystick/Kconfig                  |   24 ++
 drivers/input/joystick/Makefile                 |    2 +
 drivers/input/joystick/maplecontrol.c           |  193 +++++++++++
 drivers/input/joystick/walkera0701.c            |  292 +++++++++++++++=
++
 drivers/input/keyboard/Kconfig                  |    9 +
 drivers/input/keyboard/Makefile                 |    1 +
 drivers/input/keyboard/atkbd.c                  |   60 ++++
 drivers/input/keyboard/gpio_keys.c              |    4 +
 drivers/input/keyboard/hil_kbd.c                |    1 +
 drivers/input/keyboard/omap-keypad.c            |    6 +-
 drivers/input/keyboard/pxa930_rotary.c          |  212 ++++++++++++
 drivers/input/misc/pcspkr.c                     |    4 +-
 drivers/input/misc/uinput.c                     |  172 +++++++++--
 drivers/input/mouse/Kconfig                     |    6 +
 drivers/input/mouse/Makefile                    |   27 +-
 drivers/input/mouse/appletouch.c                |  274 ++++++++-------=
-
 drivers/input/mouse/gpio_mouse.c                |    2 +-
 drivers/input/mouse/hgpk.c                      |   32 ++-
 drivers/input/mouse/hil_ptr.c                   |    2 +-
 drivers/input/mouse/pxa930_trkball.c            |  269 +++++++++++++++=
+
 drivers/input/mouse/synaptics.c                 |   16 +-
 drivers/input/mousedev.c                        |    3 +-
 drivers/input/serio/hil_mlc.c                   |    1 +
 drivers/input/serio/i8042-x86ia64io.h           |   15 +
 drivers/input/serio/libps2.c                    |   20 +-
 drivers/input/serio/pcips2.c                    |    2 +-
 drivers/input/serio/serio.c                     |    4 +-
 drivers/input/serio/xilinx_ps2.c                |  220 +++++++-------
 drivers/input/tablet/gtco.c                     |    2 +-
 drivers/input/tablet/wacom_wac.c                |    2 +-
 drivers/input/touchscreen/Kconfig               |   32 ++
 drivers/input/touchscreen/Makefile              |    3 +
 drivers/input/touchscreen/ads7846.c             |    6 +-
 drivers/input/touchscreen/da9034-ts.c           |  389 +++++++++++++++=
++++++++
 drivers/input/touchscreen/tsc2007.c             |  381 +++++++++++++++=
+++++++
 drivers/input/touchscreen/usbtouchscreen.c      |    5 +-
 drivers/input/touchscreen/wacom_w8001.c         |  325 +++++++++++++++=
++++
 include/linux/gpio_keys.h                       |    1 +
 include/linux/i2c/tsc2007.h                     |   17 +
 include/linux/libps2.h                          |    2 +
 include/linux/map_to_7segment.h                 |    2 +-
 include/linux/serio.h                           |    1 +
 54 files changed, 3105 insertions(+), 522 deletions(-)
 create mode 100644 Documentation/input/walkera0701.txt
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa930_rotary.h
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa930_trkball.h
 create mode 100644 drivers/input/input-compat.c
 create mode 100644 drivers/input/input-compat.h
 create mode 100644 drivers/input/joystick/maplecontrol.c
 create mode 100644 drivers/input/joystick/walkera0701.c
 create mode 100644 drivers/input/keyboard/pxa930_rotary.c
 create mode 100644 drivers/input/mouse/pxa930_trkball.c
 create mode 100644 drivers/input/touchscreen/da9034-ts.c
 create mode 100644 drivers/input/touchscreen/tsc2007.c
 create mode 100644 drivers/input/touchscreen/wacom_w8001.c
 create mode 100644 include/linux/i2c/tsc2007.h

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
