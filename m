From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] Input: keypad-ep93xx - Cleanup header file
Date: Fri, 27 Dec 2013 17:33:07 +0530
Message-ID: <1388145788-6253-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:49020 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab3L0MGj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Dec 2013 07:06:39 -0500
Received: by mail-pa0-f52.google.com with SMTP id ld10so9223957pab.25
        for <linux-input@vger.kernel.org>; Fri, 27 Dec 2013 04:06:39 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, sachin.kamat@linaro.org, patches@linaro.org

Commit a3b2924547a7 ("ARM: ep93xx: move platform_data definitions")
moved the file to the current location but forgot to remove the pointer
to its previous location. Clean it up. While at it also change the header
file protection macros appropriately.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 include/linux/platform_data/keypad-ep93xx.h |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/platform_data/keypad-ep93xx.h b/include/linux/platform_data/keypad-ep93xx.h
index 1e2f4e97f428..adccee25b162 100644
--- a/include/linux/platform_data/keypad-ep93xx.h
+++ b/include/linux/platform_data/keypad-ep93xx.h
@@ -1,9 +1,5 @@
-/*
- * arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
- */
-
-#ifndef __ASM_ARCH_EP93XX_KEYPAD_H
-#define __ASM_ARCH_EP93XX_KEYPAD_H
+#ifndef __KEYPAD_EP93XX_H
+#define __KEYPAD_EP93XX_H
 
 struct matrix_keymap_data;
 
@@ -32,4 +28,4 @@ struct ep93xx_keypad_platform_data {
 #define EP93XX_MATRIX_ROWS		(8)
 #define EP93XX_MATRIX_COLS		(8)
 
-#endif	/* __ASM_ARCH_EP93XX_KEYPAD_H */
+#endif	/* __KEYPAD_EP93XX_H */
-- 
1.7.9.5

