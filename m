From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/03] sh: SuperH KEYSC keypad support
Date: Fri, 29 Feb 2008 19:48:47 +0900
Message-ID: <20080229104847.22537.66432.sendpatchset@clockwork.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, akpm@linux-foundation.org, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

These patches add support for keypads attached to the SuperH KEYSC block.

[PATCH 01/03] sh: SuperH KEYSC platform driver
[PATCH 02/03] sh: SuperH KEYSC support for MigoR
[PATCH 03/03] sh: SuperH KEYSC support for Solution Engine 7722

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Please note that the board patches need the header file provided by
 the first patch to compile. So maybe this is suitable for -mm?
 If it is better to merge the driver in some subsystem tree then I'll
 just resend the board code to the linux-sh list during late -rc1 merge.
 
 arch/sh/boards/renesas/migor/setup.c |   56 ++++++
 arch/sh/boards/se/7722/setup.c       |   41 ++++
 drivers/input/keyboard/Kconfig       |    9 +
 drivers/input/keyboard/Makefile      |    1 
 drivers/input/keyboard/sh_keysc.c    |  281 ++++++++++++++++++++++++++++++++++
 include/asm-sh/se7722.h              |    2 
 include/asm-sh/sh_keysc.h            |   13 +
 7 files changed, 402 insertions(+), 1 deletion(-)
