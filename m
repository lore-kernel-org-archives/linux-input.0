From: "Mark F. Brown" <mark.brown314@gmail.com>
Subject: [PATCH 0/5] ARM: pxa168: add keypad support
Date: Thu, 26 Aug 2010 05:18:54 -0400
Message-ID: <1282814339-10934-1-git-send-email-mark.brown314__10553.8359297954$1283222322$gmane$org@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54033 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655Ab0HaCgG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Aug 2010 22:36:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>li
Cc: "Mark F. Brown" <mark.brown314@gmail.com>

In order to add keypad support for pxa168

1) Make pxa27x_keypad.h accessible to mach-mmp
2) Add a special interrupt handler for pxa168 keypad interrupts
This interrupt handler fixes an issue on the SoC that prevents the
keypad driver from being able to clear the keypad interrupt.
3) Add initial board level support

Mark F. Brown (5):
  ARM: pxa27x/pxa3xx: moved pxa27x_keypad.h to platform pxa directory
  ARM: pxa168: added keypad support
  ARM: pxa168: added wake clear register support for APMU
  ARM: pxa168: added special case handler for keypad interrupts
  ARM: pxa168: aspenite: add board support for keypad

 arch/arm/mach-mmp/aspenite.c                   |   27 +++++++++++
 arch/arm/mach-mmp/include/mach/mfp-pxa168.h    |    7 +++
 arch/arm/mach-mmp/include/mach/pxa168.h        |    7 +++
 arch/arm/mach-mmp/include/mach/regs-apmu.h     |   12 +++++
 arch/arm/mach-mmp/irq-pxa168.c                 |   23 +++++++++-
 arch/arm/mach-mmp/pxa168.c                     |    3 +
 arch/arm/mach-pxa/devices.c                    |    2 +-
 arch/arm/mach-pxa/em-x270.c                    |    2 +-
 arch/arm/mach-pxa/ezx.c                        |    2 +-
 arch/arm/mach-pxa/include/mach/pxa27x_keypad.h |   59 ------------------------
 arch/arm/mach-pxa/littleton.c                  |    2 +-
 arch/arm/mach-pxa/mainstone.c                  |    4 +-
 arch/arm/mach-pxa/mioa701.c                    |    2 +-
 arch/arm/mach-pxa/palmld.c                     |    2 +-
 arch/arm/mach-pxa/palmt5.c                     |    2 +-
 arch/arm/mach-pxa/palmtreo.c                   |    2 +-
 arch/arm/mach-pxa/palmtx.c                     |    2 +-
 arch/arm/mach-pxa/palmz72.c                    |    2 +-
 arch/arm/mach-pxa/tavorevb.c                   |    2 +-
 arch/arm/mach-pxa/z2.c                         |    2 +-
 arch/arm/mach-pxa/zylonite.c                   |    2 +-
 arch/arm/plat-pxa/include/plat/pxa27x_keypad.h |   59 ++++++++++++++++++++++++
 drivers/input/keyboard/Kconfig                 |    2 +-
 drivers/input/keyboard/pxa27x_keypad.c         |    2 +-
 24 files changed, 154 insertions(+), 77 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
 create mode 100644 arch/arm/plat-pxa/include/plat/pxa27x_keypad.h

