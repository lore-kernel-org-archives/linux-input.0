From: Jiri Kosina <dmitry.torokhov@gmail.com>
Subject: [PATCH 29/37] Input: fix ordering in joystick Makefile
Date: Mon, 10 Mar 2008 13:43:05 +0100
Message-ID: <1b8930dc64b6842e50711441ba67482aacc475dd.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:9129 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759987AbYDUNTH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:07 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3106316waf.23
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:06 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

Make entries in drivers/input/joystick/Makefile properly alphabetically
ordered.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/joystick/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
index 868b746..e262840 100644
--- a/drivers/input/joystick/Makefile
+++ b/drivers/input/joystick/Makefile
@@ -15,9 +15,11 @@ obj-$(CONFIG_JOYSTICK_GF2K)		+= gf2k.o
 obj-$(CONFIG_JOYSTICK_GRIP)		+= grip.o
 obj-$(CONFIG_JOYSTICK_GRIP_MP)		+= grip_mp.o
 obj-$(CONFIG_JOYSTICK_GUILLEMOT)	+= guillemot.o
+obj-$(CONFIG_JOYSTICK_IFORCE)		+= iforce/
 obj-$(CONFIG_JOYSTICK_INTERACT)		+= interact.o
 obj-$(CONFIG_JOYSTICK_JOYDUMP)		+= joydump.o
 obj-$(CONFIG_JOYSTICK_MAGELLAN)		+= magellan.o
+obj-$(CONFIG_JOYSTICK_MAPLE)		+= maplecontrol.o
 obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
 obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o
 obj-$(CONFIG_JOYSTICK_SPACEORB)		+= spaceorb.o
@@ -29,4 +31,3 @@ obj-$(CONFIG_JOYSTICK_WARRIOR)		+= warrior.o
 obj-$(CONFIG_JOYSTICK_XPAD)		+= xpad.o
 obj-$(CONFIG_JOYSTICK_ZHENHUA)		+= zhenhua.o
 
-obj-$(CONFIG_JOYSTICK_IFORCE)		+= iforce/
-- 
1.5.5.rc2.6.gf58d


