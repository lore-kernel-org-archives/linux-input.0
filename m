From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.35-rc5
Date: Thu, 22 Jul 2010 08:51:59 -0700
Message-ID: <20100722155159.GA22052@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56775 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743Ab0GVPwM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jul 2010 11:52:12 -0400
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

to receive updates for the input subsystem. There are fixes for oopses
in gamecon and twl40300-keypad dtivers, fix for recent regression in
gamecon with PSX pads, and couple of changes dealing with hardware quirks.

Changelog:
---------

Christoph Fritz (1):
      Input: qt2160 - rename kconfig symbol name

Dmitry Torokhov (4):
      Input: gamecon - reference correct input device in NES mode
      Input: gamecon - reference correct pad in gc_psx_command()
      Input: twl40300-keypad - fix handling of "all ground" rows
      Input: synaptics - relax capability ID checks on newer hardware

Kamal Mostafa (1):
      Input: i8042 - add Gigabyte Spring Peak to dmi_noloop_table

Wan ZongShun (1):
      Input: w90p910_keypad - change platfrom driver name to 'nuc900-kpi'


Diffstat:
--------

 arch/arm/mach-omap2/board-rx51-peripherals.c |   17 ++++++++++++++---
 drivers/input/joystick/gamecon.c             |    5 ++---
 drivers/input/keyboard/Kconfig               |    2 +-
 drivers/input/keyboard/twl4030_keypad.c      |   17 +++++++++++------
 drivers/input/keyboard/w90p910_keypad.c      |    2 +-
 drivers/input/mouse/synaptics.c              |    7 ++++++-
 drivers/input/mouse/synaptics.h              |    3 ++-
 drivers/input/serio/i8042-x86ia64io.h        |    7 +++++++
 8 files changed, 44 insertions(+), 16 deletions(-)

-- 
Dmitry

