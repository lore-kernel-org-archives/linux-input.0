From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] Input: keypad-omap - Cleanup header file
Date: Fri, 27 Dec 2013 17:33:08 +0530
Message-ID: <1388145788-6253-2-git-send-email-sachin.kamat@linaro.org>
References: <1388145788-6253-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:36247 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab3L0MGn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Dec 2013 07:06:43 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so9170729pbc.21
        for <linux-input@vger.kernel.org>; Fri, 27 Dec 2013 04:06:43 -0800 (PST)
In-Reply-To: <1388145788-6253-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, sachin.kamat@linaro.org, patches@linaro.org

Commit 2203747c9771 ("ARM: omap: move platform_data definitions")
moved the file to the current location but forgot to remove the pointer
to its previous location. Clean it up. While at it also change the header
file protection macros appropriately.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 include/linux/platform_data/keypad-omap.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/platform_data/keypad-omap.h b/include/linux/platform_data/keypad-omap.h
index a6b21eddb212..c3a3abae98f0 100644
--- a/include/linux/platform_data/keypad-omap.h
+++ b/include/linux/platform_data/keypad-omap.h
@@ -1,14 +1,12 @@
 /*
- *  arch/arm/plat-omap/include/mach/keypad.h
- *
  *  Copyright (C) 2006 Komal Shah <komal_shah802003@yahoo.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef ASMARM_ARCH_KEYPAD_H
-#define ASMARM_ARCH_KEYPAD_H
+#ifndef __KEYPAD_OMAP_H
+#define __KEYPAD_OMAP_H
 
 #ifndef CONFIG_ARCH_OMAP1
 #warning Please update the board to use matrix-keypad driver
-- 
1.7.9.5

