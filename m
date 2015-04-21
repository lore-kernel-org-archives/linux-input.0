From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.1-rc0 (part 2)
Date: Tue, 21 Apr 2015 11:23:14 -0700
Message-ID: <20150421182314.GA16790@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34826 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbbDUSXS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2015 14:23:18 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get an update to
Atmel MXT driver that makes it functional on Google Pixel 2 boxes (both
touchpad and touchscreen). There is also a new VMware VMMouse driver
that should allow us drop X vmmouse driver that requires root privileges
(since it accesses ioports). XBox One controllers now support force
feedback (rumble).

Changelog:
---------

Dmitry Torokhov (2):
      Input: atmel_mxt_ts - add support for Google Pixel 2
      Input: elants_i2c - zero-extend hardware ID in firmware name

Dudley Du (1):
      Input: cyapa - fix setting suspend scan rate

Duson Lin (2):
      Input: elan_i2c - report hovering contacts
      Input: elan_i2c - fix calculating number of x and y traces.

Hans de Goede (1):
      Input: alps - document separate pointstick button bits for V2 devices

Ming-ting Yao Wei (1):
      Input: xpad - add rumble support for Xbox One controller

Oliver Neukum (1):
      Input: ff-core - use new debug macros

Thomas Hellstrom (1):
      Input: add vmmouse driver

Wolfram Sang (1):
      Input: lm8333 - fix broken email address

duson (1):
      Input: elan_i2c - adjust for newer firmware pressure reporting


Diffstat:
--------

 Documentation/input/alps.txt             |   9 +-
 MAINTAINERS                              |   8 +
 drivers/input/ff-core.c                  |  10 +-
 drivers/input/joystick/xpad.c            |  21 +-
 drivers/input/keyboard/lm8333.c          |   4 +-
 drivers/input/mouse/Kconfig              |  12 +
 drivers/input/mouse/Makefile             |   1 +
 drivers/input/mouse/cyapa.c              |   4 +-
 drivers/input/mouse/elan_i2c.h           |   3 +
 drivers/input/mouse/elan_i2c_core.c      |  38 ++-
 drivers/input/mouse/elan_i2c_i2c.c       |  27 +-
 drivers/input/mouse/elan_i2c_smbus.c     |  12 +-
 drivers/input/mouse/psmouse-base.c       |  17 ++
 drivers/input/mouse/psmouse.h            |   1 +
 drivers/input/mouse/vmmouse.c            | 508 +++++++++++++++++++++++++++++++
 drivers/input/mouse/vmmouse.h            |  30 ++
 drivers/input/touchscreen/atmel_mxt_ts.c | 141 ++++++++-
 drivers/input/touchscreen/elants_i2c.c   |   2 +-
 18 files changed, 806 insertions(+), 42 deletions(-)
 create mode 100644 drivers/input/mouse/vmmouse.c
 create mode 100644 drivers/input/mouse/vmmouse.h

-- 
Dmitry

