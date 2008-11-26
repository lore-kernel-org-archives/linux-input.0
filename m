From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.28-rc6
Date: Wed, 26 Nov 2008 11:26:20 -0500
Message-ID: <20081126162620.GA27380@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754736AbYKZQ0n@vger.kernel.org>
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

to receive updates for the input subsystem. Mostly small fixups with the
exception of Wacom driver, but the change only adds support for the new
tablet PCs and should not affect devices that were already supported by
earlier versions of the driver.

Changelog:
---------

Andres Salomon (1):
      Input: psmouse - fix incorrect validate_byte check in OLPC protocol

Arjan van de Ven (1):
      Input: replace spin_lock_bh with spin_lock_irqsave in ml_ff_playback

Daniel Gimpelevich (1):
      Input: cm109 - add keymap for ATCom AU-100 phone

Dmitri Vorobiev (1):
      Input: fix the example of an input device driver

Dmitry Torokhov (1):
      Input: i8042 - add Compal Hel80 laptop to nomux blacklist

Herton Ronaldo Krzesinski (1):
      Input: i8042 - add Dell XPS M1530 to nomux list

Jiri Pirko (1):
      Input: atkbd - cancel delayed work before freeing its structure

Matthew Garrett (1):
      Input: atkbd - add keymap quirk for Inventec Symphony systems

Ping Cheng (1):
      Input: wacom - add support for new USB Tablet PCs

Vojtech Pavlik (1):
      Input: elo - fix format string in elo driver


Diffstat:
--------

 Documentation/input/input-programming.txt |    3 +-
 drivers/input/ff-memless.c                |    5 +-
 drivers/input/keyboard/atkbd.c            |   27 ++++-
 drivers/input/misc/cm109.c                |   37 +++++-
 drivers/input/mouse/hgpk.c                |    2 +-
 drivers/input/serio/i8042-x86ia64io.h     |   14 ++
 drivers/input/tablet/wacom.h              |   13 +-
 drivers/input/tablet/wacom_sys.c          |  228 +++++++++++++++++++++++++----
 drivers/input/tablet/wacom_wac.c          |  160 ++++++++++++++++++--
 drivers/input/tablet/wacom_wac.h          |    4 +
 drivers/input/touchscreen/elo.c           |    2 +-
 11 files changed, 439 insertions(+), 56 deletions(-)

-- 
Dmitry
