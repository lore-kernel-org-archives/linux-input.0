From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.29-rc6
Date: Sat, 28 Feb 2009 14:08:36 -0800
Message-ID: <20090228220835.GA16208@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:36100 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbZB1WIt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 17:08:49 -0500
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

to receive updates for the input subsystem. Nothing exciting, just a fe=
w
small fixups.

Changelog:
---------

Andy Whitcroft (1):
      Input: synaptics - ensure we reset the device on resume

Arjan Opmeer (1):
      Input: elantech - touchpad driver miss-recognising logitech mice

Bastien Nocera (1):
      Input: uvc - the button on the camera is KEY_CAMERA

Dan Streetman (1):
      Input: usbtouchscreen - allow reporting calibrated data

Daniel Mierswa (1):
      Input: atkbd - make forced_release_keys[] static

Daniel Ritz (1):
      Input: usbtouchscreen - fix eGalax HID ignoring

Jean Delvare (1):
      Input: psmouse - make MOUSE_PS2_LIFEBOOK depend on X86

Kay Sievers (1):
      Input: struct device - replace bus_id with dev_name(), dev_set_na=
me()

Roel Kluin (3):
      Input: bf54x-keys - fix debounce time validation
      Input: pxa930_trkball - fix write timeout handling
      Input: ambakmi - fix timeout handling in amba_kmi_write()

Uwe Kleine-K=F6nig (4):
      Input: corgikbd - mark probe function as __devinit
      Input: corgi_ts - mark probe function as __devinit
      Input: omap-keypad - mark probe function as __devinit
      Input: spitzkbd - mark probe function as __devinit


Diffstat:
--------

 drivers/input/keyboard/atkbd.c             |    4 +-
 drivers/input/keyboard/bf54x-keys.c        |    4 +-
 drivers/input/keyboard/corgikbd.c          |    8 +++---
 drivers/input/keyboard/omap-keypad.c       |    8 +++---
 drivers/input/keyboard/spitzkbd.c          |    8 +++---
 drivers/input/mouse/Kconfig                |    2 +-
 drivers/input/mouse/elantech.c             |   32 ++++++++++++++++++++=
+-------
 drivers/input/mouse/pxa930_trkball.c       |    2 +-
 drivers/input/mouse/synaptics.c            |    9 +++----
 drivers/input/serio/ambakmi.c              |    6 ++--
 drivers/input/serio/gscps2.c               |    2 +-
 drivers/input/serio/sa1111ps2.c            |    4 +-
 drivers/input/touchscreen/atmel_tsadcc.c   |    2 +-
 drivers/input/touchscreen/corgi_ts.c       |    9 ++++---
 drivers/input/touchscreen/tsc2007.c        |    3 +-
 drivers/input/touchscreen/usbtouchscreen.c |   20 +++++++++++++++-
 drivers/media/video/uvc/uvc_status.c       |   10 +++++---
 17 files changed, 84 insertions(+), 49 deletions(-)

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
