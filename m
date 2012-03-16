From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 0/2] Omap keypad cleanup and omap5 support
Date: Fri, 16 Mar 2012 19:56:27 +0530
Message-ID: <1331907989-11891-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51111 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964906Ab2CPOZ3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 10:25:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, sourav.poddar@ti.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com

The series consists of two patches.
Patch1 of the series makes omap4 keypad independent of the
architecture by moving platform_data to <linux/platform_data>

Patch2 add support for omap5 onchip keypad.

Tested on omap4430sdp using 3.3-rc6.
Tested on omap5 board using 3.1 custom kernel. 

Felipe Balbi (1):
  input: keypad: move platform_data to <linux/platform_data>

G, Manjunath Kondaiah (1):
  Input: omap-keypad: dynamically handle register offsets

 arch/arm/mach-omap2/board-4430sdp.c            |    1 +
 arch/arm/mach-omap2/devices.c                  |    1 +
 arch/arm/plat-omap/include/plat/omap4-keypad.h |    9 --
 drivers/input/keyboard/Kconfig                 |    7 +-
 drivers/input/keyboard/omap4-keypad.c          |  124 +++++++++++++++++++-----
 include/linux/platform_data/omap4-keypad.h     |   13 +++
 6 files changed, 118 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/platform_data/omap4-keypad.h

