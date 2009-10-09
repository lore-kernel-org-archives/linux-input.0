From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.32-rc3
Date: Thu, 8 Oct 2009 21:33:07 -0700
Message-ID: <20091009043307.GB26462@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752183AbZJIEdv@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem.

Changelog:
---------

Amit Kucheria (1):
      Input: fix rx51 board keymap

Dmitry Torokhov (2):
      Input: libps2 - fix dependancy on i8042
      Input: i8042 - print debug data when testing AUX IRQ delivery

H Hartley Sweeten (1):
      Input: rotary_encoder - fix relative axis support

Michael Hennerich (1):
      Input: ad7879 - pass up error codes from probe functions

Sebastian Frei (1):
      Input: wistron_btns - add DMI entry for Medion WIM2030 laptop

Thomas Gruber (1):
      Input: xpad - add BigBen Interactive XBOX 360 Controller

Uwe Kleine-K=F6nig (1):
      Input: sparkspkr - move remove() functions to .devexit.text


Diffstat:
--------

 arch/arm/mach-omap2/board-rx51-peripherals.c |   78 +++++++++++++-----=
--------
 drivers/input/joystick/xpad.c                |    2 +
 drivers/input/misc/rotary_encoder.c          |    4 +-
 drivers/input/misc/sparcspkr.c               |    4 +-
 drivers/input/misc/wistron_btns.c            |    9 +++
 drivers/input/serio/Kconfig                  |   13 ++--
 drivers/input/serio/i8042.c                  |    3 +
 drivers/input/touchscreen/ad7879.c           |    4 +-
 include/linux/i2c/twl4030.h                  |    6 +-
 9 files changed, 69 insertions(+), 54 deletions(-)

--=20
Dmitry
