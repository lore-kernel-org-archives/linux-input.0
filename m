From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.27-rc0 (round 2)
Date: Thu, 14 Aug 2008 22:28:26 -0400
Message-ID: <20080815022826.GB9438@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:19567 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbYHOC2a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Aug 2008 22:28:30 -0400
Received: by yx-out-2324.google.com with SMTP id 8so546887yxm.1
        for <linux-input@vger.kernel.org>; Thu, 14 Aug 2008 19:28:29 -0700 (PDT)
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

to receive updates for the input subsystem. You will get a bunch of
small fixes, the change to evdev to print an warning abount invalid
parameters to EVIOCGBIT ioctl and a new driver for Macbook Air
touchpads.

Changelog:
---------

Andrew Morton (1):
      Input: xilinx_ps2 - fix warning

Carlos Corbacho (1):
      Input: i8042 - Add Dritek quirk for Acer TravelMate 4280

Dmitry Torokhov (2):
      Input: paper over a bug in Synaptics X driver
      Input: bcm5974 - implement autosuspend support

Harley Laue (1):
      Input: xpad - add Pelican Eclipse D-Pad to the list of devices

Henrik Rydberg (1):
      Input: bcm5974 - add driver for Macbook Air and Pro Penryn touchp=
ads

Linus Torvalds (1):
      Input: evdev - split EVIOCGBIT handlig into a separate function

Mark Brown (1):
      Input: wm97xx - enable sub-drivers by default

Uwe Kleine-K=F6nig (2):
      Input: gpio-keys - fix possible NULL pointer dereference
      Input: gpio-keys - make gpio_keys_device_driver static


Diffstat:
--------

 drivers/hid/usbhid/hid-quirks.c       |   12 +-
 drivers/input/evdev.c                 |   63 ++-
 drivers/input/joystick/xpad.c         |    1 +
 drivers/input/keyboard/gpio_keys.c    |    3 +-
 drivers/input/mouse/Kconfig           |   23 ++
 drivers/input/mouse/Makefile          |    1 +
 drivers/input/mouse/bcm5974.c         |  681 +++++++++++++++++++++++++=
++++++++
 drivers/input/serio/i8042-x86ia64io.h |    7 +
 drivers/input/serio/xilinx_ps2.c      |    4 +-
 drivers/input/touchscreen/Kconfig     |   21 +-
 10 files changed, 775 insertions(+), 41 deletions(-)
 create mode 100644 drivers/input/mouse/bcm5974.c

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
