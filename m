From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.33-rc4
Date: Thu, 14 Jan 2010 23:50:27 -0800
Message-ID: <20100115075026.GA19624@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:34042 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab0AOHud (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2010 02:50:33 -0500
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

Adam Jackson (1):
      Input: evdev - be less aggressive about sending SIGIO notifies

Daniel Drake (1):
      Input: psmouse - fix Synaptics detection when protocol is disabled

Dmitry Torokhov (3):
      Input: atkbd - fix canceling event_work in disconnect
      Input: xbox - do not use GFP_KERNEL under spinlock
      Input: add compat support for sysfs and /proc capabilities output

Elliott Sales de Andrade (1):
      Input: i8042 - add Dritek quirk for Acer Aspire 5610.

Eric W. Biederman (1):
      Input: serio - fix potential deadlock when unbinding drivers

Henrik Rydberg (1):
      Input: bcm5974 - report ABS_MT events

Miguel Aguilar (1):
      Input: davinci_keyscan - add device_enable method to platform data

Roel Kluin (1):
      Input: gf2k - fix &&/|| confusion in gf2k_connect()

Tai-hwa Liang (2):
      Input: pmouse - move Sentelic probe down the list
      Input: sentelic - fix left/right horizontal scroll mapping


Diffstat:
--------

 arch/arm/mach-davinci/include/mach/keyscan.h |    1 +
 drivers/input/evdev.c                        |    3 +-
 drivers/input/input.c                        |   86 +++++++++++++++++++++-----
 drivers/input/joystick/gf2k.c                |    2 +-
 drivers/input/joystick/xpad.c                |    4 +-
 drivers/input/keyboard/atkbd.c               |   69 ++++++++++-----------
 drivers/input/keyboard/davinci_keyscan.c     |    8 +++
 drivers/input/mouse/bcm5974.c                |   44 +++++++++++++-
 drivers/input/mouse/psmouse-base.c           |   69 ++++++++-------------
 drivers/input/mouse/sentelic.c               |    6 +-
 drivers/input/mouse/synaptics.c              |   10 +++
 drivers/input/mouse/synaptics.h              |    1 +
 drivers/input/serio/i8042-x86ia64io.h        |    7 ++
 include/linux/serio.h                        |   19 ------
 14 files changed, 208 insertions(+), 121 deletions(-)

-- 
Dmitry

