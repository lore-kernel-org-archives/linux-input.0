From: Cyril Chemparathy <cyril@ti.com>
Subject: [PATCH 0/7] add tnetv107x input drivers
Date: Mon, 13 Sep 2010 12:29:41 -0400
Message-ID: <1284395388-32687-1-git-send-email-cyril@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60484 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab0IMQ3w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 12:29:52 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8DGTpO2027544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Mon, 13 Sep 2010 11:29:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: Cyril Chemparathy <cyril@ti.com>

Texas Instruments' TNETV107X is an ARM1176 based SoC, with on-chip
touchscreen and keypad controllers.  This patch series adds drivers for these
controllers.

Cyril Chemparathy (7):
  davinci: define tnetv107x keypad platform data
  input: add driver for tnetv107x on-chip keypad controller
  davinci: add tnetv107x keypad platform device
  davinci: add keypad config for tnetv107x evm board
  input: add driver for tnetv107x touchscreen controller
  davinci: add tnetv107x touchscreen platform device
  davinci: add touchscreen config for tnetv107x evm board

 arch/arm/mach-davinci/board-tnetv107x-evm.c    |   51 +++
 arch/arm/mach-davinci/devices-tnetv107x.c      |   54 +++
 arch/arm/mach-davinci/include/mach/tnetv107x.h |   24 ++
 drivers/input/keyboard/Kconfig                 |    9 +
 drivers/input/keyboard/Makefile                |    1 +
 drivers/input/keyboard/tnetv107x-keypad.c      |  324 ++++++++++++++++
 drivers/input/touchscreen/Kconfig              |    6 +
 drivers/input/touchscreen/Makefile             |    1 +
 drivers/input/touchscreen/tnetv107x-ts.c       |  481 ++++++++++++++++++++++++
 9 files changed, 951 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/tnetv107x-keypad.c
 create mode 100644 drivers/input/touchscreen/tnetv107x-ts.c

