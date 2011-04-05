From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.39-rc1
Date: Tue, 5 Apr 2011 09:27:39 -0700
Message-ID: <20110405162739.GA4183@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46468 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab1DEQ1p (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 12:27:45 -0400
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

to receive updates for the input subsystem. Small driver fixups and a
change to sparse-keymap to report MSC_SCAN and KEY_UNKNOWN to aid in
establishing new keymaps.

Changelog:
---------

Axel Lin (1):
      Input: rpckbd - fix a leak of the IRQ during init failure

Jan Beulich (1):
      Input: synaptics - fix crash in synaptics_module_init()

Manoj Iyer (1):
      Input: wacom - add support for Lenovo tablet ID (0xE6)

Paul Bolle (1):
      Input: i8042 - downgrade selftest error message to dbg()

Peter Hutterer (1):
      Input: uinput - allow for 0/0 min/max on absolute axes.

Ping Cheng (2):
      Input: wacom - constify wacom_features for a new missed Bamboo models
      Input: wacom - report resolution for pen devices

Rajeev Kumar (1):
      Input: spear-keyboard - fix inverted condition in interrupt handler

Seth Forshee (2):
      Input: sparse-keymap - report scancodes with key events
      Input: sparse-keymap - report KEY_UNKNOWN for unknown scan codes

Sylvestre Ledru (1):
      Input: h3600_ts_input - fix a spelling error


Diffstat:
--------

 drivers/input/keyboard/spear-keyboard.c    |    2 +-
 drivers/input/misc/uinput.c                |    6 +-
 drivers/input/mouse/synaptics.c            |    4 +-
 drivers/input/serio/i8042.c                |    7 +-
 drivers/input/serio/rpckbd.c               |    2 +-
 drivers/input/sparse-keymap.c              |   14 ++
 drivers/input/tablet/wacom_wac.c           |  291 ++++++++++++++++++----------
 drivers/input/tablet/wacom_wac.h           |    2 +
 drivers/input/touchscreen/h3600_ts_input.c |    2 +-
 9 files changed, 221 insertions(+), 109 deletions(-)

-- 
Dmitry

