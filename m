From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.28-rc0 (part I)
Date: Thu, 16 Oct 2008 00:08:50 -0400
Message-ID: <20081016040850.GB16860@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:20903 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbYJPEIy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Oct 2008 00:08:54 -0400
Received: by yx-out-2324.google.com with SMTP id 8so689829yxm.1
        for <linux-input@vger.kernel.org>; Wed, 15 Oct 2008 21:08:53 -0700 (PDT)
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

Alfred E. Heggestad (1):
      Input: add driver for USB VoIP phones with CM109 chipset

Andres Salomon (4):
      Input: psmouse - export psmouse_set_state for ps/2 extensions to =
use
      Input: psmouse - add psmouse_queue_work() for ps/2 extension to m=
ake use of
      Input: psmouse - tweak PSMOUSE_DEFINE_ATTR to support raw set cal=
lbacks
      Input: psmouse - add OLPC touchpad driver

Aristeu Rozanski (1):
      Input: add keycodes for remote controls/phone keypads

Atsushi Nemoto (1):
      Input: move map_to_7segment.h to include/linux

Colin B Macdonald (1):
      Input: i8042 - add Thinkpad R31 to nomux list

Dan Liang (1):
      Input: atmel_tsadcc - improve accuracy

Daniel Gimpelevich (1):
      Input: cm109 - add missing newlines to messages

Dmitry Torokhov (6):
      Input: gameport - make gameport_register_driver() return errors
      Input: gameport - check return value of gameport_register_driver(=
)
      Input: gameport - mark gameport_register_driver() __must_check
      Input: expand keycode space
      Input: keyboard - fix potential out of bound access to key_map
      Input: ads7846 - fix cache line sharing issue

Elvis Pranskevichus (1):
      Input: ALPS - add signature for DualPoint found in Dell Latitude =
E6500

Eric Miao (1):
      Input: ads7846 - introduce .gpio_pendown to get pendown state

Jiri Kosina (1):
      Input: document i8042.debug in kernel-parameters.txt

Joe Rouvier (1):
      Input: convert drivers to use strict_strtoul()

Liam Girdwood (1):
      Input: wm97xx - update email address for Liam Girdwood

Matthew Garrett (1):
      Input: atkbd - expand Latitude's force release quirk to other Del=
ls

Michael Hennerich (1):
      Input: bf54x-keys - add power management support

Niels de Vos (1):
      Input: serio_raw - allow attaching to translated (SERIO_I8042XL) =
ports

Remi Herilier (1):
      Input: wistron - add support for Fujitsu-Siemens Amilo Pro v3505

Stephen Rothwell (1):
      Input: cm109 - don't use obsolete logging macros

Sven Anders (2):
      Input: appletouch - prepare for geyser 3/4 handling
      Input: appletouch - handle geyser 3/4 status bits

Uwe Kleine-K=F6nig (2):
      Input: gpio-keys - optimize interrupt handler
      Input: gpio-keys - simplify argument list for report_event

Ville Syrjala (2):
      Input: ati_remote2 - add loadable keymap support
      Input: ati_remote2 - add autosuspend support


Diffstat:
--------

 Documentation/kernel-parameters.txt                |    1 +
 MAINTAINERS                                        |    2 +-
 drivers/char/keyboard.c                            |    2 +-
 drivers/input/gameport/gameport.c                  |   88 ++-
 drivers/input/joystick/a3d.c                       |    3 +-
 drivers/input/joystick/adi.c                       |    3 +-
 drivers/input/joystick/analog.c                    |    4 +-
 drivers/input/joystick/cobra.c                     |    3 +-
 drivers/input/joystick/gf2k.c                      |    3 +-
 drivers/input/joystick/grip.c                      |    3 +-
 drivers/input/joystick/grip_mp.c                   |    3 +-
 drivers/input/joystick/guillemot.c                 |    3 +-
 drivers/input/joystick/interact.c                  |    3 +-
 drivers/input/joystick/joydump.c                   |    3 +-
 drivers/input/joystick/sidewinder.c                |    3 +-
 drivers/input/joystick/tmdc.c                      |    3 +-
 drivers/input/keyboard/atkbd.c                     |   30 +-
 drivers/input/keyboard/bf54x-keys.c                |   13 +-
 drivers/input/keyboard/gpio_keys.c                 |   42 +-
 drivers/input/misc/Kconfig                         |   13 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/ati_remote2.c                   |  263 +++++-
 drivers/input/misc/cm109.c                         |  882 ++++++++++++=
++++++++
 drivers/input/misc/wistron_btns.c                  |   19 +
 drivers/input/misc/yealink.c                       |    2 +-
 drivers/input/mouse/Kconfig                        |   10 +
 drivers/input/mouse/Makefile                       |    1 +
 drivers/input/mouse/alps.c                         |    1 +
 drivers/input/mouse/appletouch.c                   |  299 +++++--
 drivers/input/mouse/hgpk.c                         |  477 +++++++++++
 drivers/input/mouse/hgpk.h                         |   49 ++
 drivers/input/mouse/logips2pp.c                    |    4 +-
 drivers/input/mouse/psmouse-base.c                 |   81 ++-
 drivers/input/mouse/psmouse.h                      |   14 +-
 drivers/input/mouse/trackpoint.c                   |    8 +-
 drivers/input/serio/i8042-x86ia64io.h              |    7 +
 drivers/input/serio/serio_raw.c                    |    6 +
 drivers/input/tablet/aiptek.c                      |   53 +-
 drivers/input/touchscreen/ads7846.c                |   94 ++-
 drivers/input/touchscreen/atmel_tsadcc.c           |   37 +-
 drivers/input/touchscreen/mainstone-wm97xx.c       |    5 +-
 drivers/input/touchscreen/wm9705.c                 |    5 +-
 drivers/input/touchscreen/wm9712.c                 |    5 +-
 drivers/input/touchscreen/wm9713.c                 |    5 +-
 drivers/input/touchscreen/wm97xx-core.c            |    5 +-
 include/linux/Kbuild                               |    1 +
 include/linux/gameport.h                           |    7 +-
 include/linux/input.h                              |   15 +-
 .../input/misc =3D> include/linux}/map_to_7segment.h |    4 +-
 include/linux/mod_devicetable.h                    |    2 +-
 50 files changed, 2252 insertions(+), 338 deletions(-)
 create mode 100644 drivers/input/misc/cm109.c
 create mode 100644 drivers/input/mouse/hgpk.c
 create mode 100644 drivers/input/mouse/hgpk.h
 rename {drivers/input/misc =3D> include/linux}/map_to_7segment.h (98%)

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
