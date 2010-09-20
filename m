From: Cyril Chemparathy <cyril@ti.com>
Subject: [PATCH v4 0/5] add tnetv107x input drivers
Date: Mon, 20 Sep 2010 12:26:39 -0400
Message-ID: <1285000004-9464-1-git-send-email-cyril@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57176 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756815Ab0ITQ0v (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 12:26:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: shubhrajyoti@ti.com, dmitry.torokhov@gmail.com, khilman@deeprootsystems.com, Cyril Chemparathy <cyril@ti.com>

Texas Instruments' TNETV107X is an ARM1176 based SoC, with on-chip
touchscreen and keypad controllers.  This patch series adds drivers for these
controllers.

Changes between v1 and v2:
  1. Cleaned up platform data needs by reusing matrix keypad pdata
  2. Eliminated calibration code from touch driver
  3. Relocated h/w init code to open and close
  4. Other minor cleanups

Changes between v2 and v3:
  1. Merged keycodes alloc into keypad data
  2. Moved irq hookup to probe from open
  3. Other minor cleanups

Changes between v3 and v4:
  1. Locking between hardirqs for keypad driver

Cyril Chemparathy (5):
  input: add driver for tnetv107x on-chip keypad controller
  davinci: add tnetv107x keypad platform device
  davinci: add keypad config for tnetv107x evm board
  input: add driver for tnetv107x touchscreen controller
  davinci: add tnetv107x touchscreen platform device

 arch/arm/mach-davinci/board-tnetv107x-evm.c    |   56 ++++
 arch/arm/mach-davinci/devices-tnetv107x.c      |   50 +++
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    3 +
 drivers/input/keyboard/Kconfig                 |    9 +
 drivers/input/keyboard/Makefile                |    1 +
 drivers/input/keyboard/tnetv107x-keypad.c      |  340 ++++++++++++++++++++
 drivers/input/touchscreen/Kconfig              |    9 +
 drivers/input/touchscreen/Makefile             |    1 +
 drivers/input/touchscreen/tnetv107x-ts.c       |  396 ++++++++++++++++++++++++
 9 files changed, 865 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/tnetv107x-keypad.c
 create mode 100644 drivers/input/touchscreen/tnetv107x-ts.c

